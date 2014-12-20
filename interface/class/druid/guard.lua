local logo = "|TInterface\\AddOns\\Probably_MrTheSoulz\\media\\logo.blp:15:15|t"

mts_configDruidGuard = {
	key = "mtsconfDruidGuard",
	profiles = true,
	title = logo.."MrTheSoulz Config",
	subtitle = "Druid Guardian Settings",
	color = "FF7D0A",
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

			{ 
				type = "checkbox", 
				text = "Buffs", 
				key = "Buffs", 
				default = true, 
				desc = "This checkbox enables or disables the use of automatic buffing."
			},
			{ 
				type = "checkbox", 
				text = "Bear Form", 
				key = "Bear", 
				default = true, 
				desc = "This checkbox enables or disables the use of automatic Bear form."
			},
			{ 
				type = "checkbox", 
				text = "Bear Form OCC", 
				key = "BearOCC", 
				default = false, 
				desc = "This checkbox enables or disables the use of automatic Bear form while out of combat."
			},

		-- Player
		{ type = 'rule' },
		{ 
			type = 'header', 
			text = "Player settings:", 
			align = "center"
		},

			{ 
				type = "spinner", 
				text = "Savage Defense", 
				key = "SavageDefense", 
				default = 95
			},
			{ 
				type = "spinner", 
				text = "Frenzied Regeneration", 
				key = "FrenziedRegeneration", 
				default = 70
			},
			{ 
				type = "spinner", 
				text = "Barkskin", 
				key = "Barkskin", 
				default = 70
			},
			{ 
				type = "spinner", 
				text = "Cenarion Ward", 
				key = "CenarionWard", 
				default = 60
			},
			{ 
				type = "spinner", 
				text = "Survival Instincts", 
				key = "SurvivalInstincts", 
				default = 40 
			},
			{ 
				type = "spinner",
				text = "Renewal", 
				key = "Renewal", 
				default = 40 
			},
			{ 
				type = "spinner", 
				text = "Healthstone", 
				key = "Healthstone", 
				default = 50 
			},
			{ 
				type = "spinner", 
				text = "Healing Tonic", 
				key = "HealingTonic", 
				default = 30 
			},
			{ 
				type = "spinner", 
				text = "Smuggled Tonic", 
				key = "SmuggledTonic", 
				default = 30 
			},	

	}
}