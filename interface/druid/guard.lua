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
		{ type = 'header', text = "General settings:", align = "center"},

			-- Buff
			{ type = "checkbox", text = "Buffs", key = "Buffs", default = true, desc =
			 "This checkbox enables or disables the use of automatic buffing."},

			 -- Bear
			{ type = "checkbox", text = "Bear Form", key = "Bear", default = true, desc =
			 "This checkbox enables or disables the use of automatic Cat form."},

			 -- Auto Target
			{ type = "checkbox", text = "Auto Target", key = "AutoTarget", default = true, desc =
			 "This checkbox enables or disables the use of automatic Targets."},

		-- Player
		{ type = 'rule' },
		{ type = 'header', text = "Player settings:", align = "center"},

			-- Savage Defense
			{ type = "spinner", text = "Savage Defense", key = "SavageDefense", default = 95},

			-- Frenzied Regeneration
			{ type = "spinner", text = "Frenzied Regeneration", key = "FrenziedRegeneration", default = 70},

			-- Barkskin
			{ type = "spinner", text = "Barkskin", key = "Barkskin", default = 70},

			-- Cenarion Ward
			{ type = "spinner", text = "Cenarion Ward", key = "CenarionWard", default = 60},

			-- Survival Instincts
			{ type = "spinner", text = "Survival Instincts", key = "SurvivalInstincts", default = 40 },

			-- Renewal
			{ type = "spinner", text = "Renewal", key = "Renewal", default = 40 },	

			-- Healthstone
			{ type = "spinner", text = "Healthstone", key = "Healthstone", default = 50 },	

			-- Healing Tonic
			{ type = "spinner", text = "Healing Tonic", key = "HealingTonic", default = 30 },	

			-- Smuggled Tonic
			{ type = "spinner", text = "Smuggled Tonic", key = "SmuggledTonic", default = 30 },	

	}
}