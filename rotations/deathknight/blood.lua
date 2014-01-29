-- ///////////////////-----------------------------------------INFO-----------------------------------//////////////////////////////
--														//DeathKnight Blood//
--													  Originaly made by PCMD
--												  Thank Your For Your My ProFiles
--														I Hope Your Enjoy Them
--																MTS


local lib = function()


	ProbablyEngine.toggle.create("DPS", "Interface\\Icons\\Spell_DeathKnight_DarkConviction", "Push your DPS with Rune Strike", "Toggle On if you want to prioritize Rune Strike over Death Strike")
	ProbablyEngine.toggle.create("DRW", "Interface\\Icons\\INV_Sword_07", "Stop using Dancing Rune Weapon", "Toggle Off if you dont want to use DRW on CD")
	ProbablyEngine.toggle.create("RD", "Interface\\Icons\\spell_shadow_animatedead", "Enable or Disable Raise Dead", "Toggle On to use Raise Dead for DPS / Toggle Off to use Raise Dead for Death Pact")
	
end

local Buffs = {

	-- Presence
		{"48263", "player.seal != 1", nil }, -- Blood

}

local inCombat = {
	
	{ "Pause", "@mts.modifierActionForSpellIsAlt('PAUSE')" },
	{ "Pause", "@mts.modifierActionForSpellIsShift('PAUSE')" },
	{ "Pause", "@mts.modifierActionForSpellIsControl('PAUSE')" },
	
	{ "Death and Decay", "@mts.modifierActionForSpellIsAlt('DND')" },
	{ "Death and Decay", "@mts.modifierActionForSpellIsShift('DND')","ground" },
	{ "Death and Decay", "@mts.modifierActionForSpellIsControl('DND')","ground" },
	
	{ "Anti-Magic Zone", "@mts.modifierActionForSpellIsAlt('ANTIMAGICZONE')" },
	{ "Anti-Magic Zone", "@mts.modifierActionForSpellIsShift('ANTIMAGICZONE')","ground" },
	{ "Anti-Magic Zone", "@mts.modifierActionForSpellIsControl('ANTIMAGICZONE')","ground" },
	
	{ "Army of the Dead", "@mts.modifierActionForSpellIsAlt('ARMY')" },
	{ "Army of the Dead", "@mts.modifierActionForSpellIsShift('ARMY')" },
	{ "Army of the Dead", "@mts.modifierActionForSpellIsControl('ARMY')" },

	-- Defensive cooldowns
	{{
		{ "#5512", "player.health < 70"}, --healthstone
		{ "Icebound Fortitude", "@mts.ConfigUnitHp('ibfPercentage", "player')" },
		{ "Vampiric Blood", {"modifier.cooldowns","@mts.ConfigUnitHp('vbPercentage", "player')" }},
		{ "Death Pact", {"@mts.ConfigUnitHp('dpPercentage', 'player')","@mts.hasGhoul()" }},
		{ "Lichborne", {"@mts.ConfigUnitHp('lichbornePercentage', 'player')","player.runicpower >= 40","player.spell.exists(Lichborne)" }},
		{ "Death Coil", {"player.health < 90","player.runicpower >= 40","player.buff(lichborne)" }, "player"},
	}, "modifier.cooldowns" },

	{ "Rune Tap", "@mts.ConfigUnitHp('runeTapPercentage", "player')" },

	-- Aggro Control
	{ "62124", { "@mts.ShouldTaunt('PalaProtTaunts')", "@mts.bossTaunt" }, "target" }, -- Boss // Dark Command
	{ "56222", { "mouseover.threat < 100", "@mts.ShouldTaunt('DkBloodTaunts')" }, "mouseover" }, -- Dark Command / Mouse-Over
	{ "56222", { "target.threat < 100", "@mts.ShouldTaunt('DkBloodTaunts')"  }, "target" }, -- Dark Command
	{ "49576", { "mouseover.threat < 100", "@mts.ShouldTaunt('DkBloodTaunts')" }, "mouseover" }, -- Death Grip / Mouse-Over
	{ "49576", { "target.threat < 100", "@mts.ShouldTaunt('DkBloodTaunts')" }, "target" }, -- Death Grip

	
	{{-- Interrupts
		{ "mind freeze" },
		{ "Strangulate", { "!target.spell(47528).range", "!player.modifier.last(47528)" }},
		{ "Asphyxiate", "!modifier.last(47528)"},
	}, "target.interruptsAt(50)" },

	-- Spell Steal
	{ "Dark Simulacrum ", "@mts.shoulDarkSimUnit('target')" , "target" },
	{ "Dark Simulacrum ", "@mts.shoulDarkSimUnit('focus')" , "focus" },

	{ "Raise Dead", {"modifier.cooldowns","toggle.RD","!@mts.hasGhoul()" }},
	{ "Raise Dead", {"!toggle.RD","@mts.ConfigUnitHp('dpPercentage", "player')","!@mts.hasGhoul()" }},
	{
		{
			{"Dancing Rune Weapon", "!toggle.DRW"},
			-- Requires engineering
			{ "#gloves"},
			-- Requires herbalism
			{"Lifeblood"},
			-- Racials
			{ "Berserking"},
			{ "Blood Fury"},
		},
		{ "modifier.cooldowns", "target.spell(56815).range" }
	},

	-- Buff
	{ "Bone Shield", "!player.buff(Bone Shield)" },

	-- Diseases
	{ "Unholy Blight", "target.debuff(frost fever).duration < 2" },
	{ "Unholy Blight", "target.debuff(blood plague).duration < 2" },
	{ "Outbreak", "target.debuff(frost fever).duration < 2" },
	{ "Outbreak", "target.debuff(blood plague).duration < 2" },

	-- Multi-target
	{ "Blood Boil",	{"modifier.multitarget","target.range <= 10" }},
	{ "Rune Strike", {"player.runicpower >= 30","toggle.DPS" }},
	{ "Blood Boil",	{"player.buff(Crimson Scourge)","target.range <= 10" }},

	-- Rotation
	{ "Death Strike", "@mts.ConfigUnitHp('deathStrikePercentage', 'player')" },
	{ "Death Strike", "player.buff(Blood Shield).duration <= 4" },
	{ "Soul Reaper", "target.health <= 35"},
	{ "Plague Strike", "target.debuff(Blood Plague).duration = 0" },
	{ "Icy Touch", "target.debuff(Frost Fever).duration = 0" },
	{ "Rune Strike", {"player.runicpower >= 80", "player.runes(frost).count < 2", "player.runes(unholy).count < 2" }},
	{ "Death Strike" },

	-- Death Siphon
	{"Death Siphon", "player.health < 60"},

	{"Heart Strike", {"target.debuff(Blood Plague).duration > 0","target.debuff(Frost Fever).duration > 0","@mts.gotBloodRunes()" }},
	{"Rune Strike",	{"player.runicpower >= 30","!player.buff(lichborne)" }},

	{"Horn of Winter"},
	{"Plague Leech", "@mts.canCastPlagueLeech(3)" },
	{"Blood Tap", "@mts.shouldBloodTap()" },
	{"Empower Rune Weapon",	{"modifier.cooldowns","target.spell(56815).range","player.runes(death).count < 1","player.runes(frost).count < 1","player.runes(unholy).count < 1","player.runicpower < 30" }},

}

local outCombat = {

	-- Out Of Combat
	{ "Horn of Winter", {"@mts.getConfig('useOutOfCombatHorn')","!player.buff(Horn of Winter)" }},

}

for _, Buffs in pairs(Buffs) do
  inCombat[#inCombat + 1] = Buffs
  outCombat[#outCombat + 1] = Buffs
end

ProbablyEngine.rotation.register_custom(250, "|r[|cff9482C9MTS|r][|cffC41F3BDeathKnight-Blood|r]", inCombat, outCombat, lib)