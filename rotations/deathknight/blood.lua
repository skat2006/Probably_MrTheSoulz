--[[ ///---INFO---////
// DeathKnight Blood //
!Originaly made by PCMD!
Thank Your For Using My ProFiles
I Hope Your Enjoy Them
MTS
]]

local fetch = ProbablyEngine.interface.fetchKey

local exeOnLoad = function()

	ProbablyEngine.toggle.create("DRW", 
		"Interface\\Icons\\INV_Sword_07", 
		"Stop using Dancing Rune Weapon",
		"Toggle Off if you dont want to use DRW on CD")

end

local inCombat = {

	-- buffs
		{ "48263", "player.seal != 1", nil }, -- Blood
		{ "49222", "!player.buff(49222)" }, -- bone shield
		{ "57330", "!player.buff(57330)" }, -- Horn of Winter

	-- Keybinds
		{ "42650", "modifier.alt" }, -- Army of the Dead
		{ "49576", "modifier.control" }, -- Death Grip
		{ "43265", "modifier.shift", "target.ground" }, -- Death and Decay

	-- items
		{ "#5512", "player.health < 70"}, --healthstone

	-- Def cooldowns // heals
		{ "48792", (function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfDkBlood', 'IceboundFortitude')) end) }, -- Icebound Fortitude
		{ "55233", (function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfDkBlood', 'VampiricBlood')) end) }, -- Vampiric Blood
		{ "48743", (function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfDkBlood', 'DeathPact')) end) }, -- Death Pact
		{ "48982", (function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfDkBlood', 'RuneTap')) end) }, -- rune tap
		{ "108196", (function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfDkBlood', 'DeathSiphon')) end) },-- Death Siphon
		{ "49039", { "player.state.fear", "player.runicpower >= 40", "player.spell.exists(49039)" }}, -- Lichborne //fear
		{ "49039", { "player.state.sleep", "player.runicpower >= 40", "player.spell.exists(49039)" }}, -- Lichborne //sleep
		{ "49039", { "player.state.charm", "player.runicpower >= 40", "player.spell.exists(49039)" }}, -- Lichborne //charm
		
	-- Cooldowns
		{ "49028", { "modifier.cooldowns", "!toggle.DRW" }, "target" }, -- Dancing Rune Weapon
		{ "47568", { -- Empower Rune Weapon
			"modifier.cooldowns", 
			"player.runes(death).count < 1", 
			"player.runes(frost).count < 1", 
			"player.runes(unholy).count < 1", 
			"player.runicpower < 30" }}, 
		{ "115989", { "modifier.cooldowns","target.debuff(55095)" }}, -- Unholy Blight
		{ "115989", { "modifier.cooldowns","target.debuff(55078)" }}, -- Unholy Blight
		{ "#gloves"},

	-- Interrupts
		{ "47528", { "target.interruptsAt(50)", "modifier.interrupts" }, "target" }, -- Mind freeze
		{ "47476", { "target.interruptsAt(50)", "modifier.interrupts", "!player.modifier.last(47528)"}, "target" }, -- Strangulate
		{ "108194", { "target.interruptsAt(50)", "!modifier.last(47528)" }, "target" }, -- Asphyxiate

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
			"!modifier.last"}}, 

	-- Diseases
		{ "77575", "target.debuff(55095).duration < 2" }, -- Outbreak
		{ "77575", "target.debuff(55078).duration < 2" }, -- Outbreak
		{ "45462", "target.debuff(55078).duration < 2", "target" }, -- Plague Strike
		{ "45477", "target.debuff(55095).duration < 2", "target" }, -- Icy Touch
		{ "48721", { -- Blood Boil // blood
			"player.runes(blood).count > 1",
			"target.debuff(55095).duration < 3", 
			"target.debuff(55078).duration <3" }},
		{ "48721", {  -- Blood Boil // death
			"player.runes(death).count > 1",
			"target.debuff(55095).duration < 3", 
			"target.debuff(55078).duration <3" }},

	{{-- can use FH

		-- AoE smart
			{ "50842","player.area(10).enemies > 4"}, -- Blood Boil

	}, {"player.firehack", (function() return fetch('mtsconf','Firehack') end),}},

	-- AoE
		{ "50842",	{"modifier.multitarget","target.range <= 10" }}, -- Blood Boil

	-- Rotation
		{ "50842",	{"player.buff(Crimson Scourge)","target.range <= 10" }}, -- Blood Boil
		{ "47541", "player.runicpower >= 90", "target" }, -- Death Coil // Full runic
		{ "49998", { "player.buff(77513).duration <= 1" }, "target" }, -- Death Strike
		{ "114866", "target.health <= 35", "target" }, -- Soul Reaper
		{ "50842",	{ "target.range <= 10", "!target.health <= 35" }}, -- Blood Boil
		{ "50842",	{ "player.runes(blood).count = 1", "target.range <= 10", "target.health <= 35" }}, -- Blood Boil //35 % health if SR
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
		{ "43265", "modifier.shift", "target.ground" }, -- Death and Decay

	-- Buffs
		{ "48265", { -- unholy // moves faster out of combat...
			"player.seal != 3",
			(function() return fetch('mtsconfDkBlood','RunFaster') end)
			}},
		{ "49222", "!player.buff(49222)" }, -- bone shield
		{ "57330", "!player.buff(57330)" }, -- Horn of Winter

}

ProbablyEngine.rotation.register_custom(250, mts_Icon.."|r[|cff9482C9MTS|r][|cffC41F3BDeathKnight-Blood|r]", inCombat, outCombat, exeOnLoad)

-- 55095 = Frost Fever
-- 55078 = Blood plague
-- 77513 = blood shield