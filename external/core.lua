--[[ ///---INFO---////
//General Lib//
Thank You For Using My ProFiles
I Hope Your Enjoy Them
MTS
]]

local mtsLib = {}
local _media = "Interface\\AddOns\\Probably_MrTheSoulz\\media\\"
local fetch = ProbablyEngine.interface.fetchKey
local mts_Dummies = {
	31146,
	67127,
	46647,
	32546,
	31144,
	32667,
	32542,
	32666,
	32545,
	32541
}

mts_Version = "0.13.1"
mts_Icon = "|TInterface\\AddOns\\Probably_MrTheSoulz\\media\\logo.blp:16:16|t"
mts_peRecomemded = "6.0.3r9-|cffC41F3BDEV|r"
mtsLib.queueSpell = nil
mtsLib.queueTime = 0

function mts_dynamicEval(condition, spell)
	if not condition then return false end
	return ProbablyEngine.dsl.parse(condition, spell or '')
end

-- Cab Use Taunts
function mtsLib.CanTaunt()
	if UnitIsTappedByPlayer("target") 
		and fetch('mtsconf','Taunts') then
			return true 
	end
		return false
end



function mtsLib.mouseNotEqualTarget()
	if (UnitGUID('target')) ~= (UnitGUID('mouseover')) then
		return true
	end
end

function mtsLib.CanUseItem(key)
	if fetch('mtsconf','Items') 
	 	and GetItemCount(key) > 1 
	 	and GetItemCooldown(key) == 0 then 
			return true
	end
 		return false
end

									--[[   !!!Check Queue!!!   ]]
				--[[   !!!I Dont Remember who originaly build this, but thanks!!!!   ]]
--[[  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ]]
function mtsLib.checkQueue(spellId)
    if (GetTime() - mtsLib.queueTime) > 10 then
        mtsLib.queueTime = 0
        mtsLib.queueSpell = nil
    return false
    else
    if mtsLib.queueSpell then
        if mtsLib.queueSpell == spellId then
            if ProbablyEngine.parser.lastCast == GetSpellName(spellId) then
                mtsLib.queueSpell = nil
                mtsLib.queueTime = 0
            end
        return true
        end
    end
    end
    return false
end

							--[[   !!!Check If Should Stop Dps!!!   ]]
			--[[   !!!I Dont Remember who originaly build this, but thanks!!!!   ]]
			-- [[   Used to Not break CC's or when it should not attack on special events.]]
--[[  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ]]
function mtsLib.immuneEvents(unit)
  if not UnitAffectingCombat(unit) then return false end
  -- Crowd Control
  local cc = {
    49203, -- Hungering Cold
     6770, -- Sap
     1776, -- Gouge
    51514, -- Hex
     9484, -- Shackle Undead
      118, -- Polymorph
    28272, -- Polymorph (pig)
    28271, -- Polymorph (turtle)
    61305, -- Polymorph (black cat)
    61025, -- Polymorph (serpent) -- FIXME: gone ?
    61721, -- Polymorph (rabbit)
    61780, -- Polymorph (turkey)
     3355, -- Freezing Trap
    19386, -- Wyvern Sting
    20066, -- Repentance
    90337, -- Bad Manner (Monkey) -- FIXME: to check
     2637, -- Hibernate
    82676, -- Ring of Frost
   115078, -- Paralysis
    76780, -- Bind Elemental
     9484, -- Shackle Undead
     1513, -- Scare Beast
   115268, -- Mesmerize
  }
  if mtsLib.hasDebuffTable(unit, cc) then return false end
  if UnitAura(unit,GetSpellInfo(116994))
		or UnitAura(unit,GetSpellInfo(122540))
		or UnitAura(unit,GetSpellInfo(123250))
		or UnitAura(unit,GetSpellInfo(106062))
		or UnitAura(unit,GetSpellInfo(110945))
		or UnitAura(unit,GetSpellInfo(143593)) -- General Nazgrim: Defensive Stance
    	or UnitAura(unit,GetSpellInfo(143574)) -- Heroic Immerseus: Swelling Corruption
		then return false end
  return true
end

function mtsLib.hasDebuffTable(target, spells)
  for i = 1, 40 do
    local _,_,_,_,_,_,_,_,_,_,spellId = _G['UnitDebuff'](target, i)
    for k,v in pairs(spells) do
      if spellId == v then return true end
    end
  end
end

							--[[   !!!Check if it is a dummy!!!   ]]
					--[[   Used to not Taunt Dummy's like a noob, and other situations.   ]]
--[[  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ]]
function mtsLib.dummy()	
	for i=1, #mts_Dummies do
		if UnitExists("target") then
			mts_Dummies_ID = tonumber(UnitGUID("target"):sub(-13, -9), 16)
		else
			mts_Dummies_ID = 0
		end
		if mts_Dummies_ID == mts_Dummies[i] then
			return false
		else
			return true
		end	
	end
end

ProbablyEngine.library.register('mtsLib', mtsLib)
