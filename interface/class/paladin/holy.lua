local logo = "|TInterface\\AddOns\\Probably_MrTheSoulz\\media\\logo.blp:15:15|t"

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
    { 
    	type = 'header', 
    	text = "General settings:", 
    	align = "center"
    },
	    { 
	      	type = "checkbox", 
	      	text = "Run Faster", 
	      	key = "RunFaster", 
	      	default = false , 
	      	desc = "This checkbox enables or disables the use of Unholy presence while out of combat to move faster."
	    },
	    { 
	      	type = "checkbox", 
	      	text = "Crusader Strike",
	      	key = "CrusaderStrike", 
	      	default = true , 
	      	desc = "Generates Holy Power."
	    },
	    { 
	      	type = "dropdown",
	      	text = "Buff:", 
	      	key = "Buff", 
	      	list = {
		        {
		          text = "Kings",
		          key = "Kings"
		        },
		        {
		          text = "Might",
		          key = "Might"
		        }
		    }, 
	    	default = "Kings", 
	    	desc = "Select What buff to use The moust..." 
	    },
	    { 
	      	type = "dropdown",
	      	text = "Seal:", 
	      	key = "seal", 
	      	list = {
		        {
		          text = "Insight",
		          key = "Insight"
		        },
		        {
		          text = "Command",
		          key = "Command"
		        }
	    	}, 
	    	default = "Insight", 
	    	desc = "Select What Seal to use..." 
	    },
	    { 
	      	type = "checkbox", 
	      	text = "Dispels", 
	      	key = "Dispels", 
	      	default = true, 
	      	desc = "This checkbox enables or disables the use of automatic dispels of everything it can dispel." 
	    },
	    { 
	    	type = "spinner", 
	    	text = "Holy Light", 
	    	key = "HolyLightOCC", 
	    	default = 100, 
	    	desc = "Holy Light when outside of combat." 
	   	},

    -- Items
    { type = 'rule' },
    { 
    	type = 'header', 
    	text = "Items settings:", 
    	align = "center"
    },
	    { 
	      	type = "spinner", 
	      	text = "Healthstone", 
	      	key = "Healthstone", 
	      	default = 50 
	    },
	    { 
	    	type = "spinner", 
	    	text = "Trinket 1", 
	    	key = "Trinket1", 
	    	default = 85, 
	    	desc = "Use Trinket when player mana is equal to..." 
	   	}, 
	    { 
	    	type = "spinner", 
	    	text = "Trinket 2", 
	    	key = "Trinket2",
	    	default = 85, 
	    	desc = "Use Trinket when player mana is equal to..." 
	    },

    -- Survival
    { type = 'rule' },
    { 
    	type = 'header', 
    	text = "Survival settings:", 
    	align = "center"
    },
	    { 
	      	type = "spinner", 
	      	text = "Divine Protection", 
	      	key = "DivineProtection", 
	      	default = 90 
	    },
	    { 
	    	type = "spinner", 
	    	text = "Divine Shield", 
	    	key = "DivineShield", 
	    	default = 20 
	    },
	    { type = 'rule' },
	    { 
	    	type = 'header', 
	    	text = "Proc's settings:", 
	    	align = "center"
	    },
	    { 
	    	type = "text", 
	    	text = "Divine Purpose: ", 
	    	align = "center" 
	    },
	    { 
	    	type = "spinner", 
	    	text = "Word of Glory", 
	    	key = "WordofGloryDP", 
	    	default = 80 
	    },
	    { 
	    	type = "spinner", 
	    	text = "Eternal Flame", 
	    	key = "EternalFlameDP", 
	    	default = 85 
	   	},
	    { 
	    	type = "text", 
	    	text = "Selfless Healer: ", 
	    	align = "center" 
	    },
	    { 
	    	type = "spinner", 
	    	text = "Flash of light", 
	    	key = "FlashofLightSH", 
	    	default = 85 
	    },
	    { 
	    	type = "text", 
	    	text = "Infusion of Light: ", 
	    	align = "center" 
	    },
	    { 
	    	type = "spinner", 
	    	text = "Holy Light", 
	    	key = "HolyLightIL", 
	    	default = 100 
	    },

    -- Tank/Focus
    { type = 'rule' },
    { type = 'header', text = "Tank/Focus settings:", align = "center"},

	    { 
	    	type = "spinner", 
	    	text = "Hand of Sacrifice", 
	    	key = "HandofSacrifice", 
	    	default = 40 
	    },
	    { 
	    	type = "spinner", 
	    	text = "Lay on Hands", 
	    	key = "LayonHandsTank", 
	    	default = 15 
	    },
	    {
	     	type = "spinner", 
	     	text = "Flash of Light", 
	     	key = "FlashofLightTank", 
	     	default = 20 
	    },
	    { 
	    	type = "spinner", 
	    	text = "Execution Sentence", 
	    	key = "ExecutionSentenceTank", 
	    	default = 80 
	    },
	    { 
	    	type = "spinner",
	    	text = "Eternal Flame", 
	    	key = "EternalFlameTank", 
	    	default = 75, 
	    	desc = "With 3 Holy Power." 
	    },
	    { 
	    	type = "spinner", 
	    	text = "Word of Glory", 
	    	key = "WordofGloryTank", 
	    	default = 80, 
	    	desc = "With 3 Holy Power." 
	    },
	    { 
	    	type = "spinner", 
	    	text = "Holy Shock", 
	    	key = "HolyShockTank", 
	    	default = 100 
	    },
	    { 
	    	type = "spinner", 
	    	text = "Holy Prism", 
	    	key = "HolyPrismTank", 
	    	default = 85 
	    },
	    { 
	    	type = "spinner", 
	    	text = "Sacred Shield", 
	    	key = "SacredShieldTank", 
	    	default = 100, 
	    	desc = "With 1 charge or more." 
	    },
	    { 
	    	type = "spinner", 
	    	text = "Holy Light", 
	    	key = "HolyLightTank", 
	    	default = 100 
	    },

    -- Raid/party
    { type = 'rule' },
    { 
    	type = 'header', 
    	text = "Raid/Party settings:", 
    	align = "center"
    },

      	{ 
      		type = "spinner", 
      		text = "Lay on Hands", 
      		key = "LayonHands", 
      		default = 15 
      	},
      	{ 
      		type = "spinner", 
      		text = "Flash of Light", 
      		key = "FlashofLight", 
      		default = 20 
      	},
      	{ 
      		type = "spinner", 
      		text = "Execution Sentence", 
      		key = "ExecutionSentence", 
      		default = 10 
      	},
      	{ 
      		type = "spinner", 
      		text = "Eternal Flame", 
      		key = "EternalFlame", 
      		default = 93, 
      		desc = "With 1 Holy Power." 
      	},
      	{ 
      		type = "spinner", 
      		text = "Word of Glory", 
      		key = "WordofGlory", 
      		default = 80, 
      		desc = "With 3 Holy Power." 
      	},
      	{ 
      		type = "spinner", 
      		text = "Holy Shock", 
      		key = "HolyShock", 
      		default = 100 
      	},
     	{ 
     		type = "spinner", 
     		text = "Holy Prism", 
     		key = "HolyPrism", 
     		default = 85 
     	},
      	{ 
      		type = "spinner", 
      		text = "Sacred Shield", 
      		key = "SacredShield", 
      		default = 80, 
      		desc = "With 2 charge or more." 
      	},
      	{ 
      		type = "spinner",
      		text = "Holy Light", 
      		key = "HolyLight", 
      		default = 100 
      	},

  }
}