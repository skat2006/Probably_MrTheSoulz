--[[ ///---INFO---////
// DeathKnight Blood //
!Originaly made by PCMD!
Thank Your For Using My ProFiles
I Hope Your Enjoy Them
MTS
]]
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

local exeOnLoad = function()

	ProbablyEngine.toggle.create('autotarget', 'Interface\\Icons\\Ability_spy.png', 'Auto Target', 'Automatically target the nearest enemy when target dies or does not exist')
	ProbablyEngine.toggle.create("DRW", "Interface\\Icons\\INV_Sword_07", "Stop using Dancing Rune Weapon", "Toggle Off if you dont want to use DRW on CD")
	ProbablyEngine.toggle.create('defcd', 'Interface\\Icons\\Spell_deathknight_iceboundfortitude.png', 'Defensive Cooldowns & Heals', 'Enable or Disable Defensive & Healing Cooldowns.')
	ProbablyEngine.toggle.create('run', 'Interface\\Icons\\Inv_boots_plate_dungeonplate_c_05.png', 'Enable Unholy Presence Outside of Combat', 'Enable/Disable Unholy Presence Outside of Combat \nMakes you run/fly faster when outside of combat.')
	mtsStart:message("\124cff9482C9*MTS-\124cffC41F3BDeathKnight/Blood-\124cff9482C9Loaded*")

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

	-- buffs
		{ "48263", "player.seal != 1", nil }, -- Blood
		{ "49222", "!player.buff(49222)" }, -- bone shield

	--Auto target
		{ "/target [target=focustarget, harm, nodead]", "target.range > 40" },
		{ "/targetenemy [noexists]", { "toggle.autotarget", "!target.exists" }},
   		{ "/targetenemy [dead]", { "toggle.autotarget", "target.exists", "target.dead" }},

	-- Keybinds
		{ "42650", "modifier.alt" }, -- Army of the Dead
		{ "49576", "modifier.control" }, -- Death Grip
		{ "43265", {"modifier.shift", "@mtsLib.CanFireHack()"}, "target.ground" }, -- Death and Decay
		{ "43265", "modifier.shift", "target.ground" }, -- Death and Decay

	-- items
		{ "#5512", "player.health < 70"}, --healthstone

	-- Def cooldowns // heals
		{ "48792", { "toggle.defcd", "player.health <= 40" }, "player')" }, -- Icebound Fortitude
		{ "55233", { "toggle.defcd", "player.health <= 40" }}, -- Vampiric Blood
		{ "48743", { "toggle.defcd", "player.health <= 50" }}, -- Death Pact
		{ "49039", { "toggle.defcd", "player.state.fear", "player.runicpower >= 40", "player.spell.exists(49039)" }}, -- Lichborne //fear
		{ "49039", { "toggle.defcd", "player.state.sleep", "player.runicpower >= 40", "player.spell.exists(49039)" }}, -- Lichborne //sleep
		{ "49039", { "toggle.defcd", "player.state.charm", "player.runicpower >= 40", "player.spell.exists(49039)" }}, -- Lichborne //charm
		{ "48982", { "toggle.defcd", "player.health <= 60" }}, -- rune tap
		{ "108196", { "toggle.defcd","player.health < 60" }},-- Death Siphon

	-- Cooldowns
		--{ "61999", { "modifier.cooldowns", "player.health <= 30" }, "mouseover" }, -- Raise Ally
		{ "49028", { "modifier.cooldowns", "!toggle.DRW" }, "target" }, -- Dancing Rune Weapon
		{ "47568", { "modifier.cooldowns", "player.runes(death).count < 1", "player.runes(frost).count < 1", "player.runes(unholy).count < 1", "player.runicpower < 30" }}, -- Empower Rune Weapon
		{ "#gloves"},

	-- Aggro Control
		{ "62124", { "@mtsLib.ShouldTaunt('DkBloodTaunts')", "@mtsBossLib.bossTaunt", "target.threat < 100" }, "target" }, -- Boss // Dark Command
		{ "56222", { "@mtsLib.ShouldTaunt('DkBloodTaunts')", "mouseover.threat < 100", "@mtsLib.StopIfBoss" }, "mouseover" }, -- Dark Command / Mouse-Over
		{ "56222", { "@mtsLib.ShouldTaunt('DkBloodTaunts')", "target.threat < 100", "@mtsLib.StopIfBoss" }, "target" }, -- Dark Command
		{ "49576", { "@mtsLib.ShouldTaunt('DkBloodTaunts')", "mouseover.threat < 100", "@mtsLib.StopIfBoss" }, "mouseover" }, -- Death Grip / Mouse-Over
		{ "49576", { "@mtsLib.ShouldTaunt('DkBloodTaunts')", "target.threat < 100", "@mtsLib.StopIfBoss" }, "target" }, -- Death Grip

	-- Interrupts
		{ "47528", { "target.interruptsAt(50)", "modifier.interrupts" }, "target" }, -- Mind freeze
		{ "47476", { "target.interruptsAt(50)", "modifier.interrupts", "!player.modifier.last(47528)"}, "target" }, -- Strangulate
		{ "108194", { "target.interruptsAt(50)", "!modifier.last(47528)" }, "target" }, -- Asphyxiate

	-- Spell Steal
		{ "77606", DarkSimUnit('target'), "target" }, -- Dark Simulacrum
		{ "77606", DarkSimUnit('focus'), "focus" },  -- Dark Simulacrum

	-- Diseases
		{ "115989", "target.debuff(55095).duration < 2" }, -- Unholy Blight
		{ "115989", "target.debuff(55078).duration < 2" }, -- Unholy Blight
		{ "77575", "target.debuff(55095).duration < 2" }, -- Outbreak
		{ "77575", "target.debuff(55078).duration < 2" }, -- Outbreak
		{ "50842",	{"target.range <= 10", "modifier.last(77575)" }}, -- Blood Boil

	-- Multi-target
		{ "50842",	"UnitsAroundUnit(player, 10[, 5])"}, -- Blood Boil
		{ "50842",	{"modifier.multitarget","target.range <= 10" }}, -- Blood Boil

	-- Rotation
		{ "50842",	{"player.buff(Crimson Scourge)","target.range <= 10" }}, -- Blood Boil
		{ "47541", "player.runicpower >= 90", "target" }, -- Death Coil // Full runic
		{ "49998", { "player.buff(77513).duration <= 1" }, "target" }, -- Death Strike
		{ "114866", "target.health <= 35", "target" }, -- Soul Reaper
		{ "50842",	{ "target.range <= 10", "!target.health <= 35" }}, -- Blood Boil
		{ "50842",	{ "player.runes(blood).count = 1", "target.range <= 10", "target.health <= 35" }}, -- Blood Boil // at less then 35% health if SR is not available.
		{ "45462", "target.debuff(55078).duration < 2", "target" }, -- Plague Strike
		{ "45477", "target.debuff(55095).duration < 2", "target" }, -- Icy Touch
		{ "47541", "player.runicpower >= 30", "target" }, -- Death Coil

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

	-- Keybinds
		{ "42650", {"modifier.alt", "target.exits"} }, -- Army of the Dead
		{ "49576", "modifier.control" }, -- Death Grip
		{ "43265", {"modifier.shift", "@mtsLib.CanFireHack()"}, "target.ground" }, -- Death and Decay
		{ "43265", "modifier.shift", "target.ground" }, -- Death and Decay

	-- Buffs
		{ "48263", { "player.seal != 1 ", "!toggle.run" }}, -- blood
		{ "48265", { "player.seal != 3", "toggle.run" }}, -- unholy // moves faster out of combat...
		{ "49222", "!player.buff(49222)" }, -- bone shield
		{ "57330", "!player.buff(57330)" }, -- Horn of Winter

}

ProbablyEngine.rotation.register_custom(250, "|r[|cff9482C9MTS|r][|cffC41F3BDeathKnight-Blood|r]", inCombat, outCombat, exeOnLoad)

-- 55095 = Frost Fever
-- 55078 = Blood plague
-- 77513 = blood shield