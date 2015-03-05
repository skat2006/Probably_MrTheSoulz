local fetch = ProbablyEngine.interface.fetchKey
local mts_inWorld = false
local mts_SoothingMist_Target = nil

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
	--(WORKAROUND) // Create Config Keys // Open
        mts.ConfigGUI()
        mts.ClassGUI()
	--(WORKAROUND) // Create Class Keys // Close
	mts.ConfigGUI()
	mts.ClassGUI()
    	-- Status GUI
        mts.ShowStatus()
        -- This is used to only do/load stuff once inside the world
	mts_inWorld = true
end)

ProbablyEngine.listener.register("ACTIVE_TALENT_GROUP_CHANGED", function(...)
    -- Reload when player changes spec to avoid key nils.
    	if mts_inWorld then
		ReloadUI()
        end
end)

ProbablyEngine.listener.register("COMBAT_LOG_EVENT_UNFILTERED", function(...)
  	local timeStamp, event, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellID = ...
  	if event == "SPELL_CAST_SUCCESS" then
		if sourceGUID == UnitGUID("player") then
			-- Monk MW // Soothing Mist
			if spellID == 115175 then
				mts_SoothingMist_Target = targetName
			end
		end
  	end
end)

ProbablyEngine.listener.register("LFG_PROPOSAL_SHOW", function()
	if fetch('mtsconf', 'AutoLFG') then
		AcceptProposal()
	end
end)
