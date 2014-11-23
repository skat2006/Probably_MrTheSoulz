local logo = "|TInterface\\AddOns\\Probably_MrTheSoulz\\media\\logo.blp:15:15|t"

local ConfigWindow
local mts_OpenConfigWindow = false
local mts_ShowingConfigWindow = false

local _Header = { 
	type = "texture",texture = "Interface\\AddOns\\Probably_MrTheSoulz\\media\\splash.blp",
	width = 200, 
	height = 100, 
	offset = 90, 
	y = 42, 
	center = true 
}

mts_config = {
	key = "mtsconf",
	profiles = true,
	title = logo.."MrTheSoulz Config",
	subtitle = "General Settings",
	color = "9482C9",
	width = 250,
	height = 500,
	config = {
		{ type = 'header',text = 'MrTheSoulz Pack'},
		{ type = 'rule' },
		_Header,
		
		{ type = 'rule' },
		{ type = 'header', text = "MrTheSoulzs Pack General settings:"},

		-- Splash
		{ type = "checkbox", text = "Splash", key = "Splash", default = true, desc = 
		"This checkbox enables or disables MrTheSoulz splash when you choose the profile."},

		-- Taunts
		{ type = "checkbox", text = "Taunts", key = "Taunts", default = false, desc =
		"This checkbox enables or disables MrTheSoulz Pack using smarth auto taunts."},

		-- Whispers
		{ type = "checkbox", text = "Whispers", key = "Whispers", default = false, desc =
		"This checkbox enables or disables MrTheSoulz Pack using Whispers when a special event occurs."},

		-- Alerts
		{ type = "checkbox", text = "Alerts", key = "Alerts", default = true, desc =
		"This checkbox enables or disables MrTheSoulz Pack using Alerts when a special event occurs."},

		-- Sounds
		{ type = "checkbox", text = "Sounds", key = "Sounds", default = true, desc =
		"This checkbox enables or disables MrTheSoulz Pack using sounds."},

		-- Firehack
		{ type = "checkbox", text = "Firehack", key = "Firehack", default = true, desc =
		"This checkbox enables or disables MrTheSoulz Pack using Firehacks features like smart aoe and other fancy stuff."},

		-- LiveGUI
		{ type = "checkbox", text = "LiveGUI", key = "LiveGUI", default = true, desc =
		"This checkbox enables or disables MrTheSoulz Pack Displaying LiveGUI at Start."},

		-- AutoMove
		{ type = "checkbox", text = "Auto Moving", key = "AutoMove", default = false, desc =
		"Follows your current target if its an enemie.\nChecks for LoS and range."},

	}
}

function mts_ConfigGUI()
	
	-- If a frame has not been created, create one...
	if not mts_OpenConfigWindow then
		ConfigWindow = ProbablyEngine.interface.buildGUI(mts_config)
		-- This is so the window isn't opened twice :D
		mts_OpenConfigWindow = true
		mts_ShowingConfigWindow = true
		ConfigWindow.parent:SetEventListener('OnClose', function()
			mts_OpenConfigWindow = false
			mts_ShowingConfigWindow = false
		end)
	
	-- If a frame has been created and its showing, hide it.
	elseif mts_OpenConfigWindow == true and mts_ShowingConfigWindow == true then
		ConfigWindow.parent:Hide()
		mts_ShowingConfigWindow = false
	
	-- If a frame has been created and its hiding, show it.
	elseif mts_OpenConfigWindow == true and mts_ShowingConfigWindow == false then
		ConfigWindow.parent:Show()
		mts_ShowingConfigWindow = true
	
	end
end