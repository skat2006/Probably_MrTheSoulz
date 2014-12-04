local logo = "|TInterface\\AddOns\\Probably_MrTheSoulz\\media\\logo.blp:15:15|t"

local mts_configPriestDisc = {
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
		    	}}, default = "Allways", desc = "Select When to use Pain Suppression." },
			
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

local mts_configPriestHoly = {
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


	}
}

local mts_configPriestShadow = {
	key = "mtsconfPriestShadow",
	profiles = true,
	title = logo.."MrTheSoulz Config",
	subtitle = "Priest Shadow Settings",
	color = "9482C9",
	width = 250,
	height = 500,
	config = {
		
		-- General
		{ type = 'rule' },
		{ type = 'header', text = "General settings:", align = "center" },

		{ 
			type = "checkbox", 
			text = "AutoTargets", 
			key = "AutoTargets", 
			default = true, 
			desc = "This checkbox enables or disables the use of automatic targets."
		},
		{
			type = "checkbox",
			default = true,
			text = "Angelic Feather / Body and Soul",
			key = "feather",
			desc = "Use Angelic Feather / Body and Soul while moving."
		},
		{
			type = "checkbox",
			default = true,
			text = "Levitate",
			key = "levitate",
			desc = "Use Levitate when falling"
		},
		{ type = "spacer" },
		{ type = 'rule' },
		{ type = "header", text = "Survival Settings", align = "center" },
		{
			type = "spinner",
			text = "Healthstone HP",
			key = "hstone",
			width = 50,
			min = 0,
			max = 100,
			default = 75,
			step = 5
		},
		{
			type = "spinner",
			text = "PW:Shield HP",
			key = "shield",
			width = 50,
			min = 0,
			max = 100,
			default = 60,
			step = 5,
		},
		{
			type = "spinner",
			text = "Desperate Prayer HP",
			key = "instaprayer",
			width = 50,
			min = 0,
			max = 100,
			default = 20,
			step = 5,
		},
		{
			type = "spinner",
			text = "Spectral Guise / Dispersion at HP",
			key = "guise",
			width = 50,
			min = 0,
			max = 100,
			default = 20,
			step = 5,
		},
		{
			type = "spinner",
			text = "Fade at Threat",
			key = "fade",
			width = 50,
			min = 0,
			max = 100,
			default = 90,
			step = 5,
			desc = "Use Fade to reduce Threat."
		},

	}
}

local mts_configPalaHoly = {
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
       "This checkbox enables or disables the use of automatic Targets."},

      -- Crusader Strike
      { type = "checkbox", text = "Crusader Strike", key = "CrusaderStrike", default = true , desc =
       "Generates Holy Power."},
      
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
       "This checkbox enables or disables the use of automatic dispels of everything it can dispel." },

      -- Holy Light
      { type = "spinner", text = "Holy Light", key = "HolyLightOCC", default = 100, desc =
       "Holy Light when outside of combat." },

    -- Items
    { type = 'rule' },
    { type = 'header', text = "Items settings:", align = "center"},

      -- Healthstone
      { type = "spinner", text = "Healthstone", key = "Healthstone", default = 50 },

      -- Trinket 1
      { type = "spinner", text = "Trinket 1", key = "Trinket1", default = 85, desc =
       "Use Trinket when player mana is equal to..." }, 

      -- Trinket 2
      { type = "spinner", text = "Trinket 2", key = "Trinket2", default = 85, desc =
       "Use Trinket when player mana is equal to..." },

    -- Survival
    { type = 'rule' },
    { type = 'header', text = "Survival settings:", align = "center"},

      -- Divine Protection
      { type = "spinner", text = "Divine Protection", key = "DivineProtection", default = 90 },

      -- Divine Shield
      { type = "spinner", text = "Divine Shield", key = "DivineShield", default = 20 },

    -- Proc's
    { type = 'rule' },
    { type = 'header', text = "Proc's settings:", align = "center"},

      -- Divine Purpose
      { type = "text", text = "Divine Purpose: ", align = "center" },

        -- Word of Glory
        { type = "spinner", text = "Word of Glory", key = "WordofGloryDP", default = 80 },

        -- Eternal Flame
        { type = "spinner", text = "Eternal Flame", key = "EternalFlameDP", default = 85 },

      -- Selfless Healer
      { type = "text", text = "Selfless Healer: ", align = "center" },

        -- Flash of Light
        { type = "spinner", text = "Flash of light", key = "FlashofLightSH", default = 85 },

      -- Infusion of Light
      { type = "text", text = "Infusion of Light: ", align = "center" },

        -- Holy Light
        { type = "spinner", text = "Holy Light", key = "HolyLightIL", default = 100 },

    -- Tank/Focus
    { type = 'rule' },
    { type = 'header', text = "Tank/Focus settings:", align = "center"},

      -- Beacon of light
      { type = "dropdown",text = "Beacon of light:", key = "Beacon", list = {
        {
          text = "Tank",
          key = "Tank"
        },{
          text = "Focus",
          key = "Focus"
        }}, default = "Tank", desc = "Select who to use Beacon of light on..." },

      -- Hand of Sacrifice
      { type = "spinner", text = "Hand of Sacrifice", key = "HandofSacrifice", default = 40 },

      -- Lay on Hands
      { type = "spinner", text = "Lay on Hands", key = "LayonHandsTank", default = 15 },

      -- Flash of light
      { type = "spinner", text = "Flash of Light", key = "FlashofLightTank", default = 20 },

      -- Execution Sentence
      { type = "spinner", text = "Execution Sentence", key = "ExecutionSentenceTank", default = 80 },

      -- Eternal Flame
      { type = "spinner", text = "Eternal Flame", key = "EternalFlameTank", default = 75, desc =
       "With 3 Holy Power." },

      -- Word of Glory
      { type = "spinner", text = "Word of Glory", key = "WordofGloryTank", default = 80, desc =
       "With 3 Holy Power." },

      -- Holy Shock
      { type = "spinner", text = "Holy Shock", key = "HolyShockTank", default = 100 },

      -- Holy Prism
      { type = "spinner", text = "Holy Prism", key = "HolyPrismTank", default = 85 },

      -- Sacred Shield
      { type = "spinner", text = "Sacred Shield", key = "SacredShieldTank", default = 100, desc =
       "With 1 charge or more." },

      -- Holy Light
      { type = "spinner", text = "Holy Light", key = "HolyLightTank", default = 100 },

    -- Raid/party
    { type = 'rule' },
    { type = 'header', text = "Raid/Party settings:", align = "center"},

      -- Lay on Hands
      { type = "spinner", text = "Lay on Hands", key = "LayonHands", default = 15 },

      -- Flash of light
      { type = "spinner", text = "Flash of Light", key = "FlashofLight", default = 20 },

      -- Execution Sentence
      { type = "spinner", text = "Execution Sentence", key = "ExecutionSentence", default = 10 },

      -- Eternal Flame
      { type = "spinner", text = "Eternal Flame", key = "EternalFlame", default = 93, desc =
       "With 1 Holy Power." },

      -- Word of Glory
      { type = "spinner", text = "Word of Glory", key = "WordofGlory", default = 80, desc =
       "With 3 Holy Power." },

      -- Holy Shock
      { type = "spinner", text = "Holy Shock", key = "HolyShock", default = 100 },

      -- Holy Prism
      { type = "spinner", text = "Holy Prism", key = "HolyPrism", default = 85 },

      -- Sacred Shield
      { type = "spinner", text = "Sacred Shield", key = "SacredShield", default = 80, desc =
       "With 2 charge or more." },

      -- Holy Light
      { type = "spinner", text = "Holy Light", key = "HolyLight", default = 100 },

  }
}

local mts_configPalaProt = {
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
       "This checkbox enables or disables the use of automatic Targets."},
      
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

local mts_configDruidFeral = {
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

local mts_configDruidGuard = {
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

local mts_configDruidResto = {
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

local mts_configDkBlood = {
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

local mts_configDkUnholy = {
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

			 -- Auto Target
			{ type = "checkbox", text = "Auto Target", key = "AutoTarget", default = true, desc =
			 "This checkbox enables or disables the use of Unholy presence while out of combat to move faster."},

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



local mts_BuildGUI = ProbablyEngine.interface.buildGUI
local _CurrentSpec = nil

local ClassWindow
local _OpenClassWindow = false
local _ShowingClassWindow = false



function mts_ClassGUI()
local _SpecID =  GetSpecializationInfo(GetSpecialization())

	-- Check wich spec the player is to return the currect window.	
	if _SpecID == 250 and not _OpenClassWindow then -- DK Blood
		_CurrentSpec = mts_BuildGUI(mts_configDkBlood)

	elseif _SpecID == 252 and not _OpenClassWindow  then -- DK Unholy
		_CurrentSpec = mts_BuildGUI(mts_configDkUnholy)

	elseif _SpecID == 103 and not _OpenClassWindow  then -- Druid Feral
		_CurrentSpec = mts_BuildGUI(mts_configDruidFeral)

	elseif _SpecID == 104 and not _OpenClassWindow  then -- Druid Guardian
		_CurrentSpec = mts_BuildGUI(mts_configDruidGuard)

	elseif _SpecID == 105 and not _OpenClassWindow  then -- Druid Resto
		_CurrentSpec = mts_BuildGUI(mts_configDruidResto)

	elseif _SpecID == 257 and not _OpenClassWindow  then -- Priest holy
		_CurrentSpec = mts_BuildGUI(mts_configPriestHoly)

	elseif _SpecID == 258 and not _OpenClassWindow  then -- Priest Shadow
		_CurrentSpec = mts_BuildGUI(mts_configPriestShadow)
	
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