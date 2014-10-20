--[[ ///---INFO---////
// Alerts GUI //
Thank Your For Your My ProFiles
I Hope Your Enjoy Them
MTS
]]

local backdrop = {
  bgFile = "Interface\\AddOns\\Probably_MrTheSoulz\\media\\splash.tga",  
  edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Gold-Border",
  tile = false,
  tileSize = 0,
  edgeSize = 1,
  insets = { left = 11, right = 12, top = 12, bottom = 11 }
 }



local function onUpdate(mtsStart,elapsed) 
	if mtsStart.time < GetTime() - 2.0 and mtsSplash.time < GetTime() - 2.0 then
		if mtsStart:GetAlpha() == 0 and  mtsSplash:GetAlpha() then
			mtsStart:Hide()
			mtsSplash:Hide()
		else 
			mtsStart:SetAlpha(mtsStart:GetAlpha() - .05)
			mtsSplash:SetAlpha(mtsStart:GetAlpha() - .05)
		end
	end
end

mtsSplash = CreateFrame("Frame", nil,UIParent)
mtsSplash:SetPoint("CENTER",UIParent)
mtsSplash:SetWidth(512)
mtsSplash:SetHeight(256)
mtsSplash:SetBackdrop(backdrop)
mtsSplash:SetScript("OnUpdate",onUpdate)
mtsSplash:Hide()
mtsSplash.time = 0

	
mtsStart = CreateFrame("Frame",nil,UIParent)
mtsStart:SetWidth(400)
mtsStart:SetHeight(30)
mtsStart:Hide()
mtsStart:SetScript("OnUpdate",onUpdate)
mtsStart:SetPoint("TOP",0,0)
mtsStart.text = mtsStart:CreateFontString(nil,"OVERLAY","MovieSubtitleFont")
mtsStart.text:SetAllPoints()
mtsStart.time = 0

function mtsStart:message(message) 
	mtsStart.text:SetText(message)
	mtsStart:SetAlpha(1)
	mtsSplash:SetAlpha(1)
	mtsStart.time = GetTime()
	mtsSplash.time = GetTime()
	mtsStart:Show()
	mtsSplash:Show()
end