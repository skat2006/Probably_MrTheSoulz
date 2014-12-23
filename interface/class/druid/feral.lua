local logo = "|TInterface\\AddOns\\Probably_MrTheSoulz\\media\\logo.blp:15:15|t"

mts_configDruidFeral = {
	key = "mtsconfDruidFeral",
	profiles = true,
	title = logo.."MrTheSoulz Config",
	subtitle = "Druid Feral Settings",
	color = "FF7D0A",
	width = 250,
	height = 500,
	config = {
		
		-- General
		{ type = 'rule' },
		{ type = 'header', text = "General settings:", align = "center"},

			-- Buff
			{ type = "checkbox", text = "Buffs", key = "Buffs", default = true, desc =
			 "This checkbox enables or disables the use of automatic buffing."},

			{ 
		      	type = "dropdown",
		      	text = "Form", 
		      	key = "Form", 
		      	list = {
			        {
			          text = "Cat",
			          key = "2"
			        },
			        {
			          text = "Bear",
			          key = "1"
			        },
			        {
			          text = "Travel",
			          key = "3"
			        },
			        {
			          text = "Normal",
			          key = "0"
			        },
			        {
			          text = "MANUAL",
			          key = "MANUAL"
			        }
			    }, 
		    	default = "2", 
		    	desc = "Select What form to use while in of combat" 
		    },
			{ 
		      	type = "dropdown",
		      	text = "Form OOC", 
		      	key = "FormOCC", 
		      	list = {
			        {
			          text = "Cat",
			          key = "2"
			        },
			        {
			          text = "Bear",
			          key = "1"
			        },
			        {
			          text = "Travel",
			          key = "3"
			        },
			        {
			          text = "Normal",
			          key = "0"
			        },
			        {
			          text = "MANUAL",
			          key = "MANUAL"
			        }
			    }, 
		    	default = "0", 
		    	desc = "Select What form to use while out of combat" 
		    },

			-- Prowl
			{ type = "checkbox", text = "Prowl", key = "Prowl", default = false, desc =
			 "This checkbox enables or disables the use of automatic Prowl when out of combat."},

		-- Player
		{ type = 'rule' },
		{ type = 'header', text = "Player settings:", align = "center"},

			-- Tiger's Fury
			{ type = "spinner", text = "Tigers Fury", key = "TigersFury", default = 35},

			-- Renewal
			{ type = "spinner", text = "Renewal", key = "Renewal", default = 30},

			-- Cenarion Ward
			{ type = "spinner", text = "Cenarion Ward", key = "CenarionWard", default = 75},

			-- Survival Instincts
			{ type = "spinner", text = "Survival Instincts", key = "SurvivalInstincts", default = 75},

			-- Healing Touch
			{ type = "spinner", text = "Healing Touch", key = "HealingTouch", default = 70, Desc=
			"When player as buff (Predatory Swiftness)."},		

	}
}