-- //////////////////////-----------------------------------------INFO-----------------------------------//////////////////////////////
--															//General Lib//
--													Thank Your For Your My ProFiles
--														I Hope Your Enjoy Them
--																  MTS


-- //////////////////////-----------------------------------------VERSION-----------------------------------//////////////////////////////
function GetVer()
	return mts:message('MrTheSoulz Version: 2.0.0')
end

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

-- //////////////////////-----------------------------------------CONDITIONS-----------------------------------//////////////////////////////

ProbablyEngine.condition.register("talent", function(index)
	return select(5, GetTalentInfo(index)) or false
end)
