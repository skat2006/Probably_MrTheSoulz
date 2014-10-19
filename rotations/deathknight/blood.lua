--[[ ///---INFO---////
// DeathKnight Blood //
!Originaly made by PCMD!
Thank Your For Using My ProFiles
I Hope Your Enjoy Them
MTS
]]

local exeOnLoad = function()

	ProbablyEngine.toggle.create("DRW", "Interface\\Icons\\INV_Sword_07", "Stop using Dancing Rune Weapon", "Toggle Off if you dont want to use DRW on CD")
	mtsAlert:message("\124cff9482C9*MrTheSoulz - \124cffC41F3BDeathKnight/Blood \124cff9482C9Loaded*")

end

local Buffs = {

	-- Presence
		{"48263", "player.seal != 1", nil }, -- Blood
		{ "57330", "!player.buff(57330)" }, -- Horn of Winter

}

local inCombat = {
	
	-- Just Do it!
	{ "50842",	{"modifier.multitarget", function() return UnitsAroundUnit('target', 6) >= 3 end, "modifier.last(77575)" }}, -- Blood Boil

	-- Keybinds
	{ "42650", "modifier.alt" }, -- Army of the Dead
	{ "49576", "modifier.control" }, -- Death Grip
	{ "43265", "modifier.shift", "target.ground" }, -- Death and Decay

	{{-- Defensive cooldowns
		{ "#5512", "player.health < 70"}, --healthstone
		{ "48792", "player.health <= 40", "player')" },
		{ "55233", { "modifier.cooldowns", "player.health <= 40", "player')" }},
		{ "48743", "player.health <= 50" },
		{ "49039", { "player.health <= 40", "player.runicpower >= 40", "player.spell.exists(49039)" }},
		{ "47541", { "player.health < 90", "player.runicpower >= 40", "player.buff(49039)" }, "player"},
	}, "modifier.cooldowns" },

	{ "48982", "player.health <= 60" , "player')" },

	{{-- Aggro Control
		{ "62124", "@mtsBossLib.bossTaunt", "target" }, -- Boss // Dark Command
		{ "56222", { "mouseover.threat < 100", "@mtsLib.StopIfBoss" }, "mouseover" }, -- Dark Command / Mouse-Over
		{ "56222", { "target.threat < 100", "@mtsLib.StopIfBoss" }, "target" }, -- Dark Command
		{ "49576", { "mouseover.threat < 100", "@mtsLib.StopIfBoss" }, "mouseover" }, -- Death Grip / Mouse-Over
		{ "49576", { "target.threat < 100", "@mtsLib.StopIfBoss" }, "target" }, -- Death Grip
	},{ "@mtsLib.ShouldTaunt('DkBloodTaunts')" }},

	{{-- Interrupts
		{ "47528", "modifier.interrupts" }, -- Mind freeze
		{ "47476", "modifier.interrupts", "!player.modifier.last(47528)" }, -- Strangulate,
		{ "108194", "!modifier.last(47528)" },
	}, "target.interruptsAt(50)" },

	-- Spell Steal
	{ "77606", "@mtsLib.shoulDarkSimUnit('target')" , "target" },
	{ "77606", "@mtsLib.shoulDarkSimUnit('focus')" , "focus" },
	
	{{-- Cooldowns
		{ "61999", "player.health <= 30" },
		{ "49028", "!toggle.DRW" },
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
	{ "50842",	{"modifier.multitarget","target.range <= 10", function() return UnitsAroundUnit('target', 6) >= 3 end }}, -- Blood Boil
	{ "50842",	{"player.buff(Crimson Scourge)","target.range <= 10" }}, -- Blood Boil

	-- Rotation
	{ "49998", { "player.buff(77513).duration <= 1", "modifier.last(114866)" }}, -- Death Strike //refresh buff
	{ "49998", { "player.spell(49998).charges > 4", "modifier.last(114866)" }}, -- Death Strike
	{ "114866" }, -- Soul Reaper
	{ "45462", "target.debuff(55078).duration < 2" }, -- Plague Strike
	{ "45477", "target.debuff(55095).duration < 2" }, -- Icy Touch
	{ "47541", "player.runicpower >= 30" }, -- Death Coil

	-- Death Siphon
	{ "Death Siphon", "player.health < 60" },
	-- Blood Tap
	  {{
	    { "Blood Tap", "player.runes(unholy).count = 0" },
	    { "Blood Tap", "player.runes(frost).count = 0" },
	    { "Blood Tap", "player.runes(blood).count = 0" },
	  } , {
	    "player.buff(Blood Charge).count >= 5",
	    "player.runes(death).count = 0",
	    "!modifier.last"
	  }},
	{ "47568", { "modifier.cooldowns", "player.runes(death).count < 1", "player.runes(frost).count < 1", "player.runes(unholy).count < 1", "player.runicpower < 30" }}, -- Empower Rune Weapon

}

local outCombat = {

	-- Keybinds
	{ "42650", "modifier.alt" }, -- Army of the Dead
	{ "49576", "modifier.control" }, -- Death Grip
	{ "43265", "modifier.shift", "target.ground" }, -- Death and Decay

}

for _, Buffs in pairs(Buffs) do
  inCombat[#inCombat + 1] = Buffs
  outCombat[#outCombat + 1] = Buffs
end

ProbablyEngine.rotation.register_custom(250, "|r[|cff9482C9MTS|r][|cffC41F3BDeathKnight-Blood|r]", inCombat, outCombat, exeOnLoad)

-- 55095 = Frost Fever
-- 55078 = Blood plague
-- 77513 = blood shield