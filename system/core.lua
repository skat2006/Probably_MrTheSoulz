--[[ ///---INFO---////
//Core//
Thank You For Using My ProFiles
I Hope Your Enjoy Them
MTS
]]

mts_Version = "0.1.3.3"
mts_Icon = "|TInterface\\AddOns\\Probably_MrTheSoulz\\media\\logo.blp:16:16|t"
mts_peRecomemded = "6.0.3r11"
mts_CurrentCR = false

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

    -- Fallback to PE's
    else
        return ProbablyEngine.condition["distance"](b)
    
    end
  
  end
    return 0
end