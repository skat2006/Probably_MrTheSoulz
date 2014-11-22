local logo = "|TInterface\\AddOns\\Probably_MrTheSoulz\\media\\logo.blp:15:15|t"

mts_configDkBlood = {
	key = "mtsconfDkBlood",
	profiles = true,
	title = logo.."MrTheSoulz Config",
	subtitle = "Deathknight Blood Settings",
	color = "C41F3B",
	width = 250,
	height = 500,
	config = {
		
		-- General
		{ type = 'rule' },
		{ type = 'header', text = "General settings:", align = "center"},

			-- Run Faster
			{ type = "checkbox", text = "Run Faster", key = "RunFaster", default = false , desc =
			 "This checkbox enables or disables the use of Unholy presence while out of combat to move faster."},

			 -- Auto Target
			{ type = "checkbox", text = "Auto Target", key = "AutoTarget", default = true , desc =
			 "This checkbox enables or disables the use of Unholy presence while out of combat to move faster."},

		-- Focus
		{ type = 'rule' },
		{ type = 'header', text = 'Player settings:', align = "center"},

			-- Icebound Fortitude
			{ type = "spinner", text = "Icebound Fortitude", key = "IceboundFortitude", default = 40},

			-- Vampiric Blood
			{ type = "spinner", text = "Vampiric Blood", key = "VampiricBlood", default = 40},

			-- Death Pact
			{ type = "spinner", text = "Death Pact", key = "DeathPact", default = 50},

			-- Rune Tap
			{ type = "spinner", text = "Rune Tap", key = "RuneTap", default = 60},

			-- Death Siphon
			{ type = "spinner", text = "Death Siphon", key = "DeathSiphon", default = 60},

	}
}