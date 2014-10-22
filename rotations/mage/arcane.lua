local lib = function()

  ProbablyEngine.toggle.create('alter', 'Interface\\ICONS\\spell_mage_altertime', 'Alter Time', 'Toggle the usage of Alter Time and Arcane Power.')
  ProbablyEngine.toggle.create('blink', 'Interface\\ICONS\\spell_mage_blink', 'Blink!', 'Toggle the usage of bink if the target is 3 or less yards way from you.')


end



local inCombat = {

  -- keybinds
    { "113724", "modifier.alt", "target.ground" }, -- Ring of Frost

  -- Cooldowns
    { "45438", {"modifier.cooldowns","player.health <= 30" }}, -- Ice Block
    { "11958", {"modifier.cooldowns","player.health <= 25","player.spell(45438).cooldown" }}, -- Cold Snap
    { "55342", "modifier.cooldowns" }, -- Mirror Image
    { "12043", "modifier.cooldowns" }, -- Presence of Mind
    { "115610", {"modifier.cooldowns","player.health <= 80"}}, -- Temporal Shield

  -- Alter Time Logic
    { "108978", {"player.buff(12042)","!player.buff(108978)","toggle.alter" }}, -- Alter Time

  -- Interrupts
    { "2139", "modifier.interrupts" }, -- Counterspell
    { "102051", "modifier.interrupts" }, -- Frostjaw

  -- Gems
    { "!/use Mana Gem", "player.mana <= 70" }, -- Mana Gem
    { "!/use Brilliant Mana Gem", "player.mana <= 70" }, -- Brilliant Mana Gem

  -- Mage Bombs
    { "114923", "!target.debuff(114923)", "target" }, -- Nether Tempest
    { "114923", "target.debuff(114923).duration <= 2", "target" }, -- Nether Tempest
    { "44457", "!target.debuff(44457)", "target" }, -- Living Bomb
    { "112948", "player.spell(112948).cooldown = 0", "target" }, -- Frost Bomb

  -- Survivability
    { "122", "target.range <= 9" }, -- Frost Nova
    { "1953", "target.range <= 3" }, -- Blink
    { "116011", "modifier.shift", "player.ground" }, -- Rune of Power
    { "11426", "player.health <= 80" }, -- Ice Barrier

  -- AoE FH
    {"Cone of Cold ", {"player.area(10).enemies >= 3", "@mtsLib.CanFireHack()"}},
    {"Arcane Explosion", {"player.area(10).enemies >= 3", "@mtsLib.CanFireHack()"}},

  -- AoE
    {"Cone of Cold ", "modifier.multitarget"},
    {"Arcane Explosion", "modifier.multitarget"},

  -- procs
    { "5143", "player.buff(Arcane Missiles!)"},-- Arcane Missiles

  -- Moving
    { "108839", "player.moving" }, -- ice floes
    { "44425", "player.moving" }, -- Arcane Barrage
    { "2136", "player.moving" }, -- Fire Blast
    { "30455", {"player.moving","player.spell(2136).cooldown","player.spell(44425).cooldown" }},-- Ice Lance

  -- Rotation
    { "12042", {"player.buff(79683).count >= 2", "toggle.alter" }},-- Arcane Power
    { "5143", { "player.buff(79683).count >= 1", "player.debuff(36032).count >= 4" }},-- Arcane Missiles
    { "44425", {"player.debuff(36032).count >= 4","!player.buff(5143)" }},-- Arcane Barrage
    { "30451" } -- Arcane Blast

}

local outCombat = {

  { "1459", "!player.buff" }, -- Arcane Brilliance

}

ProbablyEngine.rotation.register_custom(62, "|r[|cff9482C9MTS|r][Testing Mage-Arcade|r]", inCombat, outCombat, lib)