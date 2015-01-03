local fetch = ProbablyEngine.interface.fetchKey
function exeOnLoad()



end

local inCombat = {

	

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
			"!player.buff(57330).any",
			"!player.buff(6673).any",
			"!player.buff(19506).any"
		}},

	-- Keybinds 
		{ "42650", "modifier.alt" }, -- Army of the Dead
		{ "49576", "modifier.control" }, -- Death Grip
		{ "152280", "modifier.shift", "target.ground" }, -- Defile
		{ "43265", "modifier.shift", "target.ground" }, -- Death and Decay
	
	-- Pet
		{ "46584", "!pet.exists" }, -- Raise Dead
		{ "63560" }, -- Dark Transformation

	-- Interrumpts 
		{ "47528", { -- Mind freeze
			"target.interruptsAt(50)", 
			"modifier.interrupts" 
		}, "target" }, 
		{ "47476", { -- Strangulate
			"target.interruptsAt(50)", 
			"modifier.interrupts", 
			"!player.modifier.last(47528)"
		}, "target" }, 
		{ "108194", { -- Asphyxiate
			"target.interruptsAt(50)", 
			"!modifier.last(47528)" 
		}, "target" }, 

	-- Def cooldowns // heals
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
			"player.buff(10156", 
			(function() return mts.dynamicEval("player.health <= " .. fetch('mtsconfDkUnholy', 'DeathStrikeDS')) end)
		}}, 
	
	-- Cooldowns
		 { "Empower Rune Weapon", {
			"modifier.cooldowns", 
			"player.runicpower <= 70", 
			"player.runes(blood).count = 0", 
			"player.runes(unholy).count = 0", 
			"player.runes(frost).count = 0", 
			"player.runes(death).count = 0",
			(function() return fetch("mtsconfDkUnholy", "ERP") == 'Allways' end)
		}},
		{ "Summon Gargoyle", {
			"modifier.cooldowns",
			(function() return fetch("mtsconfDkUnholy", "SG") == 'Allways' end)
		} },
		{ "115989", { -- Unholy Blight
			"modifier.cooldowns",
			"target.debuff(55095)",
			(function() return fetch("mtsconfDkUnholy", "SG") == 'Allways' end)
		}}, 
		{ "115989", { -- Unholy Blight
			"modifier.cooldowns",
			"target.debuff(55078)",
			(function() return fetch("mtsconfDkUnholy", "UB") == 'Allways' end)
		}}, 
		{ "20572", { -- Blood Fury
			"modifier.cooldowns",
			(function() return fetch("mtsconfDkUnholy", "BF") == 'Allways' end)
		} },
	
	-- Cooldowns boss
		{ "Empower Rune Weapon", {
			"modifier.cooldowns", 
			"player.runicpower <= 70", 
			"player.runes(blood).count = 0", 
			"player.runes(unholy).count = 0", 
			"player.runes(frost).count = 0", 
			"player.runes(death).count = 0",
			"target.boss",
			(function() return fetch("mtsconfDkUnholy", "ERP") == 'Boss' end)
		}},
		{ "Summon Gargoyle", {
			"modifier.cooldowns",
			"target.boss",
			(function() return fetch("mtsconfDkUnholy", "SG") == 'Boss' end)
		} },
		{ "115989", { -- Unholy Blight
			"modifier.cooldowns",
			"target.debuff(55095)",
			"target.boss",
			(function() return fetch("mtsconfDkUnholy", "SG") == 'Boss' end)
		}}, 
		{ "115989", { -- Unholy Blight
			"modifier.cooldowns",
			"target.debuff(55078)",
			"target.boss",
			(function() return fetch("mtsconfDkUnholy", "UB") == 'Boss' end)
		}}, 
		{ "20572", { -- Blood Fury
			"modifier.cooldowns",
			"target.boss",
			(function() return fetch("mtsconfDkUnholy", "BF") == 'Boss' end)
		} }, 

	-- Spell Steal
		{ "77606", "@mtsLib.DarkSimUnit('target')", "target" }, -- Dark Simulacrum
		{ "77606", "@mtsLib.DarkSimUnit('focus')", "focus" },  -- Dark Simulacrum
	
	-- Plague Leech
		{ "123693", {
			"target.debuff(55095)",-- Target With Frost Fever
			"target.debuff(55078)",-- Target With Blood Plague
			"player.runes(unholy).count = 0",-- With 0 Unholy Runes
			"player.runes(frost).count = 0",-- With 0 Frost Runes
			"player.runes(death).count = 0",-- With 0 Death Runes
			"!modifier.last"
		}}, 

	-- Proc
		{ "47541", "player.buff(Sudden Doom)", "target"  }, -- Death Coil w/t Sudden Doom

	-- Soul Reaper
		{ "Soul Reaper", { "!target.debuff", "target.health < 45" }, "target" },

	-- Excess RP
		{ "47541", "player.runicpower >= 75", "target"  }, -- Death Coil

	-- Diseases
		{ "77575", "target.debuff(55095).duration < 2" }, -- Outbreak
		{ "77575", "target.debuff(55078).duration < 2" }, -- Outbreak
		{ "45462", "target.debuff(55095).duration <= 9", "target" }, -- Plague Strike
		{ "45462", "target.debuff(55078).duration <= 9", "target" }, -- Plague Strike

	{{-- AoE // Smart
		{ "43265", "target.range < 7", "target.ground" }, -- Death and Decay
		{ "152280", "target.range < 7", "target.ground" }, -- Defile
		{ "50842", { -- Blood Boil // death
			"player.runes(death).count >= 1",
			"target.range <= 10"
		}, nil },
		{ "50842", { -- Blood Boil // blood
			"player.runes(blood).count >= 1",
			"target.debuff(55095).duration < 3", 
			"target.debuff(55078).duration <3",
			"target.range <= 10" 
		}},
		{ "50842", {  -- Blood Boil // death
			"player.runes(death).count >= 1",
			"target.debuff(55095).duration < 3", 
			"target.debuff(55078).duration <3",
			"target.range <= 10" 
		}},
		{ "85948" }, -- Festering Strike
		{ "47541", "player.runicpower >= 40", "target"  }, -- Death Coil
	}, { (function() return fetch('mtsconf','Firehack') end), "player.area(10).enemies >= 4" }},

	{{-- AoE
		{ "43265", "target.range < 7", "target.ground" }, -- Death and Decay
		{ "152280", "target.range < 7", "target.ground" }, -- Defile
		{ "50842", { -- Blood Boil // death
			"player.runes(death).count >= 1",
			"target.range <= 10"
		}, nil },
		{ "50842", { -- Blood Boil // blood
			"player.runes(blood).count >= 1",
			"target.debuff(55095).duration < 3", 
			"target.debuff(55078).duration <3",
			"target.range <= 10" 
		}},
		{ "50842", {  -- Blood Boil // death
			"player.runes(death).count >= 1",
			"target.debuff(55095).duration < 3", 
			"target.debuff(55078).duration <3",
			"target.range <= 10" 
		}},
		{ "85948" }, -- Festering Strike
	}, "modifier.multitarget"},

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
		{ "Fastering Strike", { "player.runes(unholy) = 2", "player.runes(blood) = 2" }, "target"  },
		{ "55090" },-- Scourge Strike
		{ "Festering Strike" },
		{ "47541" }, -- Death Coil

	-- Blood Tap
		{{
			{ "45529", "player.runes(unholy).count = 0" }, --Blood Tap
			{ "45529", "player.runes(frost).count = 0" }, -- Blood Tap
			{ "45529", "player.runes(blood).count = 0" }, -- Blood Tap
		} , {
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
			"!player.buff(57330).any",
			"!player.buff(6673).any",
			"!player.buff(19506).any",
			(function() return fetch('mtsconfDkUnholy','HornOCC') end)
		}}, 

}

ProbablyEngine.rotation.register_custom(
	252, mts.Icon..
	"|r[|cff9482C9MTS|r][\124cffC41F3BDeathKnight-Unholy|r]", 
	inCombat, 
	outCombat, 
	exeOnLoad)
