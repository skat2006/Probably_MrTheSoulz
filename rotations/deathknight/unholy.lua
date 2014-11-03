local _darkSimSpells = {
-- siege of orgrimmar
"Froststorm Bolt","Arcane Shock","Rage of the Empress","Chain Lightning",
-- pvp
"Hex","Mind Control","Cyclone","Polymorph","Pyroblast","Tranquility","Divine Hymn","Hymn of Hope","Ring of Frost","Entangling Roots"
}

function DarkSimUnit(unit)
	for index,spellName in pairs(_darkSimSpells) do
		if ProbablyEngine.condition["casting"](unit, spellName) then return true end
	end
		return false
end

function exeOnLoad()

	ProbablyEngine.toggle.create('autotarget', 'Interface\\Icons\\Ability_spy.png', 'Auto Target', 'Automatically target the nearest enemy when target dies or does not exist')
	ProbablyEngine.toggle.create('defcd', 'Interface\\Icons\\Spell_deathknight_iceboundfortitude.png', 'Defensive Cooldowns', 'Enable or Disable Defensive Cooldowns.')
	mtsStart:message("\124cff9482C9*MTS-\124cffC41F3BDeathKnight/Unholy\124cff9482C9-Loaded*")

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
		{ "Army of the Dead", "modifier.alt" },
		{ "Death Grip", "modifier.control" },
	
	-- Pet
		{ "Raise Dead", "!pet.exists" },
		{ "Dark Transformation" },

	-- Interrumpts 
		{ "47528", { "target.interruptsAt(50)", "modifier.interrupts" }, "target" }, -- Mind freeze
		{ "47476", { "target.interruptsAt(50)", "modifier.interrupts", "!player.modifier.last(47528)"}, "target" }, -- Strangulate
		{ "108194", { "target.interruptsAt(50)", "!modifier.last(47528)" }, "target" }, -- Asphyxiate

	-- Def cooldowns // heals
		{ "48792", { "toggle.defcd", "player.health <= 40" }, "player')" }, -- Icebound Fortitude
		{ "48743", { "toggle.defcd", "player.health <= 50" }}, -- Death Pact
		{ "49039", { "toggle.defcd", "player.state.fear", "player.runicpower >= 40", "player.spell.exists(49039)" }}, -- Lichborne //fear
		{ "49039", { "toggle.defcd", "player.state.sleep", "player.runicpower >= 40", "player.spell.exists(49039)" }}, -- Lichborne //sleep
		{ "49039", { "toggle.defcd", "player.state.charm", "player.runicpower >= 40", "player.spell.exists(49039)" }}, -- Lichborne //charm
		{ "108196", { "toggle.defcd","player.health < 60" }},-- Death Siphon
		
	--Auto target
		{ "/target [target=focustarget, harm, nodead]", "target.range > 40" },
		{ "/targetenemy [noexists]", { "toggle.autotarget", "!target.exists" }},
   		{ "/targetenemy [dead]", { "toggle.autotarget", "target.exists", "target.dead" }},
	
	-- buffs
		{ "48265", { "player.seal != 3", "toggle.run" }}, -- unholy
		{ "57330", "!player.buff(57330)" }, -- Horn of Winter
	
	-- Cooldowns
		 { "Empower Rune Weapon", {
			"modifier.cooldowns", 
			"player.runicpower <= 70", 
			"player.runes(blood).count = 0", 
			"player.runes(unholy).count = 0", 
			"player.runes(frost).count = 0", 
			"player.runes(death).count = 0"}},
		{ "Summon Gargoyle", "modifier.cooldowns" },
		{ "115989", { "modifier.cooldowns","target.debuff(55095)" }}, -- Unholy Blight
		{ "115989", { "modifier.cooldowns","target.debuff(55078)" }}, -- Unholy Blight

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

	-- Diseases
		{ "77575", "target.debuff(55095).duration < 2" }, -- Outbreak
		{ "77575", "target.debuff(55078).duration < 2" }, -- Outbreak
		{ "45462", "target.debuff(55078).duration < 2", "target" }, -- Plague Strike
		{ "45477", "target.debuff(55095).duration < 2", "target" }, -- Icy Touch
		{ "48721", { -- Blood Boil // blod
			"player.runes(blood).count > 1",
			"target.debuff(55095).duration < 3", 
			"target.debuff(55078).duration <3" }},
		{ "48721", {  -- Blood Boil // death
			"player.runes(death).count > 1",
			"target.debuff(55095).duration < 3", 
			"target.debuff(55078).duration <3" }},

	-- Rotation
		{ "Soul Reaper", { "!target.debuff", "target.health < 35" } },
		{ "Death Coil", "player.runicpower > 90" },
		{ "Death and Decay", "player.runes(unholy) = 2", "target.ground" },
		{ "Scourge Strike", "player.runes(unholy) = 2" },
		{ "Fastering Strike", { "player.runes(unholy) = 2", "player.runes(blood) = 2" } },
		{ "Death Coil", "player.buff(Sudden Doom)" },
		{ "Scourge Strike" },
		{ "Festering Strike" },
		{ "Death Coil" },

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

local outcombat = {
  
	-- Buffs
		{ "48265", { "player.seal != 3", "toggle.run" }}, -- unholy
		{ "57330", "!player.buff(57330)" }, -- Horn of Winter
  
	-- Keybinds
		{ "Army of the Dead", "modifier.alt" },
		{ "Death Grip", "modifier.control" },
  
	-- Pet
		{ "Raise Dead", "!pet.exists" },

}

ProbablyEngine.rotation.register_custom(252, mts_Icon.."|r[|cff9482C9MTS|r][\124cffC41F3BDeathKnight-Unholy|r]", inCombat, outCombat, exeOnLoad)
