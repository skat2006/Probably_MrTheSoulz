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
			text = "|cff9482C9MrTheSoulz General settings:", 
			size = 15,
			align = "Center",
			offset = 0 
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
			-- [[Fancy]]
			{ type = 'rule' },
			{ 
				type = 'header', 
				text = "|cff9482C9Fancy:", 
				size = 10,
				align = "Center",
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
			-- [[Advanced]]
			{ type = 'rule' },
			{ 
				type = 'header', 
				text = "|cff9482C9Advanced:", 
				size = 10,
				align = "Center",
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
			-- [[Extras]]
			{ type = 'rule' },
			{ 
				type = 'header', 
				text = "|cff9482C9Extras:", 
				size = 10,
				align = "Center",
			},
				{
					type = "checkbox", 
					text = "Auto Accept LFG Queue", 
					key = "AutoLFG", 
					default = false, 
					desc = "Automatic accept LFG proposal."
				},
				{ 
					type = "spinner", 
					text = "Dummy Testing Time", 
					key = "testDummy",
					min = 1,
					max = 30,
					default = 5,
					step = 1,
					desc = "Set how long to run dumy testing for in mintes."
				},
				{  
					type = "checkbox",  
					text = "Auto Open Salvage",  
					key = "OpenSalvage",  
					default = false,  
					desc = "Automatic salvage bags/crates opening." 
				},
			-- [[Fishing]] (new section)
			{ type = 'rule' },
			{ 
				type = 'header', 
				text = "|cff9482C9Fishing:", 
				size = 10,
				align = "Center",
			},
				{
					type = "checkbox", 
					text = "Use Worm Supreme", 
					key = "WormSupreme", 
					default = true, 
					desc = "Enable automatic usage of Worm Supreme."
				},
				{  
				        type = "checkbox",  
				        text = "Use Sharpened Fish Hook",  
				        key = "SharpenedFishHook",  
				        default = false,  
				        desc = "Enable automatic usage of Sharpened Fish Hook." 
				},
				{  
					type = "checkbox",  
					text = "Destroy Lunarfall Carp",  
					key = "LunarfallCarp",  
					default = false,  
					desc = "Enable automatic destruction of Lunarfall Carp." 
				},			    
				{ 
					type = "dropdown",
					text = "Bait:", 
					key = "bait", 
					list = {
							{
								text = "None",
								key = "none"
							},	
							{
								text = "Jawless Skulker",
								key = "jsb"
							},
							{
								text = "Fat Sleeper",
								key = "fsb"
							},
							{
								text = "Blind Lake Sturgeon",
								key = "blsb"
							},
							{
								text = "Fire Ammonite",
								key = "fab"
							},
							{
								text = "Sea Scorpion",
								key = "ssb"
							},
							{
								text = "Abyssal Gulper Eel",
								key = "ageb"
							},
							{
								text = "Blackwater Whiptail",
								key = "bwb"
							},
						}, 
					default = "none" 
				},
			-- [[Cache]]
			{ type = 'rule' },
			{ 
				type = 'header', 
				text = "|cff9482C9Cache Options:", 
				size = 15,
				align = "Center",
				offset = 0 
			},
				{ 
					type = "checkbox", 
					text = "Use Advanced Object Manager", 
					key = "AC", 
					default = true, 
				},
				{ 
					type = "checkbox", 
					text = "Cache Friendly Units", 
					key = "FU", 
					default = true, 
				},
				{ 
					type = "checkbox", 
					text = "Cache Enemie Units", 
					key = "EU", 
					default = true, 
				},
				{ 
					type = "dropdown",
					text = "Friendly Units", 
					key = "FU2", 
					list = {
						{
							text = "All",
							key = "All"
						},
						{
							text = "Players",
							key = "Players"
						},
						{
							text = "Party/Raid",
							key = "PR"
						},
					}, 
					default = "PR" 
				},
				{ 
					type = "dropdown",
					text = "Enemie Units", 
					key = "EU2", 
					list = {
							{
								text = "All",
								key = "All"
							},
							{
								text = "Combat",
								key = "Combat"
							},
						}, 
					default = "Combat" 
				},
				{
					type = "spinner",
					text = "Cache distance",
					key = "CD",
					width = 50,
					min = 10,
					max = 80,
					default = 40,
					step = 5
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
