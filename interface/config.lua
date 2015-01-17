local logo = "|TInterface\\AddOns\\Probably_MrTheSoulz\\media\\logo.blp:15:15|t"
local fetch = ProbablyEngine.interface.fetchKey

local ConfigWindow
local mts_OpenConfigWindow = false
local mts_ShowingConfigWindow = false

local mts_config = {
	key = "mtsconf",
	profiles = true,
	title = logo.."MrTheSoulz Config",
	subtitle = "General Settings",
	color = "9482C9",
	width = 250,
	height = 500,
	config = {
		{ 
			type = 'header',
			text = 'MrTheSoulz Pack'
		},
		{ type = 'rule' },
		{ 
			type = "texture",
			texture = "Interface\\AddOns\\Probably_MrTheSoulz\\media\\splash.blp",
			width = 200, 
			height = 100, 
			offset = 90, 
			y = 42, 
			center = true 
		},
		
		{ type = 'rule' },
		{ 
			type = 'header', 
			text = "MrTheSoulzs Pack General settings:"
		},
			{ 
				type = "checkbox", 
				text = "Splash", 
				key = "Splash", 
				default = true, 
				desc =  "This checkbox enables or disables MrTheSoulz splash when you choose the profile."
			},
			{ 
				type = "checkbox", 
				text = "Taunts", 
				key = "Taunts", 
				default = false, 
				desc = "This checkbox enables or disables MrTheSoulz Pack using smart automatic taunts."
			},
			{ 
				type = "checkbox", 
				text = "Whispers", 
				key = "Whispers", 
				default = false, 
				desc = "This checkbox enables or disables MrTheSoulz Pack using Whispers when a special event occurs."
			},
			{ 
				type = "checkbox", 
				text = "Alerts", 
				key = "Alerts", 
				default = true, 
				desc = "This checkbox enables or disables MrTheSoulz Pack using Alerts when a special event occurs."
			},
			{ 
				type = "checkbox", 
				text = "Sounds", 
				key = "Sounds", 
				default = true, 
				desc ="This checkbox enables or disables MrTheSoulz Pack using sounds."
			},
			{ 
				type = "checkbox", 
				text = "Smart AoE", 
				key = "SA", 
				default = true, 
				desc ="This checkbox enables or disables MrTheSoulz Pack using Firehacks features like smart aoe and other fancy stuff."
			},
			{ 
				type = "checkbox", 
				text = "LiveGUI", 
				key = "LiveGUI", 
				default = true, 
				desc ="This checkbox enables or disables MrTheSoulz Pack Displaying LiveGUI at Start."
			},
			{ 
				type = "checkbox", 
				text = "Auto Moving", 
				key = "AutoMove", 
				default = false, 
				desc = "Follows your current target if its an enemie.\nChecks for LoS and range."
			},
			{ 
				type = "checkbox", 
				text = "Auto Facing", 
				key = "AutoFace", 
				default = false, 
				desc ="Face your current target.\nChecks for LoS and range."
			},
			{ 
				type = "checkbox", 
				text = "Auto Targets", 
				key = "AutoTarget", 
				default = true, 
				desc = "This checkbox enables or disables the use of automatic targets."
			},
			{ 
				type = "checkbox", 
				text = "Auto Accept LFG Queue", 
				key = "AutoLFG", 
				default = true, 
				desc = "Automatic accept LFG proposal."
			},
			{  
		                type = "checkbox",  
		                text = "Auto Milling",  
		                key = "AutoMilling",  
		                default = false,  
		                desc = "This checkbox enables or disables automatic Draenor herbs milling.\n|cffff2020Warning: |cffFFFFFFWill mill all Draenor herbs in your bags on check!" 
		            },  

	}
}

function mts.ConfigGUI()
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
