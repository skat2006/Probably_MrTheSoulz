local fetch = ProbablyEngine.interface.fetchKey

local function exeOnLoad()
	mts.Splash()
	ProbablyEngine.toggle.create(
		'mts_SAoE', 
		'Interface\\AddOns\\Probably_MrTheSoulz\\media\\toggle.blp', 
		'Smart AoE', 
		'Smart AoE\nTo Force AoE enable multitarget toggle.')
end

local inCombat = {

	-- Keybinds 
	{ "42650", "modifier.control" }, -- Army of the Dead
	{ "51052", "modifier.alt" }, -- AMZ
	{ "152280", "modifier.shift", "target.ground" }, -- Defile
	{ "43265", "modifier.shift", "target.ground" }, -- Death and Decay

	-- Buffs
	{ "48263", { -- Blood
		"player.seal != 1", 
		(function() return fetch("mtsconfDkUnholy", "Presence") == 'Blood' end),
	}, nil }, 
	{ "48266", { -- Frost
		"player.seal != 2", 
		(function() return fetch("mtsconfDkUnholy", "Presence") == 'Frost' end),
	}, nil },
	{ "48265", { -- Unholy
		"player.seal != 3", 
		(function() return fetch("mtsconfDkUnholy", "Presence") == 'Unholy' end),
	}, nil },
	{ "57330", "!player.buffs.attackpower" }, -- Horn of Winter

	-- Pet
	{ "46584", "!pet.exists" }, -- Raise Dead
	{ "63560" }, -- Dark Transformation

	{{-- Interrupts 
		{ "47528" }, -- Mind freeze
		{ "47476", "!lastcast(47528)", "target" }, -- Strangulate
		{ "108194", "!lastcast(47528)", "target" }, -- Asphyxiate
		{ "47482" }, -- Leap
	}, "target.interruptsAt(50)" },

	-- Def cooldowns & Heals // Add a toggle/tick
	{ "#5512", "player.health < 85" },--Healthstone
	{ "48792", (function() return mts.dynamicEval("player.health <= " .. fetch('mtsconfDkUnholy', 'IceboundFortitude')) end) }, -- Icebound Fortitude
	{ "48743", (function() return mts.dynamicEval("player.health <= " .. fetch('mtsconfDkUnholy', 'DeathPact')) end) }, -- Death Pact
	{ "108196", (function() return mts.dynamicEval("player.health <= " .. fetch('mtsconfDkUnholy', 'DeathSiphon')) end) },-- Death Siphon
	{ "49039", { -- Lichborne //fear 
		"player.state.fear", 
		"player.runicpower >= 40", 
		"player.spell.exists(49039)" 
	}},
	{ "49039", { -- Lichborne //sleep 
		"player.state.sleep", 
		"player.runicpower >= 40", 
		"player.spell.exists(49039)" 
	}}, 
	{ "49039", { -- Lichborne //charm 
		"player.state.charm", 
		"player.runicpower >= 40", 
		"player.spell.exists(49039)" 
	}},
	{ "49998", { -- Death Strike With Dark Succor
		"player.buff(10156)", 
		(function() return mts.dynamicEval("player.health <= " .. fetch('mtsconfDkUnholy', 'DeathStrikeDS')) end)
	}}, 

	{{-- Cooldowns
		{ "47568", { -- Empower Rune Weapon
			"player.runicpower <= 70", 
			"player.runes(blood).count = 0", 
			"player.runes(unholy).count = 0", 
			"player.runes(frost).count = 0", 
			"player.runes(death).count = 0",
			(function() return fetch("mtsconfDkUnholy", "ERP") == 'Allways' end)
		}},
		{ "96268" }, -- Death's Advance
		{ "49206", (function() return fetch("mtsconfDkUnholy", "SG") == 'Allways' end) }, -- Summon Gargoyle
		{{ -- Unholy Blight
			{ "115989", { -- Unholy Blight
				"target.debuff(55095)",
				(function() return fetch("mtsconfDkUnholy", "UB") == 'Allways' end) --was "SG"
			}}, 
			{ "115989", { -- Unholy Blight
				"target.debuff(55078)",
				(function() return fetch("mtsconfDkUnholy", "UB") == 'Allways' end)
			}},
			{ "115989", { -- Unholy Blight -- For NP
				"target.debuff(155159)",
				(function() return fetch("mtsconfDkUnholy", "UB") == 'Allways' end)
			}},
		}, "!talent(7, 1)" }, 
		{ "20572", (function() return fetch("mtsconfDkUnholy", "BF") == 'Allways' end) }, -- Blood Fury
		{{-- Boss
		{ "47568", { -- Empower Rune Weapon
			"player.runicpower <= 70", 
			"player.runes(blood).count = 0", 
			"player.runes(unholy).count = 0", 
			"player.runes(frost).count = 0", 
			"player.runes(death).count = 0",
			(function() return fetch("mtsconfDkUnholy", "ERP") == 'Boss' end)
		}}, -- Empower Rune Weapon
		{ "96268" }, -- Death's Advance
		{ "#118882" }, -- Scabbrad of Kyanos
		{ "49206", (function() return fetch("mtsconfDkUnholy", "SG") == 'Boss' end) }, -- Summon Gargoyle
			{{-- Unholy Blight
				{ "115989", { -- Unholy Blight
					"target.debuff(55095)",
					(function() return fetch("mtsconfDkUnholy", "UB") == 'Boss' end)
				}}, 
				{ "115989", { -- Unholy Blight
					"target.debuff(55078)",
					(function() return fetch("mtsconfDkUnholy", "UB") == 'Boss' end)
				}}, 
				{ "115989", { -- Unholy Blight -- For NP
					"target.debuff(155159)",
					(function() return fetch("mtsconfDkUnholy", "UB") == 'Boss' end)
				}},
				}, "!talent(7, 1)" },
			{ "20572", (function() return fetch("mtsconfDkUnholy", "BF") == 'Boss' end) }, -- Blood Fury
		}, "target.boss" },
	}, "modifier.cooldowns" },

	-- Spell Steal
	{ "77606", "@mtsLib.DarkSimUnit('target')", "target" }, -- Dark Simulacrum
	{ "77606", "@mtsLib.DarkSimUnit('focus')", "focus" },  -- Dark Simulacrum

	-- Plague Leech
	{ "123693", {
		"!talent(7, 1)",
		"target.debuff(55095)",-- Target With Frost Fever
		"target.debuff(55078)",-- Target With Blood Plague
		"player.runes(unholy).count = 0",-- With 0 Unholy Runes
		"player.runes(frost).count = 0",-- With 0 Frost Runes
		"player.runes(death).count = 0",-- With 0 Death Runes
		"!lastcast"
	}},
	{ "123693", {
		"talent(7, 1)",
		"target.debuff(155159)",-- Target With NP
		"player.runes(unholy).count = 0",-- With 0 Unholy Runes
		"player.runes(frost).count = 0",-- With 0 Frost Runes
		"player.runes(death).count = 0",-- With 0 Death Runes
		"!lastcast"
	}},  

	-- Proc
	{ "47541", "player.buff(Sudden Doom)", "target"  }, -- Death Coil w/t Sudden Doom

	-- Soul Reaper
	{ "130736", { "!target.debuff", "target.health < 45" }, "target" }, -- Soul Reaper

	-- Excess RP
	{ "47541", "player.runicpower >= 75", "target"  }, -- Death Coil

	-- Diseases
	{ "77575", { --Outbreak
		"target.debuff(55095).duration < 2",
		"!talent(7, 1)",
	}, "target" },
	{ "77575", { --Outbreak 
		"target.debuff(55078).duration < 2",
		"!talent(7, 1)",
	}, "target" },
	{ "77575", { --Outbreak for NP
		"target.debuff(155159).duration < 2",
		"talent(7, 1)",
	}, "target" },
	{ "45462", { -- Plague Strike
		"target.debuff(55095).duration <= 9",
		"!talent(7, 1)", 
	}, "target" },
	{ "45462", { -- Plague Strike
		"target.debuff(55078).duration <= 9",
		"!talent(7, 1)", 
	}, "target" },
	{ "45462", { -- Plague Strike
		"target.debuff(155159).duration <= 9",
		"talent(7, 1)", 
	}, "target" },

	{{-- AoE // Smart
		{ "43265", "target.range < 7", "target.ground" }, -- Death and Decay
		{ "152280", "target.range < 7", "target.ground" }, -- Defile
		{{ -- Only at range
			{ "50842", "player.runes(death).count >= 1" }, -- Blood Boil // death
			{{ -- Not NP
				{ "50842", { -- Blood Boil // blood
					"player.runes(blood).count >= 1",
					"target.debuff(55095).duration < 3", 
					"target.debuff(55078).duration <3",
				}},
				{ "50842", {  -- Blood Boil // death
					"player.runes(death).count >= 1",
					"target.debuff(55095).duration < 3", 
					"target.debuff(55078).duration <3",
				}},
			}, "!talent(7, 1)" },
			{{ -- NP
				{ "50842", "player.runes(blood).count >= 1" }, -- Blood Boil // blood // NP
				{ "50842", "player.runes(death).count >= 1" }, -- Blood Boil // death // NP
			}, {
				"talent(7, 1)",
				"target.debuff(155159).duration < 3",
			}},
		}, "target.range <= 10" },
		{ "85948", { --Testing // Festering Strike
			"player.runes(blood) = 2", 
			"player.runes(frost) = 2" 
		}, "target"  }, 
		{ "85948" }, -- Festering Strike
		{ "47541", "player.runicpower >= 40", "target" }, -- Death Coil
	},{ 
		"toggle.mts_SAoE", 
		"player.area(10).enemies >= 4" 
	}},

	{{-- AoE // Normal/Forced
		{ "43265", "target.range < 7", "target.ground" }, -- Death and Decay
		{ "152280", "target.range < 7", "target.ground" }, -- Defile
			{{ -- Only at range
			{ "50842", "player.runes(death).count >= 1" }, -- Blood Boil // death
			{{ -- Not NP
				{ "50842", { -- Blood Boil // blood
					"player.runes(blood).count >= 1",
					"target.debuff(55095).duration < 3", 
					"target.debuff(55078).duration <3",
				}},
				{ "50842", {  -- Blood Boil // death
					"player.runes(death).count >= 1",
					"target.debuff(55095).duration < 3", 
					"target.debuff(55078).duration <3",
				}},
			}, "!talent(7, 1)" },
			{{ -- NP
				{ "50842", "player.runes(blood).count >= 1" }, -- Blood Boil // blood // NP
				{ "50842", "player.runes(death).count >= 1" }, -- Blood Boil // death // NP
			}, {
				"talent(7, 1)",
				"target.debuff(155159).duration < 3",
			}},
		}, "target.range <= 10" },
		{ "85948", { --Testing // Festering Strike
			"player.runes(blood) = 2", 
			"player.runes(frost) = 2" 
		}, "target"  }, 
		{ "85948" }, -- Festering Strike
		{ "47541", "player.runicpower >= 40", "target" }, -- Death Coil
	}, "modifier.multitarget" },

	-- Rotation
	{ "55090", "player.runes(unholy) = 2", "target"  }, -- Scourge Strike
	{ "43265", { -- Death and Decay
		"target.range < 7",
		(function() return fetch("mtsconfDkUnholy", "DnD") == 'Allways' end)
	}, "target.ground" }, 
	{ "152280", {
		"target.range < 7",
		(function() return fetch("mtsconfDkUnholy", "Defile") == 'Allways' end)
	}, "target.ground" }, -- Defile
	{ "85948", { "player.runes(unholy) = 2", "player.runes(blood) = 2" }, "target"  }, --Festering Strike
	{ "55090" },-- Scourge Strike
	{ "85948" }, -- Festering Strike
	{ "47541" }, -- Death Coil

	-- Blood Tap
	{{
		{ "45529", "player.runes(unholy).count = 0" }, --Blood Tap
		{ "45529", "player.runes(frost).count = 0" }, -- Blood Tap
		{ "45529", "player.runes(blood).count = 0" }, -- Blood Tap
	},{
		"player.buff(Blood Charge).count >= 5",
		"player.runes(death).count = 0",
		"!lastcast(45529)"
	}},
}

local outCombat = {

	{ "46584", "!pet.exists" }, -- Raise Dead

	-- Buffs
	{ "48263", { -- Blood
		"player.seal != 1", 
		(function() return fetch("mtsconfDkUnholy", "Presence") == 'Blood' end),
	}, nil }, 
	{ "48266", { -- Frost
		"player.seal != 2", 
		(function() return fetch("mtsconfDkUnholy", "Presence") == 'Frost' end),
	}, nil },
	{ "48265", { -- Unholy
		"player.seal != 3", 
		(function() return fetch("mtsconfDkUnholy", "Presence") == 'Unholy' end),
	}, nil },
	{ "57330", { -- Horn of Winter
		"!player.buffs.attackpower",
		(function() return fetch('mtsconfDkUnholy','HornOCC') end)
	}}, 
}

ProbablyEngine.rotation.register_custom(
	252, 
	mts.Icon.."|r[|cff9482C9MTS|r][\124cffC41F3BDeathKnight-Unholy|r]", 
	inCombat, outCombat, exeOnLoad)
