--[[ ///---INFO---////
//General Lib//
Thank You For Using My ProFiles
I Hope Your Enjoy Them
MTS
]]
local _playerClass, _englishClass, _idClass = UnitClass("player");
local _playerSpec = GetSpecialization()
mtsConfig = {}

function mtsinitConfig()
mtsConfig = mConfig:createConfig("\124cff9482C9MrTheSoulz Pack Settings","mtsConfig","1",{"/mts"})

	-- Info
		mtsConfig:addTitle("---> Pack Information: <---")
		mtsConfig:addText2("Ive built this pack for my own personal use and to contribute back to the PE comunity. \nIf you find any issues while using it people report it on the forum's.")
		mtsConfig:addText2("Created by: MrTheSoulz.")
		mtsConfig:addText("\124cffC41F3BDO NOT TOUCH ANYTHING, IT WILL BREAK!")
	
	-- General
		mtsConfig:addTitle("---> General Settings: <---")
		mtsConfig:addText("Everything in here is shared across all of the profiles.")
		mtsConfig:addCheckBox("getAlerts", "Show Notifications", "Shows notification on top when used certain spells.", true)
		mtsConfig:addCheckBox("getAlertSounds", "Notifications Sounds", "Plays a sound when a notification is shown.", true)
		mtsConfig:addCheckBox("getWhispers", "Allow Whispers", "Whispers people after using certain spells.", false)
		mtsConfig:addCheckBox("getTaunts", "Allow Taunts", "Enables or disables the usage of smart taunts.", false)
		mtsConfig:addCheckBox("getSplash", "Allow Splash", "Enable or disable MTS Splash when loading the pack.", true)
		mtsConfig:addCheckBox("getFirehack", "Allow FireHack Features", "Enable or disable the usage of Firehack's features", true)
	
	if _idClass == 2 then -- Paladin

		-- Holy
			mtsConfig:addTitle("\124cffF58CBA---> Paladin Holy: <---")
			mtsConfig:addText("Keybinds:")
			mtsConfig:addText2("Shift: Light´s Hammer \nAlt: Mouseover Focus")

		-- Protection
			mtsConfig:addTitle("\124cffF58CBA---> Paladin Protection: <---")
			mtsConfig:addText("Keybinds:")
			mtsConfig:addText2("Control:  Fist of Justice OR Hammer of Justice \nShift: Light´s Hammer \nAlt: Consecration IF glyphed")

	end

	if _idClass == 1 then -- Warrior 
		-- Fury
			mtsConfig:addTitle("\124cffC79C6E---> Warrior Fury: <---")
			mtsConfig:addText("Keybinds:")
			mtsConfig:addText2("Alt: Charge")

		-- Warrior Protection
			mtsConfig:addTitle("\124cffC79C6E---> Warrior Protection: <---")
			mtsConfig:addText("Keybinds:")
			mtsConfig:addText2("Alt: Charge")
	end

    if _idClass == 6 then -- DeathKinght

		-- DeathKinght Blood
			mtsConfig:addTitle("\124cffC41F3B---> DeathKinght Blood: <---")
			mtsConfig:addText("Keybinds:")
			mtsConfig:addText2("Control: Death Grip \nShift: Death and Decay \nAlt: Army of the Dead")

		-- DeathKinght Frost
			mtsConfig:addTitle("\124cffC41F3B---> DeathKinght Frost: <---")
			mtsConfig:addText("Keybinds:")
			mtsConfig:addText2("Control: Death Grip \nShift: Death and Decay \nAlt: Army of the Dead")
			
		-- DeathKinght unholy
			mtsConfig:addTitle("\124cffC41F3B---> DeathKinght Unholy: <---")
			mtsConfig:addText("Keybinds:")
			mtsConfig:addText2("Control: Death Grip \nShift: Death and Decay \nAlt: Army of the Dead")

	end
	
	if _idClass == 5 then -- DeathKinght

		-- Priest Discipline
			mtsConfig:addTitle("\124cffFFFFFF---> Priest Discipline: <---")
			mtsConfig:addText("Keybinds:")
			mtsConfig:addText2("To Be Filled...")

		-- Priest Holy
			mtsConfig:addTitle("\124cffFFFFFF---> Priest Holy: <---")
			mtsConfig:addText("Keybinds:")
			mtsConfig:addText2("To Be Filled...")

		-- Priest Shadow
			mtsConfig:addTitle("\124cffFFFFFF---> Priest Shadow: <---")
			mtsConfig:addText("Keybinds:")
			mtsConfig:addText2("To Be Filled...")

	end

	
	if _idClass == 11 then -- Druid 
		
		-- Feral
			mtsConfig:addTitle("\124cffFF7D0A---> Druid Feral: <---")
			mtsConfig:addText("Keybinds:")
			mtsConfig:addText2("To Be Filled...")
		
		-- Druid Balance
			mtsConfig:addTitle("\124cffFF7D0A---> Druid Balance: <---")
			mtsConfig:addText("Keybinds:")
			mtsConfig:addText2("To Be Filled...")
		
		-- Druid Guardian
			mtsConfig:addTitle("\124cffFF7D0A---> Druid Guardian: <---")
			mtsConfig:addText("Keybinds:")
			mtsConfig:addText2("To Be Filled...")

		-- Druid Restoration
			mtsConfig:addTitle("\124cffFF7D0A---> Druid Restoration: <---")
			mtsConfig:addText("Keybinds:")
			mtsConfig:addText2("To Be Filled...")

	end
		
	if _idClass == 12 then -- Monk 

		-- Monk WindWalker
			mtsConfig:addTitle("\124cff00FF96---> Monk WindWalker: <---")
			mtsConfig:addText("Keybinds:")
			mtsConfig:addText2("Control: Leg Sweep \nAlt: Touch of Karma")

	end
		
	if _idClass == 9 then --Warlock

		-- Warlock Destro
			mtsConfig:addTitle("\124cff9482C9---> Warlock Destro: <---")
			mtsConfig:addText("Keybinds:")
			mtsConfig:addText2("To Be Filled...")

	end
		
	if _idClass == 3 then -- Hunter 
		
		-- Hunter BeastMaster
			mtsConfig:addTitle("\124cffABD473---> Hunter BeastMaster: <---")
			mtsConfig:addText("Keybinds:")
			mtsConfig:addText2("To Be Filled...")

	end
		
	if _idClass == 8 then -- Mage 

		-- Mage Arcade
			mtsConfig:addTitle("\124cff69CCF0---> Mage Arcade: <---")
			mtsConfig:addText("Keybinds:")
			mtsConfig:addText2("To Be Filled...")

	end
		
	if _idClass == 7 then -- Mage 

		-- Shaman Elemental
			mtsConfig:addTitle("\124cff0070DE---> Shaman Elemental: <---")
			mtsConfig:addText("Keybinds:")
			mtsConfig:addText2("To Be Filled...")
			
		-- Shaman Restoration
			mtsConfig:addTitle("\124cff0070DE---> Shaman Restoration: <---")
			mtsConfig:addText("Keybinds:")
			mtsConfig:addText2("To Be Filled...")

	end
		
end

function mts_ShouldTaunt()
	if UnitIsTappedByPlayer("target") 
	and mtsConfig:get('getTaunts') then
		return true
	else
		return false
	end
end

function mts_getSetting(txt)
	return mtsConfig:get(txt)
end

function mts_ConfigWhisper(txt)
	if mtsConfig:get('getWhispers') then
		return RunMacroText("/w "..txt)
	end
	return false
end

function mts_AlertSounds()
	if mtsConfig:get('getAlertSounds') then
		PlaySoundFile("Sound\\Character\\PlayerRoars\\CharacterRoarsUndeadMale.wav")
	end
end

function mts_ConfigAlert(txt)
	if mtsConfig:get('getAlerts') then
		return mtsAlert:message(txt)
	end
end

function mts_ConfigShouldUseSpell(key)
	return mtsConfig:get(key)
end

function mts_ConfigUnitHpBelowThreshold(key,unit)
	return ProbablyEngine.condition["health"](unit) <= mtsConfig:get(key)
end

function mts_modifierActionForSpellIsAlt(name)
	return IsAltKeyDown() and not GetCurrentKeyBoardFocus() and mtsConfig:get("altKeyAction")==name
end

function mts_modifierActionForSpellIsShift(name)
	return IsShiftKeyDown() and not GetCurrentKeyBoardFocus() and mtsConfig:get("shiftKeyAction")==name
end

function mts_modifierActionForSpellIsControl(name)
	return IsControlKeyDown() and not GetCurrentKeyBoardFocus() and mtsConfig:get("controlKeyAction")==name
end

mtsinitConfig()