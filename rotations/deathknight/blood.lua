--[[ ///---INFO---////
// DeathKnight Blood //
!Originaly made by PCMD!
Thank Your For Using My ProFiles
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
	{ "42650", "modifier.alt" }, -- Army of the Dead
	{ "49576", "modifier.control" }, -- Death Grip
	{ "43265", "modifier.shift", "ground" }, -- Death and Decay

	{{-- Defensive cooldowns
		{ "#5512", "@mtsLib.ConfigUnitHp('DkBloodHs', 'player')" }, --Healthstone
		{ "48792", "@mtsLib.ConfigUnitHp('DkBloodIbfPercentage", "player')" }, -- icebound fortitude
		{ "55233", { "modifier.cooldowns", "@mtsLib.ConfigUnitHp('vbPercentage", "player')" }},
		{ "48743", { "@mtsLib.ConfigUnitHp('BloodDpPercentage', 'player')", "@mtsLibDK.hasGhoul" }}, -- death pact
		{ "49039", { "@mtsLib.ConfigUnitHp('DkBloodLichbornePercentage', 'player')", "player.runicpower >= 40", "player.spell.exists(49039)" }},
		{ "47541", { "player.health < 90", "player.runicpower >= 40", "player.buff(49039)" }, "player"},
	}, "modifier.cooldowns" },

	{ "48982", "@mtsLib.ConfigUnitHp('runeTapPercentage", "player')" }, --rune tap

	{{-- Aggro Control
		{ "62124", "@mtsBossLib.bossTaunt", "target" }, -- Boss // Dark Command
		{ "56222", { "mouseover.threat < 100", "@mtsLib.StopIfBoss" }, "mouseover" }, -- Dark Command / Mouse-Over
		{ "56222", { "target.threat < 100", "@mtsLib.StopIfBoss" }, "target" }, -- Dark Command
		{ "49576", { "mouseover.threat < 100", "@mtsLib.StopIfBoss" }, "mouseover" }, -- Death Grip / Mouse-Over
		{ "49576", { "target.threat < 100", "@mtsLib.StopIfBoss" }, "target" }, -- Death Grip
	},{ "@mtsLib.dummy()", "@mtsLib.ShouldTaunt('DkBloodTaunts')" }},

	{{-- Interrupts
		{ "47528", "modifier.interrupts" }, -- Mind freeze
		{ "47476", "modifier.interrupts", "!player.modifier.last(47528)" }, -- Strangulate,
		{ "108194", "!modifier.last(47528)" },
	}, "target.interruptsAt(50)" },

	-- Spell Steal
	{ "77606", "@mtsLibDK.shoulDarkSimUnit('target')" , "target" },
	{ "77606", "@mtsLibDK.shoulDarkSimUnit('focus')" , "focus" },
	
	{{-- Cooldowns
		{ "61999", { "toggle.RD", "@mtsLibDK.hasGhoul" }},
		{ "61999", { "!toggle.RD", "@mtsLib.ConfigUnitHp('BloodDpPercentage", "player')", "@mtsLibDK.hasGhoul" }},
		{"49028", "!toggle.DRW"},
		{ "#gloves"},
	},  "modifier.cooldowns" },

	-- Buff
	{ "49222", "!player.buff(49222)" }, -- bone shield

	-- Diseases
	{ "115989", "target.debuff(55095).duration < 2" },
	{ "115989", "target.debuff(55078).duration < 2" },
	{ "77575", "target.debuff(55095).duration < 2" }, -- Outbreak
	{ "77575", "target.debuff(55078).duration < 2" }, -- Outbreak

	-- Multi-target
	{ "50842",	{"modifier.multitarget","target.range <= 10" }}, -- Blood Boil
	{ "50842",	{"player.buff(Crimson Scourge)","target.range <= 10" }}, -- Blood Boil

	-- Rotation
	{ "49998", "@mtsLib.ConfigUnitHp('DkBloodDeathStrikePercentage', 'player')" }, -- Death Strike
	{ "49998", "player.buff(77513).duration <= 4" }, -- Death Strike
	{ "114866", "target.health <= 35"}, -- Soul Reaper
	{ "45462", "target.debuff(55078).duration = 0" }, -- Plague Strike
	{ "45477", "target.debuff(55095).duration = 0" }, -- Icy Touch
	{ "49998" },

	-- Death Siphon
	{ "Death Siphon", "player.health < 60" },

	{ "Heart Strike", { "target.debuff(55078).duration > 0", "target.debuff(55095).duration > 0", "@mtsLibDK.gotBloodRunes" }},
	{ "Rune Strike", { "player.runicpower >= 30", "!player.buff(lichborne)" }},

	{ "57330" }, -- Horn of Winter
	{ "45529", "@mtsLibDK.shouldBloodTap" }, -- Blood Tap
	{ "47568", { "modifier.cooldowns", "player.runes(death).count < 1", "player.runes(frost).count < 1", "player.runes(unholy).count < 1", "player.runicpower < 30" }}, -- Empower Rune Weapon

}

local outCombat = {

	-- Keybinds
	{ "42650", "modifier.alt" }, -- Army of the Dead
	{ "49576", "modifier.control" }, -- Death Grip
	{ "43265", "modifier.shift", "ground" }, -- Death and Decay
	{ "57330", { "@mtsLib.getConfig('DkBloodOutOfCombatHorn')","!player.buff(57330)" }}, -- Horn of Winter

}

for _, Buffs in pairs(Buffs) do
  inCombat[#inCombat + 1] = Buffs
  outCombat[#outCombat + 1] = Buffs
end

ProbablyEngine.rotation.register_custom(250, "|r[|cff9482C9MTS|r][|cffC41F3BDeathKnight-Blood|r]", inCombat, outCombat, exeOnLoad)

-- 55095 = Frost Fever
-- 55078 = Blood plague
-- 77513 = blood shield