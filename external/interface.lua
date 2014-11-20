local logo = "|TInterface\\AddOns\\Probably_MrTheSoulz\\media\\logo.blp:15:15|t"
local _Header = { 
	type = "texture",texture = "Interface\\AddOns\\Probably_MrTheSoulz\\media\\splash.blp",
	width = 200, 
	height = 100, 
	offset = 90, 
	y = 42, 
	center = true 
}
local fetch = ProbablyEngine.interface.fetchKey

local mts_BuildGUI = ProbablyEngine.interface.buildGUI
local _CurrentSpec = nil

local ConfigWindow
local mts_OpenConfigWindow = false
local mts_ShowingConfigWindow = false

local _OpenClassWindow = false
local _ShowingClassWindow = false

local InfoWindow
local mts_OpenInfoWindow = false
local mts_ShowingInfoWindow = false
local mts_InfoUpdating = false

local LiveWindow
local mts_OpenLive = false
local mts_LiveUpdating = false



								--[[   !!!Live window!!!   ]]
--[[!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!]]
local mts_live = {
	key = "mtslive",
	title = logo.."MrTheSoulz GUI \124cffC41F3Bv:"..mts_Version,
	color = "9482C9",
	width = 200,
	height = 84,
	resize = false,
	config = {

		-- Current Spell
		{ type = "text", text = "Queued: ", size = 11, offset = -11 },
		{ key = 'current_Queue', type = "text", text = "Random", size = 11, align = "right", offset = 0 },

		-- Current Spell
		{ type = "text", text = "Last Used: ", size = 11, offset = -11 },
		{ key = 'current_spell', type = "text", text = "Random", size = 11, align = "right", offset = 0 },

		-- AoE
		{ type = "text", text = "AoE: ", size = 11, offset = -11 },
		{ key = 'current_AoE', type = "text", text = "Random", size = 11, align = "right", offset = 0 },

		-- Interrupts
		{ type = "text", text = "Interrupts: ", size = 11, offset = -11 },
		{ key = 'current_Interrupts', type = "text", text = "Random", size = 11, align = "right", offset = 0 },

		-- Cooldowns
		{ type = "text", text = "Cooldowns: ", size = 11, offset = -11 },
		{ key = 'current_Cooldowns', type = "text", text = "Random", size = 11, align = "right", offset = 0 },

		{ type = "spacer" },

		-- Class GUI
		{ type = "button", text = "Class Settings", width = 180, height = 20,
			callback = function()
				mts_ClassGUI()
			end},

		-- General GUI
		{ type = "button", text = "General Settings", width = 180, height = 20,
			callback = function()
				mts_ConfigGUI()
			end},

		-- Info GUI
		{ type = "button", text = "Information", width = 180, height = 20,
			callback = function()
				mts_InfoGUI()
			end},

	}
}

								--[[   !!!INfo!!!   ]]
--[[!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!]]
mts_info = {
	key = "mtsinfo",
	title = logo.."MrTheSoulz Config",
	subtitle = "General Settings",
	color = "9482C9",
	width = 500,
	height = 350,
	config = {
		{ type = 'header',text = 'MrTheSoulz Pack', size = 15},
		{ type = 'rule' },
		{ type = "texture",texture = "Interface\\AddOns\\Probably_MrTheSoulz\\media\\splash.blp",
			width = 400, 
			height = 200, 
			offset = 190, 
			y = 94, 
			center = true 
		},

		-- General Status
		{ type = 'rule' },
		{ type = 'header', text = "MrTheSoulz General Status:", align = "center"},
		{ type = 'spacer' },

			{ type = "text", text = "Unlocker Status: ", size = 11, offset = -11 },
			{ key = 'current_Unlocker', type = "text", text = "Random", size = 11, align = "right", offset = 0 },

			{ type = "text", text = "PE Version Status: ", size = 11, offset = -11 },
			{ key = 'current_PEStatus', type = "text", text = "Random", size = 11, align = "right", offset = 0 },

			{ type = "text", text = "Overall Status: ", size = 11, offset = -11 },
			{ key = 'current_Status', type = "text", text = "Random", size = 11, align = "right", offset = 0 },

		{ type = 'spacer' },
		
		-- CR Status
		{ type = 'rule' },
		{ type = 'header', text = "MrTheSoulz CR Status:", align = "center"},
		{ type = 'spacer' },

			{ type = "text", text = "Queued: ", size = 11, offset = -11 },
			{ key = 'current_Queue', type = "text", text = "Random", size = 11, align = "right", offset = 0 },

			-- Current Spell
			{ type = "text", text = "Last Used: ", size = 11, offset = -11 },
			{ key = 'current_spell', type = "text", text = "Random", size = 11, align = "right", offset = 0 },

			-- AoE
			{ type = "text", text = "AoE: ", size = 11, offset = -11 },
			{ key = 'current_AoE', type = "text", text = "Random", size = 11, align = "right", offset = 0 },

			-- Interrupts
			{ type = "text", text = "Interrupts: ", size = 11, offset = -11 },
			{ key = 'current_Interrupts', type = "text", text = "Random", size = 11, align = "right", offset = 0 },

			-- Cooldowns
			{ type = "text", text = "Cooldowns: ", size = 11, offset = -11 },
			{ key = 'current_Cooldowns', type = "text", text = "Random", size = 11, align = "right", offset = 0 },

		{ type = 'spacer' },

		-- Spec Info
		{ type = 'rule' },
		{ type = 'header', text = "MrTheSoulz Spec Info:", align = "center"},
		{ type = 'spacer' },

			{ type = "text", text = "Spec:", size = 11, offset = -11 },
			{ key = 'current_spec', type = "text", text = "Random", size = 11, align = "right", offset = 0 },

			{ type = "text", text = "Keykinds:", size = 11, offset = -11 },
			{ key = 'current_keybinds', type = "text", text = "Random", size = 11, align = "right", offset = 0 },

		{ type = 'spacer' },
		{ type = 'spacer' },
		{ type = 'spacer' },
		{ type = 'spacer' },
		{ type = 'spacer' },

		{ type = 'rule' },
		{ type = 'header', text = "MrTheSoulz Pack Information:", align = "center"},
		{ type = 'spacer' },

			{ type = 'text', text = "This pack been created for personal use and shared to help others with the same needs." },
			{ type = 'text', text = "If you have any issues while using it and the Status say they are okay, please visit: |cffC41F3Bhttp://www.ownedcore.com/forums/world-of-warcraft/world-of-warcraft-bots-programs/probably-engine/combat-routines/498642-pe-mrthesoulzpack.html|r for futher help."},
			{ type = 'text', text = "Created By: MrTheSoulz" },

			{ type = "button", text = "Close", width = 480, height = 20,
				callback = function()
					mts_InfoGUI()
				end},

		
	}
}

								--[[   !!!General Config!!!   ]]
--[[!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!]]
mts_config = {
	key = "mtsconf",
	profiles = true,
	title = logo.."MrTheSoulz Config",
	subtitle = "General Settings",
	color = "9482C9",
	width = 250,
	height = 500,
	config = {
		{ type = 'header',text = 'MrTheSoulz Pack'},
		{ type = 'rule' },
		_Header,
		
		{ type = 'rule' },
		{ type = 'header', text = "MrTheSoulzs Pack General settings:"},

		-- Splash
		{ type = "checkbox", text = "Splash", key = "Splash", default = true, desc = 
		"This checkbox enables or disables MrTheSoulz splash when you choose the profile."},

		-- Taunts
		{ type = "checkbox", text = "Taunts", key = "Taunts", default = false, desc =
		"This checkbox enables or disables MrTheSoulz Pack using smarth auto taunts."},

		-- Whispers
		{ type = "checkbox", text = "Whispers", key = "Whispers", default = false, desc =
		"This checkbox enables or disables MrTheSoulz Pack using Whispers when a special event occurs."},

		-- Alerts
		{ type = "checkbox", text = "Alerts", key = "Alerts", default = true, desc =
		"This checkbox enables or disables MrTheSoulz Pack using Alerts when a special event occurs."},

		-- Sounds
		{ type = "checkbox", text = "Sounds", key = "Sounds", default = true, desc =
		"This checkbox enables or disables MrTheSoulz Pack using sounds."},

		-- Firehack
		{ type = "checkbox", text = "Firehack", key = "Firehack", default = true, desc =
		"This checkbox enables or disables MrTheSoulz Pack using Firehacks features like smart aoe and other fancy stuff."},

		-- LiveGUI
		{ type = "checkbox", text = "LiveGUI", key = "LiveGUI", default = true, desc =
		"This checkbox enables or disables MrTheSoulz Pack Displaying LiveGUI at Start."},

}}


								--[[   !!!Priest Holy Config!!!   ]]
--[[!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!]]

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
		{ type = 'header', text = "General settings:", align = "center" },
		{ type = 'spacer' },

			-- AutoTargets
			{ type = "checkbox", text = "AutoTargets", key = "AutoTargets", default = true, desc =
			 "This checkbox enables or disables the use of automatic targets."},

			-- Dispels
			{ type = "checkbox", text = "Dispels", key = "Dispels", default = true, desc =
			 "This checkbox enables or disables the use of automatic dispels of everything it can dispel."},
			
			-- Feathers
			{ type = "checkbox", text = "Feathers", key = "Feathers", default = true, desc =
			 "This checkbox enables or disables the use of automatic feathers to move faster."},

			 -- Chakra
			{ type = "dropdown",text = "Chakra:", key = "Chakra", list = {
				{
					text = "Chastise",
					key = "Chastise"
				},{
					text = "Sanctuary",
					key = "Sanctuary"
				},{
					text = "Serenity",
					key = "Serenity"
				}}, default = "Serenity", desc = "Select What Chakra to use..." },

		-- Buff
			{ type = "checkbox", text = "Buff", key = "Buff", default = true, desc =
			 "This checkbox enables or disables the use of automatic buffing."},

		-- Focus/Tank
		{ type = 'rule' },
		{ type = 'header', text = 'Focus/Tank settings:', align = "center" },
		{ type = 'spacer' },

			-- Flash Heal
			{ type = "spinner", text = "Flash Heal", key = "FlashHealTank", default = 40},

			-- Holy Word Serenity
			{ type = "spinner", text = "Holy Word Serenity", key = "HolyWordSerenityTank", default = 90},

			-- Power Word: Shield
			{ type = "spinner", text = "Power Word: Shield", key = "ShieldTank", default = 100},

			-- Heal
			{ type = "spinner", text = "Heal", key = "HealTank", default = 95},

			-- Renew
			{ type = "spinner", text = "Renew", key = "RenewTank", default = 100},

			-- Binding Heal
			{ type = "spinner", text = "Binding Heal", key = "BindingHealTank", default = 100},

			-- Prayer of Mending
			{ type = "spinner", text = "Prayer of Mending", key = "PrayerofMendingTank", default = 100},

		-- Raid/Party
		{ type = 'rule' },
		{ type = 'header', text = 'Raid/Party settings:', align = "center" },
		{ type = 'spacer' },

			-- Flash Heal
			{ type = "spinner", text = "Flash Heal", key = "FlashHealRaid", default = 20},

			-- Holy Word Serenity
			{ type = "spinner", text = "Holy Word Serenity", key = "HolyWordSerenityRaid", default = 60},

			-- Renew
			{ type = "spinner", text = "Renew", key = "RenewRaid", default = 85},

			-- Power Word: Shield
			{ type = "spinner", text = "Power Word: Shield", key = "ShieldRaid", default = 40},

			-- Binding Heal
			{ type = "spinner", text = "Binding Heal", key = "BindingHealRaid", default = 99},

			-- Heal
			{ type = "spinner", text = "Heal", key = "HealRaid", default = 95},

		-- Player
		{ type = 'rule' },
		{ type = 'header', text = 'Player settings:', align = "center" },
		{ type = 'spacer' },

			-- Flash Heal
			{ type = "spinner", text = "Flash Heal", key = "FlashHealPlayer", default = 40},

			-- Holy Word Serenity
			{ type = "spinner", text = "Holy Word Serenity", key = "HolyWordSerenityPlayer", default = 90},

			-- Renew
			{ type = "spinner", text = "Renew", key = "RenewPlayer", default = 85},

			-- Power Word: Shield
			{ type = "spinner", text = "Power Word: Shield", key = "ShieldPlayer", default = 70},

			-- Desperate Prayer
			{ type = "spinner", text = "Desperate Prayer", key = "DesperatePrayer", default = 25},

			-- Heal
			{ type = "spinner", text = "Heal", key = "Heal", default = 95},

			-- Healthstone
			{ type = "spinner", text = "Heal", key = "Healthstone", default = 35},


}}

								--[[   !!!Priest Discipline Config!!!   ]]
--[[!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!]]

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

}}

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

			 -- Cat
			{ type = "checkbox", text = "Cat Form", key = "Cat", default = true, desc =
			 "This checkbox enables or disables the use of automatic Cat form."},

			  -- Cat OOC
			{ type = "checkbox", text = "Cat Form OOC", key = "CatOOC", default = true, desc =
			 "This checkbox enables or disables the use of automatic Cat form while out of combat."},

			-- Prowl
			{ type = "checkbox", text = "Prowl", key = "Prowl", default = false, desc =
			 "This checkbox enables or disables the use of automatic Prowl when out of combat."},

			 -- Auto Target
			{ type = "checkbox", text = "Auto Target", key = "AutoTarget", default = true, desc =
			 "This checkbox enables or disables the use of automatic Targets."},

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

}}

mts_configPalaProt = {
	key = "mtsconfPalaProt",
	profiles = true,
	title = logo.."MrTheSoulz Config",
	subtitle = "Paladin Protection Settings",
	color = "F58CBA",
	width = 250,
	height = 500,
	config = {
		
		-- General
		{ type = 'rule' },
		{ type = 'header', text = "General settings:", align = "center"},

			-- Run Faster
			{ type = "checkbox", text = "Run Faster", key = "RunFaster", default = false , desc =
			 "This checkbox enables or disables the use of Speed of Light to move faster."},

			 -- Auto Target
			{ type = "checkbox", text = "Auto Target", key = "AutoTarget", default = true , desc =
			 "This checkbox enables or disables the use of Unholy presence while out of combat to move faster."},
			
			 -- Buff Might//Kinds
			{ type = "dropdown",text = "Buff:", key = "Buff", list = {
				{
					text = "Kings",
					key = "Kings"
				},{
					text = "Might",
					key = "Might"
				}}, default = "Kings", desc = "Select What buff to use The moust..." },

			-- Seal
			{ type = "dropdown",text = "Seal:", key = "seal", list = {
				{
					text = "Insight",
					key = "Insight"
				},{
					text = "Righteousness",
					key = "Righteousness"
				},{
					text = "Truth",
					key = "Truth"
				}}, default = "Insight", desc = "Select What Seal to use..." },

		-- Def CD's
		{ type = 'rule' },
		{ type = 'header', text = 'Defensive Cooldowns Settings:', align = "center"},

			-- Sacred Shield
			{ type = "spinner", text = "Sacred Shield", key = "SacredShield", default = 95},

			-- Ardent Defender
			{ type = "spinner", text = "ArdentDefender", key = "ArdentDefender", default = 30},

			-- Divine Protection
			{ type = "spinner", text = "Divine Protection", key = "DivineProtection", default = 95},

			-- Guardian of Ancient Kings
			{ type = "spinner", text = "Guardian of Ancient Kings", key = "GuardianofAncientKings", default = 50},

	-- Survival
		{ type = 'rule' },
		{ type = 'header', text = 'Survival Settings:', align = "center"},

			-- Healthstone
			{ type = "spinner", text = "Healthstone", key = "Healthstone", default = 60},

			-- Lay on Hands
			{ type = "spinner", text = "Lay on Hands", key = "LayonHands", default = 20},

			-- Eternal Flame
			{ type = "spinner", text = "Eternal Flame", key = "EternalFlame", default = 85},

			-- Word of Glory
			{ type = "spinner", text = "Word of Glory", key = "WordofGlory", default = 40},

	}
}

mts_configPalaHoly = {
	key = "mtsconfPalaHoly",
	profiles = true,
	title = logo.."MrTheSoulz Config",
	subtitle = "Paladin Holy Settings",
	color = "F58CBA",
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
			
			 -- Buff Might//Kinds
			{ type = "dropdown",text = "Buff:", key = "Buff", list = {
				{
					text = "Kings",
					key = "Kings"
				},{
					text = "Might",
					key = "Might"
				}}, default = "Kings", desc = "Select What buff to use The moust..." },

			-- Seal
			{ type = "dropdown",text = "Seal:", key = "seal", list = {
				{
					text = "Insight",
					key = "Insight"
				},{
					text = "Command",
					key = "Command"
				}}, default = "Insight", desc = "Select What Seal to use..." },

			-- Dispels
			{ type = "checkbox", text = "Dispels", key = "Dispels", default = true, desc =
			 "This checkbox enables or disables the use of automatic dispels of everything it can dispel."},

		

	}
}


local function UnlockerInfo()
	if ProbablyEngine.pmethod == 'Locked' then
		return "|cffC41F3BYou're not Unlocked, please use an unlocker."
	else 
		return "|cff00FF96You're Unlocked, Using: ".. ProbablyEngine.pmethod
	end
end

local function PEVersionInfo()
	if ProbablyEngine.version ~= mts_peRecomemded then
		return "|cffC41F3BYou're not using the recommeded PE version."
	else 
		return "|cff00FF96You're using the recommeded PE version."
	end
end

local function mtsInfoStatus()
	if ProbablyEngine.version == mts_peRecomemded
	and ProbablyEngine.pmethod ~= 'Locked' then
		return "|cff00FF96Okay!"
	else 
		return "|cffC41F3BOuch, something is not right..."
	end
end

local function mts_QueueState()
	if ProbablyEngine.current_spell == false then
		return ("\124cff0070DEWaiting...")
	else return ProbablyEngine.current_spell end
end

local function mts_LastCastState()
	return ProbablyEngine.parser.lastCast == "" and "\124cff0070DENone" or ProbablyEngine.parser.lastCast
end

local function mts_AoEState()
	if FireHack and fetch('mtsconf','Firehack') then
		if ProbablyEngine.config.read('button_states', 'multitarget', false) then
			return ("\124cff0070DEForced")
		end
	  return ("\124cff0070DESmart AoE")
	elseif ProbablyEngine.config.read('button_states', 'multitarget', false) then
			return ("\124cff0070DEON")
	else
		return ("\124cffC41F3BOFF") 
	end
end

local function mts_KickState()
	if ProbablyEngine.config.read('button_states', 'interrupt', false) then
		return ("\124cff0070DEON")
	else return ("\124cffC41F3BOFF") end
end

local function mts_CdState()
	if ProbablyEngine.config.read('button_states', 'cooldowns', false) then
		return ("\124cff0070DEON")
	else return ("\124cffC41F3BOFF") end
end

local function mts_ClassInfo()
	local _SpecID =  GetSpecializationInfo(GetSpecialization())

	-- Check wich spec the player is to return the currect info.	
	if _SpecID == 66 then -- Pala Prot
		return ("Control: Fist of Justice or Hammer of Justice\nShift: Light´s Hammer")
	else 
		return ("This Current Class is either not suported or wasnt documented yet...")
	end
end




local function mts_updateLiveGUI()
	LiveWindow.elements.current_Queue:SetText(mts_QueueState())
	LiveWindow.elements.current_spell:SetText(mts_LastCastState())
	LiveWindow.elements.current_AoE:SetText(mts_AoEState())
	LiveWindow.elements.current_Interrupts:SetText(mts_KickState())
	LiveWindow.elements.current_Cooldowns:SetText(mts_CdState())
end

local function mts_updateLiveInfo()
	-- General Status
	InfoWindow.elements.current_Unlocker:SetText(UnlockerInfo())
	InfoWindow.elements.current_PEStatus:SetText(PEVersionInfo())
	InfoWindow.elements.current_Status:SetText(mtsInfoStatus())

	-- CR Status
	InfoWindow.elements.current_Queue:SetText(mts_QueueState())
	InfoWindow.elements.current_spell:SetText(mts_LastCastState())
	InfoWindow.elements.current_AoE:SetText(mts_AoEState())
	InfoWindow.elements.current_Interrupts:SetText(mts_KickState())
	InfoWindow.elements.current_Cooldowns:SetText(mts_CdState())

	-- Spec info
	InfoWindow.elements.current_spec:SetText(select(2, GetSpecializationInfo(GetSpecialization())) or "None")
	InfoWindow.elements.current_keybinds:SetText(mts_ClassInfo())
end

function mts_InfoGUI()
	if not mts_OpenInfoWindow then
		InfoWindow = ProbablyEngine.interface.buildGUI(mts_info)
		-- This is so the window isn't opened twice :D
		mts_OpenInfoWindow = true
		mts_ShowingInfoWindow = true
		InfoWindow.parent:SetEventListener('OnClose', function()
			mts_OpenInfoWindow = false
			mts_ShowingInfoWindow = false
		end)
	
	elseif mts_OpenInfoWindow == true and mts_ShowingInfoWindow == true then
		InfoWindow.parent:Hide()
		mts_ShowingInfoWindow = false
	
	elseif mts_OpenInfoWindow == true and mts_ShowingInfoWindow == false then
		InfoWindow.parent:Show()
		mts_ShowingInfoWindow = true
	
	end

	if not mts_InfoUpdating then
			mts_InfoUpdating = true
			C_Timer.NewTicker(1.00, mts_updateLiveInfo, nil)
		end
end

function mts_showLive()

	-- If a window is not created, then create one...
	if not mts_OpenLive and fetch('mtsconf','LiveGUI') then
		LiveWindow = ProbablyEngine.interface.buildGUI(mts_live)
		-- This is so the window isn't opened twice :D
		mts_OpenLive = true
		LiveWindow.parent:SetEventListener('OnClose', function()
			mts_OpenLive = false
		end)
	end

	if not mts_LiveUpdating then
			mts_LiveUpdating = true
			C_Timer.NewTicker(0.01, mts_updateLiveGUI, nil)
		end
end

function mts_ConfigGUI()
	
	-- If a frame has not been created, create one...
	if not mts_OpenConfigWindow then
		ConfigWindow = ProbablyEngine.interface.buildGUI(mts_config)
		-- This is so the window isn't opened twice :D
		mts_OpenConfigWindow = true
		mts_ShowingConfigWindow = true
		ConfigWindow.parent:SetEventListener('OnClose', function()
			mts_OpenConfigWindow = false
			mts_ShowingConfigWindow = false
		end)
	
	-- If a frame has been created and its showing, hide it.
	elseif mts_OpenConfigWindow == true and mts_ShowingConfigWindow == true then
		ConfigWindow.parent:Hide()
		mts_ShowingConfigWindow = false
	
	-- If a frame has been created and its hiding, show it.
	elseif mts_OpenConfigWindow == true and mts_ShowingConfigWindow == false then
		ConfigWindow.parent:Show()
		mts_ShowingConfigWindow = true
	
	end
end

function mts_ClassGUI()
local _SpecID =  GetSpecializationInfo(GetSpecialization())

	-- Check wich spec the player is to return the currect window.	
	if _SpecID == 250 and not _OpenClassWindow then -- DK Blood
		_CurrentSpec = mts_BuildGUI(mts_configDkBlood)

	elseif _SpecID == 103 and not _OpenClassWindow  then -- Druid Feral
		_CurrentSpec = mts_BuildGUI(mts_configDruidFeral)

	elseif _SpecID == 104 and not _OpenClassWindow  then -- Druid Guardian
		_CurrentSpec = mts_BuildGUI(mts_configDruidGuard)

	elseif _SpecID == 105 and not _OpenClassWindow  then -- Druid Resto
		_CurrentSpec = mts_BuildGUI(mts_configDruidResto)

	elseif _SpecID == 257 and not _OpenClassWindow  then -- Priest holy
		_CurrentSpec = mts_BuildGUI(mts_configPriestHoly)

	elseif _SpecID == 256 and not _OpenClassWindow  then -- Priest Disc
		_CurrentSpec = mts_BuildGUI(mts_configPriestDisc)

	elseif _SpecID == 66 and not _OpenClassWindow  then -- Pala Prot
		_CurrentSpec = mts_BuildGUI(mts_configPalaProt)

	elseif _SpecID == 65 and not _OpenClassWindow  then -- Pala Holy
		_CurrentSpec = mts_BuildGUI(mts_configPalaHoly)	
	end

	-- If no window been created, create one...
	if not _OpenClassWindow and _CurrentSpec ~= nil then
		_OpenClassWindow = true
		_ShowingClassWindow = true
		_CurrentSpec.parent:SetEventListener('OnClose', function()
			_OpenClassWindow = false
			_ShowingClassWindow = false
		end)

	-- If a windows has been created and its showing then hide it...	
	elseif _OpenClassWindow == true and _ShowingClassWindow == true then
		_CurrentSpec.parent:Hide()
		_ShowingClassWindow = false

	-- If a windows has been created and its hidden then show it...		
	elseif _OpenClassWindow == true and _ShowingClassWindow == false then
		_CurrentSpec.parent:Show()
		_ShowingClassWindow = true
	end

end