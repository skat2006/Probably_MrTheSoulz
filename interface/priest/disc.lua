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
		{ type = 'header', text = "General settings:", align = "center" },

			-- AutoTargets
			{ type = "checkbox", text = "AutoTargets", key = "AutoTargets", default = true, desc =
			 "This checkbox enables or disables the use of automatic targets."},

			-- Dispels
			{ type = "checkbox", text = "Dispels", key = "Dispels", default = true, desc =
			 "This checkbox enables or disables the use of automatic dispels of everything it can dispel."},
			
			-- Feathers
			{ type = "checkbox", text = "Feathers", key = "Feathers", default = true, desc =
			 "This checkbox enables or disables the use of automatic feathers to move faster."},

			-- Pain Suppression
			{ type = "dropdown",text = "Pain Suppression", key = "PainSuppression", list = {
		    	{
		          text = "Lowest",
		          key = "Lowest"
		        },{
		          text = "Tank",
		          key = "Tank"
		    	},{
		    	  text = "Focus",
		          key = "Focus"
		    	}}, default = "Lowest", desc = "Select Who to use Pain Suppression on." },
			
			-- Pain Suppression // Target
			{ type = "dropdown",text = "Pain Suppression", key = "PainSuppressionTG", list = {
		    	{
		          text = "Allways",
		          key = "Allways"
		        },{
		          text = "Boss",
		          key = "Boss"
		    	}}, default = "Lowest", desc = "Select When to use Pain Suppression." },
			
			-- Pain Suppression // health
			{ type = "spinner", text = "Pain Suppression", key = "PainSuppressionHP", default = 25},

		-- Focus/Tank
		{ type = 'rule' },
		{ type = 'header', text = 'Focus/Tank settings:', align = "center" },

			-- Flash Heal
			{ type = "spinner", text = "Flash Heal", key = "FlashHealTank", default = 40},

			-- Power Word: Shield
			{ type = "spinner", text = "Power Word: Shield", key = "ShieldTank", default = 100},

			-- Heal
			{ type = "spinner", text = "Heal", key = "HealTank", default = 90},

			-- Prayer of Mending
			{ type = "spinner", text = "Prayer of Mending", key = "PrayerofMendingTank", default = 100},


		-- Raid/Party
		{ type = 'rule' },
		{ type = 'header', text = 'Raid/Party settings:', align = "center" },
		{ type = 'spacer' },

			-- Flash Heal
			{ type = "spinner", text = "Flash Heal", key = "FlashHealRaid", default = 20},

			-- Penance
			{ type = "spinner", text = "Panance", key = "PenanceRaid", default = 85},

			-- Power Word: Shield
			{ type = "spinner", text = "Power Word: Shield", key = "ShieldRaid", default = 40},

			-- Heal
			{ type = "spinner", text = "Heal", key = "HealRaid", default = 95},

		-- Player
		{ type = 'rule' },
		{ type = 'header', text = 'Player settings:', align = "center" },

			-- Flash Heal
			{ type = "spinner", text = "Flash Heal", key = "FlashHealPlayer", default = 40},

			-- Power Word: Shield
			{ type = "spinner", text = "Power Word: Shield", key = "ShieldPlayer", default = 70},

			-- Heal
			{ type = "spinner", text = "Heal", key = "HealPlayer", default = 90},

	}
}