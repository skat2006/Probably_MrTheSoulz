--[[ ///---INFO---////
// DK Frost 2h //
!Originaly made by PCMD!
Thank You For Using My ProFiles
I Hope Your Enjoy Them
MTS
]]

local exeOnLoad = function()

-- ////////////////-----------------------------------------TOGGLES-----------------------------------//////////////////////////////
	ProbablyEngine.toggle.create('defcd', 'Interface\\Icons\\Spell_deathknight_iceboundfortitude.png', 'Defensive Cooldowns', 'Enable or Disable Defensive Cooldowns.')
	mtsAlert:message("\124cff9482C9*MrTheSoulz - \124cffC41F3BDeathKnight/Blood \124cff9482C9Loaded*")

end

-- //////////////////////-----------------------------------------END LIB-----------------------------------//////////////////////////////

local Buffs = {

	-- Presence
		{"48263", "player.seal != 1", nil }, -- Blood

	-- Buffs
		{ "49222", "player.buff(49222).count < 6" }, -- Bone Shield
  
}
-- ////////////////////////-----------------------------------------END BUFFS-----------------------------------//////////////////////////////

local inCombat = {

	-- Keybinds
		{ "42650", "modifier.alt" }, -- Army of the Dead
		{ "49576", "modifier.control" }, -- Death Grip
		{ "43265", "modifier.shift", "ground" }, -- Death and Decay
 
	-- Buffs
		{ "57330", "player.runicpower < 100)" }, -- Horn of Winter
	
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

	-- Combat Ress
		{ "Raise Ally", "!mouseover.alive", "mouseover" }, -- Raise Ally
  
	-- Interrupts
		{ "47528", "modifier.interrupts" }, -- Mind freeze
		{ "47476", "modifier.interrupts" }, -- Strangulate
	
	-- Heal
		{ "#5512", "player.health <= 60" }, --Healthstone
		{ "/cast 46584\n/cast 48743", { "player.health < 35", "player.spell(48743).cooldown", "player.spell(46584).cooldown", "player.spell(48743).usable" }, nil },-- Death Pact Macro, Last Resort
		--{ "/cast Raise Dead\n/cast Death Pact", { "player.health < 35", "player.spell(Death Pact).cooldown", "player.spell(Raise Dead).cooldown", "player.spell(Death Pact).usable" }, nil },-- Death Pact Macro, Last Resort
	
	{{-- Defensive
		{ "48707", "player.health <= 70", "target.casting" }, -- Anti-Magic Shell
		{ "48792", "player.health <= 50" },-- Icebound Fortitude
	}, "toggle.defcd" },	
		
	{{-- Cooldowns
		{ "47568", "player.runes(blood).count < 1" }, -- Empower Rune Weapon
		{ "47568", "player.runes(death).count < 1" }, -- Empower Rune Weapon
		{ "47568", "player.runes(frost).count < 1" }, -- Empower Rune Weapon
		{ "51271" }, -- Pillar of Frost
	}, "modifier.cooldowns" },
	
	-- Rotation
	
		-- Disease's
			{ "77575", { "target.debuff(55095).duration < 3", "target.debuff(55078).duration <3" }, "target" }, -- Outbreak
			{ "48721", { "player.runes(blood).count > 1","target.debuff(55095).duration < 3", "target.debuff(55078).duration <3" }, nil }, -- Blood Boil
			{ "48721", { "player.runes(death).count > 1","target.debuff(55095).duration < 3", "target.debuff(55078).duration <3" }, nil }, -- Blood Boil
			{ "45477", "target.debuff(55095).duration < 3" }, -- Icy Touch
			{ "45462", "target.debuff(55078).duration < 3" }, -- Plague Strike

		{ "45529", "player.buff(114851).count >= 5" }, -- Blood Tap
		{ "49184", { "player.buff(59052)", "modifier.multitarget", "target.spell(49184).range" }, "target" }, -- Howling Blast
		{ "114866", "target.health < 35" }, -- Soul Reaper
		{ "49184", "player.buff(59052)", "target.spell(49184).range" }, -- Howling Blast if Freezing Fog
	    { "49143", "player.buff(51124)", "target.spell(49143).range" }, -- Frost Strike if Killing Machine
		{ "49143", "player.runicpower >= 70", "target.spell(49143).range" }, -- Frost Strike
		{ "49020", "!modifier.last(49020)" }, -- Obliterate
  
} 
-- //////////////////////-----------------------------------------END IN-COMBAT-----------------------------------//////////////////////////////

local outCombat = {

	-- Keybinds
		{ "42650", "modifier.alt" }, -- Army of the Dead
		{ "49576", "modifier.control" }, -- Death Grip
		{ "43265", "modifier.shift", "ground" }, -- Death and Decay

	-- Buffs
		{ "57330", "!player.buff(57330)" }, -- Horn of Winter
  
}
-- ////////////////////-----------------------------------------END OUT-OF-COMBAT-----------------------------------//////////////////////////////

for _, Buffs in pairs(Buffs) do
  inCombat[#inCombat + 1] = Buffs
  outCombat[#outCombat + 1] = Buffs
end

ProbablyEngine.rotation.register_custom(251, "|r[|cff9482C9MTS|r][|cffC41F3BDeathKnight-2h-Frost|r]", inCombat, outCombat, exeOnLoad)