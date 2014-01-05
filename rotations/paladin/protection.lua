ProbablyEngine.rotation.register_custom(66, "|r[|cff9482C9MTS|r][|cffF58CBAProtection-Paladin|r]", {

	-- keybinds
		{ "pause", "modifier.lalt"}, -- Pause
		{ "!/focus [target=mouseover]", "modifier.ralt" }, -- Focus
		{ "105593", "modifier.lcontrol", "target"}, -- Fist of Justice
		{ "853", "modifier.lcontrol", "target"}, -- Hammer of Justice
		{ "114158", "modifier.lshift", "ground"}, -- Light´s Hammer
		{ "26573", { "player.glyph(54928)", "modifier.rshift" }, "ground"}, -- Consecration glyphed

	--Buffs
		{ "19740", { "!player.buff(19740).any", "!player.buff(116956).any", "!player.buff(93435).any", "!player.buff(128997).any", "!toggle.buff" }, nil },-- Blessing of Might
		{ "20217", { "!player.buff(20217).any", "!player.buff(115921).any", "!player.buff(1126).any", "!player.buff(90363).any", "!player.buff(69378).any", "toggle.buff" }, nil }, -- Blessing of Kings
			
	-- Seals
		{ "20165", { "player.seal != 3", "!modifier.multitarget", "@mts.SealsToggle" }, nil }, -- Seal of Insight
		{ "20154", { "player.seal != 2", "modifier.multitarget", "@mts.SealsToggle" }, nil }, -- Seal of righteousness
			
	-- Hands
		{ "1044", "player.state.root"}, -- Hand of Freedom
		{ "6940", { "lowest.health <= 80", "!player.health <= 40" }, "lowest" }, -- Hand of Sacrifice
		
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
		{ "114163", { "!player.buff(114163)", "player.buff(114637).count = 5", "player.holypower >= 3", "player.health <= 85" }, "player"}, -- Eternal Flame
		{ "85673", { "player.buff(114637).count = 5", "player.holypower >= 3", "player.health <= 40" }, "player" }, -- Word of Glory

	-- Rotation

		{ "24275", { "target.health <= 20", "target.spell(24275).range" }, "target" }, -- Hammer of Wrath
		{ "31935", { "player.buff(98057)", "target.spell(31935).range" }, "target" }, -- Avenger´s Shield Proc
		{ "53600", { "player.holypower >= 3", "target.spell(53600).range" }, "target" }, -- Shield of the Righteous
		{ "35395", { "!modifier.multitarget", "target.spell(35395).range" }, "target" }, -- Crusader Strike
		{ "53595", { "modifier.multitarget", "target.spell(53595).range" }, "target" }, -- Hammer of the Righteous
		{ "20271", "target.spell(20271).range", "target" }, -- Judgment
		{ "114165", "target.spell(114165).range", "target" }, -- Holy Prism
		{ "31935", "target.spell(31935).range", "target" },-- Avenger´s Shield Normal
		{ "26573", { "!player.glyph(54928)", "target.range <= 5", "@mts.ConToggle" }, nil }, -- Consecration
		{ "114157", "target.spell(114157).range", "target" }, -- Execution Sentense
		{ "119072" }, -- Holy Wrath

},{--------------------------------------- Out Of Combat

	-- keybinds
		{ "pause", "modifier.lalt"}, -- Pause
		{ "!/focus [target=mouseover]", "modifier.ralt" }, -- Focus
		{ "105593", "modifier.lcontrol", "target"}, -- Fist of Justice
		{ "853", "modifier.lcontrol", "target"}, -- Hammer of Justice
		{ "114158", "modifier.lshift", "ground"}, -- Light´s Hammer
		{ "26573", { "player.glyph(54928)", "modifier.rshift" }, "ground"}, -- Consecration glyphed
		
	-- Seals
		{ "20165", { "player.seal != 3", "!modifier.multitarget", "@mts.SealsToggle" }, nil }, -- Seal of Insight
		{ "20154", { "player.seal != 2", "modifier.multitarget", "@mts.SealsToggle" }, nil }, -- Seal of righteousness
		
	--Buffs
		{ "19740", { "!player.buff(19740).any", "!player.buff(116956).any", "!player.buff(93435).any", "!player.buff(128997).any", "!toggle.buff" }, nil },-- Blessing of Might
		{ "20217", { "!player.buff(20217).any", "!player.buff(115921).any", "!player.buff(1126).any", "!player.buff(90363).any", "!player.buff(69378).any", "toggle.buff" }, nil }, -- Blessing of Kings
	
	-- Hands
		{ "1044", "player.state.root" } -- Hand of Freedom

}, -----------------------------------------------------------------------------------------------------------------------
-- Toggles
function()
	ProbablyEngine.toggle.create('defcd', 'Interface\\Icons\\Spell_holy_devotionaura.png', 'Defensive Cooldowns', 'Enable or Disable Defensive Cooldowns.')
	ProbablyEngine.toggle.create('buff', 'Interface\\Icons\\spell_magic_greaterblessingofkings.png', 'Buffs', 'Enable for Blessing of Kings. \nDisable for Blessing of Might.')
	ProbablyEngine.toggle.create('aggro', 'Interface\\Icons\\Ability_warrior_stalwartprotector.png', 'Aggro Control', 'Auto Taunts on mouse-over ot target if dosent have aggro.')
end)