local logo = "|TInterface\\AddOns\\Probably_MrTheSoulz\\media\\logo.blp:15:15|t"

mts_configPriestShadow = {
	key = "mtsconfPriestShadow",
	profiles = true,
	title = logo.."MrTheSoulz Config",
	subtitle = "Priest Shadow Settings",
	color = "9482C9",
	width = 250,
	height = 500,
	config = {
		
		-- General
		{ type = 'rule' },
		{ type = 'header', text = "General settings:", align = "center" },

		{ 
			type = "checkbox", 
			text = "AutoTargets", 
			key = "AutoTargets", 
			default = true, 
			desc = "This checkbox enables or disables the use of automatic targets."
		},
		{
			type = "checkbox",
			default = true,
			text = "Angelic Feather / Body and Soul",
			key = "feather",
			desc = "Use Angelic Feather / Body and Soul while moving."
		},
		{
			type = "checkbox",
			default = true,
			text = "Levitate",
			key = "levitate",
			desc = "Use Levitate when falling"
		},
		{ type = "spacer" },
		{ type = 'rule' },
		{ type = "header", text = "Survival Settings", align = "center" },
		{
			type = "spinner",
			text = "Healthstone HP",
			key = "hstone",
			width = 50,
			min = 0,
			max = 100,
			default = 75,
			step = 5
		},
		{
			type = "spinner",
			text = "PW:Shield HP",
			key = "shield",
			width = 50,
			min = 0,
			max = 100,
			default = 60,
			step = 5,
		},
		{
			type = "spinner",
			text = "Desperate Prayer HP",
			key = "instaprayer",
			width = 50,
			min = 0,
			max = 100,
			default = 20,
			step = 5,
		},
		{
			type = "spinner",
			text = "Spectral Guise / Dispersion at HP",
			key = "guise",
			width = 50,
			min = 0,
			max = 100,
			default = 20,
			step = 5,
		},
		{
			type = "spinner",
			text = "Fade at Threat",
			key = "fade",
			width = 50,
			min = 0,
			max = 100,
			default = 90,
			step = 5,
			desc = "Use Fade to reduce Threat."
		},

	}
}