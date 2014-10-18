--[[ ///---INFO---////
//General Lib//
Thank Your For Your My ProFiles
I Hope Your Enjoy Them
MTS
]]

local mtsBossLib = {}

function mtsBossLib.stackCheck(spell, otherTank, stacks)
	local debuffName, _, _, debuffCount = UnitDebuff(otherTank, spell)
	if debuffName and debuffCount >= stacks and not UnitDebuff("player", spell) then
		return true
	end 
        return false
end

function mtsBossLib.bossTaunt()
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
					if mtsBossLib.stackCheck("Corrosive Blast", otherTank, 1) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end 
				elseif boss == 72276 then -- Norushen
					if mtsBossLib.stackCheck("Self Doubt", otherTank, 3) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end 
				elseif boss == 71734 then -- Sha of Pride
					if mtsBossLib.stackCheck("Wounded Pride", otherTank, 1) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 72249 then -- Galakras
					if mtsBossLib.stackCheck("Flames of Galakrond", otherTank, 3) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end  
				elseif boss == 71466 then -- Iron Juggernaut
					if mtsBossLib.stackCheck("Ignite Armor", otherTank, 2) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end  
				elseif boss == 71859 then -- Kor'kron Dark Shaman / Earthbreaker Haromm
					if mtsBossLib.stackCheck("Froststorm Strike", otherTank, 5) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end   
				elseif boss == 71515 then -- General Nazgrim
					if mtsBossLib.stackCheck("Sundering Blow", otherTank, 3) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 71454 then -- Malkorok
					if mtsBossLib.stackCheck("Fatal Strike", otherTank, 12) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 71529 then -- Thok the Bloodsthirsty
					if mtsBossLib.stackCheck("Panic", otherTank, 3)
					or mtsBossLib.stackCheck("Acid Breath", otherTank, 3) 
					or mtsBossLib.stackCheck("Freezing Breath", otherTank, 3)
					or mtsBossLib.stackCheck("Scorching Breath", otherTank, 3) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 71504 then -- Siegecrafter Blackfuse
					if mtsBossLib.stackCheck("Electrostatic Charge", otherTank, 4) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 71865 then -- Garrosh Hellscream
					if mtsBossLib.stackCheck("Gripping Despair", otherTank, 3)
					or mtsBossLib.stackCheck("Empowered Gripping Despair", otherTank, 3) then
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
					if mtsBossLib.stackCheck("Triple Puncture", otherTank, 9) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 69131 then -- Council of Elders / Frost King Malakk
					if mtsBossLib.stackCheck("Frigid Assault", otherTank, 13) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end                                
				elseif boss == 69712 then -- Ji-Kun
					if mtsBossLib.stackCheck("Talon Rake", otherTank, 2) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 68036 then -- Durumu the Forgotten
					if mtsBossLib.stackCheck("Hard Stare", otherTank, 5) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 69017 then -- Primordius
					if mtsBossLib.stackCheck("Malformed Blood", otherTank, 8) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 69699 then -- Dark Animus - Massive Anima Golem
					if mtsBossLib.stackCheck("Explosive Slam", otherTank, 5) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 68078 then -- Iron Qon
					if mtsBossLib.stackCheck("Impale", otherTank, 4) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 68905 then -- Twin Consorts - Lu’lin
					if mtsBossLib.stackCheck("Beast of Nightmare", otherTank, 1) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 68904 then -- Twin Consorts - Suen
					if mtsBossLib.stackCheck("Fan of Flames", otherTank, 3) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 68397 then -- Lei Shen
					if mtsBossLib.stackCheck("Decapitate", otherTank, 1) 
					or mtsBossLib.stackCheck("Fusion Slash", otherTank, 1) 
					or mtsBossLib.stackCheck("Overwhelming Power", otherTank, 12) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end 
				end



			end
		end
	end
		return false
end

ProbablyEngine.library.register('mtsBossLib', mtsBossLib)