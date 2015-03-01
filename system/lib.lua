local fetch = ProbablyEngine.interface.fetchKey

local _queueSpell = nil
local _queueTime = 0

local _darkSimSpells = {
    -- Siege of Orgrimmar
    "Froststorm Bolt",
    "Arcane Shock",
    "Rage of the Empress",
    "Chain Lightning",
    -- PvP
    "Hex",
    "Mind Control",
    "Cyclone",
    "Polymorph",
    "Pyroblast",
    "Tranquility",
    "Divine Hymn",
    "Hymn of Hope",
    "Ring of Frost",
    "Entangling Roots"
}

local ignoreDebuffs = {
	'Mark of Arrogance',
	'Displaced Energy'
}

ProbablyEngine.library.register('mtsLib', {

    --[[-----------------------------------------------
    ** checkQueue **
    DESC: ...
    ToDo: Check if we even need this anymore.

    Build By: FORGOTTEN
    ---------------------------------------------------]]
    checkQueue = function(spellId)
      if (GetTime() - _queueTime) > 10 then
        _queueTime = 0
        _queueSpell = nil
        return false
      else
        if _queueSpell then
          if _queueSpell == spellId then
            if ProbablyEngine.parser.lastCast == GetSpellName(spellId) then
              _queueSpell = nil
              _queueTime = 0
            end
            return true
          end
        end
      end
        return false
    end,

    --[[-----------------------------------------------
    ** CanTaunt **
    DESC: Checks if it is okay to taunt.
    ToDo: Finish\Test\Use it...

    Build By: MTS
    ---------------------------------------------------]]
    canTaunt = function()
      if fetch('mtsconf', 'Taunts') then
        for i=1,#mts.unitCache do
          if UnitIsTappedByPlayer(mts.unitCache[i].key) then
        	  if not mts.immuneEvents(mts.unitCache[i].key) then
              if UnitThreatSituation(mts.unitCache[i].key) and UnitThreatSituation(mts.unitCache[i].key) >= 2 then
                if mts.Infront(mts.unitCache[i].key) then
                  ProbablyEngine.dsl.parsedTarget = mts.unitCache[i].key
                  return true 
                end
              end
            end
          end
        end
      end
      return false
    end,

    --[[-----------------------------------------------
    ** Priest - Prayer of Healing **
    DESC: Uses Unit cache to verify if enough people need healing
    and are in range of Holy Nova.
    We cache this count because PE cicles (therefore calling it) too fast and we dont 
    want to do all these checks alot (Saving FPS).
    ToDo: Change the amount of units that need to be around when in raid.

    Build By: Mirakuru
    Modified by: MTS
    ---------------------------------------------------]]
    holyNova = function()
      local minHeal = GetSpellBonusDamage(2) * 1.125
      local total = 0
      local prefix = (IsInRaid() and 'raid') or 'party'
        for i=1,#mts.unitFriendlyCache do
          local incomingHeals = UnitGetIncomingHeals(mts.unitFriendlyCache[i].key) or 0
          local absorbs = UnitGetTotalHealAbsorbs(mts.unitFriendlyCache[i].key) or 0
          local health = mts.unitFriendlyCache[i].actualHealth + incomingHeals - absorbs
          local healthMissing = max(0, mts.unitFriendlyCache[i].maxHealth - mts.unitFriendlyCache[i].actualHealth)
            if healthMissing > minHeal and UnitIsFriend("player", mts.unitFriendlyCache[i].key) then
              if mts.unitFriendlyCache[i].distance <= 12 then
                total = total + 1
              end
            end
        end
      return total > 3
    end,

    --[[-----------------------------------------------
    ** Priest - Prayer of Healing **
    DESC: Checks if a party group needs to be healed.
    Bugs: Counts dead people's health.

    Build By: woe
    ---------------------------------------------------]]
    PoH = function()
      local minHeal = GetSpellBonusDamage(2) * 2.21664
      local GetRaidRosterInfo, min, subgroups, member = GetRaidRosterInfo, math.min, {}, {}
      local lowest, lowestHP, _, subgroup = false, 0
      local start, groupMembers = 0, GetNumGroupMembers()
        if IsInRaid() then
            start = 1
        elseif groupMembers > 0 then
            groupMembers = groupMembers - 1
        end
        for i = start, groupMembers do
            _, _, subgroup, _, _, _, _, _, _, _, _ = GetRaidRosterInfo(i)
            if not subgroups[subgroup] then
                subgroups[subgroup] = 0
                member[subgroup] = ProbablyEngine.raid.roster[i].unit
            end
            subgroups[subgroup] = subgroups[subgroup] + min(minHeal, ProbablyEngine.raid.roster[i].healthMissing)
        end
        for i = 1, #subgroups do
            if subgroups[i] > minHeal * 4
            and subgroups[i] > lowestHP then
                lowest = i
                lowestHP = subgroups[i]
            end
        end
        if lowest then
            ProbablyEngine.dsl.parsedTarget = member[lowest]
            return true
        end
        return false
    end,

    --[[-----------------------------------------------
    ** Druid - MoonFire **
    DESC: Uses unit cache to verify if any unit around
    meets MoonFire Conditions.

    Build By: MTS
    ---------------------------------------------------]]
    mtsDot = function(spell, duration, health)
      for i=1,#mts.unitCache do
        if mts.unitCache[i].health <= health then
           local _,_,_,_,_,_,debuff = UnitDebuff(mts.unitCache[i].key, GetSpellInfo(spell), nil, "PLAYER")
            if not debuff or debuff - GetTime() < duration then
              if UnitCanAttack("player", mts.unitCache[i].key) and IsSpellInRange(GetSpellInfo(spell), mts.unitCache[i].key) then
                 if mts.Infront(mts.unitCache[i].key) then
                   ProbablyEngine.dsl.parsedTarget = mts.unitCache[i].key
                    return true
                 end           
               end
             end
         end
      end
        return false
    end,

    --[[-----------------------------------------------
    ** DarkSim **
    DESC: copys a spell from a unit.

    Build By: FORGOTTEN
    Modifyed by: MTS
    ---------------------------------------------------]]
    DarkSimUnit = function(unit)
      for index,spellName in pairs(_darkSimSpells) do
          if ProbablyEngine.condition["casting"](unit, spellName) then
            return true 
          end
        end
      return false
    end,

   --[[-----------------------------------------------
    ** Mass Dispel **
    DESC: Checks if units around player needs to be dispelled.
    UNUSED AND UNTESTED!

    Build By: MTS
    ---------------------------------------------------]]
    MassDispell = function()
      local prefix = (IsInRaid() and 'raid') or 'party'
      local total = 0        
        for i = -1, GetNumGroupMembers() - 1 do
          local unit = (i == -1 and 'target') or (i == 0 and 'player') or prefix .. i
            if IsSpellInRange('Mass Dispell', unit) then
              for j = 1, 40 do
                local debuffName, _, _, _, dispelType, duration, expires, _, _, _, spellID, _, isBossDebuff, _, _, _ = UnitDebuff(unit, j)
                  if dispelType and dispelType == 'Magic' or dispelType == 'Disease' then
                    if mts.Distance('player', unit) then
                      total = total + 1
                    end
                  end
                  if total >= 5 then
                    mts.Print("Mass Dispelled: "..debuffName.." on: "..unit.." total units:"..total)
                    ProbablyEngine.dsl.parsedTarget = unit
                    return true
                    end
                end
            end
        end
            return false
    end,

    --[[-----------------------------------------------
    ** Power word Barrier **
    DESC: Checks if units around tank have enough missing heal to use this.
    ToDo: Would be cool if i could predict a big AoE and use this to lower
    its raid damage.
    UNUSED AND UNTESTED!

    Build By: MTS
    ---------------------------------------------------]]
    PWBarrier = function()
    local minHeal = GetSpellBonusDamage(2) * 1.125
    local total = 0
    local prefix = (IsInRaid() and 'raid') or 'party'
      for i=1,#mts.unitFriendlyCache do
        local incomingHeals = UnitGetIncomingHeals(mts.unitFriendlyCache[i].key) or 0
        local absorbs = UnitGetTotalHealAbsorbs(mts.unitFriendlyCache[i].key) or 0
        local health = mts.unitFriendlyCache[i].actualHealth + incomingHeals - absorbs
        local healthMissing = max(0, mts.unitFriendlyCache[i].maxHealth - mts.unitFriendlyCache[i].actualHealth)
          if healthMissing > minHeal 
            and UnitIsFriend("player", mts.unitFriendlyCache[i].key) then
            if mts.Distance("focus", mts.unitFriendlyCache[i].key) <= 12 then
              total = total + 1
            end
          end
      end
        return total > 3
    end,

    -- Clarity of Purpose
    ClarityOfPurpose = function()
      local minHeal = GetSpellBonusDamage(2) * 1.125
      local total = 0
      local prefix = (IsInRaid() and 'raid') or 'party'
      local lowest = ProbablyEngine.raid.lowestHP
        for i=1,#mts.unitFriendlyCache do
          local incomingHeals = UnitGetIncomingHeals(mts.unitFriendlyCache[i].key) or 0
          local absorbs = UnitGetTotalHealAbsorbs(mts.unitFriendlyCache[i].key) or 0
          local health = mts.unitFriendlyCache[i].actualHealth + incomingHeals - absorbs
          local healthMissing = max(0, mts.unitFriendlyCache[i].maxHealth - mts.unitFriendlyCache[i].actualHealth)
            if healthMissing > minHeal and UnitIsFriend("player", mts.unitFriendlyCache[i].key) then
              if mts.Distance(lowest, mts.unitFriendlyCache[i].key) <= 10 then
                total = total + 1
              end
            end
        end
        return total > 3
    end,

    SEF = function()
      for i=1,#mts.unitCache do
        if UnitGUID('target') ~= UnitGUID(mts.unitCache[i].key) and IsSpellInRange(GetSpellInfo(137639), unit) then
          local _,_,_,_,_,_,debuff = UnitDebuff(mts.unitCache[i].key, GetSpellInfo(137639), nil, "PLAYER")
          if not debuff and mts.dynamicEval("!player.buff(137639).count = 2") then
            if not mts.immuneEvents(mts.unitCache[i].key) then
              if mts.Infront(mts.unitCache[i].key) then
                ProbablyEngine.dsl.parsedTarget = mts.unitCache[i].key
                return true 
              end
            end
          end
        end
      end
      return false
    end
 
})
