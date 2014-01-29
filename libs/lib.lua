--[[ ///---INFO---////
//General Lib//
Thank Your For Your My ProFiles
I Hope Your Enjoy Them
MTS
]]

local mtsLib = {}
local media = "Interface\\AddOns\\Probably_MrTheSoulz\\media\\"
local _playerClass, _englishClass, _idClass = UnitClass("player");
local _playerSpec = GetSpecialization();
local mts_Dummies = {31146,67127,46647,32546,31144,32667,32542,32666,32545,32541}
local cc = {49203,6770,1776,51514,9484,118,28272,28271,61305,61025,61721,61780,3355,19386,20066,90337,2637,82676,115078,76780,9484,1513,115268}

function mtsLib.StopIfBoss()
if UnitExists("boss1") then
local npcId = tonumber(UnitGUID("target"):sub(6,10), 16)
	if npcId == 71543 then boss = true end -- Immersus
	if npcId == 72276 then boss = true end -- Norushen
	if npcId == 71734 then boss = true end -- Sha of Pride
	if npcId == 72249 then boss = true end -- Galakras
	if npcId == 71466 then boss = true end -- Iron Juggernaut
	if npcId == 71859 then boss = true end -- Kor'kron Dark Shaman
	if npcId == 71515 then boss = true end -- General Nazgrim
	if npcId == 71454 then boss = true end -- Malkorok
	if npcId == 71529 then boss = true end -- Thok the Bloodsthirsty
	if npcId == 71504 then boss = true end -- Siegecrafter Blackfuse
	if npcId == 71865 then boss = true end -- Garrosh Hellscream
	if boss then 
		return false
	end
end
	return true 
end

function mtsLib.stackCheck(spell, otherTank, stacks)
	local debuffName, _, _, debuffCount = UnitDebuff(otherTank, spell)
	if debuffName and debuffCount >= stacks and not UnitDebuff("player", spell) then
		return true
	end 
        return false
end

function mtsLib.bossTaunt()
	if UnitGroupRolesAssigned("player") == "TANK" and IsInRaid() then
	local otherTank
	for i = 1, GetNumGroupMembers() do
		local other = "raid" .. i
			if not otherTank and not UnitIsUnit("player", other) and UnitGroupRolesAssigned(other) == "TANK" then
				otherTank = other
			end
		end
		if otherTank and not UnitIsDeadOrGhost(otherTank) then
			for j = 1, 4 do
			local bossID = "boss" .. j
			local boss = UnitID(bossID) -- /script print(UnitID("target"))

		-- //////////////////////--------------------SoO--------------------------//////////////////////////////

				if boss == 71543 then -- Immersus
					if mtsLib.stackCheck("Corrosive Blast", otherTank, 1) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end 
				elseif boss == 72276 then -- Norushen
					if mtsLib.stackCheck("Self Doubt", otherTank, 3) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end 
				elseif boss == 71734 then -- Sha of Pride
					if mtsLib.stackCheck("Wounded Pride", otherTank, 1) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 72249 then -- Galakras
					if mtsLib.stackCheck("Flames of Galakrond", otherTank, 3) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end  
				elseif boss == 71466 then -- Iron Juggernaut
					if mtsLib.stackCheck("Ignite Armor", otherTank, 2) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end  
				elseif boss == 71859 then -- Kor'kron Dark Shaman / Earthbreaker Haromm
					if mtsLib.stackCheck("Froststorm Strike", otherTank, 5) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end   
				elseif boss == 71515 then -- General Nazgrim
					if mtsLib.stackCheck("Sundering Blow", otherTank, 3) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 71454 then -- Malkorok
					if mtsLib.stackCheck("Fatal Strike", otherTank, 12) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 71529 then -- Thok the Bloodsthirsty
					if mtsLib.stackCheck("Panic", otherTank, 3)
					or mtsLib.stackCheck("Acid Breath", otherTank, 3) 
					or mtsLib.stackCheck("Freezing Breath", otherTank, 3)
					or mtsLib.stackCheck("Scorching Breath", otherTank, 3) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 71504 then -- Siegecrafter Blackfuse
					if mtsLib.stackCheck("Electrostatic Charge", otherTank, 4) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 71865 then -- Garrosh Hellscream
					if mtsLib.stackCheck("Gripping Despair", otherTank, 3)
					or mtsLib.stackCheck("Empowered Gripping Despair", otherTank, 3) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end
				end 

		-- //////////////////////--------------------ToT--------------------------//////////////////////////////

				if boss == 69465 then -- Jin’rokh the Breaker
				local debuffName, _, _, debuffCount = UnitDebuff(otherTank, "Static Wound")
				local debuffName2, _, _, debuffCount2 = UnitDebuff("player", "Static Wound")
					if debuffName 
					and ( not debuffName2 or debuffCount > debuffCount2) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 68476 then -- Horridon
					if mtsLib.stackCheck("Triple Puncture", otherTank, 9) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 69131 then -- Council of Elders / Frost King Malakk
					if mtsLib.stackCheck("Frigid Assault", otherTank, 13) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end                                
				elseif boss == 69712 then -- Ji-Kun
					if mtsLib.stackCheck("Talon Rake", otherTank, 2) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 68036 then -- Durumu the Forgotten
					if mtsLib.stackCheck("Hard Stare", otherTank, 5) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 69017 then -- Primordius
					if mtsLib.stackCheck("Malformed Blood", otherTank, 8) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 69699 then -- Dark Animus - Massive Anima Golem
					if mtsLib.stackCheck("Explosive Slam", otherTank, 5) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 68078 then -- Iron Qon
					if mtsLib.stackCheck("Impale", otherTank, 4) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 68905 then -- Twin Consorts - Lu’lin
					if mtsLib.stackCheck("Beast of Nightmare", otherTank, 1) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 68904 then -- Twin Consorts - Suen
					if mtsLib.stackCheck("Fan of Flames", otherTank, 3) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 68397 then -- Lei Shen
					if mtsLib.stackCheck("Decapitate", otherTank, 1) 
					or mtsLib.stackCheck("Fusion Slash", otherTank, 1) 
					or mtsLib.stackCheck("Overwhelming Power", otherTank, 12) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end 
				end



			end
		end
	end
		return false
end


function mtsLib.shouldStop(unit)
	if not UnitAffectingCombat(unit) then return false end
	if mtsLib.hasDebuffTable(unit, cc) then return false end
	if UnitAura(unit,GetSpellInfo(116994))
		or UnitAura(unit,GetSpellInfo(122540))
		or UnitAura(unit,GetSpellInfo(123250))
		or UnitAura(unit,GetSpellInfo(106062))
		or UnitAura(unit,GetSpellInfo(110945))
		or UnitAura(unit,GetSpellInfo(143593)) -- General Nazgrim: Defensive Stance
		or UnitAura(unit,GetSpellInfo(143574)) -- Heroic Immerseus: Swelling Corruption
		then return false 
	end
		return true
end

ProbablyEngine.listener.register("COMBAT_LOG_EVENT_UNFILTERED", function(...)
local event = select(2, ...)
local source = select(4, ...)
local spellId = select(12, ...)
local tname = UnitName("target")
if source ~= UnitGUID("player") then return false end

	if event == "SPELL_CAST_SUCCESS" then	

		if spellId == 114158 then
			mts_ConfigAlertSound()
			mts_ConfigAlert("*Casted Light´s Hammer*")
		end
	
		if spellId == 633 then
			mts_ConfigAlertSound()
			mts_ConfigWhisper(tname.." MSG: Casted Lay On Hands on you.")
			mts_ConfigAlert("*Casted Lay on Hands*")
		end
		
		if spellId == 1044 then
			mts_ConfigAlertSound()
			mts_ConfigWhisper(tname.." MSG: Casted Hand of Freedom on you.")
			mts_ConfigAlert("*Casted Hand of Freedom*")
		end
		
		if spellId == 6940 then
			mts_ConfigAlertSound()
			mts_ConfigAlert("*Casted Hand of Sacrifice*")
			mts_ConfigWhisper("/w "..tname.." MSG: Casted Hand of Sacrifice on you.")
		end
		
		if spellId == 105593 then
			mts_ConfigAlertSound()
			mts_ConfigAlert("*Stunned Target*")
		end
		
		if spellId == 853 then
			mts_ConfigAlertSound()
			mts_ConfigAlert("*Stunned Target*")
		end

		if spellId == 31821 then
			mts_ConfigAlertSound()
			mts_ConfigAlert("*Casted Devotion Aura*")
		end

		if spellId == 31884 then
			mts_ConfigAlertSound()
			mts_ConfigAlert("*Casted Avenging Wrath*")
		end

		if spellId == 105809 then
			mts_ConfigAlertSound()
			mts_ConfigAlert("*Casted Guardian of Ancient Kings*")
		end

		if spellId == 31850 then
			mts_ConfigAlertSound()
			mts_ConfigAlert("*Casted Ardent Defender*")
		end
		
		if spellId == 86659 then
			mts_ConfigAlertSound()
			mts_ConfigAlert("*Casted Holy Avenger*")
		end

		if spellId == 86669 then
			mts_ConfigAlertSound()
			mts_ConfigAlert("*Casted Guardian of Ancient Kings*")
		end

		if spellId == 31842 then
			mts_ConfigAlertSound()
			mts_ConfigAlert("*Casted Divine Favor*")
		end

	end
end)

ProbablyEngine.condition.register("talent", function(index)
	return select(5, GetTalentInfo(index)) or false
end)

function mtsLib.HealthPot()
	if GetItemCount(76097) > 1
	and GetItemCooldown(76097) == 0 then 
		return true
	end
	return false
end

function mtsLib.KafaPress()
	if GetItemCount(86125) > 0
	and GetItemCooldown(86125) == 0 then 
		return true
	end
	return false
end

function mts_ConfigWhisper(txt)
	if mtsLib.getConfig('getWhispers')then
		return RunMacroText("/w "..txt)
	end
	return false
end

function mts_ConfigAlert(txt)
	if mtsLib.getConfig('getAlerts')then
		return mtsAlert:message(txt)
	end
end

function mts_ConfigAlertSound()
	if mtsLib.getConfig('getAlertSounds')then
		PlaySoundFile(media .. "beep.mp3", "master")
	end
end

function mtsLib.getConfig(key)
	return mts_Config:get(key)
end

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

function mtsLib.ShouldTaunt(key)
	if UnitIsTappedByPlayer("target")
	and mts_Config:get(key) == true then
		return true
	else
		return false
	end
end

function mtsLib.getSetting(txt1, txt2)
	if mtsLib.getConfig(txt1) == txt2 then
		return true
	else
		return false
	end
end

function mtsLib.ConfigUnitMana(key, unit)
	if ProbablyEngine.condition["mana"](unit) <= mts_Config:get(key) then
		return true
	else
		return false
	end
end

function mtsLib.ConfigUnitHp(key, unit)
	if ProbablyEngine.condition["health"](unit) <= mts_Config:get(key) then
		return true
	else
		return false
	end
end

function mtsLib.modifierActionForSpellIsAlt(name)
	return IsAltKeyDown() and not GetCurrentKeyBoardFocus() and mtsLib.getConfig("altKeyAction") == name
end

function mtsLib.modifierActionForSpellIsShift(name)
	return IsShiftKeyDown() and not GetCurrentKeyBoardFocus() and mtsLib.getConfig("shiftKeyAction") == name
end

function mtsLib.modifierActionForSpellIsControl(name)
	return IsControlKeyDown() and not GetCurrentKeyBoardFocus() and mtsLib.getConfig("controlKeyAction") == name
end

ProbablyEngine.library.register('mtsLib', mtsLib)




-- mConfig copyright & thanks to https://github.com/kirk24788/mConfig
-- Modified by MTS
mts_Config = {}
function mtsLib.initConfig()
mts_Config = mConfig:createConfig("\124cff9482C9MrTheSoulz Profiles Settings","mtsConfig","Default",{"/mts"})
        
	-- Settings
		mts_Config:addTitle("---> General Settings: <---")
		mts_Config:addText("Everything in here is shared cross all of the profiles.")
		mts_Config:addCheckBox("getAlerts", "Show Notifications", "Shows notification on top when used certain spells", true)
		mts_Config:addCheckBox("getAlertSounds", "Notifications Sounds", "Plays a sound when a notification is shown.", true)
		mts_Config:addCheckBox("getWhispers", "Allow Whispers", "Whispers people after using certain spells", true)

	--Paladin Holy
		mts_Config:addTitle("\124cffF58CBA---> Paladin Holy: <---")
		mts_Config:addText("Everything in here only affects the Paladin Holy profile.")
		mts_Config:addCheckBox("PalaHolyItems", "Use items", "Allows usage of items", true)
		mts_Config:addCheckBox("PalaHolyBuffs", "Buffing", "Use Buffs", true)
		mts_Config:addCheckBox("PalaHolyDispells", "Auto Dispelling", "Allows Auto Dispelling", true)
		mts_Config:addDropDown("toUsePalaHolyBuff", "Buff To Use:", "Choose buff to use Might or Kings", {MIGHT="Might", KINGS="Kings"}, "KINGS")
		mts_Config:addDropDown("toUsePalaHolyHr", "Holy Radiance:", "Choose how to use Holy Radiance", {AUTO="Auto", MANUAL="Manual"}, "AUTO")
		mts_Config:addSlider("PalaHolyHs", "HealthStone @ HP %", "HP percentage you need to drop to use HealthStone", 10,100,60,1)
		mts_Config:addSlider("PalaHolyEf", "Eternal Flame @ HP %", "HP percentage you need to drop to use Eternal Flame", 10,100,93,1)
		mts_Config:addSlider("PalaHolyLoh", "Lay on Hands @ HP %", "HP percentage you need to drop to use Lay on Hands", 10,100,15,1)
		mts_Config:addCheckBox("usePalaHolyTk1", "Use Trinket 1", "Allows usage of Trinket 1", true)
		mts_Config:addCheckBox("usePalaHolyTk2", "Use Trinket 2", "Allows usage of Trinket 2", true)
		mts_Config:addSlider("PalaHolyTk1", "Trinket 1 @ MANA %", "MANA percentage you need to drop to use Trinket 1", 10,100,85,1)
		mts_Config:addSlider("PalaHolyTk2", "Trinket 2 @ MANA %", "MANA percentage you need to drop to use Trinket 2", 10,100,85,1)
		mts_Config:addSlider("PalaHolyAct", "Arcane Torrent *Racial* @ MANA %", "MANA percentage you need to drop to use Arcane Torrent *Racial*", 10,100,90,1)
		mts_Config:addSlider("PalaHolyDvp", "Divine Plea @ MANA %", "MANA percentage you need to drop to use Divine Plea", 10,100,85,1)

	-- Paladin Protection
		mts_Config:addTitle("\124cffF58CBA---> Paladin Protection: <---")
		mts_Config:addText("Everything in here only affects the Paladin Protection profile.")
		mts_Config:addCheckBox("PalaProtItems", "Use items", "Allows usage of items", true)
		mts_Config:addCheckBox("PalaProtTaunts", "Auto Taunting", "Allows Auto Taunts", true)
		mts_Config:addCheckBox("PalaProtConsecration", "Consecration", "Use Consecration", true)
		mts_Config:addCheckBox("PalaProtChangeSeals", "Change Seals", "Allow the rotation to change Seals suto", true)
		mts_Config:addCheckBox("PalaProtDefCd", "Defensive Cooldowns", "Use Defensive Cooldowns", true)
		mts_Config:addCheckBox("PalaProtBuffs", "Buffing", "Use Buffs Kings/Might/Fury", true)
		mts_Config:addDropDown("toUsePalaProtBuff", "Buff To Use:", "Choose buff to use Might or Kings", {MIGHT="Might", KINGS="Kings"}, "KINGS")
		mts_Config:addSlider("PalaProtHs", "HealthStone @ HP %", "HP percentage you need to drop to use HealthStone", 10,100,60,1)

	-- DeathKinght Blood
		mts_Config:addTitle("\124cffC41F3B---> DeathKinght Blood: <---")
		mts_Config:addSlider("ibfPercentage","Icebound Fortitude HP %","HP % you need to drop to use Icebound Fortitude", 10,100,40,1)
		mts_Config:addSlider("vbPercentage","Vampiric Blood HP %","HP % you need to drop to use Vampiric Blood", 10,100,40,1)
		mts_Config:addSlider("dpPercentage","Death Pact HP %","HP % you need to drop to use Death Pact", 10,100,50,1)
		mts_Config:addSlider("lichbornePercentage","Lichborne HP %","HP % you need to drop to use Lichborne", 10,100,50,1)
		mts_Config:addSlider("runeTapPercentage","Rune Tap HP %","HP % you need to drop to use Rune Tap", 10,100,80,1)
		mts_Config:addSlider("deathStrikePercentage","Death Strike HP %","HP % you need to drop to use Death Strike on CD", 10,100,70,1)
		mts_Config:addCheckBox("useOutOfCombatHorn", "Horn of Winter out of combat", "Use Horn of Winter out of combat", true)
		mts_Config:addCheckBox("DkBloodTaunts", "Auto Taunting", "Allows Auto Taunts", true)
		mts_Config:addDropDown("altKeyAction", "Alt-Key Action", "Action to do when Alt-Key is pressed", {ANTIMAGICZONE="Anti Magic Zone", DND="Death and Decay", PAUSE="Pause Rotation", ARMY="Army of Death"}, "ANTIMAGICZONE")
		mts_Config:addDropDown("shiftKeyAction", "Shift-Key Action", "Action to do when Shift-Key is pressed", {ANTIMAGICZONE="Anti Magic Zone", DND="Death and Decay", PAUSE="Pause Rotation", ARMY="Army of Death"}, "DND")
		mts_Config:addDropDown("controlKeyAction", "Control-Key Action", "Action to do when Control-Key is pressed", {ANTIMAGICZONE="Anti Magic Zone", DND="Death and Decay", PAUSE="Pause Rotation", ARMY="Army of Death"}, "PAUSE")

	-- Druid Guardian
		mts_Config:addTitle("\124cffFF7D0A---> Druid Guardian: <---")
		mts_Config:addText("Everything in here only affects the Druid Guardian profile.")
		mts_Config:addCheckBox("DoodGuardTaunts", "Auto Taunting", "Allows Auto Taunts", true)
		mts_Config:addCheckBox("DoodGuardDefCd", "Defensive Cooldowns", "Use Defensive Cooldowns", true)
		mts_Config:addCheckBox("DoodGuardBuffs", "Buffing", "Use Buffs", true)
		mts_Config:addCheckBox("DoodGuardItems", "Use items", "Allows usage of items", true)
		mts_Config:addSlider("DoodGuardHs", "HealthStone @ HP %", "HP percentage you need to drop to use HealthStone", 10,100,60,1)

	-- Druid Restoration
		mts_Config:addTitle("\124cffFF7D0A---> Druid Restoration: <---")
		mts_Config:addText("Everything in here only affects the Druid Restoration profile.")
		mts_Config:addCheckBox("DoodRestoDispells", "Auto Dispelling", "Allows Auto Dispelling", true)
		mts_Config:addCheckBox("DoodRestoBuffs", "Buffing", "Use Buffs", true)
		mts_Config:addCheckBox("DoodRestoItems", "Use items", "Allows usage of items", true)
		mts_Config:addCheckBox("DoodRestoMr", "Use Wild Mushroom", "Allows usage of Wild Mushroom", true)
		mts_Config:addSlider("toUseDoodRestoMr", "Wild Mushroom @ HP %", "HP percentage you need to drop to use Wild Mushroom", 60,100,95,1)
		mts_Config:addSlider("DoodRestoHs", "HealthStone @ HP %", "HP percentage you need to drop to use HealthStone", 10,100,60,1)
		
end

mtsLib.initConfig()