local fetch = ProbablyEngine.interface.fetchKey
local mts_inWorld = false
mts_SoothingMist_Target = nil

function mts_soothingMist(ht)
	if mts_SoothingMist_Target ~= nil then
		local health = math.floor((UnitHealth(mts_SoothingMist_Target) / UnitHealthMax(mts_SoothingMist_Target)) * 100)
			if health >= ht then
				return true
			end
	end
	return false
end

ProbablyEngine.listener.register("PLAYER_ENTERING_WORLD", function(...)

    --(WORKAROUND) // Create Config Keys
        mts_ConfigGUI()-- Open
        mts_ConfigGUI()-- Close
        
    --(WORKAROUND) // Create Class Keys
        mts_ClassGUI() -- Open
        mts_ClassGUI() -- Close
    
    -- Status GUI
        mts_showLive()

    mts_inWorld = true

end)

ProbablyEngine.listener.register("ACTIVE_TALENT_GROUP_CHANGED", function(...)

    -- Reload when player changes spec to avoid key nils.
    	if mts_inWorld then
        	ReloadUI()
        end

end)






-- Temp Solution for combat unit tracking while not using FH.

local band = bit.band

local HostileEvents = {
        ['SWING_DAMAGE'] = true,
        ['SWING_MISSED'] = true,
        ['RANGE_DAMAGE'] = true,
        ['RANGE_MISSED'] = true,
        ['SPELL_DAMAGE'] = true,
        ['SPELL_PERIODIC_DAMAGE'] = true,
        ['SPELL_MISSED'] = true
}

ProbablyEngine.listener.register("COMBAT_LOG_EVENT_UNFILTERED", function(...)
  local timeStamp, event, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, _ = ...
  
  	if event == "SPELL_CAST_SUCCESS" then
		if sourceGUID == UnitGUID("player") then	
			-- Monk MW // Soothing Mist
			if spellID == 115175 then
				mts_SoothingMist_Target = targetName
			end
		end
  	end
end)