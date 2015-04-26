local fetch = ProbablyEngine.interface.fetchKey

local exeOnLoad = function()
	mts.Splash()
end

	---------------------------------------------------------------------------
	-------------------------- Testing Area -----------------------------------
	---------------------------------------------------------------------------
	--{{ ToDo: Convert to ID's, finish the CR, document and test everything }}

local Survival = {
	{ "Eternal Flame", { 
		"player.buff(Eternal Flame).duration < 3", 
		(function() return fetch('mtsconfPalaRet', 'eternalglory') end) 
	}, "player" },
	{ "Sacred Shield", { 
		"player.buff(Sacred Shield).duration < 7", 
		"target.range > 3", 
		(function() return fetch('mtsconfPalaRet', 'sacredshield') end) 
	}, "player" },
	{ "Hand of Freedom", { 
		"!player.buff", 
		"player.state.snare", 
		(function() return fetch('mtsconfPalaRet', 'handoffreedom') end) 
	}, "player" },
	{ "Emancipate", { 
		"!modifier.last(Emancipate)", 
		"player.state.root", 
		(function() return fetch('mtsconfPalaRet', 'emancipate') end) 
	}, "player" },
	{ "Divine Shield", { 
		(function() return mts.dynamicEval("player.health <= " .. fetch('mtsconfPalaRet', 'divineshield_spin')) end), 
		(function() return fetch('mtsconfPalaRet', 'divineshield_check') end) 
	}},
}

local SelfHeals = {
	{ "Flash of Light", { 
		"player.buff(Selfless Healer).count = 3", 
		(function() return mts.dynamicEval("player.health <= " .. fetch('mtsconfPalaRet', 'flashoflight_spin')) end), 
		(function() return fetch('mtsconfPalaRet', 'flashoflight_check') end) 
	}},
	{ "Word of Glory", { 
		"player.holypower >= 3", 
		(function() return mts.dynamicEval("player.health <= " .. fetch('mtsconfPalaRet', 'wordofglory_spin')) end), 
		(function() return fetch('mtsconfPalaRet', 'wordofglory_check') end) 
	}},
	{ "Lay on Hands", { 
		(function() return mts.dynamicEval("player.health <= " .. fetch('mtsconfPalaRet', 'layonhands_spin')) end), 
		(function() return fetch('mtsconfPalaRet', 'layonhands_check') end) 
	}},
	{ "#5512", { -- Healthstone (5512)
		(function() return mts.dynamicEval("player.health <= " .. fetch('mtsconfPalaRet', 'healthstone_spin')) end), 
		(function() return fetch('mtsconfPalaRet', 'healthstone_check') end) 
	}},
}

-- Test these, they came from prot and might not be the same on ret...
local Seals = {
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
}

local inCombat = {
	{{ -- Cooldowns
		{ "Execution Sentence", "target.enemy", "target" },
		{ "Light's Hammer", nil, "target.ground" },
		{ "#trinket1" },
		{ "#trinket2" },
	}, "modifier.cooldowns" },

	{{ -- Talent / Final Verdict
		{ "Divine Storm", { 
			"player.buff(Final Verdict)", 
			"player.buff(Divine Crusader)", 
			"player.holypower >= 5" 
		}},
		{ "Final Verdict", { 
			"player.buff(Divine Purpose).duration < 3", 
			"player.buff(Divine Purpose)" 
		}},
		{ "Final Verdict", { 
			"player.buff(Holy Avenger)", 
			"player.holypower >= 3" 
		}}, 
		{ "Divine Storm", { 
			"player.buff(Divine Crusader).duration < 3", 
			"player.buff(Divine Crusader)" 
		}},
		{ "Final Verdict", "player.holypower >= 5" }
	}, "talent(7, 3)" },
	
	{{ -- Talent / Seraphim
		{ "Templar's Verdict", "player.buff(Avenging Wrath)" },
		{ "Templar's Verdict", "player.health < 20" },
		{ "Final Verdict", "player.buff(Avenging Wrath)" },
		{ "Final Verdict", "player.health < 20" }
	}, { "talent(7, 2)", "player.spell(Seraphim).cooldown >= 8" }},
	
	{{ -- Talent / Empowered Seals
		{ "Templar's Verdict", "player.buff(Avenging Wrath)" },
		{ "Templar's Verdict", "player.health < 20" }
	}, "talent(7, 1)" },
}

-- Solo Target
local ST = {
	{ "Avenging Wrath", "modifier.cooldowns" },
	{ "Holy Avenger", "modifier.cooldowns" },
	{ "Execution Sentence", "target.health.actual > 100000" },
	{ "Templar's Verdict", "player.buff(Divine Purpose)" },
	{ "Final Verdict", "player.buff(Divine Purpose)" },
	{ "Templar's Verdict", "player.holypower = 5" },
	{ "Final Verdict", "player.holypower = 5" },
	{ "Divine Storm", {
		"player.buff(Final Verdict)",
		"player.buff(Divine Crusader)"
	}},
	{ "Hammer of Wrath" },
	{ "Crusader Strike" },
	{ "Judgment" },
	{ "Exorcism" },
	{ "Templar's Verdict", "player.holypower >= 3" },
	{ "Final Verdict", "player.holypower >= 3" },
}

-- AoE
local AoE = {
	{ "Avenging Wrath", "modifier.cooldowns" },
	{ "Holy Avenger", "modifier.cooldowns" },
	{ "Execution Sentence", "target.health.actual > 100000" },
	{ "Divine Storm", {
		"player.buff(Final Verdict)",
		"player.buff(Divine Crusader)"
	}},
	{ "Divine Storm", "player.buff(Divine Purpose)" },
	{ "Divine Storm", "player.buff(Final Verdict)" },
	{ "Divine Storm", "player.holypower = 5" },
	{ "Hammer of the Righteous" },
	{ "Exorcism" },
	{ "Hammer of Wrath" },
	{ "Judgment" },
	{ "Divine Storm", "player.holypower >= 3" },
}

local outCombat = {
	{ "Seal of Truth", { 
		"!modifier.multitarget", 
		"player.seal != 1" 
	}},
	{ "Seal of Righteousness", { 
		"modifier.multitarget", 
		"player.seal != 2" 
	}},
}

ProbablyEngine.rotation.register_custom(
	70,  
	mts.Icon.."|r[|cff9482C9MTS|r][|cffF58CBAPaladin-Retribution|r]", 
	{-- In-Combat
		{ "Rebuke", "modifier.interrupts" },
		{ "Cleanse", {
			"player.dispellable(Cleanse)", 
			(function() return fetch('mtsconfPalaRet', 'cleanse') end) 
		}, "player" },
		{ Survival },
		{ SelfHeals },
		{ Seals },
		{ inCombat },
		{ AoE, "modifier.multitarget" },
		{ ST }, -- fallback
	}, outCombat_Testing, exeOnLoad)