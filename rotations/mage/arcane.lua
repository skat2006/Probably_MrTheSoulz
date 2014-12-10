local fetch = ProbablyEngine.interface.fetchKey

local lib = function()

  ProbablyEngine.toggle.create('alter', 'Interface\\ICONS\\spell_mage_altertime', 'Alter Time', 'Toggle the usage of Alter Time and Arcane Power.')
  ProbablyEngine.toggle.create('def', 'Interface\\ICONS\\creatureportrait_creature_iceblock', 'Survival', 'Ice Block when Shit gets serious')
  
end



local inCombat = {

  -- keybinds
    { "113724", "modifier.alt", "target.ground" }, -- Ring of Frost
    { "116011", {"modifier.shift","!player.buff(116014)"}, "player.ground" }, -- Rune of Power

  -- Survival
    { "45438", {"toggle.def","player.health <= 30"}}, --Ice Block
    { "11958", {"toggle.def","player.health <= 25","player.spell(45438).cooldown"}}, --Cold Snap for Reset 
    { "#5512", "player.health < 35"},--Healthstone

  -- Cooldowns
    { "12042", "modifier.cooldowns"},--Arcane Power
    { "12043", "modifier.cooldowns"},--Presence of Mind
    { "108978", {"player.buff(12042)","!player.buff(108978)","toggle.alter" }},--Alter Time
    { "159916", "modifier.cooldowns"}, -- AMagic

  -- Interrupts
    { "102051", "modifier.interrupts" }, -- Frostjaw
    { "2139", "modifier.interrupts" }, -- Counterspell

  {{-- can use FH

    -- AoE smart
      { "1449", "target.area(10).enemies >= 5" },--Arcane Explosion
      { "120", "target.area(10).enemies >= 5" },--Cone of Cold

  }, {"player.firehack", (function() return fetch('mtsconf','Firehack') end),}},

  -- AoE
    { "1449", "modifier.multitarget"},--Arcane Explosion
    { "120", "modifier.multitarget"},--Cone of Cold

  -- Moving
    { "108839", "player.moving" },--Ice Floes
    { "108843", {"player.moving", "player.spell.exists(108843)" }}, --Blazing Speed

  -- Rotation
    { "114923", {"player.debuff(36032).count >= 4", "target.debuff(114923).duration <= 3.6"}},--Nether Tempest
    { "157980", {"modifier.cooldowns","player.spell.exists(157980)"}},--Supernova
    { "5143", { "player.debuff(36032).count >= 4", "player.buff(79683).count >= 3" }},--Arcane Missiles with 3x Procc
    { "44425", "player.debuff(36032).count >= 4" },--Arcane Barrage 
    { "30451" },--Arcane Blast

}

local outCombat = {

  { "1459", "!player.buff" }, -- Arcane Brilliance
  { "30455", "tank.combat", "target" }, -- ty to MRTSZ, didn't know about "tank.combat" Ice Lance

}

ProbablyEngine.rotation.register_custom(
  62, 
  mts_Icon.."|r[|cff69CCF0MTS|r][Testing Mage-Arcade|r]", 
  inCombat, outCombat, lib)