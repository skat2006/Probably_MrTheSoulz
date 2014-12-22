local fetch = ProbablyEngine.interface.fetchKey

local exeOnLoad = function()
mts_Splash("|cff9482C9[MTS]-|cffFFFFFF"..(select(2, GetSpecializationInfo(GetSpecialization())) or "Error").."-|cff9482C9Loaded", 5.0)

	
end

local inCombat = {

	{{-- rake // prowl with glyph
		{ "1822", {
			"player.buff(5215)", -- prowl
			"player.glyph(127540)" -- Savage Roar
		}, "target" },
	}, (function() return mts_infront('target') end) },

  	--	keybinds
  		{{ -- Shift
  			{ "106839", { -- Skull Bash
  				"target.exists",
  				"target.range <= 13"
  			}, "target" },
		  	{ "Mighty Bash", {
  				"target.exists",
  				"target.range <= 13"
  			}, "target" },
		  	{ "77764", "modifier.party" }, -- Stampending Roar
		  	{ "1850" } -- Dash
	  	}, "modifier.shift" },
	  	{{-- Control
	  		{ "Mass Entanglement" },
	  		{ "Ursol's Vortex", "target.exists", "mouseover.ground" }, -- Ursol's Vortex
	  		{ "339" }, -- Entangling Roots
	  	}, "modifier.control" },
	  	{ "Typhoon", { 
	  		"modifier.alt", 
	  		"target.exists"
	  	}, "target" },

  	-- Survival
	  	{ "Renewal", (function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfDruidFeral', 'Renewal')) end) }, -- Renewal
	  	{ "Cenarion Ward", (function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfDruidFeral', 'CenarionWard')) end) }, -- Cenarion Ward
	  	{ "61336",(function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfDruidFeral', 'SurvivalInstincts')) end) }, -- Survival Instincts
	  	
	-- Predatory Swiftness (Passive Proc)
	  	{ "5185", {  -- Healing Touch Player
	  		(function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfDruidFeral', 'HealingTouch')) end),
	  		"player.buff(Predatory Swiftness)" 
	  	}, "player" },
	  	{ "5185", {  -- Healing Touch Lowest
	  		"lowest.health < 70",
	  		"player.buff(Predatory Swiftness)" 
	  	}, "lowest" },
	  	{ "5185", {  -- Healing Touch Lowest (BooldTalons TALENT)
	  		"talent(7,2)",
	  		"player.buff(Predatory Swiftness)"
	  	}, "lowest" },

  	{{--Interrupts
	  	{ "106839", "modifier.interrupt", "target"},	-- Skull Bash
		{ "5211", "modifier.interrupt", "target" }, 	-- Mighty Bash
	}, (function() return mts_infront('target') end) },

  	--Cooldowns
	  	{ "106737", {  --Force of Nature
	  		"player.spell(106737).charges > 2", 
	  		"!modifier.last(106737)", 
	  		"player.spell(106737).exists" 
	  	} --[[NO TARGET]] },
	  	{ "106951", "modifier.cooldowns" }, -- Beserk
	  	{ "124974", "modifier.cooldowns" }, -- Nature's Vigil
	  	{ "102543", "modifier.cooldowns" }, -- incarnation
  	
	-- buffs
		{ "5217", (function() return mts_dynamicEval("player.energy <= " .. fetch('mtsconfDruidFeral', 'TigersFury')) end) }, -- Tiger's Fury

	{{-- Main CR
		-- Proc's
	  		{ "106830", "player.buff(Omen of Clarity)", "target" }, -- Free Thrash

	  	-- Finish
	  		{ "52610", { -- Savage Roar
	  			"player.buff(52610).duration <= 4", -- Savage Roar
	  			"player.buff(174544).duration <= 4", -- Savage Roar GLYPH
	  			"player.combopoints <= 2" 
	  		}, "target"},
	  		{ "22568", { -- Ferocious Bite to refresh Rip when target at <= 25% health.
			    "target.health < 25", 
			    "target.debuff(1079).duration < 5", -- RIP
			    "player.combopoints = 5"
			}, "target"},
		  	{ "1079", { -- Rip // bellow 25% if target does not have debuff
				"target.health < 25", 
				"!target.debuff(1079)", -- stop if target as rip debuff
				"player.combopoints = 5" 
			}, "target"},
			{ "1079", { -- Rip // more then 25% to refresh
				"target.health > 25", 
				"target.debuff(1079).duration <= 7", 
				"player.combopoints = 5" 
			}, "target"},
			{ "22568", { -- Ferocious Bite // Max Combo and Rip or Savage Roar do not need refreshed
			   	"player.combopoints = 5", 
			    "target.debuff(1079).duration > 7", -- RIP
			    "player.buff(52610).duration > 4" -- Savage Roar GLYPH
			}, "target"},
			{ "22568", { -- Ferocious Bite // Max Combo and Rip or Savage Roar GLYPH do not need refreshed
			   	"player.combopoints = 5", 
			    "target.debuff(1079).duration > 7", -- RIP
			    "player.buff(174544).duration > 4" -- Savage Roar GLYPH
			}, "target"},

	  	-- AOE
	  			{{-- AoE FALLBACK
					{ "106830", "target.debuff(106830).duration < 5", "target" }, -- Tharsh
					{ "106785" }, -- Swipe
				}, "modifier.multitarget" },
	  			{{ -- Smart AoE
					{ "106830", { -- Tharsh
						"player.area(8).enemies >= 3", 
						"target.debuff(106830).duration < 5"
					}, "target" },
					{ "106785", "player.area(8).enemies >= 3" },-- Swipe // FireHack
				}, (function() return fetch('mtsconf','Firehack') end) },

	  	-- Single Rotation
	  		{ "1822", "target.debuff(155722).duration <= 4", "target" }, -- rake
	  		{ "155625", { -- MoonFire // Lunar Inspiration (TALENT)
	  			"target.debuff(155625).duration <= 4",
	  			"talent(7, 1)"
	  		}, "target" },

	  		-- Shred // Combo Point Building Rotation
		    	{ "5221", "player.buff(Clearcasting)", "target"  }, -- Shred
		    	{ "5221", "player.buff(Berserk)", "target"  }, -- Shred 
		    	{ "5221", "player.combopoints < 5", "target" }, -- Shred
	}, 
	{
		(function() return mts_infront('target') end)},
		"target.range <= 8"
	},
  
}

local inCombatNoForm = {
	
	{ "768", { -- catform
  		"player.form != 2", -- Stop if cat
  		"!modifier.lalt", -- Stop if pressing left alt
  		"!player.buff(5215)", -- Not in Stealth
  		(function() return fetch('mtsconfDruidFeral','Form') == Cat end),
  	} --[[NO TARGET]] },
  	{ "787", { -- Travel
  		"player.form != 3", -- Stop if cat
  		"!modifier.lalt", -- Stop if pressing left alt
  		"!player.buff(5215)", -- Not in Stealth
  		(function() return fetch('mtsconfDruidFeral','Form') == Travel end),
  	} --[[NO TARGET]] },
  	{ "5487", { -- catform
  		"player.form != 1", -- Stop if cat
  		"!modifier.lalt", -- Stop if pressing left alt
  		"!player.buff(5215)", -- Not in Stealth
  		(function() return fetch('mtsconfDruidFeral','Form') == Bear end),
  	} --[[NO TARGET]] },

}

local outCombat = {
	
	{ "768", { -- catform
  		"player.form != 2", -- Stop if cat
  		"!modifier.lalt", -- Stop if pressing left alt
  		"!player.buff(5215)", -- Not in Stealth
  		(function() return fetch('mtsconfDruidFeral','FormOCC') == Cat end),
  	} --[[NO TARGET]] },
  	{ "787", { -- Travel
  		"player.form != 3", -- Stop if cat
  		"!modifier.lalt", -- Stop if pressing left alt
  		"!player.buff(5215)", -- Not in Stealth
  		(function() return fetch('mtsconfDruidFeral','FormOCC') == Travel end),
  	} --[[NO TARGET]] },
  	{ "5487", { -- catform
  		"player.form != 1", -- Stop if cat
  		"!modifier.lalt", -- Stop if pressing left alt
  		"!player.buff(5215)", -- Not in Stealth
  		(function() return fetch('mtsconfDruidFeral','FormOCC') == Bear end),
  	} --[[NO TARGET]] },

  	{ "5215", { -- Stealth
  		"player.form = 2", -- If cat
  		"!player.buff(5215)", -- Not in Stealth
  		(function() return fetch('mtsconfDruidFeral','Prowl') end),
  	} --[[NO TARGET]] },

	-- buff
		-- Cat && MotW
		{ "1126", {  -- Mark of the Wild
			"!player.buff(20217).any", -- kings
			"!player.buff(115921).any", -- Legacy of the Emperor
			"!player.buff(1126).any",   -- Mark of the Wild
			"!player.buff(90363).any",  -- embrace of the Shale Spider
			"!player.buff(69378).any",  -- Blessing of Forgotten Kings
			"!player.buff(5215)",-- Not in Stealth
			"player.form = 0", -- Player not in form
			(function() return fetch('mtsconfDruidFeral','Buffs') end),
		} --[[NO TARGET]] },

	--	keybinds
	  	{ "Ursol's Vortex", {"modifier.shift", "target.exists"}, "mouseover.ground" }, -- Ursol's Vortex
	  	{ "Disorienting Roar", "modifier.shift" },
	  	{ "Mighty Bash", {"modifier.control", "target.exists"}, "target" },
	  	{ "Typhoon", {"modifier.alt", "target.exists"}, "target" },
	  	{ "Mass Entanglement", "modifier.shift" },

}

ProbablyEngine.rotation.register_custom(103, mts_Icon.."|r[|cff9482C9MTS|r][|cffFF7D0ADruid-Feral|r]", 
		{ -- Change CR Dyn
			{inCombat, "player.form = 2"},
			{inCombatNoForm, "player.form = 0"}
		}, 
	outCombat, exeOnLoad)