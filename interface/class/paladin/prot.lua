local logo = "|TInterface\\AddOns\\Probably_MrTheSoulz\\media\\logo.blp:15:15|t"

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

      -- Seal AoE
      { type = "dropdown",text = "Seal AoE:", key = "sealAoE", list = {
        {
          text = "Insight",
          key = "Insight"
        },{
          text = "Righteousness",
          key = "Righteousness"
        },{
          text = "Truth",
          key = "Truth"
        }}, default = "Righteousness", desc = "Select What Seal to use while in AoE..." },

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

  -- Raid Heals
    { type = 'rule' },
    { 
      type = 'header', 
      text = 'Survival Settings:', 
      align = "center"
    },
      { 
        type = "spinner", 
        text = "Flash of Light", 
        key = "FlashOfLight_Raid", 
        default = 40, 
        desc = "Only with 3 stacks of Selfless Healer"
      },
      { 
        type = "spinner", 
        text = "Lay on Hands", 
        key = "LayOnHands_Raid", 
        default = 10
      },
      { 
        type = "spinner", 
        text = "Hand of Protection", 
        key = "HandOfProtection_Raid", 
        default = 30
      },

  }
}