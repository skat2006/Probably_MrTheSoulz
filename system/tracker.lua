--[[ ///---INFO---////
// Splash GUI //
Thank Your For Using My ProFiles
I Hope Your Enjoy Them
MTS
]]

local fetch = ProbablyEngine.interface.fetchKey

local function mts_CanWhisper(txt)
	if fetch('mtsconf','Whispers') then
		return RunMacroText("/w "..txt)
	end
end

local function mts_CanSound()
	if fetch('mtsconf','Sounds') then
		PlaySoundFile("Interface\\AddOns\\Probably_MrTheSoulz\\media\\beep.mp3", "master")
	end
end

local function mts_CanAlert(txt)
	if fetch('mtsconf','Alerts') then
		return mtsAlert:message(txt) 
	end
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

end)

ProbablyEngine.listener.register("ACTIVE_TALENT_GROUP_CHANGED", function(...)

    -- Reload when player changes spec to avoid key nils.
        ReloadUI()

end)

								--[[   !!!Combat Alert Tracker!!!   ]]
						     --[[   Used For Spiting Alerts & sounds   ]]
--[[  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ]]
ProbablyEngine.listener.register("COMBAT_LOG_EVENT_UNFILTERED", function(...)
local event = select(2, ...)
local source = select(4, ...)
local spellId = select(12, ...)
local tname = UnitName("target")
if source ~= UnitGUID("player") then return false end

	if event == "SPELL_CAST_SUCCESS" then	

    -- Paladin

		if spellId == 114158 then
			mts_CanSound()
			mts_CanAlert("*Casted Light´s Hammer*")
		end
		if spellId == 633 then
			mts_CanSound()
			mts_CanWhisper(tname.." MSG: Casted Lay On Hands on you.")
			mts_CanAlert("*Casted Lay on Hands*")
		end
		if spellId == 1044 then
			mts_CanSound()
			mts_CanWhisper(tname.." MSG: Casted Hand of Freedom on you.")
			mts_CanAlert("*Casted Hand of Freedom*")
		end
		if spellId == 6940 then
			mts_CanSound()
			mts_CanAlert("*Casted Hand of Sacrifice*")
			mts_CanWhisper("/w "..tname.." MSG: Casted Hand of Sacrifice on you.")
		end
		if spellId == 105593 then
			mts_CanSound()
			mts_CanAlert("*Stunned Target*")
		end
		if spellId == 853 then
			mts_CanSound()
			mts_CanAlert("*Stunned Target*")
		end
		if spellId == 31821 then
			mts_CanSound()
			mts_CanAlert("*Casted Devotion Aura*")
		end
		if spellId == 31884 then
			mts_CanSound()
			mts_CanAlert("*Casted Avenging Wrath*")
		end
		if spellId == 105809 then
			mts_CanSound()
			mts_CanAlert("*Casted Guardian of Ancient Kings*")
		end
		if spellId == 31850 then
			mts_CanSound()
			mts_CanAlert("*Casted Ardent Defender*")
		end
		if spellId == 86659 then
			mts_CanSound()
			mts_CanAlert("*Casted Holy Avenger*")
		end
		if spellId == 86669 then
			mts_CanSound()
			mts_CanAlert("*Casted Guardian of Ancient Kings*")
		end
		if spellId == 31842 then
			mts_CanSound()
			mts_CanAlert("*Casted Divine Favor*")
		end

    -- DeathKnight

		if spellId == 43265 then
			mts_CanSound()
			mts_CanAlert("*Casted Death and Decay*")
		end
		if spellId == 48707 then
			mts_CanSound()
			mts_CanAlert("*Casted Anti-Magic Shell*")
		end
		if spellId == 49028 then
			mts_CanSound()
			mts_CanAlert("*Casted Dancing Rune Weapon*")
		end
		if spellId == 55233 then
			mts_CanSound()
			mts_CanAlert("*Casted Vampiric Blood*")
		end
		if spellId == 48792 then
			mts_CanSound()
			mts_CanAlert("*Casted Icebound Fortitude*")
		end
		if spellId == 42650 then
			mts_CanSound()
			mts_CanAlert("*Casting Army of the Dead*")
		end

	end
end)