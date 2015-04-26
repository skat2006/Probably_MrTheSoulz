local fetch = ProbablyEngine.interface.fetchKey

local exeOnLoad = function()
	mts.Splash()
end

local InCombat = {

	-- Buff's
	{ "20217", { -- Kings
		"!player.buffs.stats",
		(function() return fetch("mtsconfPalaProt", "Buff") == 'Kings' end)
	}},
	{ "19740", { -- Might
		"!player.buffs.mastery",
		(function() return fetch("mtsconfPalaProt", "Buff") == 'Might' end)
	}},
	
	-- Defensive Cooldowns
	{ "20925", (function() return mts.dynamicEval("player.health <= " .. fetch('mtsconfPalaProt', 'SacredShield')) end), "player" }, 	-- Sacred Shield
	{ "31850", (function() return mts.dynamicEval("player.health <= " .. fetch('mtsconfPalaProt', 'ArdentDefender')) end) }, 			-- Ardent Defender
	{ "498", (function() return mts.dynamicEval("player.health <= " .. fetch('mtsconfPalaProt', 'DivineProtection')) end) }, 			-- Divine Protection
	{ "86659", (function() return mts.dynamicEval("player.health <= " .. fetch('mtsconfPalaProt', 'GuardianofAncientKings')) end) }, 	-- Guardian of Ancient Kings

	-- Heals
	{ "#5512", (function() return mts.dynamicEval("player.health <= " .. fetch('mtsconfPalaProt', 'Healthstone')) end) }, 		-- Healthstone
	{ "633", (function() return mts.dynamicEval("player.health <= " .. fetch('mtsconfPalaProt', 'LayonHands')) end), "player"}, -- Lay on Hands
	{ "114163", { ---------------------------------------------------------------------------------------------------------------- Eternal Flame
		"!player.buff(114163)", 
		"player.buff(114637).count = 5", 
		"player.holypower >= 3",
		(function() return mts.dynamicEval("player.health <= " .. fetch('mtsconfPalaProt', 'EternalFlame')) end)
	}, "player"},
	{ "85673", { ---------------------------------------------------------------------------------------------------------------- Word of Glory
		"player.buff(114637).count = 5", 
		"player.holypower >= 3",
		(function() return mts.dynamicEval("player.health <= " .. fetch('mtsconfPalaProt', 'WordofGlory')) end)
	}, "player" },

	-- Raid Heals
	{ "Flash of Light", { 
		"player.buff(Selfless Healer).count = 3", 
		(function() return mts.dynamicEval("lowest.health <= " .. fetch('mtsconfPalaProt', 'FlashOfLightRaid')) end), 
	}, "lowest" },		
	{ "Lay on Hands", (function() return mts.dynamicEval("lowest.health <= " .. fetch('mtsconfPalaProt', 'LayOnHandsRaid')) end), "lowest" },
	--{ "Hand of Protection", (function() return mts.dynamicEval("lowest.health <= " .. fetch('mtsconfPalaProt', 'HandOfProtectionRaid')) end), "lowest" },

	-- Keybinds // Interrumpts
	{ "96231", "modifier.interrupts", "target" }, 				-- Rebuke
	{ "105593", "modifier.control", "target" }, 				-- Fist of Justice
	{ "853", "modifier.control", "target" }, 					-- Hammer of Justice
	{ "114158", "modifier.shift", "target.ground" }, 			-- Light´s Hammer

	{{ -- Empowered Seals
		{ "31801", { -- Seal of Truth
			"player.seal != 1", 					-- Seal of Truth
			"!player.buff(156990).duration > 3", 	-- Maraad's Truth
			"player.spell(20271).cooldown <= 1" 	-- Judment  CD less then 1
		}},
		{ "20154", { -- Seal of Righteousness
			"player.seal != 2", 					-- Seal of Righteousness
			"!player.buff(156989).duration > 3", 	-- Liadrin's Righteousness
			"player.buff(156990)", 					-- Maraad's Truth
			"player.spell(20271).cooldown <= 1" 	-- Judment  CD less then 1
		}},
		{ "20165", { -- Seal of Insigh
			"player.seal != 3", 					-- Seal of Insigh
			"!player.buff(156988).duration > 3", 	-- Uther's Insight
			"player.buff(156990)", 					-- Maraad's Truth
			"player.buff(156989)", 					-- Liadrin's Righteousness
			"player.spell(20271).cooldown <= 1" 	-- Judment  CD less then 1
		}},
			
		------------------------------------------------------------------------------ Judgment
		{ "20271", {
			"player.buff(156990).duration < 3", -- Maraad's Truth
			"player.seal = 1"
		}},
		{ "20271", { 
			"player.buff(156989).duration < 3", -- Liadrin's Righteousness
			"player.seal = 2"
		}},
		{ "20271", {
			"player.buff(156988).duration < 3", -- Uther's Insight
			"player.seal = 3"
		}},
	}, "talent(7,1)" },

	{{ -- Normal Seals
		{{ -- AoE
			{ "20165", { -- Seal of Insigh
				"player.seal != 3",
				(function() return fetch("mtsconfPalaProt", "sealAoE") == 'Insight' end),
			}},
			{ "20154", { -- Seal of Righteousness
				"player.seal != 2",
				(function() return fetch("mtsconfPalaProt", "sealAoE") == 'Righteousness' end),
			}},
			{ "31801", { -- Seal of truth
				"player.seal != 1",
				(function() return fetch("mtsconfPalaProt", "sealAoE") == 'Truth' end),
			}},
		}, "modifier.multitarget" },
		{{ -- Single Target
			{ "20165", { -- Seal of Insigh
				"player.seal != 3",
				(function() return fetch("mtsconfPalaProt", "seal") == 'Insight' end),
			}},
			{ "20154", { -- Seal of Righteousness
				"player.seal != 2",
				(function() return fetch("mtsconfPalaProt", "seal") == 'Righteousness' end),
			}},
			{ "31801", { -- Seal of truth
				"player.seal != 1",
				(function() return fetch("mtsconfPalaProt", "seal") == 'Truth' end),
			}},
		}, "!modifier.multitarget" },
	}, "!talent(7,1)" },

	{{ -- Cooldowns
		{ "31884" }, 											-- Avenging Wrath
		{ "105809" }, 											-- Holy Avenger
		{ "114158", "target.range <= 30", "target.ground" }, 	-- Light´s Hammer
		{ "#gloves" },											-- Gloves
		{{ ------------------------------------------------------- Seraphim
			{ "Seraphim" },   -- Seraphim
			{ "Holy Avenger", { ------------------- Holy Avenger
				"player.holypower < 3",  -- 3 Holy Power
				"player.buff(Seraphim)", -- Buff Seraphin
			}},
		}, "talent(7, 2)" },
	}, "modifier.cooldowns" },

	-- Proc's
	{ "31935", "player.buff(Grand Crusader)", "target" }, 		-- Avenger's Shield // Proc

	{{-- AoE
		{ "53595", "target.spell(Crusader Strike).range", "target" }, 	-- Hammer of the Righteous
		{ "31935" }, 													-- Avenger's Shield
		{ "26573", { 	-------------------------------------------------- Consecration 
			"target.range <= 10",  	-- range less then 10
			"!player.moving" 		-- Not Moving
		}},
		{ "119072", "target.range <= 10" }, 
	}, "modifier.multitarget" },

	-- Normal
	{ "53600", { 				------------------------------ Shield of Righteous
		"target.spell(53600).range", 	-- Spell in range
		"player.holypower > 3"			-- 3 Holy Power
	}, "target" },
	{ "35395", "target.spell(35395).range", "target" }, 	-- Crusader Strike
	{ "20271", "target.spell(20271).range", "target" }, 	-- Judgment
	{ "31935", "target.spell(31935).range", "target" }, 	-- Avenger´s Shield
	{ "24275", "target.health <= 20", "target" }, 			-- Hammer of Wrath
	{ "26573", "target.range <= 6", "ground" }, 			-- consecration
	{ "119072", "target.range <= 10" }, 					-- Holy Wrath
	{ "114165", { 				------------------------------ Holy Prism
		"target.spell(114165).range", 	-- Spell in Range
		"talent(5, 1)" 					-- Got Talent
	}, "target"},
	{ "114157", "target.spell(114157).range", "target" }, 	-- Execution Sentence

}

local outCombat = {

	-- Buff's
	{ "20217", { -- Kings
		"!player.buffs.stats",
		(function() return fetch("mtsconfPalaProt", "Buff") == 'Kings' end)
	}},
	{ "19740", { -- Might
		"!player.buffs.mastery",
		(function() return fetch("mtsconfPalaProt", "Buff") == 'Might' end)
	}},

	-- Keybinds
	{ "96231", "modifier.interrupts", "target" }, 				-- Rebuke
	{ "105593", "modifier.control", "target" }, 				-- Fist of Justice
	{ "853", "modifier.control", "target" }, 					-- Hammer of Justice
	{ "114158", "modifier.shift", "target.ground" }, 			-- Light´s Hammer
	
	-- Heals
	{ "#5512", (function() return mts.dynamicEval("player.health <= " .. fetch('mtsconfPalaProt', 'Healthstone')) end) }, 		-- Healthstone
	{ "633", (function() return mts.dynamicEval("player.health <= " .. fetch('mtsconfPalaProt', 'LayonHands')) end), "player"}, -- Lay on Hands
	{ "114163", { ---------------------------------------------------------------------------------------------------------------- Eternal Flame
		"!player.buff(114163)", 
		"player.buff(114637).count = 5", 
		"player.holypower >= 3",
		(function() return mts.dynamicEval("player.health <= " .. fetch('mtsconfPalaProt', 'EternalFlame')) end)
	}, "player"},
	{ "85673", { ---------------------------------------------------------------------------------------------------------------- Word of Glory
		"player.buff(114637).count = 5", 
		"player.holypower >= 3",
		(function() return mts.dynamicEval("player.health <= " .. fetch('mtsconfPalaProt', 'WordofGlory')) end)
	}, "player" },

}

ProbablyEngine.rotation.register_custom(
	66, 
	mts.Icon.."|r[|cff9482C9MTS|r][|cffF58CBAPaladin-Protection|r]", 
	InCombat, outCombat, exeOnLoad)