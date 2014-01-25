-- //////////////////////-----------------------------------------INFO-----------------------------------//////////////////////////////
--															//General Lib//
--													Thank Your For Your My ProFiles
--														I Hope Your Enjoy Them
--																  MTS




local mts = {}
local media = "Interface\\AddOns\\Probably_MrTheSoulz\\media\\"

-- //////////////////////-----------------------------------------Taunts-----------------------------------/////////////////////////////

-- Thanks blazinsheath
function mts.StopIfBoss()
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


function mts.stackCheck(spell, otherTank, stacks)
        local debuffName, _, _, debuffCount = UnitDebuff(otherTank, spell)
        if debuffName and debuffCount >= stacks and not UnitDebuff("player", spell) then
                return true
        end 
        return false
end

function mts.bossTaunt()
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
					if mts.stackCheck("Corrosive Blast", otherTank, 1) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end 
				elseif boss == 72276 then -- Norushen
					if mts.stackCheck("Self Doubt", otherTank, 3) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end 
				elseif boss == 71734 then -- Sha of Pride
					if mts.stackCheck("Wounded Pride", otherTank, 1) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 72249 then -- Galakras
					if mts.stackCheck("Flames of Galakrond", otherTank, 3) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end  
				elseif boss == 71466 then -- Iron Juggernaut
					if mts.stackCheck("Ignite Armor", otherTank, 2) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end  
				elseif boss == 71859 then -- Kor'kron Dark Shaman / Earthbreaker Haromm
					if mts.stackCheck("Froststorm Strike", otherTank, 5) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end   
				elseif boss == 71515 then -- General Nazgrim
					if mts.stackCheck("Sundering Blow", otherTank, 3) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 71454 then -- Malkorok
					if mts.stackCheck("Fatal Strike", otherTank, 12) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 71529 then -- Thok the Bloodsthirsty
					if mts.stackCheck("Panic", otherTank, 3)
					or mts.stackCheck("Acid Breath", otherTank, 3) 
					or mts.stackCheck("Freezing Breath", otherTank, 3)
					or mts.stackCheck("Scorching Breath", otherTank, 3) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 71504 then -- Siegecrafter Blackfuse
					if mts.stackCheck("Electrostatic Charge", otherTank, 4) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 71865 then -- Garrosh Hellscream
					if mts.stackCheck("Gripping Despair", otherTank, 3)
					or mts.stackCheck("Empowered Gripping Despair", otherTank, 3) then
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
					if mts.stackCheck("Triple Puncture", otherTank, 9) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 69131 then -- Council of Elders / Frost King Malakk
					if mts.stackCheck("Frigid Assault", otherTank, 13) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end                                
				elseif boss == 69712 then -- Ji-Kun
					if mts.stackCheck("Talon Rake", otherTank, 2) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 68036 then -- Durumu the Forgotten
					if mts.stackCheck("Hard Stare", otherTank, 5) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 69017 then -- Primordius
					if mts.stackCheck("Malformed Blood", otherTank, 8) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 69699 then -- Dark Animus - Massive Anima Golem
					if mts.stackCheck("Explosive Slam", otherTank, 5) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 68078 then -- Iron Qon
					if mts.stackCheck("Impale", otherTank, 4) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 68905 then -- Twin Consorts - Lu’lin
					if mts.stackCheck("Beast of Nightmare", otherTank, 1) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 68904 then -- Twin Consorts - Suen
					if mts.stackCheck("Fan of Flames", otherTank, 3) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 68397 then -- Lei Shen
					if mts.stackCheck("Decapitate", otherTank, 1) 
					or mts.stackCheck("Fusion Slash", otherTank, 1) 
					or mts.stackCheck("Overwhelming Power", otherTank, 12) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end 
				end



			end
		end
	end
		return false
end

-- //////////////////////-----------------------------------------Items-----------------------------------//////////////////////////////

-- Master Health Potion
function mts.HealthPot()
	if GetItemCount(76097) > 1 
	and GetItemCooldown(76097) == 0 
	and ProbablyEngine.condition["modifier.cooldowns"] then 
		return true
	end
	return false
end

-- Kafa Press
--function mts.KafaPress()
--if GetItem(86125)
--and GetItemCooldown(86125) == 0 
--and ProbablyEngine.condition["modifier.cooldowns"] then 
--	return true
--end
--	return false
--end

-- //////////////////////-----------------------------------------CONDITIONS-----------------------------------//////////////////////////////

ProbablyEngine.condition.register("talent", function(index)
	return select(5, GetTalentInfo(index)) or false
end)


-- //////////////////////-----------------------------------------Alerts-----------------------------------//////////////////////////////

ProbablyEngine.listener.register("COMBAT_LOG_EVENT_UNFILTERED", function(...)
local event = select(2, ...)
local source = select(4, ...)
local spellId = select(12, ...)
local tname = UnitName("target")
if source ~= UnitGUID("player") then return false end

	if event == "SPELL_CAST_SUCCESS" then	

	-- Paladin shit here
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

	end -- Ends Table
end)

-- //////////////////////-----------------------------------------Register Lib-----------------------------------//////////////////////////////

ProbablyEngine.library.register('mts', mts)

-- //////////////////////-----------------------------------------Config-----------------------------------//////////////////////////////

-- mConfig copyright & thanks to https://github.com/kirk24788/mConfig
-- Modified by MTS

mts_Config = {}
function mts.initConfig()
local _playerClass, _englishClass, _idClass = UnitClass("player");
local _playerSpec = GetSpecialization()
mts_Config = mConfig:createConfig("\124cff9482C9MrTheSoulz Profiles Settings","mtsConfig","Default",{"/mts"})
        
		-- Settings
        mts_Config:addTitle("---> General Settings: <---")
		mts_Config:addText("Everything in here is shared cross all of the profiles.")
		mts_Config:addCheckBox("getAlerts", "Show Notifications", "Shows notification on top when used certain spells", true)
		mts_Config:addCheckBox("getAlertSounds", "Notifications Sounds", "Plays a sound when a notification is shown.", true)
		mts_Config:addCheckBox("getWhispers", "Allow Whispers", "Whispers people after using certain spells", true)
		if _idClass == 2 then -- Paladin
			if _playerSpec == 1 then -- Holy
				mts_Config:addTitle("\124cffF58CBA---> Paladin Holy: <---")
				mts_Config:addText("Everything in here only affects the Paladin Holy profile.")
				mts_Config:addCheckBox("PalaHolyItems", "Use items", "Allows usage of items", true)
				mts_Config:addCheckBox("PalaHolyBuffs", "Buffing", "Use Buffs", true)
				mts_Config:addCheckBox("PalaHolyDispells", "Auto Dispelling", "Allows Auto Dispelling", true)
				mts_Config:addDropDown("toUsePalaHolyBuff", "Buff To Use:", "Choose buff to use Might or Kings", {MIGHT="Might", KINGS="Kings"}, "KINGS")
				mts_Config:addDropDown("toUsePalaHolyHr", "Holy Radiance:", "Choose how to use Holy Radiance", {AUTO="Auto", MANUAL="Manual"}, "AUTO")
				mts_Config:addSlider("PalaHolyHs", "HealthStone @ HP %", "HP percentage you need to drop to use HealthStone", 10,100,60,1)
			elseif _playerSpec == 2 then -- Protection
				mts_Config:addTitle("\124cffF58CBA---> Paladin Protection: <---")
				mts_Config:addText("Everything in here only affects the Paladin Protection profile.")
				mts_Config:addCheckBox("PalaProtItems", "Use items", "Allows usage of items", true)
				mts_Config:addCheckBox("PalaProtTaunts", "Auto Taunting", "Allows Auto Taunts", true)
				mts_Config:addCheckBox("PalaProtConsecration", "Consecration", "Use Consecration", true)
				mts_Config:addCheckBox("PalaProtChangeSeals", "Seals", "Use Seals", true)
				mts_Config:addCheckBox("PalaProtDefCd", "Defensive Cooldowns", "Use Defensive Cooldowns", true)
				mts_Config:addCheckBox("PalaProtBuffs", "Buffing", "Use Buffs Kings/Might/Fury", true)
				mts_Config:addDropDown("toUsePalaProtBuff", "Buff To Use:", "Choose buff to use Might or Kings", {MIGHT="Might", KINGS="Kings"}, "KINGS")
				mts_Config:addSlider("PalaProtHs", "HealthStone @ HP %", "HP percentage you need to drop to use HealthStone", 10,100,60,1)
			else
				mts_Config:addTitle("---> Not Supported: <---")
				mts_Config:addText("This Class or/and Spec is Currently not supported by MTS.")
				mts_Config:addText("If you have changed Spec or Character please do /reload, there is currently and issue auto-updating when this occurs.")
			end
		elseif _idClass == 6 then -- DeathKinght
			if _playerSpec == 1 then -- Blood
				mts_Config:addTitle("\124cffC41F3B---> DeathKinght Blood: <---")
				mts_Config:addText("Everything in here only affects the DeathKinght Blood profile.")
				mts_Config:addCheckBox("DkBloodTaunts", "Auto Taunting", "Allows Auto Taunts", true)
				mts_Config:addCheckBox("DkBloodDefCd", "Defensive Cooldowns", "Use Defensive Cooldowns", true)
				mts_Config:addCheckBox("DkBloodItems", "Use items", "Allows usage of items", true)
				mts_Config:addCheckBox("DkBloodBuffs", "Buffing", "Use Buffs", true)
				mts_Config:addSlider("DkBloodHs", "HealthStone @ HP %", "HP percentage you need to drop to use HealthStone", 10,100,60,1)
			else
				mts_Config:addTitle("---> Not Supported: <---")
				mts_Config:addText("This Class or/and Spec is Currently not supported by MTS.")
				mts_Config:addText("If you have changed Spec or Character please do /reload, there is currently and issue auto-updating when this occurs.")
			end
		elseif _idClass == 11 then -- Druid
		
			if _playerSpec == 3 then -- Guardian
				mts_Config:addTitle("\124cffFF7D0A---> Druid Guardian: <---")
				mts_Config:addText("Everything in here only affects the Druid Guardian profile.")
				mts_Config:addSlider("DoodGuard", "HealthStone @ HP %", "HP percentage you need to drop to use HealthStone", 10,100,60,1)
			elseif _playerSpec == 4 then -- Resto
				mts_Config:addTitle("\124cffFF7D0A---> Druid Restoration: <---")
				mts_Config:addText("Everything in here only affects the Druid Restoration profile.")
				mts_Config:addSlider("DoodResto", "HealthStone @ HP %", "HP percentage you need to drop to use HealthStone", 10,100,60,1)
			else
				mts_Config:addTitle("---> Not Supported: <---")
				mts_Config:addText("This Class or/and Spec is Currently not supported by MTS.")
				mts_Config:addText("If you have changed Spec or Character please do /reload, there is currently and issue auto-updating when this occurs.")
			end
		else
			mts_Config:addTitle("---> Not Supported: <---")
			mts_Config:addText("This Class or/and Spec is Currently not supported by MTS.")
			mts_Config:addText("If you have changed Spec or Character please do /reload, there is currently and issue auto-updating when this occurs.")
		end
		
end

function mts_ConfigWhisper(txt)
	if mts.getConfig('getWhispers')then
		return RunMacroText("/w "..txt)
	end
	return false
end

function mts_ConfigAlert(txt)
	if mts.getConfig('getAlerts')then
		return mtsAlert:message(txt)
	end
end

function mts_ConfigAlertSound()
	if mts.getConfig('getAlertSounds')then
		PlaySoundFile(media .. "beep.mp3", "master")
	end
end

function mts.getConfig(key)
	return mts_Config:get(key)
end

function mts.getSetting(txt1, txt2)
	if mts.getConfig(txt1) == txt2 then
		return true
	else
		return false
	end
end

function mts.ConfigUnitHp(key, unit)
	if ProbablyEngine.condition["health"](unit) <= mts_Config:get(key) then
		return true
	else
		return false
	end
end

mts.initConfig()