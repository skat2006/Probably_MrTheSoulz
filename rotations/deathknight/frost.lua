ProbablyEngine.condition.register('twohand', function(target)
  return IsEquippedItemType("Two-Hand")
end)

ProbablyEngine.condition.register('onehand', function(target)
  return IsEquippedItemType("One-Hand")
end)

local exeOnLoad = function()
	mts.Splash("|cff9482C9[MTS]-[|cffC41F3BDeathKnight-Frost|r]-|cff9482C9Loaded", 5.0)
	ProbablyEngine.toggle.create(
		'defcd', 
		'Interface\\Icons\\Spell_deathknight_iceboundfortitude.png', 
		'Defensive Cooldowns', 
		'Enable or Disable Defensive Cooldowns.')
	ProbablyEngine.toggle.create(
		'run', 
		'Interface\\Icons\\Inv_boots_plate_dungeonplate_c_05.png', 
		'Enable Unholy Presence Outside of Combat', 
		'Enable/Disable Unholy Presence Outside of Combat \nMakes you run/fly faster when outside of combat.')
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

	-- Keybinds
		{ "42650", "modifier.alt" }, -- Army of the Dead
		{ "49576", "modifier.control" }, -- Death Grip
		{ "43265", "modifier.shift", "target.ground" }, -- Death and Decay
		{ "152280", "modifier.shift", "target.ground" }, -- Defile
	
	-- Presence
		{ "48266", "player.seal != 2" }, -- frost

	-- Buffs
		{ "57330", "!player.buffs.attackpower" }, -- Horn of Winter

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

	-- items
		{ "#5512", "player.health < 70"}, --healthstone

	-- Def cooldowns // heals
		{ "48792", { -- Icebound Fortitude
			"toggle.defcd", 
			"player.health <= 40" 
			}, "player')" }, 
		{ "48743", { -- Death Pact
			"toggle.defcd", 
			"player.health <= 50" 
			}}, 
		{ "49039", { -- Lichborne //fear
			"toggle.defcd", 
			"player.state.fear", 
			"player.runicpower >= 40", 
			"player.spell.exists(49039)" 
			}}, 
		{ "49039", { -- Lichborne //sleep
			"toggle.defcd", 
			"player.state.sleep", 
			"player.runicpower >= 40", 
			"player.spell.exists(49039)" 
			}}, 
		{ "49039", { -- Lichborne //charm
			"toggle.defcd", 
			"player.state.charm", 
			"player.runicpower >= 40", 
			"player.spell.exists(49039)" 
			}}, 
		{ "108196", { -- Death Siphon
			"toggle.defcd",
			"player.health < 60" 
			}},

	-- Cooldowns
		--{ "61999", { "modifier.cooldowns", "player.health <= 30" }, "mouseover" }, -- Raise Ally
		{ "47568", { -- Empower Rune Weapon
			"modifier.cooldowns", 
			"player.runes(death).count < 1", 
			"player.runes(frost).count < 1", 
			"player.runes(unholy).count < 1", 
			"player.runicpower < 30" 
			}}, 
		{ "51271", "modifier.cooldowns" }, -- Pilar of frost
		{ "115989", { -- Unholy Blight
			"modifier.cooldowns",
			"target.debuff(55095)" 
			}}, 
		{ "115989", { -- Unholy Blight
			"modifier.cooldowns",
			"target.debuff(55078)" 
			}},
		{ "#gloves"},

	-- Interrupts
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

	-- Diseases
		{ "77575", "target.debuff(55095).duration < 2" }, -- Outbreak
		{ "77575", "target.debuff(55078).duration < 2" }, -- Outbreak
		{ "45462", "target.debuff(55078).duration < 2", "target" }, -- Plague Strike

	-- Soul Reaper
		{ "114866", "target.health < 35", "target"  },
	
	-- AoE
	    { "49184", "modifier.multitarget", "target" }, -- Howling Blast

	{{ -- 1-hand
		{ "49143", "player.buff(Killing Machine)", "target"  },-- Frost Strike
	    { "49143", "player.runicpower >= 80", "target" },-- Frost Strike
	    { "49184", "player.runes(death).count > 1", "target"  },-- Howling Blast
	    { "49184", "player.runes(frost).count > 1", "target" },-- Howling Blast
	    { "49184", "player.buff(Freezing Fog)", "target"  }, -- Howling Blast
	    { "49143", "player.runicpower > 76", "target"  },-- Frost Strike
	    { "49998", "player.buff(Dark Succor)", "target"  }, -- Death Strike
	    { "49998", "player.health <= 65", "target"  }, -- Death Strike
	    { "49020", { -- Obliterate
			"player.runes(unholy).count > 0", 
			"!player.buff(Killing Machine)" 
			}, "target" }, 
	    { "49184" },--Howling Blast
	    { "49143", "player.runicpower >= 40", "target" },-- Frost Strike
	 }, "player.onehand" },

	{{ -- 2-Hand
	    { "49184", "player.buff(Freezing Fog)" }, -- Howling Blast
	    -- If player less then 65% health
			{ "49998", {
				"player.buff(Killing Machine)", 
				"player.health < 65"
				}, "target" }, -- Death Strike
	        { "49998", {
				"player.runicpower <= 75", 
				"player.health < 65"
				}, "target" }, -- Death Strike
		-- If player more then 65% health
		    { "49020", {
				"player.buff(Killing Machine)", 
				"player.health > 65"
				}, "target" }, -- Obliterate
			{ "49020", {
				"player.runicpower <= 75", 
				"player.health > 65"
				}, "target" }, -- Obliterate
	    { "49143", "!player.buff(Killing Machine)", "target" }, -- Frost Strike
	    { "49143", "player.spell(Obliterate).cooldown >= 4", "target" }, -- Frost Strike
	}, "player.twohand" },
	
	
	{{ -- Blood Tap
		{ "45529", "player.runes(unholy).count = 0" }, --Blood Tap
		{ "45529", "player.runes(frost).count = 0" }, -- Blood Tap
		{ "45529", "player.runes(blood).count = 0" }, -- Blood Tap
		}, { "player.buff(Blood Charge).count >= 5", "player.runes(death).count = 0", "!modifier.last" } },
  
}

local outCombat = {

	-- Buffs
		{ "48266", { -- frost
			"player.seal != 2 ", 
			"!toggle.run" 
			}}, 
		{ "48265", { -- unholy // moves faster out of combat...
			"player.seal != 3", 
			"toggle.run" 
			}}, 
		{ "57330", "!player.buffs.attackpower" }, -- Horn of Winter
  
}

ProbablyEngine.rotation.register_custom(
251, 
"|r[|cff9482C9MTS|r][|cffC41F3BDeathKnight-Frost|r]", 
inCombat, 
outCombat, 
exeOnLoad)
