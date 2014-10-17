--[[ ///---INFO---////
// DeathKnight Blood //
!Originaly made by PCMD!
Thank Your For Your My ProFiles
I Hope Your Enjoy Them
MTS
]]

local exeOnLoad = function()

	ProbablyEngine.toggle.create("DPS", "Interface\\Icons\\Spell_DeathKnight_DarkConviction", "Push your DPS with Rune Strike", "Toggle On if you want to prioritize Rune Strike over Death Strike")
	ProbablyEngine.toggle.create("DRW", "Interface\\Icons\\INV_Sword_07", "Stop using Dancing Rune Weapon", "Toggle Off if you dont want to use DRW on CD")
	ProbablyEngine.toggle.create("RD", "Interface\\Icons\\spell_shadow_animatedead", "Enable or Disable Raise Dead", "Toggle On to use Raise Dead for DPS / Toggle Off to use Raise Dead for Death Pact")
	mtsAlert:message("\124cff9482C9*MrTheSoulz - \124cffC41F3BDeathKnight/Blood \124cff9482C9Loaded*")

end

local Buffs = {

	-- Presence
		{"48263", "player.seal != 1", nil }, -- Blood

}

local inCombat = {
	
	-- Keybinds
	{ "Pause", "@mtsLib.modifierActionForSpellIsAlt('PAUSE')" },
	{ "Pause", "@mtsLib.modifierActionForSpellIsShift('PAUSE')" },
	{ "Pause", "@mtsLib.modifierActionForSpellIsControl('PAUSE')" },
	
	{ "Death and Decay", "@mtsLib.modifierActionForSpellIsAlt('DND')" },
	{ "Death and Decay", "@mtsLib.modifierActionForSpellIsShift('DND')","ground" },
	{ "Death and Decay", "@mtsLib.modifierActionForSpellIsControl('DND')","ground" },
	
	{ "Anti-Magic Zone", "@mtsLib.modifierActionForSpellIsAlt('ANTIMAGICZONE')" },
	{ "Anti-Magic Zone", "@mtsLib.modifierActionForSpellIsShift('ANTIMAGICZONE')","ground" },
	{ "Anti-Magic Zone", "@mtsLib.modifierActionForSpellIsControl('ANTIMAGICZONE')","ground" },
	
	{ "Army of the Dead", "@mtsLib.modifierActionForSpellIsAlt('ARMY')" },
	{ "Army of the Dead", "@mtsLib.modifierActionForSpellIsShift('ARMY')" },
	{ "Army of the Dead", "@mtsLib.modifierActionForSpellIsControl('ARMY')" },

	{{-- Defensive cooldowns
		{ "#5512", "player.health < 70"}, --healthstone
		{ "Icebound Fortitude", "@mtsLib.ConfigUnitHp('ibfPercentage", "player')" },
		{ "Vampiric Blood", { "modifier.cooldowns", "@mtsLib.ConfigUnitHp('vbPercentage", "player')" }},
		{ "Death Pact", { "@mtsLib.ConfigUnitHp('dpPercentage', 'player')", "@mtsLibDK.hasGhoul" }},
		{ "Lichborne", { "@mtsLib.ConfigUnitHp('lichbornePercentage', 'player')", "player.runicpower >= 40", "player.spell.exists(Lichborne)" }},
		{ "Death Coil", { "player.health < 90", "player.runicpower >= 40", "player.buff(lichborne)" }, "player"},
	}, "modifier.cooldowns" },

	{ "Rune Tap", "@mtsLib.ConfigUnitHp('runeTapPercentage", "player')" },

	{{-- Aggro Control
		{ "62124", "@mtsBossLib.bossTaunt", "target" }, -- Boss // Dark Command
		{ "56222", { "mouseover.threat < 100", "@mtsLib.StopIfBoss" }, "mouseover" }, -- Dark Command / Mouse-Over
		{ "56222", { "target.threat < 100", "@mtsLib.StopIfBoss" }, "target" }, -- Dark Command
		{ "49576", { "mouseover.threat < 100", "@mtsLib.StopIfBoss" }, "mouseover" }, -- Death Grip / Mouse-Over
		{ "49576", { "target.threat < 100", "@mtsLib.StopIfBoss" }, "target" }, -- Death Grip
	},{ "@mtsLib.dummy()", "@mtsLib.ShouldTaunt('DkBloodTaunts')" }},

	
	{{-- Interrupts
		{ "mind freeze" },
		{ "Strangulate", { "!target.spell(47528).range", "!player.modifier.last(47528)" }},
		{ "Asphyxiate", "!modifier.last(47528)"},
	}, "target.interruptsAt(50)" },

	-- Spell Steal
	{ "Dark Simulacrum ", "@mtsLibDK.shoulDarkSimUnit('target')" , "target" },
	{ "Dark Simulacrum ", "@mtsLibDK.shoulDarkSimUnit('focus')" , "focus" },
	
	{{-- Cooldowns
		{ "Raise Dead", { "toggle.RD", "@mtsLibDK.hasGhoul" }},
		{ "Raise Dead", { "!toggle.RD", "@mtsLib.ConfigUnitHp('dpPercentage", "player')", "@mtsLibDK.hasGhoul" }},
		{"Dancing Rune Weapon", "!toggle.DRW"},
		{ "#gloves"},
		{"Lifeblood"},
		{ "Berserking"},
		{ "Blood Fury"},
	},  "modifier.cooldowns" },

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
	{ "Death Strike", "@mtsLib.ConfigUnitHp('deathStrikePercentage', 'player')" },
	{ "Death Strike", "player.buff(Blood Shield).duration <= 4" },
	{ "Soul Reaper", "target.health <= 35"},
	{ "Plague Strike", "target.debuff(Blood Plague).duration = 0" },
	{ "Icy Touch", "target.debuff(Frost Fever).duration = 0" },
	{ "Rune Strike", {"player.runicpower >= 80", "player.runes(frost).count < 2", "player.runes(unholy).count < 2" }},
	{ "Death Strike" },

	-- Death Siphon
	{ "Death Siphon", "player.health < 60" },

	{ "Heart Strike", { "target.debuff(Blood Plague).duration > 0", "target.debuff(Frost Fever).duration > 0", "@mtsLibDK.gotBloodRunes" }},
	{ "Rune Strike", { "player.runicpower >= 30", "!player.buff(lichborne)" }},

	{ "Horn of Winter" },
	{ "Plague Leech", "@mtsLibDK.canCastPlagueLeech(3)" },
	{ "Blood Tap", "@mtsLibDK.shouldBloodTap" },
	{ "Empower Rune Weapon", { "modifier.cooldowns", "player.runes(death).count < 1", "player.runes(frost).count < 1", "player.runes(unholy).count < 1", "player.runicpower < 30" }},

}

local outCombat = {

	-- Keybinds
	{ "Pause", "@mtsLib.modifierActionForSpellIsAlt('PAUSE')" },
	{ "Pause", "@mtsLib.modifierActionForSpellIsShift('PAUSE')" },
	{ "Pause", "@mtsLib.modifierActionForSpellIsControl('PAUSE')" },
	
	{ "Death and Decay", "@mtsLib.modifierActionForSpellIsAlt('DND')" },
	{ "Death and Decay", "@mtsLib.modifierActionForSpellIsShift('DND')","ground" },
	{ "Death and Decay", "@mtsLib.modifierActionForSpellIsControl('DND')","ground" },
	
	{ "Anti-Magic Zone", "@mtsLib.modifierActionForSpellIsAlt('ANTIMAGICZONE')" },
	{ "Anti-Magic Zone", "@mtsLib.modifierActionForSpellIsShift('ANTIMAGICZONE')","ground" },
	{ "Anti-Magic Zone", "@mtsLib.modifierActionForSpellIsControl('ANTIMAGICZONE')","ground" },
	
	{ "Army of the Dead", "@mtsLib.modifierActionForSpellIsAlt('ARMY')" },
	{ "Army of the Dead", "@mtsLib.modifierActionForSpellIsShift('ARMY')" },
	{ "Army of the Dead", "@mtsLib.modifierActionForSpellIsControl('ARMY')" },

	-- Out Of Combat
	{ "Horn of Winter", { "@mtsLib.getConfig('useOutOfCombatHorn')","!player.buff(Horn of Winter)" }},

}

for _, Buffs in pairs(Buffs) do
  inCombat[#inCombat + 1] = Buffs
  outCombat[#outCombat + 1] = Buffs
end

ProbablyEngine.rotation.register_custom(251, "|r[|cff9482C9MTS|r][|cffC41F3BDeathKnight-2h-Frost|r]", inCombat, outCombat, exeOnLoad)