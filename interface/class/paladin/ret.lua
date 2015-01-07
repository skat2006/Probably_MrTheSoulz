local logo = "|TInterface\\AddOns\\Probably_MrTheSoulz\\media\\logo.blp:15:15|t"
    
mts_configPalaRet = {
  key = "mtsconfPalaRet",
  profiles = true,
  title = logo.."MrTheSoulz Config",
  subtitle = "Paladin Retribution Settings",
  color = "F58CBA",
  width = 250,
  height = 500,
  config = {
    { 
      type = "checkbox",
      text = "Auto target",
      key = "auto_target",
      default_check = false,
    },
    {
      type = "dropdown",
      text = "Select a Blessing",
      key = "set_blessing",
      list = {
        {
          text = "Kings",
          key = "20217"
        },
        {
          text = "Might",
          key = "19740"
        },
        {
          text = "none",
          key = "none"
        },
      },

      default = "19740",
    },
    {type = "rule"},
    {
      type = "text",
      text = "Self Healing",
      align = "center",
    },
    { 
      type = "checkspin",
      text = "Enable Flash of Light",
      key = "flashoflight",
      default_spin = 40,
      default_check = true,
      desc = "Only for talent 'Selfless Healer'." 
    },
    { 
      type = "checkspin",
      text = "Enable Word of Glory",
      key = "wordofglory",
      default_spin = 30,
      default_check = true,
      desc = "Requiers 3 Holy Power." 
    },
    { 
      type = "checkspin",
      text = "Enable Healthstone",
      key = "healthstone",
      default_spin = 30,
      default_check = true,
    },
    { 
      type = "checkspin",
      text = "Enable Lay on Hands",
      key = "layonhands",
      default_spin = 12,
      default_check = true,
      desc = "Cast after reaching this HP value." 
    },
    {type = "rule"},
    {
      type = "text",
      text = "Self Survivability",
      align = "center",
    },
    { 
      type = "checkspin",
      text = "Enable Divine Shield",
      key = "divineshield",
      default_spin = 10,
      default_check = false,
    },
    { 
      type = "checkbox",
      text = "Enable Cleanse",
      key = "cleanse",
      default_check = true,
    },
    { 
      type = "checkbox",
      text = "Maintain Sacred Shield",
      key = "sacredshield",     
      default_check = false,
    },
    { 
      type = "checkbox",
      text = "Maintain Eternal Glory HoT",
      key = "eternalglory",
      default_check = false,
    },
    { 
      type = "checkbox",
      text = "Enable Hand of Freedom",
      key = "handoffreedom",
      default_check = true,
    },
    { 
      type = "checkbox",
      text = "Enable Emancipate",
      key = "emancipate",
      default_check = true,
    },    
    {  
      type = "dropdown", 
      text = "Empowered Seals",  
      key = "twisting",  
      list = { 
        { 
          text = "Justice", 
          key = "justice" 
        }, 
        { 
          text = "Insight", 
          key = "insight" 
        }, 
        { 
          text = "None", 
          key = "none" 
        } 
      }, default = "None", desc = "Select a third Seal to twist." }, 

    {type = "rule"},
    { 
      type = "checkbox",
      text = "Raid Protection",
      key = "raidprotection",
      default_check = true,
      desc = "Allow LoH, FoL, HoP to cast on raid members."
    },
    { 
      type = "checkspin",
      text = "Hand of Protection",
      key = "handoprot",
      default_spin = 10,
      default_check = true,
      desc = "Allow Hand of Protection on raid members"
    },  
    {type = "rule"},
    {
      type = "text",
      text = "Hotkeys",
      align = "center",
    },    
    {
      type = "text",
      text = "Left Control: Light's Hammer mouseover location",
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