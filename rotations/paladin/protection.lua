-- //////////////////////-----------------------------------------INFO-----------------------------------//////////////////////////////
--													   	//Paladin Protection//
--													Thank Your For Your My ProFiles
--														I Hope Your Enjoy Them
--																  MTS


local lib = function()

	ProbablyEngine.toggle.create('defcd', 'Interface\\Icons\\Spell_holy_devotionaura.png', 'Defensive Cooldowns', 'Enable or Disable Defensive Cooldowns.')
	mtsStart:message("\124cff9482C9*MTS-\124cffF58CBAPaladin/Protection-\124cff9482C9Loaded*")
	mts_showLive()
	
end

local inCombat = {
	
	-- Buffs
		--{ "20217", { "player.buffs.stats", "@mtsLib.Dropdown('Kings')" }, nil },
		--{ "19740", { "player.buffs.attackpower", "@mtsLib.Dropdown('Might')" }, nil },
		{ "25780", "!player.buff(25780).any" }, -- Fury

	-- Seals
		{ "20165", {"player.seal != 3", "@mtsLib.Dropdown('Insight')"}, nil }, -- seal of Insigh
		{ "20154", {"player.seal != 2", "@mtsLib.Dropdown('Righteousness')"}, nil }, -- seal of Righteousness
		{ "31801", {"player.seal != 1", "@mtsLib.Dropdown('Truth')"}, nil }, -- seal of truth

	-- run fast
		{ "85499", {"player.movingfor > 3", "@mtsLib.getConfig('mtsconfPalaProt','RunFaster')"} }, -- Speed of Light

	-- keybinds
		{ "105593", "modifier.control", "target" }, -- Fist of Justice
		{ "853", "modifier.control", "target" }, -- Hammer of Justice
		{ "114158", "modifier.shift", "target.ground" }, -- Light´s Hammer
	
	-- Auto Targets
		{ "/target [target=focustarget, harm, nodead]", { "@mtsLib.getConfig('mtsconfPalaProt','AutoTarget')", "target.range > 40" }}, -- Use Tank Target
		{ "/targetenemy [noexists]", { "@mtsLib.getConfig('mtsconfPalaProt','AutoTarget')", "!target.exists" }}, -- target enemire if no target
		{ "/targetenemy [dead]", { "@mtsLib.getConfig('mtsconfPalaProt','AutoTarget')", "target.exists", "target.dead" }}, -- target enemire if current is dead.

	-- Hands
		--{ "6940", { "lowest.health <= 80", "!player.health <= 40" }, "lowest" }, -- Hand of Sacrifice
		{ "1044", "player.state.root" }, -- Hand of Freedom

	-- Interrupt
		{ "96231", "modifier.interrupts", "target" }, -- Rebuke

	-- Defensive Cooldowns
		{ "20925", "@mtsLib.Compare('health','mtsconfPalaProt','SacredShield','player')", "player" }, -- Sacred Shield
		{ "31850", "@mtsLib.Compare('health','mtsconfPalaProt','ArdentDefender','player')" }, --Ardent Defender
		{ "498", "@mtsLib.Compare('health','mtsconfPalaProt','DivineProtection','player')" }, -- Divine Protection
		{ "86659", "@mtsLib.Compare('health','mtsconfPalaProt','GuardianofAncientKings','player')" }, -- Guardian of Ancient Kings

	-- Cooldowns
		{ "31884", "modifier.cooldowns" }, -- Avenging Wrath
		{ "105809", "modifier.cooldowns" }, --Holy Avenger
		{ "114158", {"modifier.cooldowns", "target.range <= 30"}, "target.ground" }, -- Light´s Hammer
		{ "#gloves", "modifier.cooldowns" },
		
	-- Self Heal
		{ "#5512", "@mtsLib.Compare('health','mtsconfPalaProt','Healthstone','player')" }, --Healthstone
		{ "633", "@mtsLib.Compare('health','mtsconfPalaProt','LayonHands','player')","player"}, -- Lay on Hands
		{ "114163", { "!player.buff(114163)", "player.buff(114637).count = 5", "player.holypower >= 3", "@mtsLib.Compare('health','mtsconfPalaProt','EternalFlame','player')" }, "player"}, -- Eternal Flame
		{ "85673", { "player.buff(114637).count = 5", "player.holypower >= 3", "@mtsLib.Compare('health','mtsconfPalaProt','WordofGlory','player')" }, "player" },-- Word of Glory

	-- Procs
		{ "31935", { "modifier.multitarget", "player.buff(Grand Crusader)" }, "target" }, -- Avenger's Shield

	-- Holy Ditchers
		{ "53600", {"target.spell(53600).range", "player.holypower > 3"}, "target" }, -- Shield of Righteous

	-- AOE Rotation
		{ "53595", { "target.spell(Crusader Strike).range", "modifier.multitarget" }, "target" }, -- Hammer of the Righteous
		{ "31935", "modifier.multitarget", "target" }, -- Avenger's Shield
		{ "26573", { "modifier.multitarget", "target.range <= 10", "!player.moving" }}, -- Consecration
		{ "119072", { "modifier.multitarget", "target.range <= 10"  }}, -- Holy Wrath
	
	-- Rotation
		{ "35395", "target.spell(35395).range", "target" }, -- Crusader Strike
		{ "20271", "target.spell(20271).range", "target" }, -- Judgment
		{ "31935", "target.spell(31935).range", "target" }, -- Avenger´s Shield
		{ "24275", "target.health <= 20", "target" }, -- Hammer of Wrath
		{ "26573", "target.range <= 6", "ground" }, -- consecration
		{ "119072", "target.range <= 10" }, -- Holy Wrath
		{ "114165", { "target.spell(114165).range", "talent(5, 1)" }}, -- Holy Prism
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
		--{ "20217", { "!player.buffs.stats", "@mtsLib.Dropdown('Kings')" }, nil },
		--{ "19740", { "!player.buffs.attackpower", "@mtsLib.Dropdown('Might')" }, nil },
		{ "25780", "!player.buff(25780).any" }, -- Fury

	-- Seals
		{ "20165", {"player.seal != 3", "@mtsLib.Dropdown('Insight')"}, nil }, -- seal of Insigh
		{ "20154", {"player.seal != 2", "@mtsLib.Dropdown('Righteousness')"}, nil }, -- seal of Righteousness
		{ "31801", {"player.seal != 1", "@mtsLib.Dropdown('Truth')"}, nil }, -- seal of truth

	-- run fast
		{ "85499", {"player.movingfor > 3", "@mtsLib.getConfig('mtsconfPalaProt','RunFaster')"} }, -- Speed of Light

}

ProbablyEngine.rotation.register_custom(66, mts_Icon.."|r[|cff9482C9MTS|r][|cffF58CBAPaladin-Protection|r]", inCombat, outCombat, lib)