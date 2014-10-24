
local lib = function()

  ProbablyEngine.toggle.create('autotarget', 'Interface\\Icons\\Ability_spy.png', 'Auto Target', 'Automatically target the nearest enemy when target dies or does not exist,')
  ProbablyEngine.toggle.create('mouseoverdots', 'Interface\\Icons\\INV_Helmet_131.png', 'Mouseoverd Doting', 'Mouseover to to anything thats not doted.')
  mtsStart:message("\124cff9482C9*MTS-\124cffFFFFFFPriest/Shadow-\124cff9482C9Loaded*")

end

local Shared = {
  
  --buffs
    { "Power Word: Fortitude", "!player.buff(Power Word: Fortitude)" },
    { "Inner Fire", "!player.buff(Inner Fire)" },
    { "Shadow Form", "!player.buff(Shadowform)" },

}

local inCombat = {

  -- Cooldowns
    { "Power Infusion", "modifier.cooldowns" },
    { "Shadowfiend", "modifier.cooldowns" },
    
  -- Keybinds
    { "Mind Sear", "modifier.shift" },

  -- Auto Target
    { "/target [target=focustarget, harm, nodead]", {"target.range > 40", "!target.exists","toggle.autotarget"} },
    { "/targetenemy [noexists]", { "toggle.autotarget", "!target.exists" }},
    { "/targetenemy [dead]", { "toggle.autotarget", "target.exists", "target.dead" }},


  -- dots
    { "/run mtsLib.dots(589, 589)", {"player.area(30).enemies > 1", "player.spell(589).cooldown = 0", "@mtsLib.CanFireHack()"}},
    { "589",  "!target.debuff(589)" , "target" },
    { "589",  {"toggle.mouseoverdots","!mouseover.debuff(589)"} , "mouseover" },

  -- If Moving
    { "Cascade", "player.moving" },
    { "Halo", "player.moving" },
    { "Shadow Word: Death", "player.moving" },

  -- Rotation
    { "Mind Blast", "player.buff(Divine Insight)" },
    { "Devouring Plague", "player.shadoworbs >= 3" },
    { "Mind Blast" }, 
    { "Shadow Word: Death", "target.debuff(Shadow Word: Death).duration < 1" },
    { "Vampiric Touch", "target.debuff(Vampiric Touch).duration <= 4" },
    { "Mind Flay", "target.debuff(Devouring Plague)" }, 
    { "Cascade", },
    { "Halo" },
    { "Mind Spike", "player.buff(Surge of Darkness)" },
    { "Mind Flay" },
    { "Shadow Word: Death" },
  
} 

local outCombat = {


  
}

for _, Shared in pairs(Shared) do
  inCombat[#inCombat + 1] = Shared
  outCombat[#outCombat + 1] = Shared
end

ProbablyEngine.rotation.register_custom(258, "|r[|cff9482C9MTS|r][Testing Priest-Shadow|r]", inCombat, outCombat, lib)