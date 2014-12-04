--[[ ///---INFO---////
//Core//
Thank You For Using My ProFiles
I Hope Your Enjoy Them
MTS
]]

mts_Version = "0.13.11"
mts_Icon = "|TInterface\\AddOns\\Probably_MrTheSoulz\\media\\logo.blp:16:16|t"
mts_peRecomemded = "6.0.3r11"

local fetch = ProbablyEngine.interface.fetchKey

local mts_unitCache = {}

local _queueSpell = nil
local _queueTime = 0
local _dotCount = 0

local holyNova_cache_time = 0
local holyNova_cache_count = 0
local holyNova_cache_dura = 0.3




                                                --[[ Local Functions ]]
--[[------------------------------------------------------------------------------------------------------------]]
--[[------------------------------------------------------------------------------------------------------------]]

--[[-----------------------------------------------
** Infront **
DESC: Checks if unit is infront.
Replaces PE build in one beacuse PE's is over sensitive.

Build By: Mirakuru
Modified by: MTS
---------------------------------------------------]]

local function mts_infront(unit)
  if FireHack then
    local aX, aY, aZ = ObjectPosition(unit)
    local bX, bY, bZ = ObjectPosition('player')
    local playerFacing = GetPlayerFacing()
    local facing = math.atan2(bY - aY, bX - aX) % 6.2831853071796
    return math.abs(math.deg(math.abs(playerFacing - (facing)))-180) < 90
  elseif oexecute then
    local aX, aY, aZ = opos(unit)
    local bX, bY, bZ = opos('player')
    local playerFacing = GetPlayerFacing()
    local facing = math.atan2(bY - aY, bX - aX) % 6.2831853071796
    return math.abs(math.deg(math.abs(playerFacing - (facing)))-180) < 90
  end
end

--[[-----------------------------------------------
** mts_Distance **
DESC: Sometimes PE's behaves baddly,
So here we go...

Build By: MTS
---------------------------------------------------]]
local function mts_Distance(a, b)
  if UnitExists(a) and UnitIsVisible(a) and UnitExists(b) and UnitIsVisible(b) then
    if FireHack then
      local ax, ay, az = ObjectPosition(a)
      local bx, by, bz = ObjectPosition(b)
      return math.sqrt(((bx-ax)^2) + ((by-ay)^2) + ((bz-az)^2)) - ((UnitCombatReach(a)) + (UnitCombatReach(b)))
    elseif oexecute then
      local ax, ay, az = opos(a)
      local bx, by, bz = opos(b)
      return math.sqrt(((bx-ax)^2) + ((by-ay)^2) + ((bz-az)^2)) - 6
    end
  end
    return 0
end

--[[-----------------------------------------------
** Automated moving/facing. **
DESC: This code will try to move or face a unit if said unit 
meets the requirements (LoS, mts_Distance etc...)

Build by: MTS
---------------------------------------------------]]
local function mts_rangeNeeded(unit)
  local _SpecID =  GetSpecializationInfo(GetSpecialization())
  local ranged = {
    62,     -- arcane mage
    63,     -- fire mage
    64,     -- frost mage
    65,     -- holy paladin
    102,    -- balance druid
    105,    -- restoration druid
    253,    -- beast mastery hunter
    254,    -- marksmanship hunter
    255,    -- survival hunter
    256,    -- discipline priest
    257,    -- holy priest
    258,    -- shadow priest
    262,    -- elemental shaman
    263,    -- enhancement shaman
    264,    -- restoration shaman
    265,    -- affliction warlock
    266,    -- demonology warlock
    267,    -- destruction warlock
    270,    -- mistweaver monk
  }
  if unit == nil then unit = 'target' end
  for i=1,#ranged do
    if _SpecID == ranged[i] then
        if FireHack then
            return (30 + (ObjectPosition('player') + UnitCombatReach(unit)))
        else
            return 30
        end
    else 
        if FireHack then
            return (6 + (ObjectPosition('player') + UnitCombatReach(unit)))
        else
            return 6
        end
    end
  end
end

local function mts_MoveTo(unit, ds)
  if FireHack then
  local aX, aY, aZ = ObjectPosition(unit)
  local bX, bY, bZ = ObjectPosition('player')
    --(Over sensitive...)if TraceLine(bX, bY, bZ, aX, aY, aZ, 0xFFFFFFFF) then 
      if not mts_Distance("player", unit) <= ((ObjectPosition('player') + UnitCombatReach(unit)) + ds) then
        MoveTo(aX, aY, aZ)
      end
    --end
  elseif oexecute then -- Offspring dosent have MoveTo :(
    
  end
end

local function mts_FaceTo(unit)
  if FireHack then
    if not mts_infront(unit) then
      if mts_Distance("player", unit) <= (UnitCombatReach('player') + UnitCombatReach(unit))
      or mts_rangeNeeded(unit) >= 30 then
        FaceUnit(unit)
      end
    end
  elseif oexecute then
    if not mts_infront(unit) then
      if mts_Distance("player", unit) <= 6 then 
        FaceUnit(unit)
      end
    end
  end
end

--[[-----------------------------------------------
** Immune Event's **
DESC: Checks if unit is cc'd and other special events when you should not
attack that unit.

Build by: MTS
Contributions by: StinkyTwitch
---------------------------------------------------]]

local mts_SpecialTargets = {
    -- TRAINING DUMMIES
    31144,      -- Training Dummy - Lvl 80
    31146,      -- Raider's Training Dummy - Lvl ??
    32541,      -- Initiate's Training Dummy - Lvl 55 (Scarlet Enclave)
    32542,      -- Disciple's Training Dummy - Lvl 65
    32545,      -- Initiate's Training Dummy - Lvl 55
    32546,      -- Ebon Knight's Training Dummy - Lvl 80
    32666,      -- Training Dummy - Lvl 60
    32667,      -- Training Dummy - Lvl 70
    46647,      -- Training Dummy - Lvl 85
    60197,      -- Scarlet Monastery Dummy
    67127,      -- Training Dummy - Lvl 90
    87761,      -- Dungeoneer's Training Dummy <Damage>
    88314,      -- Dungeoneer's Training Dummy <Tanking>
    88316,      -- Training Dummy <Healing>
    89078,      -- Training Dummy (Garrison)
    87318,      -- Dungeoneer's Training Dummy <Damage>
    -- WOD DUNGEONS/RAIDS
    75966,      -- Defiled Spirit (Shadowmoon Burial Grounds)
    76518,      -- Ritual of Bones (Shadowmoon Burial Grounds)
    81638,      -- Aqueous Globule (The Everbloom)
}

local mts_ImmuneAuras = {
    -- CROWD CONTROL
    118,        -- Polymorph
    1513,       -- Scare Beast
    1776,       -- Gouge
    2637,       -- Hibernate
    3355,       -- Freezing Trap
    6770,       -- Sap
    9484,       -- Shackle Undead
    19386,      -- Wyvern Sting
    20066,      -- Repentance
    28271,      -- Polymorph (turtle)
    28272,      -- Polymorph (pig)
    49203,      -- Hungering Cold
    51514,      -- Hex
    61025,      -- Polymorph (serpent) -- FIXME: gone ?
    61305,      -- Polymorph (black cat)
    61721,      -- Polymorph (rabbit)
    61780,      -- Polymorph (turkey)
    76780,      -- Bind Elemental
    82676,      -- Ring of Frost
    90337,      -- Bad Manner (Monkey) -- FIXME: to check
    115078,     -- Paralysis
    115268,     -- Mesmerize
    -- MOP DUNGEONS/RAIDS
    106062,     -- Water Bubble (Wise Mari)
    110945,     -- Charging Soul (Gu Cloudstrike)
    116994,     -- Unstable Energy (Elegon)
    122540,     -- Amber Carapace (Amber Monstrosity - Heat of Fear)
    123250,     -- Protect (Lei Shi)
    143574,     -- Swelling Corruption (Immerseus)
    143593,     -- Defensive Stance (General Nazgrim)
}

local function mts_hasDebuffTable(unit, spells)
  for i = 1, 40 do
    local _,_,_,_,_,_,_,_,_,_,spellId = _G['UnitDebuff'](unit, i)
    for k,v in pairs(spells) do
      if spellId == v then return true end
    end
  end
end

function mts_CheckSpecialTarget(unit)
    if not UnitExists(unit) then
        return false
    elseif UnitGUID(unit) then
        targets_guid = tonumber(string.match(UnitGUID(unit), "-(%d+)-%x+$"))
    else
        targets_guid = 0
    end
 
    for i=1, #mts_SpecialTargets do
        if targets_guid == mts_SpecialTargets[i] then
            return true
        end
    end
 
    return false
end

local function mts_immuneEvents(unit)
    if not UnitCanAttack("player", unit) then
        return false
    elseif not UnitAffectingCombat(unit) and not mts_CheckSpecialTarget(unit) then
        return false
    elseif mts_hasDebuffTable(unit, mts_ImmuneAuras) then
        return false
    else
        return true
    end
end

--[[-----------------------------------------------
** Automated Targets **
DESC: Checks if unit can/should be targted.

Build By: MTS & StinkyTwitch
---------------------------------------------------]]
local function mts_autoTarget()
  if UnitExists("target")
    and not UnitIsFriend("player","target")
    and not UnitIsDeadOrGhost("target") then
        -- do nothing
  end
  for i=1,#mts_unitCache do
    if mts_immuneEvents(mts_unitCache[i]) then
      if mts_infront(mts_unitCache[i]) then
        return Macro("/target "..mts_unitCache[i])
      end
    end
  end
end

--[[-----------------------------------------------
** Automated Unit Caching **
DESC: Checks if units around and caches them so they can
be later used for other stuff.

Build By: Mirakuru
Modified by: MTS
---------------------------------------------------]]
local function cache()
    local totalObjects = ObjectCount()
    local specID = GetSpecializationInfo(GetSpecialization())
    wipe(mts_unitCache)
    if FireHack then
      for i=1, totalObjects do
      local object = ObjectWithIndex(i)
        if ObjectExists(object) then
          if ObjectIsType(object, ObjectTypes.Unit)
          and mts_Distance("player", object) <= 40
          and ProbablyEngine.condition["alive"](object) then
            table.insert(mts_unitCache, object)
          end
        end
      end
    else -- Cache Raid/Party Targets
      local groupType = IsInRaid() and "raid" or "party"
      for i = 1, GetNumGroupMembers() do
      local target = groupType..i.."target"
        if ProbablyEngine.condition["alive"](target)
        and UnitAffectingCombat(target)
        and not UnitIsPlayer(target) then
          if ProbablyEngine.condition["mts_Distance"](target) <= 40 then
            table.insert(mts_unitCache, target)
          end
        end
      end
   end
end



                                                    --[[ Lib ]]
--[[------------------------------------------------------------------------------------------------------------]]
--[[------------------------------------------------------------------------------------------------------------]]



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
    CanTaunt = function()
        if UnitIsTappedByPlayer("target") 
            and fetch('mtsconf','Taunts') then
                return true 
        end
            return false
    end,

    --[[-----------------------------------------------
    TO BE REMOVED, CAN BE DONE INSIDE THE CR USING:
    (function() return UnitGUID('target')) ~= (UnitGUID('mouseover') end)

    ** mouseNotEqualTarget **
    DESC: Checks if mouseover unit is not equal current target.
    Been used for SEF.

    Build By: MTS
    ---------------------------------------------------]]
    mouseNotEqualTarget = function()
        if (UnitGUID('target')) ~= (UnitGUID('mouseover')) then
            return true
        end
    end,

    --[[-----------------------------------------------
    ** Priest - Prayer of Healing **
    DESC: Uses Unit cache to verify if enough people need healing
    and are in range of Holy Nova.
    ToDo: Change the amount of units that need to be around when in raid.

    Build By: Mirakuru
    Modified by: MTS
    ---------------------------------------------------]]
    holyNova = function()
      local minHeal = (GetSpellBonusDamage(2) * 1.125) + (GetCombatRatingBonus(CR_VERSATILITY_DAMAGE_DONE) + GetVersatilityBonus(CR_VERSATILITY_DAMAGE_DONE))
      local total = 0
      local prefix = (IsInRaid() and 'raid') or 'party'
      local holyNova_cache_time_c = holyNova_cache_time
      if holyNova_cache_time_c and ((holyNova_cache_time_c + holyNova_cache_dura) > GetTime()) then
        return holyNova_cache_count > 3
      end
      for i=1,#mts_unitCache do
      local incomingHeals = UnitGetIncomingHeals(mts_unitCache[i]) or 0
      local absorbs = UnitGetTotalHealAbsorbs(mts_unitCache[i]) or 0
      local health = UnitHealth(mts_unitCache[i]) + incomingHeals - absorbs
      local maxHealth = UnitHealthMax(mts_unitCache[i])
      local healthMissing = max(0, maxHealth - health)
        if healthMissing > minHeal 
          and UnitIsFriend("player", mts_unitCache[i]) then
          if mts_Distance("player", mts_unitCache[i]) <= 12 then
            total = total + 1
          end
        end
      end
        holyNova_cache_count = total
        holyNova_cache_time = GetTime()
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
    ** Priest - Shadow Word: Pain **
    DESC: Uses unit cache to verify if any unit around
    meets Shadow Word: Pain Conditions.

    Build By: MTS
    ---------------------------------------------------]]
    SWP = function()
      for i=1,#mts_unitCache do
      local _,_,_,_,_,_,debuff = UnitDebuff(mts_unitCache[i], GetSpellInfo(589), nil, "PLAYER")
        if not debuff then
          if mts_immuneEvents(mts_unitCache[i])
          --and not UnitIsUnit("target", mts_unitCache[i])
          and UnitAffectingCombat(mts_unitCache[i])
          and UnitCanAttack("player", mts_unitCache[i])
          and not UnitIsPlayer(mts_unitCache[i]) then
            if ProbablyEngine.parser.can_cast(589, mts_unitCache[i], false) then
              if mts_infront(mts_unitCache[i]) then
                ProbablyEngine.dsl.parsedTarget = mts_unitCache[i]
                return true
              end           
            end
          end   
        end
      end
        return false
    end,
 
    --[[-----------------------------------------------
    ** Priest - Shadow Word: Death **
    DESC: Uses unit cache to verify if any unit around
    meets Shadow Word: Death Conditions.

    Build By: MTS
    ---------------------------------------------------]]
    SWD = function()
      for i=1,#mts_unitCache do
        if mts_immuneEvents(mts_unitCache[i])
        and ProbablyEngine.condition["health"](mts_unitCache[i]) <= 20
        and UnitAffectingCombat(mts_unitCache[i])
        and UnitCanAttack("player", mts_unitCache[i])
        and not UnitIsPlayer(mts_unitCache[i]) then
          if ProbablyEngine.parser.can_cast(32379, mts_unitCache[i], false) then
            if mts_infront(mts_unitCache[i]) then
              ProbablyEngine.dsl.parsedTarget = mts_unitCache[i]
              return true
            end
          end
        end
      end
        return false
    end,

    --[[-----------------------------------------------
    ** Druid - MoonFire **
    DESC: Uses unit cache to verify if any unit around
    meets MoonFire Conditions.

    Build By: MTS
    ---------------------------------------------------]]
    MoonFire = function()
      for i=1,#mts_unitCache do
      local _,_,_,_,_,_,debuff = UnitDebuff(mts_unitCache[i], GetSpellInfo(164812), nil, "PLAYER")
        if not debuff or debuff - GetTime() < 5.5 then
          if mts_immuneEvents(mts_unitCache[i])
          and not UnitIsUnit("target", mts_unitCache[i])
          and ProbablyEngine.condition["health"](mts_unitCache[i]) <= 20
          and UnitAffectingCombat(mts_unitCache[i])
          and UnitCanAttack("player", mts_unitCache[i])
          and not UnitIsPlayer(mts_unitCache[i]) then
            if ProbablyEngine.parser.can_cast(164812, mts_unitCache[i], false) then
              if mts_infront(mts_unitCache[i]) then
                ProbablyEngine.dsl.parsedTarget = mts_unitCache[i]
                return true
              end           
            end
          end   
        end
      end
        return false
    end,

    --[[-----------------------------------------------
    ** Hunter Kill Shot **
    DESC: Uses unit cache to verify if any unit around
    meets Kill Shot Conditions.

    Build By: MTS
    ---------------------------------------------------]]
    KillShot = function()
      for i=1,#mts_unitCache do
        if mts_immuneEvents(mts_unitCache[i])
        and ProbablyEngine.condition["health"](mts_unitCache[i]) <= 35
        and UnitAffectingCombat(mts_unitCache[i])
        and UnitCanAttack("player", mts_unitCache[i])
        and not UnitIsPlayer(mts_unitCache[i]) then
          if ProbablyEngine.parser.can_cast(32379, mts_unitCache[i], false) then
            if mts_infront(mts_unitCache[i])then
              ProbablyEngine.dsl.parsedTarget = mts_unitCache[i]
              return true
            end
          end
        end
      end
            return false
    end
 
})


                                                    --[[ Commands ]]
--[[------------------------------------------------------------------------------------------------------------]]
--[[------------------------------------------------------------------------------------------------------------]]
ProbablyEngine.command.register('mts', function(msg, box)
local command, text = msg:match("^(%S*)%s*(.-)$")

    -- Displays General GUI
    if command == 'config' or command == 'c' then
    	mts_ConfigGUI()
    end

   -- Displays LiveGUI
    if command == 'live' or command == 'status' or command == 's' then
    	mts_showLive()
    end

    -- Displays Class GUI
    if command == 'class' or command == 'cl' then
    	mts_ClassGUI()
    end

	-- Displays Help GUI
	if command == 'help' or command == 'info' or command == 'i' or command == '?' then
		mts_InfoGUI()
	end

end)

                                                 --[[ Global ]]
--[[------------------------------------------------------------------------------------------------------------]]
--[[------------------------------------------------------------------------------------------------------------]]

--[[ Used to compare stuff with GUI's values ]]
function mts_dynamicEval(condition, spell)
	if not condition then return false end
	return ProbablyEngine.dsl.parse(condition, spell or '')
end


                                                --[[ Execute ]]
--[[------------------------------------------------------------------------------------------------------------]]
--[[------------------------------------------------------------------------------------------------------------]]


ProbablyEngine.listener.register("PLAYER_ENTERING_WORLD", function(...)

    --(WORKAROUND) // Create Config Keys
        mts_ConfigGUI()-- Open
        mts_ConfigGUI()-- Close
        
    --(WORKAROUND) // Create Class Keys
        mts_ClassGUI() -- Open
        mts_ClassGUI() -- Close
        
    -- Splash
        mts_Splash("|cff9482C9[MTS]-|cffFFFFFF"..(select(2, GetSpecializationInfo(GetSpecialization())) or "Error").."-|cff9482C9Loaded", 5.0)
    
    -- Status GUI
        mts_showLive()



    --[[-----------------------------------------------
    ** Ticker **
    DESC: MoveTo & Face.

    Build By: MTS
    ---------------------------------------------------]]
    C_Timer.NewTicker(0.5, (function()
      if FireHack or oexecute then
        if ProbablyEngine.config.read('button_states', 'MasterToggle', false)
        and ProbablyEngine.module.player.combat then
          if UnitExists("target")
          and not UnitIsFriend("player", "target") then
            if fetch('mtsconf', 'AutoMove') then
              mts_MoveTo('target', mts_rangeNeeded())
            end
            if fetch('mtsconf', 'AutoFace') then
             mts_FaceTo('target')
            end
          end
        end
      end
    end), nil)

    --[[-----------------------------------------------
    ** Ticker **
    DESC: Refresh unit cache & autoTarget.

    Build By: MTS
    ---------------------------------------------------]]
    C_Timer.NewTicker(0.1, (function()
        if ProbablyEngine.config.read('button_states', 'MasterToggle', false)
        and ProbablyEngine.module.player.combat then
            mts_autoTarget()
            cache()
        end
    end), nil)


end)