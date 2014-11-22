local logo = "|TInterface\\AddOns\\Probably_MrTheSoulz\\media\\logo.blp:15:15|t"

mts_configDruidResto = {
	key = "mtsconfDruidResto",
	profiles = true,
	title = logo.."MrTheSoulz Config",
	subtitle = "Druid Restoration Settings",
	color = "FF7D0A",
	width = 250,
	height = 500,
	config = {
		
		-- General
		{ type = 'rule' },
		{ type = 'header', text = "General settings:", align = "center"},

			-- Dispels
			{ type = "checkbox", text = "Dispels", key = "Dispels", default = true, desc =
			 "This checkbox enables or disables the use of automatic dispels of everything it can dispel."},

		-- Focus
		{ type = 'rule' },
		{ type = 'header', text = 'Focus settings:', align = "center"},

			-- Life Bloom
			{ type = "spinner", text = "Life Bloom", key = "LifeBloomTank", default = 100},

			-- Swiftmend
			{ type = "spinner", text = "Swiftmend", key = "SwiftmendTank", default = 80},

			-- Rejuvenation
			{ type = "spinner", text = "Rejuvenation", key = "RejuvenationTank", default = 95},

			-- Wild Mushroom
			{ type = "spinner", text = "Wild Mushroom", key = "WildMushroomTank", default = 100},

			-- Healing Touch
			{ type = "spinner", text = "Healing Touch", key = "HealingTouchTank", default = 96},

	}
}