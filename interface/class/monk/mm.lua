local logo = "|TInterface\\AddOns\\Probably_MrTheSoulz\\media\\logo.blp:15:15|t"

mts_configMonkMm = {
	key = "mtsconfigMonkMm",
	profiles = true,
	title = logo.."MrTheSoulz Config",
	subtitle = "Monk Mistweaver Settings",
	color = "cff00FF96",
	width = 250,
	height = 500,
	config = {
		
		-- General
		{ type = 'rule' },
		{ 
			type = 'header',
			text = "General settings:", 
			align = "center" 
		},

			-- NOTHING IN HERE YET...

		{ type = "spacer" },
		{ type = 'rule' },
		{ 
			type = "header", 
			text = "Survival Settings", 
			align = "center" 
		},
			
			-- Survival Settings:
			{
				type = "spinner",
				text = "Soothing Mist",
				key = "SM",
				width = 50,
				min = 0,
				max = 100,
				default = 100,
				step = 5
			},
			
	}
}