--[[ ///---INFO---////
// Alerts GUI //
Thank Your For Your My ProFiles
I Hope Your Enjoy Them
MTS
]]

local function onUpdate(self,elapsed) 
	if self.time < GetTime() - 2.0 then
		if self:GetAlpha() == 0 then
			self:Hide()
		else 
			self:SetAlpha(self:GetAlpha() - .05)
		end
	end
end
	
mtsAlert = CreateFrame("Frame",nil,UIParent)
mtsAlert:SetWidth(400)
mtsAlert:SetHeight(30)
mtsAlert:Hide()
mtsAlert:SetScript("OnUpdate",onUpdate)
mtsAlert:SetPoint("TOP",0,0)
mtsAlert.text = mtsAlert:CreateFontString(nil,"OVERLAY","MovieSubtitleFont")
mtsAlert.text:SetAllPoints()
mtsAlert.time = 0

function mtsAlert:message(message) 
	self.text:SetText(message)
	self:SetAlpha(1)
	self.time = GetTime() 
	self:Show() 
end