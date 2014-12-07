local fetch = ProbablyEngine.interface.fetchKey

local lib = function()
  
  ProbablyEngine.toggle.create(
	'mouseoverdots', 
	'Interface\\Icons\\INV_Helmet_131.png', 
	'MouseOver Doting', 
	'Mouseover to to anything thats not doted.')
	
  ProbablyEngine.toggle.create(
	'dotEverything', 
	'Interface\\Icons\\Ability_creature_cursed_05.png', 
	'Dot All The Things!', 
	'Click here to dot all the things!\nSome Spells require Multitarget enabled also.\nOnly Works if using FireHack.')

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

	{{-- Auto Dotting
		{ "32379", "@mtsLib.SWD" },
		{{-- AoE FH
			{ "589", "@mtsLib.SWP" }, -- SWP 
		}, "target.area(10).enemies >= 3" },
		{{-- AoE forced
			{ "589", "@mtsLib.SWP" }, -- SWP 
		}, "modifier.multitarget" },
	}, {"toggle.dotEverything"} },
  
  -- Mouse-Over
		{ "589", { -- SWP
			"!mouseover.debuff(589)",
			"toggle.mouseoverdots",
			--"mouseover.enemie" FIXME
			}, "mouseover" },
		{ "34914", { -- Vampiric touch
			"!mouseover.debuff(34914)",
			"toggle.mouseoverdots",
			"!player.moving"
			}, "mouseover"},
	
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
	{ "#5512", (function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfPriestShadow', 'hstone')) end)}, -- Healthstone
  
  --Defensive/Heal
		{ "586", (function() return mts_dynamicEval("player.threat >= " .. fetch('mtsconfPriestShadow', 'fade')) end) }, -- FADE
		{ "!12963", (function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfPriestShadow', 'instaprayer')) end) },
		{ "17", { -- PW:S on HP
			"!player.debuff(6788)", 
			(function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfPriestShadow', 'shield')) end)
			}, "player" },
		{ "47585", (function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfPriestShadow', 'guise')) end) },  -- Dispersion
		{ "112833", { -- Guise
			"talent(1, 2)", 
			(function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfPriestShadow', 'guise')) end),
			}},
  
  {{-- FH AoE
    { "48045", "target.area(10).enemies >= 4" , "target" }, -- Mind Sear
	{ "127632", { -- Cascade 
		"target.area(10).enemies >= 4", 
		"modifier.cooldowns"  
		} }, 
	{ "12064", { -- Halo
		"target.area(10).enemies >= 4", 
		"modifier.cooldowns"  
		} }, 
	{ "122121", {--Divine Star...
		"target.area(10).enemies >= 4", 
		"modifier.cooldowns"  
		} }, 
  }, {"player.firehack", (function() return fetch('mtsconf','Firehack') end)}},
  
  -- AoE
    { "48045", "modifier.multitarget", "target" }, -- Mind Sear
	{ "127632", { -- Cascade
		"modifier.multitarget",  
		"modifier.cooldowns"  
		} },
	{ "12064", { -- Halo
		"modifier.multitarget",  
		"modifier.cooldowns"  
		} }, 
	{ "122121", { -- Divine Star
		"modifier.multitarget", 
		"modifier.cooldowns"  
		} },

   -- Dots
	{ "32379", "target.health <= 20", "target" }, -- SWD
	{ "589", "!target.debuff(589)", "target" }, -- SWP
	{ "34914", { -- Vampiric Touch
		"target.debuff(34914).duration <= 3.5",
		"!player.buff(132573)" 
		}, "target" },
   
   -- Moving
	{ "73510", { 
		"player.moving", 
		"player.buff(162448)" 
		}}, --Mind Spike when Procc
  
  -- Rotation
	{ "!8092", { --Mind Blast // Shadowy Insight
		"player.buff(162452)", 
		"!player.buff(132573" 
		}, "target" }, 
	{ "73510", "player.buff(87160)", "target", "target" }, -- Mind Spike // Procc
	{ "!2944", "player.shadoworbs = 3", "target" }, -- Devouring Plague // 3 Orbs
	{ "129197", "player.buff(132573)" }, --Insanity with Procc Up
	{ "8092" }, -- Mind Blast
	{ "15407" }, --Mind Flay // filler
  
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

ProbablyEngine.rotation.register_custom(258, mts_Icon.."|r[|cff9482C9MTS|r][Priest-Shadow|r]", inCombat, outCombat, lib)