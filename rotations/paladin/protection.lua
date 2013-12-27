ProbablyEngine.rotation.register_custom(66, "|r[|cff9482C9MTS|r][|cffF58CBAProtection-Paladin|r]", {

	-- keybinds
		{ "114158", { -- Light´s Hammer
			"player.spell(114158).exists",
			"modifier.lshift"
		}, "ground"},
		{ "26573", { -- Consecration glyphed
			"player.spell(54928).exists",
			"modifier.rshift"
		}, "ground"}, 
		{ "pause", "modifier.lalt"}, -- Pause
		{ "!/focus [target=mouseover]", "modifier.ralt" }, -- Focus
		{ "105593", "modifier.lcontrol", "target"}, -- Fist of Justice
		{ "853", "modifier.lcontrol", "target"}, -- Hammer of Justice

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
			"focus.health <= 50",
			"focus.range <= 40.",
		}, "focus" },
		
	-- Interrupt
		{ "96231", "modifier.interrupts"}, -- Rebuke

	-- Survival
		{ "20925", { --Sacred Shield
			"player.spell(20925).exists",
			"!player.buff(20925)",
		}, "player" }, 		
		{ "31850", "player.health < 30"}, --Ardent Defender
		{ "498", "player.health <= 95", "toggle.defcd" }, -- Divine Protection
		{ "86659", "player.health <= 45", "toggle.defcd" }, -- Guardian of Ancient Kings
		{ "#gloves", "toggle.defcd" },
		
	-- Cooldowns
		{ "31884", "modifier.cooldowns" }, -- Avenging Wrath
		{ "105809", "player.spell(105809).exists", "modifier.cooldowns" }, --Holy Avenger
		
	-- Self Heal
		{ "#5512", "player.health <= 45" }, --Healthstone
		{ "633", "player.health <= 20", "player"}, --Lay on Hands	
		{ "114163", { --Eternal Flame
			"player.spell(114163).exists",
			"!player.buff(114163)",
			"player.buff(114637).count = 5", --Bastion of Glory
			"player.holypower >= 3",
			"player.health <= 85"
		}, "player"}, 
		{ "85673", { --Word of Glory
			"player.spell(85673).exists",
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
		---------------------------------------------------------
			{ "35395", { -- Crusader Strike
				"!modifier.multitarget",
				"target.spell(35395).range"
			}, "target" },
			{ "53595", { -- Hammer of the Righteous
				"modifier.multitarget",
				"target.spell(53595).range"
			}, "target" },
		---------------------------------------------------------
			
		{ "20271", "target.spell(20271).range", "target" }, -- Judgment
		{ "114165", { -- Holy Prism
			"player.spell(114165).exists",
			"target.spell(114165).range"
		}, "target" },
		{ "31935", { -- Avenger´s Shield Normal
			"target.spell(31935).range"
		}, "target" },
		{ "26573", { -- Consecration
			"!player.spell(54928).exists", 
			"@mts.ConToggle"
		}, nil }, 
		{ "114157", { -- Execution Sentense
			"player.spell(114157).exists",
			"target.spell(114157).range"
		}, "target" },
		{ "119072" }, -- Holy Wrath

},{--------------------------------------- Out Of Combat

	-- keybinds
		{ "114158", { -- Light´s Hammer
			"player.spell(114158).exists",
			"modifier.lshift"
		}, "ground"},
		{ "26573", { -- Consecration glyphed
			"player.spell(54928).exists",
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
			"!player.buff",
			"!toggle.buff"
		}, nil },
		{ "20217", { -- Blessing of Kings
			"!player.buff",
			"toggle.buff"
		}, nil },
	
	--Other's
		{ "1044", "player.state.root" } -- Hand of Freedom

}, -----------------------------------------------------------------------------------------------------------------------
-- Toggles
function()
	ProbablyEngine.toggle.create('defcd', 'Interface\\Icons\\Spell_holy_devotionaura.png', 'Defensive Cooldowns', 'Enable or Disable Defensive Cooldowns.')
	ProbablyEngine.toggle.create('buff', 'Interface\\Icons\\spell_magic_greaterblessingofkings.png', 'Buffs', 'Enable for Blessing of Kings. \nDisable for Blessing of Might.')
end)