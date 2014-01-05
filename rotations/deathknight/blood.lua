ProbablyEngine.rotation.register_custom(250, "|r[|cff9482C9MTS|r][|cffC41F3BDeathKnight-Blood|r]", {

	-- Keybinds
		{ "Army of the Dead", "modifier.alt" }, -- Army of the Dead
		{ "49576", "modifier.control" }, -- Death Grip
		{ "43265", "modifier.shift", "ground" }, -- Death and Decay
	
	-- Presence
		{ "48263", "player.seal != 1" }, -- Blood Presence

	-- Buffs
		{ "57330", "!player.buff(57330)" }, -- Horn of Winter
		{ "Bone Shield", "player.buff(Bone Shield).charges < 1" },
	
	--  Racials
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

	-- Battle Rez Mouseover
		{ "Raise Ally", "!mouseover.alive", "mouseover" },
  
	-- Interrupts
		{ "Mind Freeze", "modifier.interrupts" },
		{ "Strangulate", "modifier.interrupts" },

	{{-- Aggro Control
		{ "56222", { "mouseover.threat < 100" }, "mouseover" }, -- Dark Command / Mouse-Over
		{ "56222", { "target.threat < 100" }, "target" }, -- Dark Command
		{ "49576", { "mouseover.threat < 100" }, "mouseover" }, -- Death Grip / Mouse-Over
		{ "49576", { "target.threat < 100" }, "target" }, -- Death Grip
	}, "toggle.aggro" },
	
	-- Heal
		{ "48982", "player.health <= 40" }, -- Rune Tap
		{ "/cast Raise Dead\n/cast Death Pact", { "player.health < 35", "player.spell(Death Pact).cooldown", "player.spell(Raise Dead).cooldown", "player.spell(Death Pact).usable" }, nil },-- Death Pact Macro, Last Resort
	
	{{-- Defensive
		{ "48707", "player.health <= 70", "target.casting" }, -- Anti-Magic Shell
		{ "49028", "player.health <= 75" }, -- Dancing Rune Weapon
		{ "Conversion", "player.health <= 60" },
		{ "55233", "player.health <= 55" }, -- Vampiric Blood
		{ "48792", "player.health <= 50" },-- Icebound Fortitude
	}, "toggle.defcd" },	
		
	{{-- Cooldowns
		{ "Empower Rune Weapon", "player.health <= 40" }, -- Empower Rune Weapon
	}, "modifier.cooldowns" },
	
	-- Rotation
	
		-- Disease's
			{ "Outbreak", "target.debuff(55095).duration < 3", "target.debuff(55078).duration <3", "target" },
			{ "48721", "player.runes(blood).count > 1","target.debuff(55095).duration < 3", "target.debuff(55078).duration <3" }, -- Blood Boil
			{ "48721", "player.runes(death).count > 1","target.debuff(55095).duration < 3", "target.debuff(55078).duration <3" }, -- Blood Boil
			{ "45477", "target.debuff(55095).duration < 3" }, -- Icy Touch
			{ "45462", "target.debuff(55078).duration < 3" }, -- Plague Strike

		{ "45529", "player.buff(114851).count >= 5" }, -- Blood Tap
		{ "Pestilence", "target.debuff(55078", "target.debuff(55078)" },
		{"114866", "target.health < 35" }, -- Soul Reaper
		{"48721", { "player.buff(81141)", "target.range <= 5" }, "target" }, -- Blood Boil W/ Crimson Scourge
		
		{{-- AoE
			{ "55050", "modifier.enemies < 4", "target.spell(55050).range" }, -- Heart Strike
			{ "48721", "modifier.enemies > 3", "target.range < " }, -- Blood Boil
			{ "49998", "!modifier.last(49998)" }, -- Death Strike
			{ "56815", "player.runicpower >= 40" }, -- Rune Strike
		}, "modifier.multitarget" },

		{{-- Single
			{ "49998", "!modifier.last(49998)" }, -- Death Strike
			{ "55050", "player.runes(blood).count >= 1", "target.health > 35" }, -- Heart Strike
			{ "114866", "player.runes(blood).count >= 1", "target.health < 35" }, -- Soul Reaper
			{ "56815", "player.runicpower >= 40" }, -- Rune Strike
		}, "!modifier.multitarget" },
  
},{------------------------------------------------------------------------ Out Of Combat

	-- Presence
		{ "48263", "player.seal != 1" }, -- Blood Presence

	-- Buffs
		{ "57330", "!player.buff(57330)" }, -- Horn of Winter
		{ "Bone Shield", "player.buff(Bone Shield).charges < 1" },
  
	-- Keybinds
		{ "Army of the Dead", "modifier.alt" },
		{ "Death Grip", "modifier.control" },
		{ "Death and Decay", "modifier.shift", "ground" },

},
function()
	ProbablyEngine.toggle.create('defcd', 'Interface\\Icons\\Spell_deathknight_iceboundfortitude.png', 'Defensive Cooldowns', 'Enable or Disable Defensive Cooldowns.')
	ProbablyEngine.toggle.create('aggro', 'Interface\\Icons\\Ability_warrior_stalwartprotector.png', 'Aggro Control', 'Auto Taunts on mouse-over ot target if dosent have aggro.')
end)
