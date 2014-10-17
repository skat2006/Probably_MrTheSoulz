--[[ ///---INFO---////
//General Lib//
Thank You For Using My ProFiles
I Hope Your Enjoy Them
MTS
]]

ProbablyEngine.listener.register("COMBAT_LOG_EVENT_UNFILTERED", function(...)
local event = select(2, ...)
local source = select(4, ...)
local spellId = select(12, ...)
local tname = UnitName("target")
if source ~= UnitGUID("player") then return false end

	if event == "SPELL_CAST_SUCCESS" then	

    -- Paladin

		if spellId == 114158 then
			mtsLib.ConfigAlertSound()
			mtsLib.ConfigAlert("*Casted Light´s Hammer*")
		end
		if spellId == 633 then
			mtsLib.ConfigAlertSound()
			mtsLib.ConfigWhisper(tname.." MSG: Casted Lay On Hands on you.")
			mtsLib.ConfigAlert("*Casted Lay on Hands*")
		end
		if spellId == 1044 then
			mtsLib.ConfigAlertSound()
			mtsLib.ConfigWhisper(tname.." MSG: Casted Hand of Freedom on you.")
			mtsLib.ConfigAlert("*Casted Hand of Freedom*")
		end
		if spellId == 6940 then
			mtsLib.ConfigAlertSound()
			mtsLib.ConfigAlert("*Casted Hand of Sacrifice*")
			mtsLib.ConfigWhisper("/w "..tname.." MSG: Casted Hand of Sacrifice on you.")
		end
		if spellId == 105593 then
			mtsLib.ConfigAlertSound()
			mtsLib.ConfigAlert("*Stunned Target*")
		end
		if spellId == 853 then
			mtsLib.ConfigAlertSound()
			mtsLib.ConfigAlert("*Stunned Target*")
		end
		if spellId == 31821 then
			mtsLib.ConfigAlertSound()
			mtsLib.ConfigAlert("*Casted Devotion Aura*")
		end
		if spellId == 31884 then
			mtsLib.ConfigAlertSound()
			mtsLib.ConfigAlert("*Casted Avenging Wrath*")
		end
		if spellId == 105809 then
			mtsLib.ConfigAlertSound()
			mtsLib.ConfigAlert("*Casted Guardian of Ancient Kings*")
		end
		if spellId == 31850 then
			mtsLib.ConfigAlertSound()
			mtsLib.ConfigAlert("*Casted Ardent Defender*")
		end
		if spellId == 86659 then
			mtsLib.ConfigAlertSound()
			mtsLib.ConfigAlert("*Casted Holy Avenger*")
		end
		if spellId == 86669 then
			mtsLib.ConfigAlertSound()
			mtsLib.ConfigAlert("*Casted Guardian of Ancient Kings*")
		end
		if spellId == 31842 then
			mtsLib.ConfigAlertSound()
			mtsLib.ConfigAlert("*Casted Divine Favor*")
		end

    -- DeathKnight

		if spellId == 43265 then
			mts:message("*Casted Death and Decay*")
		end
		if spellId == 48707 then
			mts:message("*Casted Anti-Magic Shell*")
		end
		if spellId == 49028 then
			mts:message("*Casted Dancing Rune Weapon*")
		end
		if spellId == 55233 then
			mts:message("*Casted Vampiric Blood*")
		end
		if spellId == 48792 then
			mts:message("*Casted Icebound Fortitude*")
		end

	end
end)