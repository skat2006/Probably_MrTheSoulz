local logo = "|TInterface\\AddOns\\Probably_MrTheSoulz\\media\\logo.blp:15:15|t"

mts_configShamanEle = {
	key = "mtsconfShamanEle",
	profiles = true,
	title = logo.."MrTheSoulz Config",
	subtitle = "Shaman Elemental Settings",
	color = "9482C9",
	width = 250,
	height = 500,
	config = {
				{
					type = "checkbox",
					default = false,
					text = "Flameshock mouseover target",
					key = "flameshock",
				}, 
				{type = "rule"},
				{
					type = "text",
					text = "Self Healing",
					align = "center",
				},
				{
					type = "checkspin",
					text = "Healthstone",
					key = "healthstone",
					default_spin = 30,
					default_check = true,
				},
				{
					type = "checkspin",
					text = "Healing Stream Totem",
					key = "healingstreamtotem",
					default_spin = 40,
					default_check = false,
				},
				{
					type = "checkspin",
					text = "Healing Surge",
					key = "healingsurge",
					default_spin = 30,
					default_check = true,
				},
				{
					type = "checkspin",
					text = "Healing Surge Out of Combat",
					key = "healingsurgeOCC",
					default_spin = 90,
					default_check = true,
				},
				{type = "rule"},
				{
					type = "text",
					text = "Self Survivability",
					align = "center",
				},
				{
					type = "checkbox",
					default = true,
					text = "Cleanse Spirit",
					key = "cleansespirit",
				},
				{
					type = "checkbox",
					default = true,
					text = "Tremor Totem",
					key = "tremortotem",
				},
				{
					type = "checkbox",
					default = true,
					text = "Windwalk Totem",
					key = "windwalktotem",
				},
				{
					type = "checkbox",
					default = false,
					text = "Shamanistic Rage",
					key = "shamrage",
					desc = "Cast Shamanistic Rage when stunned."
				},
				{
					type = "checkbox",
					default = false,
					text = "Ancestral Guidance",
					key = "guidance",
					desc = "Cast Ancestral Guidance when Ascendance and Spirit Walker's Grace are active."
				},
				{type = "rule"},
				{
					type = "text",
					text = "Proximity Spells",
					align = "center",
				},
				{
					type = "checkbox",
					default = false,
					text = "Earthbind / Earthgrab",
					key = "earthbind",
				},	
				{
					type = "checkbox",
					default = false,
					text = "Thunderstorm",
					key = "thunderstorm",
				},
				{
					type = "checkbox",
					default = false,
					text = "Frostshock",
					key = "frostshock",
					desc = "Requiers talent 'Frozen Power'."
				},
				{type = "rule"},
				{
					type = "text",
					text = "Hotkeys",
					align = "center",
				},		
				{
					type = "text",
					text = "Left Control: Earthquake mouseover location",
					align = "left",
				},
				{
					type = "text",
					text = "Left Shift: Cleanse on mouseover target",
					align = "left",
				},
				{
					type = "text",
					text = "Left Alt: Pause Rotation",
					align = "left",
				},
			}
}