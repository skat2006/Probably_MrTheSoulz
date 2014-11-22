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