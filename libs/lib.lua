--[[ ///---INFO---////
//General Lib//
Thank You For Using My ProFiles
I Hope Your Enjoy Them
MTS
]]

local mtsLib = {}
local _media = "Interface\\AddOns\\Probably_MrTheSoulz\\media\\"
local _playerClass, _englishClass, _idClass = UnitClass("player");
local _playerSpec = GetSpecialization();
local mts_Dummies = {31146,67127,46647,32546,31144,32667,32542,32666,32545,32541}
local _cc = {49203,6770,1776,51514,9484,118,28272,28271,61305,61025,61721,61780,3355,19386,20066,90337,2637,82676,115078,76780,9484,1513,115268}
local ignoreDebuffs = {'Mark of Arrogance','Displaced Energy'}



function mtsLib.StopIfBoss()
if UnitExists("boss1") then
local npcId = tonumber(UnitGUID("target"):sub(6,10), 16)
	if npcId == 71543 -- Immersus
	or npcId == 72276 -- Norushen
	or npcId == 71734 -- Sha of Pride
	or npcId == 72249 -- Galakras
	or npcId == 71466 -- Iron Juggernaut
	or npcId == 71859 -- Kor'kron Dark Shaman
	or npcId == 71515 -- General Nazgrim
	or npcId == 71454 -- Malkorok
	or npcId == 71529 -- Thok the Bloodsthirsty
	or npcId == 71504 -- Siegecrafter Blackfuse
	or npcId == 71865 -- Garrosh Hellscream
	then return false end
end
	return true 
end
	
function mtsLib.Dispell(text)
local prefix = (IsInRaid() and 'raid') or 'party'
	for i = -1, GetNumGroupMembers() - 1 do
	local unit = (i == -1 and 'target') or (i == 0 and 'player') or prefix .. i
		if IsSpellInRange(text, unit) then
			for j = 1, 40 do
			local debuffName, _, _, _, dispelType, duration, expires, _, _, _, spellID, _, isBossDebuff, _, _, _ = UnitDebuff(unit, j)
				if dispelType and dispelType == 'Magic' or dispelType == 'Poison' or dispelType == 'Disease' then
				local ignore = false
				for k = 1, #ignoreDebuffs do
					if debuffName == ignoreDebuffs[k] then
						ignore = true
						break
					end
				end
					if not ignore then
						ProbablyEngine.dsl.parsedTarget = unit
						return true
					end
				end
				if not debuffName then
					break
				end
			end
		end
	end
		return false
end

function mtsLib.shouldStop(unit)
	if not UnitAffectingCombat(unit) then return false end
	if mtsLib.hasDebuffTable(unit, _cc) then return false end
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
		PlaySoundFile(_media .. "beep.mp3", "master")
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
		mts_Config:addText("---------------------------------------------------------------------------------------------------------------")

	--Paladin Holy
		mts_Config:addTitle("\124cffF58CBA---> Paladin Holy: <---")
		mts_Config:addCheckBox("PalaHolyItems", "Use items", "Allows usage of items", true)
		mts_Config:addCheckBox("PalaHolyBuffs", "Buffing", "Use Buffs", true)
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
		mts_Config:addText("---------------------------------------------------------------------------------------------------------------")

	-- Paladin Protection
		mts_Config:addTitle("\124cffF58CBA---> Paladin Protection: <---")
		mts_Config:addCheckBox("PalaProtItems", "Use items", "Allows usage of items", true)
		mts_Config:addCheckBox("PalaProtTaunts", "Auto Taunting", "Allows Auto Taunts", true)
		mts_Config:addCheckBox("PalaProtConsecration", "Consecration", "Use Consecration", true)
		mts_Config:addCheckBox("PalaProtChangeSeals", "Change Seals", "Allow the rotation to change Seals suto", true)
		mts_Config:addCheckBox("PalaProtDefCd", "Defensive Cooldowns", "Use Defensive Cooldowns", true)
		mts_Config:addCheckBox("PalaProtBuffs", "Buffing", "Use Buffs Kings/Might/Fury", true)
		mts_Config:addDropDown("toUsePalaProtBuff", "Buff To Use:", "Choose buff to use Might or Kings", {MIGHT="Might", KINGS="Kings"}, "KINGS")
		mts_Config:addSlider("PalaProtHs", "HealthStone @ HP %", "HP percentage you need to drop to use HealthStone", 10,100,60,1)
		mts_Config:addText("---------------------------------------------------------------------------------------------------------------")

	-- Warrior Fury
		mts_Config:addTitle("\124cffC79C6E---> Warrior Fury: <---")
		mts_Config:addCheckBox("WarFuryItems", "Use items", "Allows usage of items", true)
		mts_Config:addCheckBox("WarFuryChangeStances", "Change Stances", "Allow the rotation to change Stances suto", true)
		mts_Config:addCheckBox("WarFuryDefCd", "Defensive Cooldowns", "Use Defensive Cooldowns", true)
		mts_Config:addCheckBox("WarFuryBuffs", "Buffing", "Use Buffs", true)
		mts_Config:addSlider("WarFuryHs", "HealthStone @ HP %", "HP percentage you need to drop to use HealthStone", 10,100,60,1)
		mts_Config:addText("---------------------------------------------------------------------------------------------------------------")

	-- DeathKinght Blood
		mts_Config:addTitle("\124cffC41F3B---> DeathKinght Blood: <---")
		mts_Config:addCheckBox("DkBloodTaunts", "Auto Taunting", "Allows Auto Taunts", true)
		mts_Config:addSlider("DkBloodHs", "HealthStone @ HP %", "HP percentage you need to drop to use HealthStone", 10,100,60,1)
		mts_Config:addCheckBox("DkBloodOutOfCombatHorn", "Horn of Winter out of combat", "Use Horn of Winter out of combat", true)
		mts_Config:addSlider("runeTapPercentage","Rune Tap HP %","HP % you need to drop to use Rune Tap", 10,100,80,1)
		mts_Config:addSlider("DkBloodDeathStrikePercentage","Death Strike HP %","HP % you need to drop to use Death Strike on CD", 10,100,70,1)
		mts_Config:addSlider("DkBloodLichbornePercentage","Lichborne HP %","HP % you need to drop to use Lichborne", 10,100,50,1)
		mts_Config:addSlider("BloodDpPercentage","Death Pact HP %","HP % you need to drop to use Death Pact", 10,100,50,1)
		mts_Config:addSlider("vbPercentage","Vampiric Blood HP %","HP % you need to drop to use Vampiric Blood", 10,100,40,1)
		mts_Config:addSlider("DkBloodIbfPercentage","Icebound Fortitude HP %","HP % you need to drop to use Icebound Fortitude", 10,100,40,1)
		mts_Config:addText("---------------------------------------------------------------------------------------------------------------")

	-- DeathKinght Frost
		mts_Config:addTitle("\124cffC41F3B---> DeathKinght Frost: <---")
		mts_Config:addSlider("DkFrostHs", "HealthStone @ HP %", "HP percentage you need to drop to use HealthStone", 10,100,60,1)
		mts_Config:addCheckBox("DkFrostOutOfCombatHorn", "Horn of Winter out of combat", "Use Horn of Winter out of combat", true)
		mts_Config:addText("---------------------------------------------------------------------------------------------------------------")

	-- Druid Guardian
		mts_Config:addTitle("\124cffFF7D0A---> Druid Guardian: <---")
		mts_Config:addCheckBox("DoodGuardTaunts", "Auto Taunting", "Allows Auto Taunts", true)
		mts_Config:addCheckBox("DoodGuardDefCd", "Defensive Cooldowns", "Use Defensive Cooldowns", true)
		mts_Config:addCheckBox("DoodGuardBuffs", "Buffing", "Use Buffs", true)
		mts_Config:addCheckBox("DoodGuardItems", "Use items", "Allows usage of items", true)
		mts_Config:addSlider("DoodGuardHs", "HealthStone @ HP %", "HP percentage you need to drop to use HealthStone", 10,100,60,1)
		mts_Config:addText("---------------------------------------------------------------------------------------------------------------")

	-- Druid Restoration
		mts_Config:addTitle("\124cffFF7D0A---> Druid Restoration: <---")
		mts_Config:addCheckBox("DoodRestoDispells", "Auto Dispelling", "Allows Auto Dispelling", true)
		mts_Config:addCheckBox("DoodRestoBuffs", "Buffing", "Use Buffs", true)
		mts_Config:addCheckBox("DoodRestoItems", "Use items", "Allows usage of items", true)
		mts_Config:addCheckBox("DoodRestoMr", "Use Wild Mushroom", "Allows usage of Wild Mushroom", true)
		mts_Config:addSlider("toUseDoodRestoMr", "Wild Mushroom @ HP %", "HP percentage you need to drop to use Wild Mushroom", 60,100,95,1)
		mts_Config:addSlider("DoodRestoHs", "HealthStone @ HP %", "HP percentage you need to drop to use HealthStone", 10,100,60,1)
		mts_Config:addText("---------------------------------------------------------------------------------------------------------------")
		
end

mtsLib.initConfig()