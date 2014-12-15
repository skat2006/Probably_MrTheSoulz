local fetch = ProbablyEngine.interface.fetchKey

local lib = function()
	
end

local inCombat = {
	
	-- keybinds
		{ "105593", "modifier.control", "target" }, -- Fist of Justice
		{ "853", "modifier.control", "target" }, -- Hammer of Justice
		{ "114158", "modifier.shift", "target.ground" }, -- Light´s Hammer

	-- Hands
		--{ "6940", { "lowest.health <= 80", "!player.health <= 40" }, "lowest" }, -- Hand of Sacrifice
		{ "1044", "player.state.root" }, -- Hand of Freedom

	-- Interrupt
		{ "96231", "modifier.interrupts", "target" }, -- Rebuke

	-- Defensive Cooldowns
		{ "20925", (function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfPalaProt', 'SacredShield')) end), "player" }, -- Sacred Shield
		{ "31850", (function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfPalaProt', 'ArdentDefender')) end) }, --Ardent Defender
		{ "498", (function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfPalaProt', 'DivineProtection')) end) }, -- Divine Protection
		{ "86659", (function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfPalaProt', 'GuardianofAncientKings')) end) }, -- Guardian of Ancient Kings

	-- Cooldowns
		{ "31884", "modifier.cooldowns" }, -- Avenging Wrath
		{ "105809", "modifier.cooldowns" }, --Holy Avenger
		{ "114158", { -- Light´s Hammer
			"modifier.cooldowns", 
			"target.range <= 30"
		}, "target.ground" },
		{ "#gloves", "modifier.cooldowns" },

	{{ -- Seraphim
		{ "Seraphim" }, 
		{ "Holy Avenger", { 
			"player.holypower < 3", 
			"player.buff(Seraphim)", 
			"modifier.cooldowns" 
		} --[[  No Target  ]] }
	}, "talent(7, 2)" },

	-- Self Heal
		{ "#5512", (function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfPalaProt', 'Healthstone')) end) }, --Healthstone
		{ "633", (function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfPalaProt', 'LayonHands')) end), "player"}, -- Lay on Hands
		{ "114163", { -- Eternal Flame
			"!player.buff(114163)", 
			"player.buff(114637).count = 5", 
			"player.holypower >= 3",
			(function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfPalaProt', 'EternalFlame')) end)
		}, "player"},
		{ "85673", { -- Word of Glory
			"player.buff(114637).count = 5", 
			"player.holypower >= 3",
			(function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfPalaProt', 'WordofGlory')) end)
		}, "player" },

	-- Buffs
		{ "20217", { -- Blessing of Kings
			"!player.buff(20217).any",
			"!player.buff(115921).any", 
			"!player.buff(1126).any", 
			"!player.buff(90363).any", 
			"!player.buff(69378).any",
			(function() return fetch("mtsconfPalaProt", "Buff") == 'Kings' end),
		}, --[[  No Target  ]] },
		{ "19740", { -- Blessing of Might
			"!player.buff(19740).any", 
			"!player.buff(116956).any", 
			"!player.buff(93435).any", 
			"!player.buff(128997).any", 
			(function() return fetch("mtsconfPalaProt", "Buff") == 'Might' end),
		}, --[[  No Target  ]] },
		{ "25780", "!player.buff(25780).any" }, -- Fury

	-- Seals
		{{ -- Empowered Seals		
			 -- Cycle Seals for buffs
				{ "31801", { -- seal of truth
					"player.seal != 1", 
					"!player.buff(156990).duration > 3", -- Maraad's Truth
					"player.spell(20271).cooldown <= 1" -- Judment  CD less then 1
				} --[[  No Target  ]] },
				{ "20154", { -- seal of Righteousness
					"player.seal != 2", 
					"!player.buff(156989).duration > 3", -- Liadrin's Righteousness
					"player.buff(156990)", -- Maraad's Truth
					"player.spell(20271).cooldown <= 1" -- Judment  CD less then 1
				} --[[  No Target  ]] },
				{ "20165", { -- seal of Insigh
					"player.seal != 3", 
					"!player.buff(156988).duration > 3", -- Uther's Insight
					"player.buff(156990)", --Maraad's Truth
					"player.buff(156989)", --Liadrin's Righteousness
					"player.spell(20271).cooldown <= 1" -- Judment  CD less then 1
				} --[[  No Target  ]] },
			-- Judgment
				{ "20271", "!player.buff(156989).duration < 3" }, -- Judment // Liadrin's Righteousness
				{ "20271", "!player.buff(156990).duration < 3" }, -- Judment // Maraad's Truth
				{ "20271", "!player.buff(156988).duration < 3" }, -- Judment // Uther's Insight
			{{-- Wanted Seal
				{{ -- Single Target
					{ "20165", { -- seal of Insigh
						"player.seal != 3", 
						(function() return fetch("mtsconfPalaProt", "seal") == 'Insight' end),
					}, --[[  No Target  ]] }, 
					{ "20154", { -- seal of Righteousness
						"player.seal != 2",
						(function() return fetch("mtsconfPalaProt", "seal") == 'Righteousness' end),
					}, --[[  No Target  ]] },
					{ "31801", { -- seal of truth
						"player.seal != 1",
						(function() return fetch("mtsconfPalaProt", "seal") == 'Truth' end),
					}, --[[  No Target  ]] },
				}, "!modifier.multitarget" },
				{{ -- MultiTarget
					{ "20165", { -- seal of Insigh
						"player.seal != 3", 
						(function() return fetch("mtsconfPalaProt", "sealAoE") == 'Insight' end),
					}, --[[  No Target  ]] }, 
					{ "20154", { -- seal of Righteousness
						"player.seal != 2",
						(function() return fetch("mtsconfPalaProt", "sealAoE") == 'Righteousness' end),
					}, --[[  No Target  ]] },
					{ "31801", { -- seal of truth
						"player.seal != 1",
						(function() return fetch("mtsconfPalaProt", "sealAoE") == 'Truth' end),
					}, --[[  No Target  ]] },
				}, "modifier.multitarget" }
			},{
				{ "!player.buff(156989).duration < 3" }, -- Judment // Liadrin's Righteousness
				{ "!player.buff(156990).duration < 3" }, -- Judment // Maraad's Truth
				{ "!player.buff(156988).duration < 3" }, -- Judment // Uther's Insigh
			}},
		}, "talent(7, 1)" },

		{{-- Dont care if talent Empowered Seals
			{{ -- Single Target
				{ "20165", { -- seal of Insigh
					"player.seal != 3", 
					(function() return fetch("mtsconfPalaProt", "seal") == 'Insight' end),
				}, --[[  No Target  ]] }, 
				{ "20154", { -- seal of Righteousness
					"player.seal != 2",
					(function() return fetch("mtsconfPalaProt", "seal") == 'Righteousness' end),
				}, --[[  No Target  ]] },
				{ "31801", { -- seal of truth
					"player.seal != 1",
					(function() return fetch("mtsconfPalaProt", "seal") == 'Truth' end),
				}, --[[  No Target  ]] },
			}, "!modifier.multitarget" },
			{{ -- MultiTarget
				{ "20165", { -- seal of Insigh
					"player.seal != 3", 
					(function() return fetch("mtsconfPalaProt", "sealAoE") == 'Insight' end),
				}, --[[  No Target  ]] }, 
				{ "20154", { -- seal of Righteousness
					"player.seal != 2",
					(function() return fetch("mtsconfPalaProt", "sealAoE") == 'Righteousness' end),
				}, --[[  No Target  ]] },
				{ "31801", { -- seal of truth
					"player.seal != 1",
					(function() return fetch("mtsconfPalaProt", "sealAoE") == 'Truth' end),
				}, --[[  No Target  ]] },
			}, "modifier.multitarget" }
		}, "!talent(7, 1)" },

	-- run fast
		{ "85499", { -- Speed of Light
			"player.movingfor > 3", 
			(function() return fetch('mtsconfPalaProt','RunFaster') end),
		}},

	-- Procs
		{ "31935", { -- Avenger's Shield
			"modifier.multitarget", 
			"player.buff(Grand Crusader)" 
		}, "target" }, 

	-- Holy Ditchers
		{ "53600", { -- Shield of Righteous
			"target.spell(53600).range", 
			"player.holypower > 3"
		}, "target" }, 

	-- AOE Rotation
		{ "53595", { -- Hammer of the Righteous
			"target.spell(Crusader Strike).range", 
			"modifier.multitarget" 
		}, "target" },
		{ "31935", "modifier.multitarget", "target" }, -- Avenger's Shield
		{ "26573", { -- Consecration
			"modifier.multitarget", 
			"target.range <= 10", 
			"!player.moving" 
		} --[[  No Target  ]] },
		{ "119072", { -- Holy Wrath
			"modifier.multitarget", "target.range <= 10"  
		} --[[  No Target  ]] }, 
	
	-- Rotation
		{ "35395", "target.spell(35395).range", "target" }, -- Crusader Strike
		{ "20271", "target.spell(20271).range", "target" }, -- Judgment
		{ "31935", "target.spell(31935).range", "target" }, -- Avenger´s Shield
		{ "24275", "target.health <= 20", "target" }, -- Hammer of Wrath
		{ "26573", "target.range <= 6", "ground" }, -- consecration
		{ "119072", "target.range <= 10" }, -- Holy Wrath
		{ "114165", { -- Holy Prism
			"target.spell(114165).range", 
			"talent(5, 1)" 
		}, "target"},
		{ "114157", "target.spell(114157).range", "target" }, -- Execution Sentence

}

local outCombat = {
	
	-- keybinds
		{ "105593", "modifier.control", "target" }, -- Fist of Justice
		{ "853", "modifier.control", "target" }, -- Hammer of Justice
		{ "114158", "modifier.shift", "target.ground" }, -- Light´s Hammer

	-- Hands
		{ "1044", "player.state.root" }, -- Hand of Freedom

	-- Buffs
		{ "20217", { -- Blessing of Kings
			"!player.buff(20217).any",
			"!player.buff(115921).any", 
			"!player.buff(1126).any", 
			"!player.buff(90363).any", 
			"!player.buff(69378).any",
			(function() return fetch("mtsconfPalaProt", "Buff") == 'Kings' end),
			}, nil },
		{ "19740", { -- Blessing of Might
			"!player.buff(19740).any", 
			"!player.buff(116956).any", 
			"!player.buff(93435).any", 
			"!player.buff(128997).any", 
			(function() return fetch("mtsconfPalaProt", "Buff") == 'Might' end),
			}, nil },
		{ "25780", "!player.buff(25780).any" }, -- Fury

	-- Seals
		{ "20165", { -- seal of Insigh
			"player.seal != 3", 
			(function() return fetch("mtsconfPalaProt", "seal") == 'Insight' end),
			}, nil }, 
		
		{ "20154", { -- seal of Righteousness
			"player.seal != 2",
			(function() return fetch("mtsconfPalaProt", "seal") == 'Righteousness' end),
			}, nil },
		
		{ "31801", { -- seal of truth
			"player.seal != 1",
			(function() return fetch("mtsconfPalaProt", "seal") == 'Truth' end),
			}, nil },

	-- run fast
		{ "85499", { -- Speed of Light
			"player.movingfor > 3", 
			(function() return fetch('mtsconfPalaProt','RunFaster') end),
			}},

}

ProbablyEngine.rotation.register_custom(
	66, 
	mts_Icon.."|r[|cff9482C9MTS|r][|cffF58CBAPaladin-Protection|r]", 
	inCombat, 
	outCombat, 
	lib)