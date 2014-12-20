local logo = "|TInterface\\AddOns\\Probably_MrTheSoulz\\media\\logo.blp:15:15|t"

mts_configPriestHoly = {
	key = "mtsconfPriestHoly",
	profiles = true,
	title = logo.."MrTheSoulz Config",
	subtitle = "Priest Holy Settings",
	color = "ffffff",
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
		{ type = 'spacer' },

			-- Dispels
			{ 
				type = "checkbox", 
				text = "Dispels", 
				key = "Dispels", 
				default = true, 
				desc = "This checkbox enables or disables the use of automatic dispels of everything it can dispel."
			},
			
			-- Feathers
			{ 
				type = "checkbox",
				text = "Feathers", 
				key = "Feathers", 
				default = true, 
				desc = "This checkbox enables or disables the use of automatic feathers to move faster."
			},

			 -- Chakra
			{ 
				type = "dropdown",
				text = "Chakra:", 
				key = "Chakra", 
				list = {
					{
						text = "Chastise",
						key = "Chastise"
					},
					{
						text = "Sanctuary",
						key = "Sanctuary"
					},
					{
						text = "Serenity",
						key = "Serenity"
					}
				}, default = "Serenity", desc = "Select What Chakra to use..." },

		-- Buff
			{ 
				type = "checkbox", 
				text = "Buff", 
				key = "Buff", 
				default = true, 
				desc = "This checkbox enables or disables the use of automatic buffing."
			},

		-- Focus/Tank
		{ type = 'rule' },
		{ 
			type = 'header', 
			text = 'Focus/Tank settings:', 
			align = "center" 
		},
		{ type = 'spacer' },

			-- Flash Heal
			{ 
				type = "spinner", 
				text = "Flash Heal", 
				key = "FlashHealTank", 
				default = 40
			},

			-- Holy Word Serenity
			{ 
				type = "spinner", 
				text = "Holy Word Serenity", 
				key = "HolyWordSerenityTank", 
				default = 90
			},

			-- Power Word: Shield
			{ 
				type = "spinner", 
				text = "Power Word: Shield", 
				key = "ShieldTank", 
				default = 100
			},

			-- Heal
			{ 
				type = "spinner", 
				text = "Heal", 
				key = "HealTank", 
				default = 95
			},

			-- Renew
			{ 
				type = "spinner", 
				text = "Renew", 
				key = "RenewTank", 
				default = 100
			},

			-- Binding Heal
			{ 
				type = "spinner", 
				text = "Binding Heal", 
				key = "BindingHealTank", 
				default = 100
			},

			-- Prayer of Mending
			{ 
				type = "spinner", 
				text = "Prayer of Mending", 
				key = "PrayerofMendingTank", 
				default = 100
			},

		-- Raid/Party
		{ type = 'rule' },
		{ 
			type = 'header', 
			text = 'Raid/Party settings:', 
			align = "center" 
		},
		{ type = 'spacer' },

			-- Flash Heal
			{ 
				type = "spinner", 
				text = "Flash Heal", 
				key = "FlashHealRaid", 
				default = 20
			},

			-- Holy Word Serenity
			{ 
				type = "spinner", 
				text = "Holy Word Serenity", 
				key = "HolyWordSerenityRaid", 
				default = 60
			},

			-- Renew
			{
			 	type = "spinner", 
			 	text = "Renew", 
			 	key = "RenewRaid",
			 	default = 85
			 },

			-- Power Word: Shield
			{ 
				type = "spinner", 
				text = "Power Word: Shield", 
				key = "ShieldRaid", 
				default = 40
			},

			-- Binding Heal
			{ 
				type = "spinner", 
				text = "Binding Heal", 
				key = "BindingHealRaid", 
				default = 99
			},

			-- Heal
			{ 
				type = "spinner", 
				text = "Heal", 
				key = "HealRaid", 
				default = 95
			},

		-- Player
		{ type = 'rule' },
		{ 
			type = 'header', 
			text = 'Player settings:', 
			align = "center" 
		},
		{ type = 'spacer' },

			-- Flash Heal
			{ 
				type = "spinner", 
				text = "Flash Heal", 
				key = "FlashHealPlayer", 
				default = 40
			},

			-- Holy Word Serenity
			{ 
				type = "spinner", 
				text = "Holy Word Serenity", 
				key = "HolyWordSerenityPlayer", 
				default = 90
			},

			-- Renew
			{ 
				type = "spinner", 
				text = "Renew",
				key = "RenewPlayer", 
				default = 85
			},

			-- Power Word: Shield
			{ 
				type = "spinner", 
				text = "Power Word: Shield", 
				key = "ShieldPlayer", 
				default = 70
			},

			-- Desperate Prayer
			{ 
				type = "spinner", 
				text = "Desperate Prayer",
				key = "DesperatePrayer", 
				default = 25
			},

			-- Heal
			{ 
				type = "spinner", 
				text = "Heal", 
				key = "Heal", 
				default = 95
			},

			-- Healthstone
			{ 
				type = "spinner", 
				text = "Heal", 
				key = "Healthstone", 
				default = 35
			},


	}
}