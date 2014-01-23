-- //////////////////////-----------------------------------------INFO-----------------------------------//////////////////////////////
--															//General Lib//
--													Thank Your For Your My ProFiles
--														I Hope Your Enjoy Them
--																  MTS




local mts = {}

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
											
-- //////////////////////-----------------------------------------SoO-----------------------------------//////////////////////////////

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

-- //////////////////////-----------------------------------------ToT-----------------------------------//////////////////////////////

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

-- //////////////////////-----------------------------------------END TABLE-----------------------------------//////////////////////////////

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
--local dname = UnitDebuff("target")
if source ~= UnitGUID("player") then return false end

	if event == "SPELL_CAST_SUCCESS" then	

		if spellId == 114158 then
			mts.configAlert("*Casted Light´s Hammer*")
		end


-----------------------------
	end -- Ends Table
end)

-- //////////////////////-----------------------------------------Register Lib-----------------------------------//////////////////////////////

ProbablyEngine.library.register('mts', mts)

-- //////////////////////-----------------------------------------Config-----------------------------------//////////////////////////////

-- mConfig copyright & thanks to https://github.com/kirk24788/mConfig
mts.config = {}
function mts.initConfig()
        mts.config = mtsConfig:createConfig("MrTheSoulz Profiles Settings","mtsConfig","Default",{"/mts"})
        
		-- Settings
        mts.config:addText("General Settings:")
		mts.config:addCheckBox("getTaunts", "Auto Taunting", "Allows Auto Taunts", true)
		mts.config:addCheckBox("getDispells", "Auto Dispelling", "Allows Auto Dispelling", true)
		mts.config:addCheckBox("getAlerts", "Show Notifications", "Shows notification on top when used certain spells", true)
		mts.config:addCheckBox("getWhispers", "Allow Whispers", "Whispers people after using certain spells", true)
		
        -- Paldin Protection
        mts.config:addText("Paladin Protection:")
		mts.config:addCheckBox("useConsecration", "Consecration", "Use Consecration", true)
		mts.config:addCheckBox("changeSeals", "Seals", "Use Seals", true)
		mts.config:addCheckBox("useBuffs", "Buffing", "Use Buffs", true)
		mts.config:addCheckBox("pprotDefcd", "Defensive Cooldowns", "Use Defensive Cooldowns", true)
		mts.config:addCheckBox("useBuffs", "Buffing", "Use Buffs", true)
		
end

function mts.GetWhisper()
	if mts.getConfig('getWhispers')then
		return true
	end
	return false
end

function mts.configAlert(txt)
	if mts.getConfig('getAlerts')then
		return mtsAlert:message("\124cff9482C9ALERT!:\124cffF58C" ..txt)
	end
end

function mts.getConfig(key)
	return mts.config:get(key)
end

function mts.configUnitHpBelowThreshold(key,unit)
	return ProbablyEngine.condition["health"](unit) <= mts.config:get(key)
end

function mts.modifierActionForSpellIsAlt(name)
	return IsAltKeyDown() and not GetCurrentKeyBoardFocus() and mts.getConfig("altKeyAction")==name
end

function mts.modifierActionForSpellIsShift(name)
	return IsShiftKeyDown() and not GetCurrentKeyBoardFocus() and mts.getConfig("shiftKeyAction")==name
end

function mts.modifierActionForSpellIsControl(name)
	return IsControlKeyDown() and not GetCurrentKeyBoardFocus() and mts.getConfig("controlKeyAction")==name
end

mts.initConfig()