local logo = "|TInterface\\AddOns\\Probably_MrTheSoulz\\media\\logo.blp:15:15|t"

mts_configDkUnholy = {
	key = "mtsconfDkUnholy",
	profiles = true,
	title = logo.."MrTheSoulz Config",
	subtitle = "Deathknight Unholy Settings",
	color = "C41F3B",
	width = 250,
	height = 500,
	config = {
		
		-- General
		{ type = 'rule' },
		{ type = 'header', text = "General settings:", align = "center"},

			-- HornOCC
			{ type = "checkbox", text = "Buff out of combat", key = "HornOCC", default = false, desc =
			 "This checkbox enables or disables the use of buffing while out of combat."},

			{ type = "dropdown",text = "Presence", key = "Presence", list = {
		    	{
		          text = "Unholy",
		          key = "Unholy"
		        },{
		          text = "Blood",
		          key = "Blood"
		    	},{
		    	  text = "Frost",
		          key = "Frost"
		    	}}, default = "Unholy", desc = "Select What Presence to use." },

		-- Focus
		{ type = 'rule' },
		{ type = 'header', text = 'Survival settings:', align = "center"},

			-- Icebound Fortitude
			{ type = "spinner", text = "Icebound Fortitude", key = "IceboundFortitude", default = 40},

			-- Death Pact
			{ type = "spinner", text = "Death Pact", key = "DeathPact", default = 50},

			-- Death Siphon
			{ type = "spinner", text = "Death Siphon", key = "DeathSiphon", default = 60},

			-- Death Strike With Dark Succor
			{ type = "spinner", text = "Death Strike with Dark Succor", key = "DeathStrikeDS", default = 80},

		-- Cooldowns
		{ type = 'rule' },
		{ type = 'header', text = "Cooldowns settings:", align = "center"},

			-- Empower Rune Weapon
			{ type = "dropdown",text = "Empower Rune Weapon", key = "ERP", list = {
		    	{
		          text = "Allways",
		          key = "Allways"
		        },{
		          text = "Boss Only",
		          key = "Boss"
		    	}}, default = "Allways" },

		    -- Summon Gargoyle
			{ type = "dropdown",text = "Summon Gargoyle", key = "SG", list = {
		    	{
		          text = "Allways",
		          key = "Allways"
		        },{
		          text = "Boss Only",
		          key = "Boss"
		    	}}, default = "Allways" },

		    -- Unholy Blight
			{ type = "dropdown",text = "Unholy Blight", key = "UB", list = {
		    	{
		          text = "Allways",
		          key = "Allways"
		        },{
		          text = "Boss Only",
		          key = "Boss"
		    	}}, default = "Allways" },

		    -- Blood Fury
			{ type = "dropdown",text = "Blood Fury", key = "BF", list = {
		    	{
		          text = "Allways",
		          key = "Allways"
		        },{
		          text = "Boss Only",
		          key = "Boss"
		    	}}, default = "Allways" },

		    -- Cooldowns
		{ type = 'rule' },
		{ type = 'header', text = "Cooldowns settings:", align = "center"},

			-- Death and Decay
			{ type = "dropdown",text = "Death and Decay", key = "DnD", list = {
		    	{
		          text = "Allways",
		          key = "Allways"
		        },{
		          text = "AoE only",
		          key = "AoE"
		    	}}, default = "Allways" },

		    -- Defile
			{ type = "dropdown",text = "Defile", key = "Defile", list = {
		    	{
		          text = "Allways",
		          key = "Allways"
		        },{
		          text = "AoE only",
		          key = "AoE"
		    	}}, default = "Allways" },


	}
}