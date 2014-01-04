ProbablyEngine.rotation.register_custom(66, "|r[|cff9482C9MTS|r][|cffF58CBAProtection-Paladin|r]", {

	-- keybinds
		{ "pause", "modifier.lalt"}, -- Pause
		{ "!/focus [target=mouseover]", "modifier.ralt" }, -- Focus
		-- Stuns (Left Control)
			{ "105593", "modifier.lcontrol", "target"}, -- Fist of Justice
			{ "853", "modifier.lcontrol", "target"}, -- Hammer of Justice
		-- Ground (Will Drop on Mouse-over)
			{ "114158", "modifier.lshift", "ground"}, -- Light´s Hammer
			{ "26573", { -- Consecration glyphed
				"player.glyph(54928)",
				"modifier.rshift"
			}, "ground"}, 

	--Buffs
		{ "25780", "!player.buff" }, -- Righteous Fury
		{ "19740", { -- Blessing of Might
			"!player.buff(19740).any",
			"!player.buff(116956).any",
			"!player.buff(93435).any",
			"!player.buff(128997).any",
			"!toggle.buff"
		}, nil },
		{ "20217", { -- Blessing of Kings
			"!player.buff(20217).any",
			"!player.buff(115921).any",
			"!player.buff(1126).any",
			"!player.buff(90363).any",
			"!player.buff(69378).any",
			"toggle.buff"
		}, nil },
			
	-- Seals
		{ "20165", { -- Seal of Insight
			"player.seal != 3",
			"!modifier.multitarget",
			"@mts.SealsToggle"
		}, nil },
		{ "20154", { -- Seal of righteousness
			"player.seal != 2",
			"modifier.multitarget",
			"@mts.SealsToggle"
		}, nil }, 
			
	-- Hands
		{ "1044", "player.state.root"}, -- Hand of Freedom
		{ "6940", { -- Hand of Sacrifice
			"lowest.health <= 80",
			"!player.health <= 40",
		}, "lowest" },
		
	-- Interrupt
		{ "96231", "modifier.interrupts"}, -- Rebuke

	{{-- Defensive Cooldowns
		{ "20925", "!player.buff(20925)", "player" }, -- Sacred Shield 		
		{ "31850", "player.health < 30"}, --Ardent Defender
		{ "498", "player.health <= 99" }, -- Divine Protection
		{ "86659", "player.health <= 50" }, -- Guardian of Ancient Kings
		{ "#gloves" },
	}, "toggle.defcd" },
	
	-- Cooldowns
		{ "31884", "modifier.cooldowns" }, -- Avenging Wrath
		{ "105809", "modifier.cooldowns" }, --Holy Avenger
		
	-- Self Heal
		{ "#5512", "player.health <= 60" }, --Healthstone
		{ "633", "player.health <= 20", "player"}, --Lay on Hands	
		{ "114163", { --Eternal Flame
			"!player.buff(114163)",
			"player.buff(114637).count = 5", --Bastion of Glory
			"player.holypower >= 3",
			"player.health <= 85"
		}, "player"}, 
		{ "85673", { --Word of Glory
			"player.buff(114637).count = 5", --Bastion of Glory
			"player.holypower >= 3",
			"player.health <= 40"
		}, "player" },

	-- Rotation

		{ "24275", { -- Hammer of Wrath
			"target.health <= 20",
			"target.spell(24275).range"
		}, "target" },
		{ "31935", { -- Avenger´s Shield Proc
			"player.buff(98057)",
			"target.spell(31935).range"
		}, "target" },
		{ "53600", { -- Shield of the Righteous
			"player.holypower >= 3",
			"target.spell(53600).range"
		}, "target" },
		
		-- AOE/Single
			{ "35395", { -- Crusader Strike
				"!modifier.multitarget",
				"target.spell(35395).range"
			}, "target" },
			{ "53595", { -- Hammer of the Righteous
				"modifier.multitarget",
				"target.spell(53595).range"
			}, "target" },
			
		{ "20271", "target.spell(20271).range", "target" }, -- Judgment
		{ "114165", "target.spell(114165).range", "target" }, -- Holy Prism
		{ "31935", "target.spell(31935).range", "target" },-- Avenger´s Shield Normal
		{ "26573", { -- Consecration
			"!player.glyph(54928)",
			"target.range <= 5",		
			"@mts.ConToggle"
		}, nil }, 
		{ "114157", "target.spell(114157).range", "target" }, -- Execution Sentense
		{ "119072" }, -- Holy Wrath

},{--------------------------------------- Out Of Combat

	-- keybinds
		{ "114158", "modifier.lshift", "ground"}, -- Light´s Hammer
		{ "26573", { -- Consecration glyphed
			"player.glyph(54928)",
			"modifier.rshift"
		}, "ground"}, 
		{ "pause", "modifier.lalt"}, -- Pause
		{ "!/focus [target=mouseover]", "modifier.ralt" }, -- Focus
		{ "105593", "modifier.lcontrol", "target" }, -- Fist of Justice
		{ "853", "modifier.lcontrol", "target" }, -- Hammer of Justice
		
	-- Seals
		{ "20165", { -- Seal of Insight
			"player.seal != 3",
			"!modifier.multitarget",
			"@mts.SealsToggle"
		}, nil },
		{ "20154", { -- Seal of righteousness
			"player.seal != 2",
			"modifier.multitarget",
			"@mts.SealsToggle"
		}, nil }, 
		
	--Buffs
		{ "25780", "!player.buff" }, -- Righteous Fury
		{ "19740", { -- Blessing of Might
			"!player.buff(19740).any",
			"!player.buff(116956).any",
			"!player.buff(93435).any",
			"!player.buff(128997).any",
			"!toggle.buff"
		}, nil },
		{ "20217", { -- Blessing of Kings
			"!player.buff(20217).any",
			"!player.buff(115921).any",
			"!player.buff(1126).any",
			"!player.buff(90363).any",
			"!player.buff(69378).any",
			"toggle.buff"
		}, nil },
	
	-- Hands
		{ "1044", "player.state.root" } -- Hand of Freedom

}, -----------------------------------------------------------------------------------------------------------------------
-- Toggles
function()
	ProbablyEngine.toggle.create('defcd', 'Interface\\Icons\\Spell_holy_devotionaura.png', 'Defensive Cooldowns', 'Enable or Disable Defensive Cooldowns.')
	ProbablyEngine.toggle.create('buff', 'Interface\\Icons\\spell_magic_greaterblessingofkings.png', 'Buffs', 'Enable for Blessing of Kings. \nDisable for Blessing of Might.')
end)