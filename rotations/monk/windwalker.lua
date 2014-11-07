--[[ ///---INFO---////
// Monk WindWalker //
!Originaly made by Tao!
Thank You For Using My ProFiles
I Hope Your Enjoy Them
MTS
]]

local n,r = GetSpellInfo(137639)

local exeOnLoad = function()

	ProbablyEngine.toggle.create('autotarget', 'Interface\\Icons\\ability_hunter_snipershot', 'Auto Target', 'Automatically target the nearest enemy when target dies or does not exist')
	ProbablyEngine.toggle.create('autosef', 'Interface\\Icons\\spell_sandstorm', 'Auto SEF', 'Automatically cast SEF on mouseover targets')
	mtsStart:message("\124cff9482C9*MTS-\124cff00FF96Monk/WW\124cff9482C9-Loaded*")
	ProbablyEngine.toggle.create( 'GUI', 'Interface\\AddOns\\Probably_MrTheSoulz\\media\\toggle.blp:36:36"', 'Open/Close GUIs','Toggle GUIs', (function() mts_ClassGUI() mts_ConfigGUI() end) )     mts_showLive()
	
end

local inCombat = {

	-- Keybinds
		{ "pause", "modifier.shift" },
		{ "Leg Sweep", "modifier.control" }, -- Leg Sweep
		{ "Touch of Karma", "modifier.alt" }, -- Touch of Karma

	-- SEF on mouseover // Needs Futher Logic...
  		{ "137639",  {"toggle.autosef","!mouseover.debuff(138130)","!player.buff(137639).count = 2", "@mtsLib.mouseNotEqualTarget()"} , "mouseover" },
  		{ "/cancelaura "..n, { "target.debuff(Storm, Earth, and Fire)", "toggle.autosef" }, "target"},

	-- Auto Target
		{ "/target [target=focustarget, harm, nodead]", {"target.range > 40", "!target.exists","toggle.autotarget"} },
		{ "/targetenemy [noexists]", { "toggle.autotarget", "!target.exists" }},
   		{ "/targetenemy [dead]", { "toggle.autotarget", "target.exists", "target.dead" }},

	-- Survival
		{ "Expel Harm", { "player.health <= 80", "player.chi < 4" }},
		{ "115098", "player.health <= 75" }, -- Chi Wave
		{ "115203", { -- Forifying Brew at < 30% health and when DM & DH buff is not up
		  "player.health < 30",
		  "!player.buff(Diffuse Magic)", --DM
		  "!player.buff(Dampen Harm)"}}, --DH
		{ "#5512", "player.health < 40" }, -- Healthstone

	-- Interrupts
	  	{ "115078", { -- Paralysis when SHS, and Quaking Palm are all on CD
	     	"!target.debuff(Spear Hand Strike)",
	     	"player.spell(Spear Hand Strike).cooldown > 0",
	     	"player.spell(Quaking Palm).cooldown > 0",
	     	"!modifier.last(Spear Hand Strike)",
	     	"target.interruptsAt(50)", 
	     	"modifier.interrupts"}},
	  	{ "Ring of Peace", { -- Ring of Peace when SHS is on CD
	     	"!target.debuff(Spear Hand Strike)",
	     	"player.spell(Spear Hand Strike).cooldown > 0",
	     	"!modifier.last(Spear Hand Strike)",
	     	"target.interruptsAt(50)", 
	     	"modifier.interrupts"}},
	  	{ "Leg Sweep", { -- Leg Sweep when SHS is on CD
	     	"player.spell(116705).cooldown > 0",
	     	"target.range <= 5",
	     	"!modifier.last(116705)",
	     	"target.interruptsAt(50)", 
	     	"modifier.interrupts"}},
	  	{ "Charging Ox Wave", { -- Charging Ox Wave when SHS is on CD
	     	"player.spell(116705).cooldown > 0",
	     	"target.range <= 30",
	     	"!modifier.last(116705)",
	     	"target.interruptsAt(50)", 
	     	"modifier.interrupts"}},
	  	{ "Quaking Palm", { -- Quaking Palm when SHS is on CD
	     	"!target.debuff(Spear Hand Strike)",
	     	"player.spell(Spear Hand Strike).cooldown > 0",
	     	"!modifier.last(Spear Hand Strike)",
	     	"target.interruptsAt(50)",
	     	"modifier.interrupts"}},
	  	{ "Spear Hand Strike", {"target.interruptsAt(50)", "modifier.interrupts"} }, -- Spear Hand Strike

	-- Cooldowns
		{ "115288", {"player.energy <= 30","modifier.cooldowns"} }, -- Energizing Brew
		{ "123904", "modifier.cooldowns" }, -- Invoke Xuen, the White Tiger

	-- FREEDOOM!
		{ "Nimble Brew", "player.state.disorient" }, -- Nimble Brew = Nimble Brew
		{ "Nimble Brew", "player.state.fear" },
		{ "Nimble Brew", "player.state.stun" },
		{ "Nimble Brew", "player.state.root" },
		{ "Nimble Brew", "player.state.horror" },
		{ "Nimble Brew", "player.state.snare" },
		{ "Tiger's Lust", "player.state.disorient" }, -- Tiger's Lust = Tiger's Lust
		{ "Tiger's Lust", "player.state.stun" },
		{ "Tiger's Lust", "player.state.root" },
		{ "Tiger's Lust", "player.state.snare" },

	-- Ranged
		{ "Tiger's Lust", { "target.range >= 15", "player.moving" }},-- Tiger's Lust if the target is at least 15 yards away and we are moving
		{ "Zen Sphere", {"!target.debuff(Zen Sphere)","target.range >= 15"} }, -- 40 yard range!
		{ "115098", "target.range >= 15" }, -- Chi Wave (40yrd range!)
		{ "Chi Burst", "target.range >= 15" }, -- Chi Burst (40yrd range!)
		{ "117952", { "target.range > 5", "target.range <= 40", "!player.moving" }}, -- Crackling Jade Lightning
		{ "Expel Harm", {"player.chi < 4", "target.range >= 15"} }, -- Expel Harm
		

	-- buffs
		{ "115080", "player.buff(Death Note)" }, -- Touch of Death
		{ "116740", {"player.buff(125195).count >= 10", "!player.buff(116740)"} }, -- Tigereye Brew

	-- Procs
		{ "100784", "player.buff(116768)"},-- Blackout Kick w/tCombo Breaker: Blackout Kick
		{ "100787", "player.buff(118864)"}, -- Tiger Palm w/t Combo Breaker: Tiger Palm

	-- Rotation
		{ "107428", "target.debuff(130320).duration < 3" }, -- Rising Sun Kick
		{ "113656", "!player.moving" },-- Fists of Fury

		{{-- can use FH

			-- AoE smart
				{ "101546","player.area(8).enemies >= 3"}, -- Spinning Crane Kick // FH Smarth

		}, {"player.firehack", "@mtsLib.getConfig('mtsconf_Firehack')"}},
			
		-- AoE
			{ "101546", "modifier.multitarget" }, -- Spinning Crane Kick

		{ "100784", "player.chi >= 3" }, -- Blackout Kick
		{ "100787", "!player.buff(125359)"}, -- Tiger Palm if not w/t Tiger Power
		{ "115698", "player.chi <= 3" }, -- Jab
		  
}

local outCombat = {

 	{ "116781", { -- Legacy of the White Tiger
	  	"!player.buff(Legacy of the White Tiger).any",
	  	"!player.buff(Leader of the Pack).any",
	  	"!player.buff(Arcane Brilliance).any",
	  	"!player.buff(Dalaran Brilliance).any",
	  	"!player.buff(Bellowing Roar).any",
	  	"!player.buff(Furious Howl).any",
	  	"!player.buff(Terrifying Roar).any",
	  	"!player.buff(Fearless Roar).any",
	  	"!player.buff(Still Water).any"}},
  	{ "Legacy of the Emperor", {
  		"!player.buff(Legacy of the Emperor).any",
  		"!player.buff(Mark of the Wild).any",
  		"!player.buff(Blessing of Kings).any",
  		"!player.buff(Embrace of the Shale Spider).any",
  		"!player.buff(Blessing of the Forgotten Kings).any"}}
  
}

ProbablyEngine.rotation.register_custom(269, mts_Icon.."|r[|cff9482C9MTS|r][|cff00FF96Monk-WindWalker|r]", inCombat, outCombat, exeOnLoad)
