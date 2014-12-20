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
        
    -- Splash
        mts_Splash("|cff9482C9[MTS]-|cffFFFFFF"..(select(2, GetSpecializationInfo(GetSpecialization())) or "Error").."-|cff9482C9Loaded", 5.0)
    
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

ProbablyEngine.listener.register("COMBAT_LOG_EVENT_UNFILTERED", function(...)
	local event			= select(2, ...)
	local sourceGUID	= select(4, ...)
	local targetGUID	= select(8, ...)
	local targetName	= select(9, ...)
	local spellID		= select(12, ...)
	
		if sourceGUID ~= UnitGUID("player") then 
			return false 
		end

		if event == "SPELL_CAST_SUCCESS" then	

		-- Monk
			if spellID == 115175 then
				mts_SoothingMist_Target = targetName
			end

		end
end)