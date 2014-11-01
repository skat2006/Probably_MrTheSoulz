mts_config = {
	key = "mtsconf",
	title = "MrTheSoulz Config",
	subtitle = "General Settings",
	color = "69CCF0",
	width = 250,
	height = 500,
	config = {
		{ type = 'header',text = 'MrTheSoulz Pack'},
		{ type = 'rule' },
		{ type = "texture",texture = "Interface\\AddOns\\Probably_MrTheSoulz\\media\\splash.blp",width = 200, height = 100, offset = 110, y = 50, center = true },
		{ type = 'rule' },
		{ type = 'text', text = "This GUI controls MrTheSoulzs Pack settings."},

		-- Splash
		{ type = "checkbox", text = "Splash", key = "Splash", default = true },
		{ type = 'text', text = "This checkbox enables or disables MrTheSoulz splash when you choose the profile."},

		-- Taunts
		{ type = "checkbox", text = "Taunts", key = "Taunts", default = false },
		{ type = 'text', text = "This checkbox enables or disables MrTheSoulz Pack using smarth auto taunts."},

		-- Whispers
		{ type = "checkbox", text = "Whispers", key = "Whispers", default = false },
		{ type = 'text', text = "This checkbox enables or disables MrTheSoulz Pack using Whispers when a special event occurs."},

		-- Alerts
		{ type = "checkbox", text = "Alerts", key = "Alerts", default = true },
		{ type = 'text', text = "This checkbox enables or disables MrTheSoulz Pack using Alerts when a special event occurs."},

		-- Sounds
		{ type = "checkbox", text = "Sounds", key = "Sounds", default = true },
		{ type = 'text', text = "This checkbox enables or disables MrTheSoulz Pack using sounds."},

		-- Firehack
		{ type = "checkbox", text = "Firehack", key = "Firehack", default = true },
		{ type = 'text', text = "This checkbox enables or disables MrTheSoulz Pack using Firehacks features like smarth aoe and other fancy stuff."},
}}