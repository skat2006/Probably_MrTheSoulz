--[[ ///---INFO---////
// Druid Guard //
Thank You For Using My ProFiles
I Hope Your Enjoy Them
MTS
]]

local exeOnLoad = function()

	ProbablyEngine.toggle.create('autotarget', 'Interface\\Icons\\Ability_spy.png', 'Auto Target', 'Automatically target the nearest enemy when target dies or does not exist')
	ProbablyEngine.toggle.create('cat', 'Interface\\Icons\\Ability_druid_prowl.png', 'Defensive Cooldowns', 'Enable or Disable out of combat feral & prowl.')
	mtsStart:message("\124cff9482C9*MrTheSoulz - \124cffFF7D0ADruid/Feral \124cff9482C9Loaded*")

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

  	--	keybinds
  		{ "Ursol's Vortex", {"modifier.shift", "@mtsLib.CanFireHack()"}, "mouseover.ground" }, -- Ursol's Vortex // FH
	  	{ "Ursol's Vortex", "modifier.shift", "mouseover.ground" }, -- Ursol's Vortex
	  	{ "Mighty Bash", "modifier.shift" },
	  	{ "132469", "modifier.alt" }, -- Typhoon
	  	{ "Mass Entanglement", "modifier.shift" },

	--Run fast
  		{ "1850", { "target.boss", "target.range >= 30" }}, -- dash

  	-- Cat
  		{ "/cancelaura Cat Form", { "player.form = 2", "!player.buff(1126)", "!player.buff(5212)" }},
		{ "1126", { "!player.buff(20217).any", "!player.buff(115921).any", "!player.buff(1126).any", "!player.buff(90363).any", "!player.buff(69378).any", "player.form = 0", "!player.buff(5212)" }}, -- Mark of the Wild
  		{ "768", { "player.form != 2", "!modifier.lalt", "player.buff(1126)", "!player.buff(5212)" }}, -- catform

  	-- Auto Target
		{ "/target [target=focustarget, harm, nodead]", "target.range > 40" },
		{ "/targetenemy [noexists]", { "toggle.autotarget", "!target.exists" }},
   		{ "/targetenemy [dead]", { "toggle.autotarget", "target.exists", "target.dead" }},

  	-- Survival
	  	{ "Renewal", "player.health <= 30" },
	  	{ "Cenarion Ward", "player.health <75" },
	  	{ "61336", "player.health <75" }, -- Survival Instincts
	  	{ "5185", { "player.buff(Predatory Swiftness)", "player.health <= 70" }}, -- Healing Touch

  	--Cooldowns
	  	{ "106737", { "player.spell(106737).charges > 2", "!modifier.last(106737)", "player.spell(106737).exists" }}, --Force of Nature
	  	{ "106951", "modifier.cooldowns" }, -- Beserk
	  	{ "124974", "modifier.cooldowns" }, -- Nature's Vigil
	  	{ "102543", "modifier.cooldowns" }, -- incarnation

  	--Interrupts
	  	{ "106839", { "target.casting", "modifier.interrupt" }, "target"},	-- Skull Bash
	  	{ "5211", "modifier.interrupt", "target" }, -- Mighty Bash

  	-- Buffs
		{ "52610", { "!player.buff(52610)", "player.combopoints = 0", "!player.combat", "target.enemy" }, "target"}, -- Savage Roar
		{ "52610", { "player.buff(52610).duration < 5", "player.combopoints = 5" }, "target"}, -- Savage Roar
		{ "52610", { "player.buff(52610).duration < 3", "player.combopoints >= 2" }, "target"}, -- Savage Roar
		{ "770", { "!target.debuff(770)", "!player.spell(106707).exists" }, "target" }, -- Faerie Fire
		--{ "102355", { "!target.debuff(102355)", "player.spell(106707).exists" }, "target" }, -- Faerie swarm
		{ "5217", "player.energy <= 35"}, -- Tiger's Fury

	-- Proc's
  		{ "106830", "player.buff(Omen of Clarity)", "target" }, -- Free Thrash

	-- dots
		{ "1822", "target.debuff(Rake).duration <= 4", "target" }, -- Rake
		{ "1079", { "target.health < 25", "!target.debuff(1079)", "player.combopoints = 5" }, "target"},-- Rip // bellow 25% if target does not have debuff

	-- AoE
		{ "106830", { "modifier.multitarget", "target.debuff(106830).duration <= 1.5", "modifier.multitarget" }, "target" }, -- Tharsh
		{ "106785", { "player.area(8).enemies > 11", "modifier.multitarget", "@mtsLib.CanFireHack()" }}, -- Swipe // FireHack
		{ "106785", { "modifier.multitarget", "modifier.multitarget" }}, -- Swipe

	-- rotation
	    { "1822", "target.debuff(Rake).duration <= 4", "target" }, -- Rake 
	    { "22568", { "target.health < 25", "target.debuff(1079).duration < 5" }, "target"}, -- Ferocious Bite to refresh Rip when target at <= 25% health.
	    { "1079", { "target.health > 25", "target.debuff(1079).duration < 5", "player.combopoints = 5" }, "target"},-- Rip
	    { "22568", { "target.debuff(1079)", "target.health < 30", "player.combopoints = 5" }, "target"},-- Ferocious Bite // Target Health is less then 25%
	    { "22568", { "player.combopoints = 5", "target.debuff(1079).duration > 5", "player.buff(Savage Roar).duration > 5" }, "target"}, -- Ferocious Bite // Max Combo and Rip or Savage do not need refreshed
	      	
	    -- Shred // Combo Point Building Rotation
	    	{ "5221", {"player.buff(Clearcasting)"}, "target"  }, -- Shred
	    	{ "5221", {"player.buff(Berserk)"}, "target"  }, -- Shred 
	    	{ "5221", {"player.combopoints < 5","player.behind"}, "target" }, -- Shred
  
}

local outCombat = {
	
	--	keybinds
	  	{ "Ursol's Vortex", {"modifier.shift", "@mtsLib.CanFireHack()"}, "mouseover.ground" }, -- Ursol's Vortex // FH
	  	{ "Ursol's Vortex", "modifier.shift", "mouseover.ground" }, -- Ursol's Vortex
	  	{ "Disorienting Roar", "modifier.shift" },
	  	{ "Mighty Bash", "modifier.shift" },
	  	{ "Typhoon", "modifier.alt" },
	  	{ "Mass Entanglement", "modifier.shift" },

	-- buff
		{ "/cancelaura Cat Form", { "player.form = 2", "!player.buff(1126)" }},
		{ "1126", { "!player.buff(20217).any", "!player.buff(115921).any", "!player.buff(1126).any", "!player.buff(90363).any", "!player.buff(69378).any", "player.form = 0" }}, -- Mark of the Wild

}

ProbablyEngine.rotation.register_custom(103, "|r[|cff9482C9MTS|r][|cffFF7D0ADruid-Feral|r]", inCombat, outCombat, exeOnLoad)


