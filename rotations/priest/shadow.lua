
local lib = function()

  mtsStart:message("\124cff9482C9*MrTheSoulz - \124cffABD473Priest/Shadow \124cff9482C9Loaded*")

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
    
  -- If Moving
    { "Shadow Word: Pain", "player.moving" },
    { "Cascade", "player.moving" },
    { "Halo", "player.moving" },
    { "Shadow Word: Death", "player.moving" },
    
  -- Rotation
    { "Shadow Word: Pain", "target.debuff(Shadow Word: Pain).duration <= 5" },
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