local fetch = ProbablyEngine.interface.fetchKey
local WoWver, WoWbuild, WoWdate, WoWtoc = GetBuildInfo()

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

function mts.Splash()
	-- Displays a fancy splash.
	if fetch('mtsconf', 'Splash') then
		mtsStart.text:SetText("|TInterface\\AddOns\\Probably_MrTheSoulz\\media\\logo.blp:17:17|t"..mts.addonColor.."[MTS]|r-[".."|T"..(select(4, GetSpecializationInfo(GetSpecialization())))..":13:13|t"..(select(2, GetSpecializationInfo(GetSpecialization()))).."|r]-"..mts.addonColor.."[Loaded]", 5.0)
		mtsStart:SetAlpha(1)
		mtsSplash:SetAlpha(1)
		mtsStart.time = GetTime()
		mtsSplash.time = GetTime()
		mtsStart:Show()
		mtsSplash:Show()
		--PlaySoundFile("Sound\\Interface\\Levelup.Wav")
		PlaySound("UnwrapGift", "master");
	end
	-- This is used so we know we're using MTS CR's, this way we cant stop stuff from running while we're not running.
	mts.CurrentCR = true
	-- Tell the user erros
	if WoWver ~= mts.WoW_Version or ProbablyEngine.version ~= mts.peRecomemded then
		if WoWver ~= mts.WoW_Version then
			mts.Print("Your WoW Version is not supported by MTSP\n Using: "..WoWver.." while supported version is: "..mts.WoW_Version.."\nSomethings might not work until updated.")
		end
		if ProbablyEngine.version ~= mts.peRecomemded then
			mts.Print("Your PE Version is not supported by MTSP\n Using: "..ProbablyEngine.version.." while supported version is: "..mts.peRecomemded.."\nSomethings might not work until updated.")
		end
	else
		mts.Print("Load successful.")
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