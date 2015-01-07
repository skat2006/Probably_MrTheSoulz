local logo = "|TInterface\\AddOns\\Probably_MrTheSoulz\\media\\logo.blp:15:15|t"

mts_configPriestDisc = {
	key = "mtsconfPriestDisc",
	profiles = true,
	title = logo.."MrTheSoulz Config",
	subtitle = "Priest Discipline Settings",
	color = "9482C9",
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
				text = "Dispels", 
				key = "Dispels", 
				default = true, 
				desc = "This checkbox enables or disables the use of automatic dispels of everything it can dispel."
			},
			{ 
				type = "checkbox", 
				text = "Power Word Barrier", 
				key = "PowerWordBarrier", 
				default = true, 
				desc = "This checkbox enables or disables the use of automatic Power Word Barrier on tank."
			},
			{ 
				type = "checkbox", 
				text = "Feathers", 
				key = "Feathers", 
				default = true, 
				desc = "This checkbox enables or disables the use of automatic feathers to move faster."
			},
			{ 
				type = "dropdown",
				text = "Pain Suppression", 
				key = "PainSuppression", 
				list = {
			    	{
			          text = "Lowest",
			          key = "Lowest"
			        },
			        {
			          text = "Tank",
			          key = "Tank"
			    	},
			    	{
			    	  text = "Focus",
			          key = "Focus"
			    	}
		    	}, 
		    	default = "Lowest", 
		    	desc = "Select Who to use Pain Suppression on." 
		    },
			{ 
				type = "dropdown",
				text = "Pain Suppression", 
				key = "PainSuppressionTG", 
				list = {
			    	{
			          text = "Allways",
			          key = "Allways"
			        },
			        {
			          text = "Boss",
			          key = "Boss"
			    	}
		    	}, 
		    	default = "Allways", 
		    	desc = "Select When to use Pain Suppression." 
		    },
			{ 
				type = "spinner", 
				text = "Pain Suppression", 
				key = "PainSuppressionHP", 
				default = 25
			},
			{ 
				type = "spinner", 
				text = "Attonement", 
				key = "Attonement", 
				default = 90,
				desc = "If a lowest unit goes bellow HP% then use direct heals."
			},

		-- Focus/Tank
		{ type = 'rule' },
		{ 
			type = 'header', 
			text = 'Focus/Tank settings:', 
			align = "center" 
		},

			{ 
				type = "spinner", 
				text = "Flash Heal", 
				key = "FlashHealTank", 
				default = 40
			},
			{ 
				type = "spinner", 
				text = "Power Word: Shield", 
				key = "ShieldTank", 
				default = 100
			},
			{ 
				type = "spinner", 
				text = "Heal", 
				key = "HealTank", 
				default = 90
			},
			{ 
				type = "spinner", 
				text = "Prayer of Mending", 
				key = "PrayerofMendingTank",
				default = 100
			},
			{
				type = "checkspin",
				text = "Clarity of Will",
				key = "CoWTank",
				default_spin = 100,
				default_check = true,
			},


		-- Raid/Party
		{ type = 'rule' },
		{ 
			type = 'header', 
			text = 'Raid/Party settings:', 
			align = "center" 
		},
		{ type = 'spacer' },

			{ 
				type = "spinner", 
				text = "Flash Heal", 
				key = "FlashHealRaid", 
				default = 20
			},
			{ 
				type = "spinner", 
				text = "Panance", 
				key = "PenanceRaid", 
				default = 85
			},
			{ 
				type = "spinner", 
				text = "Power Word: Shield", 
				key = "ShieldRaid", 
				default = 40
			},
			{ 
				type = "spinner", 
				text = "Heal", 
				key = "HealRaid", 
				default = 95
			},
			{
				type = "checkspin",
				text = "Clarity of Will",
				key = "CoW",
				default_spin = 100,
				default_check = true,
			},
			{
				type = "checkspin",
				text = "Saving Grace",
				key = "SavingGrace",
				default_spin = 20,
				default_check = true,
			},
			{ 
				type = "spinner", 
				text = "SavingGrace Debuff Stacks", 
				key = "SavingGraceStacks",
				min = 0,
				max = 10,
				default = 5,
				step = 1
			},


		-- Player
		{ type = 'rule' },
		{ 
			type = 'header', 
			text = 'Player settings:', 
			align = "center" 
		},

			{ 
				type = "spinner", 
				text = "Flash Heal", 
				key = "FlashHealPlayer", 
				default = 40
			},
			{ 
				type = "spinner", 
				text = "Power Word: Shield",
				key = "ShieldPlayer", 
				default = 70
			},
			{ 
				type = "spinner", 
				text = "Heal", 
				key = "HealPlayer", 
				default = 90
			},

	}
}