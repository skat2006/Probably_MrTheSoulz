local fetch = ProbablyEngine.interface.fetchKey

local lib = function()
mts.Splash("|cff9482C9[MTS]|r-[|cff9482C9MTS|r]-|cff9482C9Loaded", 5.0)
  
  ProbablyEngine.toggle.create(
	'dotEverything', 
	'Interface\\Icons\\Ability_creature_cursed_05.png', 
	'Dot All The Things! (SOLO)', 
	'Click here to dot all the things while in Solo mode!\nSome Spells require Multitarget enabled also.\nOnly Works if using FireHack.')

end

local inCombat = {

  -- Cooldowns
    { "10060", "modifier.cooldowns" }, -- Power Infusion
    { "34433", "modifier.cooldowns" }, -- Shadowfiend
    
  --buffs
    { "21562", {-- Fortitude
		"!player.buff(21562).any",
		"!player.buff(588)"
	}},
    { "15473", "!player.buff(15473)" }, -- Shadowform
  
  -- Keybinds
    { "Mind Sear", "modifier.shift" },
 
  -- LoOk aT It GOoZ!!! // Needs to add tank...
	{ "121536", {
		(function() return fetch('mtsconfPriestShadow','feather') end), 
		"player.movingfor > 2", 
		"!player.buff(121557)", 
		"player.spell(121536).charges >= 1" 
	}, "player.ground" },
	{ "17", {
		"talent(2, 1)", 
		"player.movingfor > 2", 
		"!player.buff(6788)", 
		(function() return fetch('mtsconfPriestShadow', 'feather') end)
	}, "player" },

  -- items
	{ "#5512", (function() return mts.dynamicEval("player.health <= " .. fetch('mtsconfPriestShadow', 'hstone')) end)}, -- Healthstone
  
  --Defensive/Heal
		{ "586", (function() return mts.dynamicEval("player.threat >= " .. fetch('mtsconfPriestShadow', 'fade')) end) }, -- FADE
		{ "!12963", (function() return mts.dynamicEval("player.health <= " .. fetch('mtsconfPriestShadow', 'instaprayer')) end) },
		{ "17", { -- PW:S on HP
			"!player.debuff(6788)", 
			(function() return mts.dynamicEval("player.health <= " .. fetch('mtsconfPriestShadow', 'shield')) end)
		}, "player" },
		--{ "47585", (function() return mts.dynamicEval("player.health <= " .. fetch('mtsconfPriestShadow', '*****')) end) },  -- Dispersion
		--{ "112833", { -- *****
		--	"talent(1, 2)", 
		--	(function() return mts.dynamicEval("player.health <= " .. fetch('mtsconfPriestShadow', '*****')) end),
		--}},
  
  	{{-- Auto Dotting
		{ "32379", "@mtsLib.mtsDot(32379, 0, 20)" }, -- SW:D
		{ "589", "@mtsLib.mtsDot(589, 2, 100)" }, -- SW:P 
	}, "toggle.dotEverything" },

  {{-- FH AoE
	{ "127632", "modifier.cooldowns" }, -- Cascade
	{ "12064", "modifier.cooldowns" }, -- Halo
	{ "122121", "modifier.cooldowns" }, -- Divine Star...
	{ "48045" }, -- Mind Sear
  }, "target.area(10).enemies >= 4" },

  {{-- FH AoE
	{ "127632", "modifier.cooldowns" }, -- Cascade
	{ "12064", "modifier.cooldowns" }, -- Halo
	{ "122121", "modifier.cooldowns" }, -- Divine Star...
	{ "48045" }, -- Mind Sear
  }, "modifier.multitarget" },

  -- Rotation
	{ "2944", "player.shadoworbs >= 3" }, -- Devouring Plague // 3 Orbs
	{ "32379", "target.health < 20" }, -- SW:Death
	{ "8092", "player.shadoworbs <= 5" }, --Mind Blast less then 5 orbs
	{ "73510", "player.buff(162448)" }, -- Mind Spike
	{ "129197", "player.buff(132573)" }, --Insanity with Procc Up
	{ "73510" }, -- Mind Spike Filler
  
} 

local outCombat = {

	-- LoOk aT It GOoZ!!! // Needs to add tank...
		{ "121536", {
			(function() return fetch('mtsconfPriestShadow','feather') end), 
			"player.movingfor > 2", 
			"!player.buff(121557)", 
			"player.spell(121536).charges >= 1" 
		}, "player.ground" },
		{ "17", {
			"talent(2, 1)", 
			"player.movingfor > 2", 
			"!player.buff(6788)", 
			(function() return fetch('mtsconfPriestShadow', 'feather') end)
		}, "player" },
	
	-- buffs
		{ "21562", {-- Fortitude
			"!player.buff(21562).any",
			"!player.buff(588)"
		}},
		{ "15473", "!player.buff(15473)" }, -- Shadow Form
  
}

ProbablyEngine.rotation.register_custom(258, mts.Icon.."|r[|cff9482C9MTS|r][Priest-Shadow|r]", inCombat, outCombat, lib)