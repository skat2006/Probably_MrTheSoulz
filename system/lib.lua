--[[ ///---INFO---////
//General Lib//
Thank You For Using My ProFiles
I Hope Your Enjoy Them
MTS
]]

													--[[ Local's ]]
--[[------------------------------------------------------------------------------------------------------------]]
--[[------------------------------------------------------------------------------------------------------------]]

local mtsLib = {}
local _media = "Interface\\AddOns\\Probably_MrTheSoulz\\media\\"
local fetch = ProbablyEngine.interface.fetchKey
local _queueSpell = nil
local _queueTime = 0
local _dotCount = 0

													--[[ Lib ]]
--[[------------------------------------------------------------------------------------------------------------]]
--[[------------------------------------------------------------------------------------------------------------]]

									--[[   !!!Check Queue!!!   ]]
				--[[   !!!I Dont Remember who originaly build this, but thanks!!!!   ]]
--[[  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ]]
function mtsLib.checkQueue(spellId)
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
end

-- Can Use Taunts
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

							--[[   !!!Check if it is a dummy!!!   ]]
					--[[   Used to not Taunt Dummy's like a noob, and other situations.   ]]
--[[  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ]]
function mtsLib.dummy()
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
