-- //////////////////////-----------------------------------------INFO-----------------------------------//////////////////////////////
--															//General Lib//
--													Thank Your For Your My ProFiles
--														I Hope Your Enjoy Them
--																  MTS


-- //////////////////////-----------------------------------------VERSION-----------------------------------//////////////////////////////
function GetVer()
	return mts:message('MrTheSoulz Version: 2.1.0')
end

-- //////////////////////-----------------------------------------CONDITIONS-----------------------------------//////////////////////////////

ProbablyEngine.condition.register("talent", function(index)
	return select(5, GetTalentInfo(index)) or false
end)

-- //////////////////////-----------------------------------------NOTIFICATIONS-----------------------------------//////////////////////////////
	
	-- Chat Overlay originally made by Sheuron
	local function onUpdate(self,elapsed) 
	  if self.time < GetTime() - 2.0 then
	if self:GetAlpha() == 0 then self:Hide() else self:SetAlpha(self:GetAlpha() - .05) end
	  end
	end
	mts = CreateFrame("Frame",nil,ChatFrame1) 
	mts:SetSize(ChatFrame1:GetWidth(),30)
	mts:Hide()
	mts:SetScript("OnUpdate",onUpdate)
	mts:SetPoint("TOP",0,0)
	mts.text = mts:CreateFontString(nil,"OVERLAY","MovieSubtitleFont")
	mts.text:SetAllPoints()
	mts.texture = mts:CreateTexture()
	mts.texture:SetAllPoints()
	mts.texture:SetTexture(0,0,0,.50) 
	mts.time = 0
	function mts:message(message) 
	  self.text:SetText(message)
	  self:SetAlpha(1)
	  self.time = GetTime() 
	  self:Show() 
	end


-- //////////////////////-----------------------------------------Taunts-----------------------------------//////////////////////////////

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
            local boss = UnitID(bossID)
            local bossID = "boss" .. j

                if boss == 71543 then -- Immersus
                    if UnitDebuff(otherTank, "Corrosive Blast") and not UnitDebuff("player", "Corrosive Blast") then
                        ProbablyEngine.dsl.parsedTarget = bossID
                    	return true
                	end 

                elseif boss == 72276 then -- Norushen
                    local debuffName, _, _, debuffCount = UnitDebuff(otherTank, "Self Doubt")
	                if debuffName and debuffCount > 2 and not UnitDebuff("player", "Self Doubt") then
	                    ProbablyEngine.dsl.parsedTarget = bossID
	                    return true
	                end 

                elseif boss == 71734 then -- Sha of Pride
                    if UnitDebuff(otherTank, "Wounded Pride") and not UnitDebuff("player", "Wounded Pride") then
                        ProbablyEngine.dsl.parsedTarget = bossID
                    	return true
                	end

                elseif boss == 72249 then -- Galakras
                    local debuffName, _, _, debuffCount = UnitDebuff(otherTank, "Flames of Galakrond")
	                if debuffName and debuffCount > 2 and not UnitDebuff("player", "Flames of Galakrond") then
	                    ProbablyEngine.dsl.parsedTarget = bossID
	                    return true
	                end

                elseif boss == 71466 then -- Iron Juggernaut
                    local debuffName, _, _, debuffCount = UnitDebuff(otherTank, "Ignite Armor")
	                if debuffName and debuffCount > 1 and not UnitDebuff("player", "Ignite Armor") then
	                    ProbablyEngine.dsl.parsedTarget = bossID
	                    return true
	               	end

                elseif boss == 71859 then -- Kor'kron Dark Shaman
                    local debuffName, _, _, debuffCount = UnitDebuff(otherTank, "Froststorm Strike")
	                if debuffName and debuffCount > 4 and not UnitDebuff("player", "Froststorm Strike") then
	                    ProbablyEngine.dsl.parsedTarget = bossID
	                    return true
	                end

                elseif boss == 71515 then -- General Nazgrim
                    local debuffName, _, _, debuffCount = UnitDebuff(otherTank, "Sundering Blow")
	                if debuffName and debuffCount > 2 and not UnitDebuff("player", "Sundering Blow") then
	                    ProbablyEngine.dsl.parsedTarget = bossID
	                    return true
	                end

                elseif boss == 71454 then -- Malkorok
                local debuffName, _, _, debuffCount = UnitDebuff(otherTank, "Fatal Strike")
	                if debuffName and debuffCount > 11 and not UnitDebuff("player", "Fatal Strike") then
	                    ProbablyEngine.dsl.parsedTarget = bossID
	                    return true
	               	end

                elseif boss == 71529 then -- Thok the Bloodsthirsty
                    local debuffName, _, _, debuffCount = UnitDebuff(otherTank, "Panic")
	                if debuffName and debuffCount > 2 and not UnitDebuff("player", "Panic") then
	                    ProbablyEngine.dsl.parsedTarget = bossID
	                    return true
	               	end
                    local debuffName, _, _, debuffCount = UnitDebuff(otherTank, "Acid Breath")
                    if debuffName and debuffCount > 2 and not UnitDebuff("player", "Acid Breath") then
                        ProbablyEngine.dsl.parsedTarget = bossID
                        return true
                    end 
                    local debuffName, _, _, debuffCount = UnitDebuff(otherTank, "Freezing Breath")
                    if debuffName and debuffCount > 2 and not UnitDebuff("player", "Freezing Breath") then
                        ProbablyEngine.dsl.parsedTarget = bossID
                        return true
                    end 
                    local debuffName, _, _, debuffCount = UnitDebuff(otherTank, "Scorching Breath")
                    if debuffName and debuffCount > 2 and not UnitDebuff("player", "Scorching Breath") then
                        ProbablyEngine.dsl.parsedTarget = bossID
                        return true
                    end

                elseif boss == 71504 then -- Siegecrafter Blackfuse
                    local debuffName, _, _, debuffCount = UnitDebuff(otherTank, "Electrostatic Charge")
                    if debuffName and debuffCount > 3 and not UnitDebuff("player", "Electrostatic Charge") then
                        robablyEngine.dsl.parsedTarget = bossID
                        return true
                   	end

                elseif boss == 71865 then -- Garrosh Hellscream
                    local debuffName, _, _, debuffCount = UnitDebuff(otherTank, "Gripping Despair")
                    if debuffName and debuffCount > 2 and not UnitDebuff("player", "Gripping Despair") then
                        ProbablyEngine.dsl.parsedTarget = bossID
                        return true
                    end

                end -- End Boss's Table
            end
        end
    end
    	return false
end

-- //////////////////////-----------------------------------------Boss's-----------------------------------//////////////////////////////

--mts.bosses = {

-- Soo Bosses
--	71543, -- Immersus
--	72276, -- Norushen
--	71734, -- Sha of Pride
--	72249, -- Galakras
--	71466, -- Iron Juggernaut
--	71859, -- Kor'kron Dark Shaman
--	71515, -- General Nazgrim
--	71454, -- Malkorok
--	71529, -- Thok the Bloodsthirsty
--	71504, -- Siegecrafter Blackfuse
--	71865  -- Garrosh Hellscream
--
--}

--local mts.bosses = { 71543, 72276, 71734, 72249, 71466, 71859, 71515, 71454, 71529, 71504, 71865 }
--function mts.StopIfBoss()
--    for i = 1, 4 do
--      local bossTarget = "boss" .. i
--      local bossID = UnitID(bossTarget)
--      if table.contains(mts.bosses, bossID) then
--          return false
--      end
--    end
--    return true
--end

-- //////////////////////-----------------------------------------Register Lib-----------------------------------//////////////////////////////
ProbablyEngine.library.register('mts', mts)