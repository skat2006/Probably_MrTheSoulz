--[[ ///---INFO---////
//Core//
Thank You For Using My ProFiles
I Hope Your Enjoy Them
MTS
]]

mts_Version = "0.1.3.0"
mts_Icon = "|TInterface\\AddOns\\Probably_MrTheSoulz\\media\\logo.blp:16:16|t"
mts_peRecomemded = "6.0.3r11"

local fetch = ProbablyEngine.interface.fetchKey
local _parse = ProbablyEngine.dsl.parse
local _PeConfig = ProbablyEngine.config

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

local ranged = {
    62,         -- arcane mage
    63,         -- fire mage
    64,         -- frost mage
    65,         -- holy paladin
    102,        -- balance druid
    105,        -- restoration druid
    253,        -- beast mastery hunter
    254,        -- marksmanship hunter
    255,        -- survival hunter
    256,        -- discipline priest
    257,        -- holy priest
    258,        -- shadow priest
    262,        -- elemental shaman
    263,        -- enhancement shaman
    264,        -- restoration shaman
    265,        -- affliction warlock
    266,        -- demonology warlock
    267,        -- destruction warlock
    270,        -- mistweaver monk
  }



                                                --[[ Local Functions ]]
--[[------------------------------------------------------------------------------------------------------------]]
--[[------------------------------------------------------------------------------------------------------------]]

--[[-----------------------------------------------
** Automated Targets **
DESC: Checks if unit can/should be targeted.

Build By: MTS & StinkyTwitch
---------------------------------------------------]]
local function mts_autoTarget()
    for i=1,#mts_unitCache do
        if UnitExists("target") and not UnitIsFriend("player", "target") and not UnitIsDeadOrGhost("target") then
            -- Do nothing
        else
            return Macro("/target "..mts_unitCache[i].key)
        end
    end
end
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

    if command == 'ch' or command == 'cache' then
        mts_cacheGUI()
    end

end)

                                                 --[[ Global ]]
--[[------------------------------------------------------------------------------------------------------------]]
--[[------------------------------------------------------------------------------------------------------------]]

--[[ Used to compare stuff with GUI's values ]]
function mts_dynamicEval(condition, spell)
	if not condition then return false end
	return _parse(condition, spell or '')
end

function mts_immuneEvents(unit, spells)
  for i = 1, 40 do
    local _,_,_,_,_,_,_,_,_,_,spellId = _G['UnitDebuff'](unit, i)
    for k,v in pairs(mts_ImmuneAuras) do
      if spellId == v then return true end
    end
  end
end

--[[-----------------------------------------------
** Im a Ranged? **
DESC: Checks what range do i need.

Build By: MTS
---------------------------------------------------]]
function mts_rangeNeeded(unit)
  local _SpecID =  GetSpecializationInfo(GetSpecialization())
  if UnitExists(unit) then
      for i=1,#ranged do
        -- If its a ranged
        if _SpecID == ranged[i] then
            -- If we're using FH // 30 + Player's and Unit's combat range
            if FireHack then return (30 + (ObjectPosition('player') + UnitCombatReach(unit)))
            -- Other unlockers dont have UnitCombatReach
            else return 30 end
        else
            -- If we're using FH // 6 + Player's and Unit's combat range
            if FireHack then return (6 + (ObjectPosition('player') + UnitCombatReach(unit)))
            -- Other unlockers dont have UnitCombatReach
            else return 6 end
        end
      end
    end
end

--[[-----------------------------------------------
** Infront **
DESC: Checks if unit is infront.
Replaces PE build in one beacuse PE's is over sensitive.

Build By: Mirakuru
Modified by: MTS
---------------------------------------------------]]
function mts_infront(unit)
  
  if UnitExists(unit) and UnitIsVisible(unit) then
    
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
end

--[[-----------------------------------------------
** mts_Distance **
DESC: Sometimes PE's behaves badly,
So here we go...

Build By: MTS
---------------------------------------------------]]
function mts_Distance(a, b)
  
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
    ** Racials **
    DESC: Checks what race player is and if racial meats
    conditions.     
    UNUSED AND UNTESTED!

    Build By: MTS
    ---------------------------------------------------]]
function mts_Racials()
    local race = UnitRace("player")
    if race == Humman then
        if _parse("player.state.fear")
        or _parse("player.state.charm")
        or _parse("player.state.incapacitate")
        or _parse("player.state.sleep")
        or _parse("player.state.stun") then
            CastSpellByID("59752")
        end
    elseif race == Dwarf then
        if _parse("player.health <= 65") then
            CastSpellByID("20594", "player")
        end
    elseif race == Undead then
        if _parse("player.state.fear")
        or _parse("player.state.charm")
        or _parse("player.state.sleep") then
            CastSpellByID("7744")
        end
    elseif race == Gnome then
        if _parse("player.state.root")
        or _parse("player.state.snare") then
            CastSpellByID("20589")
        end
    elseif race == Goblin then
         if _parse("player.moving") then
            CastSpellByID("69041")
        end
    elseif race == Draenei then
        if _parse("player.health <= 70") then
            CastSpellByID("28880", "player")
        end
    end
end


-- TO BE REMOVED
function mts_WildMushroom()
  local minHeal = (GetSpellBonusDamage(2) * 1.125) + (GetCombatRatingBonus(CR_VERSATILITY_DAMAGE_DONE) + GetVersatilityBonus(CR_VERSATILITY_DAMAGE_DONE))
  local playerTotal = 0
  local focusTotal = 0
  local prefix = (IsInRaid() and 'raid') or 'party'
  local WildMushroom_cache_time_c = WildMushroom_cache_time
      
      for i=1,#mts_unitCache do
      local incomingHeals = UnitGetIncomingHeals(mts_unitCache[i].key) or 0
      local absorbs = UnitGetTotalHealAbsorbs(mts_unitCache[i].key) or 0
      local health = UnitHealth(mts_unitCache[i].key) + incomingHeals - absorbs
      local maxHealth = UnitHealthMax(mts_unitCache[i].key)
      local healthMissing = max(0, maxHealth - health)
        
        if healthMissing > minHeal and UnitIsFriend("player", mts_unitCache[i].key) then
          if mts_Distance("player", mts_unitCache[i].key) <= 12 then
            playerTotal = playerTotal + 1
          end
        end
        if healthMissing > minHeal and UnitIsFriend("player", mts_unitCache[i].key) then
            if UnitExists('focus') then
              if mts_Distance("focus", mts_unitCache[i].key) <= 12 then
                focusTotal = focusTotal + 1
              end
            end
        end
      
      end

      --print('player: '..playerTotal..' focus: '..focusTotal)
        
      if playerTotal > focusTotal then
        if playerTotal > 2 then
            return 'player'
        end
      else
            return 'focus'
      end

end

                                                --[[ Execute ]]
--[[------------------------------------------------------------------------------------------------------------]]
--[[------------------------------------------------------------------------------------------------------------]]



--[[-----------------------------------------------
** Ticker **
DESC: MoveTo & Face.

Build By: MTS
 ---------------------------------------------------]]
C_Timer.NewTicker(0.1, (function()
  --No Point in Trying any of these if not using an advanced unlocker
  if FireHack or oexecute then
    
    if _PeConfig.read('button_states', 'MasterToggle', false)
    and ProbablyEngine.module.player.combat then
      -- Can we target?
      if fetch('mtsconf', 'AutoTarget') then
        mts_autoTarget()
      end
    
    end

  end
end), nil)