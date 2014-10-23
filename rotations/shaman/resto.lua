
local lib = function()

  mtsStart:message("\124cff9482C9*MTS-\124cff0070DEShaman/Resto-\124cff9482C9Loaded*")

end

local inCombat = {
  
  -- Oh Shit Healing Start
    { "Healing Rain", { "@coreHealing.needsHealing(45,10)", "!player.buff(Ascendance)"}, "ground"},
    { "Ascendance", { "@coreHealing.needsHealing(45,10)", "!player.buff(Ascendance)", "modifier.cooldowns"}},
    { "Spirit Link Totem", {  "player.buff(Ascendance)", "modifier.cooldowns"}},
   
  -- regular healing
    { "Earth Shield", {"focus.health <= 100", "!focus.buff(Earth Shield)", "focus.range <= 40" }, "focus" },
    { "Riptide", { "focus.health <= 100", "focus.buff(Riptide).duration <= 3", "focus.range <= 40" }, "focus" },
    { "Healing Stream Totem", "@coreHealing.needsHealing(99, 1)" },
    { "Chain Heal", { "!player.buff(Tidal Waves)","@coreHealing.needsHealing(60, 3)", "lowest.range <= 40" }, "lowest" },
    { "Chain Heal", { "@coreHealing.needsHealing(40, 3)", "lowest.range <= 40" }, "lowest" },
    { "Riptide", {"!player.buff(Tidal Waves)","lowest.buff(Riptide).duration <= 3","lowest.range <= 40"}, "lowest" },
    { "Unleash Life", "!player.buff(Unleash Life)" },
    { "Ancestral Swiftness", { "lowest.health <= 20", "lowest.range <= 40" }, "player" },
    { "Healing Wave", {"player.buff(Ancestral Swiftness)" ,"lowest.range <= 40"}, "lowest" },   
    { "Healing Surge", { "lowest.health <= 20", "lowest.range <= 40"}, "lowest" },
    { "Healing Wave", { "lowest.health <= 85","lowest.range <= 40"}, "lowest" },
  
}

local outCombat = {

   
  -- Regular Healing
    { "Water Shield", "Player.buff(Water Shield)" },
    { "pause", "modifier.shift" },
    { "Chain Heal", { "@coreHealing.needsHealing(75, 4)", "lowest.range <= 40" }, "lowest" },
    { "Earth Shield", { "focus.health <= 100", "!focus.buff(Earth Shield)", "focus.range <= 40" }, "focus" },
    { "Healing Surge", { "lowest.health <= 50", "lowest.range <= 40" }, "lowest" },
    { "Riptide", { "lowest.health <= 85", "!lowest.buff(Riptide)", "lowest.range <= 40" }, "lowest" },
    { "Healing Wave", { "lowest.health <= 70", "lowest.range <= 40" }, "lowest" }
  
}


ProbablyEngine.rotation.register_custom(264, "|r[|cff9482C9MTS|r][|cff0070DETesting Shaman-Resto|r]", inCombat, outCombat, lib)