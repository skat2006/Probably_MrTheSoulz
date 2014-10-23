--[[ ///---INFO---////
// Druid Guard //
Thank You For Using My ProFiles
I Hope Your Enjoy Them
MTS
]]

local exeOnLoad = function()

	ProbablyEngine.toggle.create('autotarget', 'Interface\\Icons\\Ability_spy.png', 'Auto Target', 'Automatically target the nearest enemy when target dies or does not exist')
	ProbablyEngine.toggle.create('cat', 'Interface\\Icons\\Ability_druid_prowl.png', 'Cat & Hide & Buff', 'Enable or Disable out of combat feral & prowl.\nIf Disabled also disables incombat buffing.')
	mtsStart:message("\124cff9482C9*MTS-\124cffFF7D0ADruid/Feral-\124cff9482C9Loaded*")

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
  		{ "Ursol's Vortex", {"modifier.shift", "target.exists"}, "mouseover.ground" }, -- Ursol's Vortex
	  	{ "Disorienting Roar", "modifier.shift" },
	  	{ "Mighty Bash", {"modifier.shift", "target.exists"}, "target" },
	  	{ "Typhoon", {"modifier.alt", "target.exists"}, "target" },
	  	{ "Mass Entanglement", "modifier.shift" },

  	-- Auto Target
		{ "/target [target=focustarget, harm, nodead]", {"target.range > 40", "!target.exists","toggle.autotarget"} },
		{ "/targetenemy [noexists]", { "toggle.autotarget", "!target.exists" }},
   		{ "/targetenemy [dead]", { "toggle.autotarget", "target.exists", "target.dead" }},

  	-- Survival
	  	{ "Renewal", "player.health <= 30" },
	  	{ "Cenarion Ward", "player.health <75" },
	  	{ "61336", "player.health <75" }, -- Survival Instincts
	  	{ "5185", { "player.buff(Predatory Swiftness)", "player.health <= 70" }}, -- Healing Touch

  	--Interrupts
	  	{ "106839", { "target.casting", "modifier.interrupt" }, "target"},	-- Skull Bash
	  	{ "5211", "modifier.interrupt", "target" }, -- Mighty Bash

  	{{-- Cat && MotW
  		{ "/cancelaura Cat Form", { -- Cancel player form
  			"player.form > 0",  -- Is in any fom
  			"!player.buff(1126)", -- DOes not have Mark of the Wild
  			"!player.buff(5215)" }},-- Not in Stealth
		{ "1126", {  -- Mark of the Wild
			"!player.buff(20217).any", -- kings
			"!player.buff(115921).any", -- Legacy of the Emperor
			"!player.buff(1126).any",   -- Mark of the Wild
			"!player.buff(90363).any",  -- embrace of the Shale Spider
			"!player.buff(69378).any",  -- Blessing of Forgotten Kings
			"!player.buff(5215)",-- Not in Stealth
			"player.form = 0" }}, -- Player not in form
  		{ "768", { -- catform
  			"player.form != 2", -- Stop if cat
  			"!modifier.lalt", -- Stop if pressing left alt
  			"player.buff(1126)", -- Player has Mark of the Wild 
  			"!player.buff(5215)"}}, -- Not in Stealth
  	},"toggle.cat"},

  	-- buffs
  		{ "52610", { "!player.buff(174544)", "player.combopoints = 5" }, "target"}, -- Savage Roar
  		{ "770", { "!target.debuff(770)", "!player.spell(106707).exists" }, "target", "!player.buff(5215)" }, -- Faerie Fire
		{ "5217", "player.energy <= 35"}, -- Tiger's Fury

  	--Cooldowns
	  	{ "106737", { "player.spell(106737).charges > 2", "!modifier.last(106737)", "player.spell(106737).exists" }}, --Force of Nature
	  	{ "106951", "modifier.cooldowns" }, -- Beserk
	  	{ "124974", "modifier.cooldowns" }, -- Nature's Vigil
	  	{ "102543", "modifier.cooldowns" }, -- incarnation
  	
	-- Proc's
  		{ "106830", "player.buff(Omen of Clarity)", "target" }, -- Free Thrash

	-- dots
		{ "1822", "target.debuff(155722).duration <= 4", "target" }, -- 
		{ "1079", { -- Rip // bellow 25% if target does not have debuff
			"target.health < 25", 
			"!target.debuff(1079)", -- stop if target as rip debuff
			"player.combopoints = 5" }, "target"},
		{ "1079", { -- Rip
			"target.health > 25", 
			"target.debuff(1079).duration <= 7", 
			"player.combopoints = 5" }, "target"},
		{ "106830", {  -- Tharsh
			"target.debuff(106830).duration <= 1.5", 
			"modifier.multitarget" }, "target" },

	-- AoE
		{ "106785", { "player.area(8).enemies > 11", "modifier.multitarget", "@mtsLib.CanFireHack()" }}, -- Swipe // FireHack
		{ "106785", { "modifier.multitarget", "modifier.multitarget" }}, -- Swipe

	-- rotation
	    { "22568", { "target.health < 25", "target.debuff(1079).duration < 5" }, "target"}, -- Ferocious Bite to refresh Rip when target at <= 25% health.
	    { "22568", { "target.debuff(1079)", "target.health < 30", "player.combopoints = 5" }, "target"},-- Ferocious Bite // Target Health is less then 25%
	    { "22568", { "player.combopoints = 5", "target.debuff(1079).duration > 5", "player.buff(174544).duration > 5" }, "target"}, -- Ferocious Bite // Max Combo and Rip or Savage do not need refreshed
	      	
	    -- Shred // Combo Point Building Rotation
	    	{ "5221", "player.buff(Clearcasting)", "target"  }, -- Shred
	    	{ "5221", "player.buff(Berserk)", "target"  }, -- Shred 
	    	{ "5221", "player.combopoints < 5", "target" }, -- Shred
  
}

local outCombat = {
	
	--	keybinds
	  	{ "Ursol's Vortex", {"modifier.shift", "target.exists"}, "mouseover.ground" }, -- Ursol's Vortex
	  	{ "Disorienting Roar", "modifier.shift" },
	  	{ "Mighty Bash", {"modifier.shift", "target.exists"}, "target" },
	  	{ "Typhoon", {"modifier.alt", "target.exists"}, "target" },
	  	{ "Mass Entanglement", "modifier.shift" },

	-- buff
		{ "/cancelaura Cat Form", { -- Cancel player form
  			"player.form > 0",  -- Is in any fom
  			"!player.buff(1126)", -- DOes not have Mark of the Wild
  			"!player.buff(5215)" }},-- Not in Stealth
		{ "1126", {  -- Mark of the Wild
			"!player.buff(20217).any", -- kings
			"!player.buff(115921).any", -- Legacy of the Emperor
			"!player.buff(1126).any",   -- Mark of the Wild
			"!player.buff(90363).any",  -- embrace of the Shale Spider
			"!player.buff(69378).any",  -- Blessing of Forgotten Kings
			"!player.buff(5215)",-- Not in Stealth
			"player.form = 0" }}, -- Player not in form
		{ "768", { -- catform
  			"player.form != 2", -- Stop if cat
  			"!modifier.lalt", -- Stop if pressing left alt
  			"player.buff(1126)", -- Player has Mark of the Wild 
  			"!player.buff(5215)", -- Not in Stealth
  			"toggle.cat"}}, -- Toggle cat is active
  		{ "5215", { -- Stealth
  			"player.form = 2", -- If cat
  			"!player.buff(5215)", -- Not in Stealth
  			"toggle.cat"}}, -- Toggle cat is active

}

ProbablyEngine.rotation.register_custom(103, "|r[|cff9482C9MTS|r][|cffFF7D0ADruid-Feral|r]", inCombat, outCombat, exeOnLoad)


