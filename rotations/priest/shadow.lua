
local lib = function()

  ProbablyEngine.toggle.create('autotarget', 'Interface\\Icons\\Ability_spy.png', 'Auto Target', 'Automatically target the nearest enemy when target dies or does not exist,')
  ProbablyEngine.toggle.create('mouseoverdots', 'Interface\\Icons\\INV_Helmet_131.png', 'Mouseoverd Doting', 'Mouseover to to anything thats not doted.')
  mtsStart:message("\124cff9482C9*MTS-\124cffFFFFFFPriest/Shadow\124cff9482C9-Loaded*")

end

local inCombat = {

  -- Cooldowns
    { "10060", "modifier.cooldowns" }, -- Power Infusion
    { "34433", "modifier.cooldowns" }, -- Shadowfiend
    
  --buffs
    { "Power Word: Fortitude", "!player.buff(Power Word: Fortitude)" },
    { "Inner Fire", "!player.buff(Inner Fire)" },
    { "15473", "!player.buff(15473)" }, -- Shadowform
  
  -- Keybinds
    { "Mind Sear", "modifier.shift" },

  -- Auto Target
    { "/target [target=focustarget, harm, nodead]", { "toggle.autotarget", "target.range > 40" }}, -- Use Tank Target
    { "/targetenemy [noexists]", { "toggle.autotarget", "!target.exists" }}, -- target enemire if no target
   	{ "/targetenemy [dead]", { "toggle.autotarget", "target.exists", "target.dead" }}, -- target enemire if current is dead.

  -- dots
    { "589", "!target.debuff(589)", "target" },
    { "589", {"toggle.mouseoverdots","!mouseover.debuff(589)"}, "mouseover" },

  -- If Moving
    { "73510", { "player.moving", "player.buff(162448)" }}, --Mind Spike // Proc
    { "127632", { "player.moving", "modifier.multitarget" }}, -- Cascade
    { "120644", { "player.moving", "modifier.multitarget" }}, --Halo 
    { "122121", { "player.moving", "modifier.multitarget" }}, --Divine Star 
    { "589", { "player.moving", "target.debuff(589).duration <= 3" } }, -- SW:Pain
    { "32379", { "player.moving", "target.health <= 20" }}, -- SW:D // 20 Percent

  -- Procs
    { "73510", "player.buff(162448)" }, -- Mind Spike // Proc
    { "129197", "player.buff(132573)" }, --Insanity // Proc

  -- AoE // Smart
    { "48045", {"!modifier.multitarget","player.area(8).enemies > 3", "@mtsLib.CanFireHack()" }, "target" }, -- Mind Sear
    { "127632", { "!modifier.multitarget","player.area(8).enemies > 3", "@mtsLib.CanFireHack()" } }, --Cascade 
    { "12064", { "!modifier.multitarget","player.area(8).enemies > 3", "@mtsLib.CanFireHack()" } }, -- Halo
    { "122121", { "!modifier.multitarget","player.area(8).enemies > 3", "@mtsLib.CanFireHack()" } }, --Divine Star

  -- AoE
    { "48045", "modifier.multitarget", "target" }, -- Mind Sear
    { "127632", "modifier.multitarget" }, --Cascade 
    { "12064", "modifier.multitarget" }, -- Halo
    { "122121", "modifier.multitarget" }, --Divine Star

  -- Rotation
    { "8092" }, -- Mind Blast 
    { "8092", "player.buff(162452)" }, --Mind Blast with Shadowy Insight
    { "2944", "player.shadoworbs = 3" }, -- Devouring Plague // 3 Orbs
    { "32379", "target.health <= 20" }, -- SW:D // 20%
    { "589", "target.debuff(589).duration <= 3" }, -- SW:P
    { "32379", "target.debuff(32379).duration <= 3" }, -- wat
    { "34914", { "target.debuff(34914).duration <= 3", "!modifier.last", "!player.buff(132573)" }}, -- Vampiric Touch
    { "15407" }, --Mind Flay as filler
    { "15286", "player.health <= 75" }, -- Vampiric Embrace
  
} 

local outCombat = {

	-- Auto Target
		{ "/target [target=focustarget, harm, nodead]", { "toggle.autotarget", "target.range > 40", "tank.combat" }}, -- Use Tank Target
		{ "/targetenemy ", { "toggle.autotarget", "target.friendly", "tank.combat" }}, -- Target a enemie if target is friendly
		{ "/targetenemy [noexists]", { "toggle.autotarget", "!target.exists", "tank.combat" }}, -- target enemire if no target
		{ "/targetenemy [dead]", { "toggle.autotarget", "target.exists", "target.dead", "tank.combat" }}, -- target enemire if current is dead.

	-- dot to start ICC if tank is in combat
		{ "589", "tank.combat", "target" },
	
	--buffs
		{ "Power Word: Fortitude", "!player.buff(Power Word: Fortitude)" },
		{ "Inner Fire", "!player.buff(Inner Fire)" },
		{ "15473", "!player.buff(15473)" },--Shadow Form
  
}

ProbablyEngine.rotation.register_custom(258, mts_Icon.."|r[|cff9482C9MTS|r][Testing Priest-Shadow|r]", inCombat, outCombat, lib)