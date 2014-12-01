local fetch = ProbablyEngine.interface.fetchKey

local function onUpdate(mtsStart,elapsed) 
	if mtsStart.time < GetTime() - 5.0 and mtsSplash.time < GetTime() - 5.0 then
		if mtsStart:GetAlpha() == 0 and  mtsSplash:GetAlpha() then
			mtsStart:Hide()
			mtsSplash:Hide()
		else 
			mtsStart:SetAlpha(mtsStart:GetAlpha() - .05)
			mtsSplash:SetAlpha(mtsStart:GetAlpha() - .05)
		end
	end
end

function mts_Splash(message)
	if fetch('mtsconf', 'Splash') then
		mtsStart.text:SetText("|TInterface\\AddOns\\Probably_MrTheSoulz\\media\\logo.blp:17:17|t"..message)
		mtsStart:SetAlpha(1)
		mtsSplash:SetAlpha(1)
		mtsStart.time = GetTime()
		mtsSplash.time = GetTime()
		mtsStart:Show()
		mtsSplash:Show()
		PlaySoundFile("Sound\\Interface\\Levelup.Wav")
	end
end

mtsSplash = CreateFrame("Frame", nil,UIParent)
mtsSplash:SetPoint("CENTER",UIParent)
mtsSplash:SetWidth(512)
mtsSplash:SetHeight(256)
mtsSplash:SetBackdrop({ bgFile = "Interface\\AddOns\\Probably_MrTheSoulz\\media\\splash.blp" })
mtsSplash:SetScript("OnUpdate",onUpdate)
mtsSplash:Hide()
mtsSplash.time = 0
	
mtsStart = CreateFrame("Frame",nil,UIParent)
mtsStart:SetWidth(600)
mtsStart:SetHeight(30)
mtsStart:Hide()
mtsStart:SetScript("OnUpdate",onUpdate)
mtsStart:SetPoint("TOP",0,0)
mtsStart.text = mtsStart:CreateFontString(nil,"OVERLAY","MovieSubtitleFont")
mtsStart.text:SetAllPoints()
mtsStart.time = 0