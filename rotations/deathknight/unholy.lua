local fetch = ProbablyEngine.interface.fetchKey
local _darkSimSpells = {
	-- siege of orgrimmar
	"Froststorm Bolt",
	"Arcane Shock",
	"Rage of the Empress",
	"Chain Lightning",
	-- pvp
	"Hex",
	"Mind Control",
	"Cyclone",
	"Polymorph",
	"Pyroblast",
	"Tranquility",
	"Divine Hymn",
	"Hymn of Hope",
	"Ring of Frost",
	"Entangling Roots"
}

function DarkSimUnit(unit)
	for index,spellName in pairs(_darkSimSpells) do
		if ProbablyEngine.condition["casting"](unit, spellName) then return true end
	end
		return false
end

function exeOnLoad()



end

local inCombat = {

	--Racials
        -- Dwarves
			{ "20594", "player.health <= 65" },
		-- Humans
			{ "59752", "player.state.charm" },
			{ "59752", "player.state.fear" },
			{ "59752", "player.state.incapacitate" },
			{ "59752", "player.state.sleep" },
			{ "59752", "player.state.stun" },
		-- Draenei
			{ "28880", "player.health <= 70", "player" },
		-- Gnomes
			{ "20589", "player.state.root" },
			{ "20589", "player.state.snare" },
		-- Forsaken
			{ "7744", "player.state.fear" },
			{ "7744", "player.state.charm" },
			{ "7744", "player.state.sleep" },
		-- Goblins
			{ "69041", "player.moving" },
	
	--Auto target
		{ "/cleartarget", {
			(function() return fetch('mtsconfDkUnholy','AutoTargets') end),
			(function() return UnitIsFriend("player","target") end)
			}},

		{ "/target [target=focustarget, harm, nodead]", { -- Use Tank Target
			(function() return fetch('mtsconfDkUnholy','AutoTarget') end),
			"target.range > 40"
			 }}, 
		{ "/targetenemy [noexists]", { -- target enemire if no target
			(function() return fetch('mtsconfDkUnholy','AutoTarget') end),
			"!target.exists" 
			}},
		{ "/targetenemy [dead]", { -- target enemire if current is dead.
			(function() return fetch('mtsconfDkUnholy','AutoTarget') end), 
			"target.exists", 
			"target.dead" 
			}},

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
		{ "Army of the Dead", "modifier.alt" },
		{ "Death Grip", "modifier.control" },
		{ "152280", "modifier.shift", "target.ground" }, -- Defile
		{ "43265", "modifier.shift", "target.ground" }, -- Death and Decay
	
	-- Pet
		{ "Raise Dead", "!pet.exists" },
		{ "Dark Transformation" },

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
		{ "48792", (function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfDkBlood', 'IceboundFortitude')) end) }, -- Icebound Fortitude
		{ "48743", (function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfDkBlood', 'DeathPact')) end) }, -- Death Pact
		{ "108196", (function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfDkBlood', 'DeathSiphon')) end) },-- Death Siphon
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
			(function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfDkBlood', 'DeathStrikeDS')) end)
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
		{ "77606", function() return DarkSimUnit('target') end, "target" }, -- Dark Simulacrum
		{ "77606", function() return DarkSimUnit('focus') end, "focus" },  -- Dark Simulacrum
	
	-- Plague Leech
		{ "123693", {
			"target.debuff(55095)",-- Target With Frost Fever
			"target.debuff(55078)",-- Target With Blood Plague
			"player.runes(unholy).count = 0",-- With 0 Unholy Runes
			"player.runes(frost).count = 0",-- With 0 Frost Runes
			"player.runes(death).count = 0",-- With 0 Death Runes
			"!modifier.last"}}, 

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
			"target.range <= 10" }},
		{ "50842", {  -- Blood Boil // death
			"player.runes(death).count >= 1",
			"target.debuff(55095).duration < 3", 
			"target.debuff(55078).duration <3",
			"target.range <= 10" }},
		{ "Festering Strike" },
		{ "47541", "player.runicpower >= 40", "target"  }, -- Death Coil
	}, { "player.firehack", (function() return fetch('mtsconf','Firehack') end), "player.area(10).enemies >= 4" }},

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
			"target.range <= 10" }},
		{ "50842", {  -- Blood Boil // death
			"player.runes(death).count >= 1",
			"target.debuff(55095).duration < 3", 
			"target.debuff(55078).duration <3",
			"target.range <= 10" }},
		{ "Festering Strike" },
		{ "Festering Strike" },
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
			"!modifier.last"
		}},

}

local outCombat = {
  
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
  
	-- Pet
		{ "Raise Dead", "!pet.exists" },

}

ProbablyEngine.rotation.register_custom(
	252, mts_Icon..
	"|r[|cff9482C9MTS|r][\124cffC41F3BDeathKnight-Unholy|r]", 
	inCombat, 
	outCombat, 
	exeOnLoad)
