local fetch = ProbablyEngine.interface.fetchKey

local lib = function()

end

local inCombat = {
	
	-- SPECIAL
		{ "!53351", "@mtsLib.KillShot" },--Kill Shot
	
	-- Interrumpt
		{ "147362", "target.interruptAt(50)", "target" }, -- Counter Shot

	-- PET
		{ "34477", { -- Misdirect on [[ Focus ]]
			"focus.exists", 
			"!player.buff(35079)", 
			"target.threat > 60" 
		}, "focus" },
		{ "34477", { -- Misdirect on [[ Pet ]]
			"pet.exists", 
			"!pet.dead", 
			"!player.buff(35079)", 
			"!focus.exists", 
			"target.threat > 85" 
		}, "pet" },
		{{	-- Master's Call when stuck
		    { "53271", "player.state.stun" }, -- Use when Stunned
		    { "53271", "player.state.root" }, -- Use when Rooted
		    { "53271", "player.state.snare" }, -- Use when Snared
		}, "!talent(7,3)" },
		{ "136", {  -- Mend Pet
			"pet.health <= 95", 
			"pet.exists", 
			"!pet.dead", 
			"!pet.buff(136)", 
			"!talent(7,3)" 
		} --[[  No Target  ]] },
		{ "!/cast [@pet,dead] Revive Pet; Call Pet 1", {
			"!pet.alive",
			"toggle.resspet"
		}, "!talent(7,3)" },

	{{ -- Cooldowns
      { "Stampede", "player.buff(Rapid Fire)" },
      { "Lifeblood" },
      { "Berserking" },
      { "Blood Fury" },
      { "Bear Hug" },
    }, "modifier.cooldowns" },

    -- Items
    	--{ "#trinket1" },
      	--{ "#trinket2" },

	-- Survival
		{ "Deterrence", "player.health <= 25" }, -- Deterrence as a last resort!
		{ "#5512", "player.health < 40" }, -- Healthstone
	
	-- Keybinds / Traps
		{ "82939", "modifier.lshift", "target.ground" }, -- Explosive Trap
	  	{ "82941", "modifier.lshift", "target.ground" }, -- Ice Trap
		{ "19386", "modifier.lalt", "mouseover" }, -- Wyvern Sting	
		{ "60192", "modifier.lalt", "mouseover.ground" }, -- Freeze Trap
		{ "77769", "!player.buff(77769)" }, -- Trap Launcher
	
  	-- Aggro
  		{ "5384", "player.aggro >= 100" }, -- Feign Death
		{ "pause", "player.buff(5384)" }, -- Pause for Feign Death

	-- AoE	
		{{-- Smart AoE [[ Firehack ]]
			{ "2643", "player.area(35).enemies > 4", "target" }, -- Multi-Shot
			{ "Barrage" },
		}, (function() return fetch('mtsconf','Firehack') end) },
		{{-- Fallback Aoe
			{ "2643", "player.area(35).enemies > 4", "target" }, -- Multi-Shot
			{ "Barrage" },
		}, "modifier.multitarget" },

	-- SINGLE TARGET
	    {{-- Careful Aim // 80% heaçth
			{ "Aimed Shot" },
			{ "Focusing Shot", "player.timetomax > 4" },
			{ "Steady Shot" },
		}, "target.health >= 80" },
		{{-- Careful Aim // Buff Rapid Fire
			{ "Aimed Shot" },
			{ "Focusing Shot", "player.timetomax > 4" },
			{ "Steady Shot" },
		}, "player.buff(Rapid Fire)" },
		{ "A Murder of Crows" },
	    { "Dire Beast", "player.timetomax > 3" },
	    { "Glaive Toss" },
	    { "Powershot", "player.timetomax > 2.5" },
	    { "Barrage" },
	    { "Steady Shot", "player.timetomax > player.spell(Rapid Fire).cooldown" },
	    { "Focusing Shot", { "player.focus < 50" }},
	    { "Steady Shot", { "player.buff(Steady Focus)", "player.timetomax > 5" }},
	    { "Aimed Shot", "player.spell(Focusing Shot).exists" },
	    { "Aimed Shot", "player.focus > 80" },
	    { "Aimed Shot", { "player.buff(34720)", "player.focus > 60" }},
	    { "Focusing Shot", "player.focus < 50" },
	    { "Steady Shot" },

}


local outCombat = {
---------------------------------------------------------------------------------------------------------------------------------------
-- OUT-OF-COMBAT -- -------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------
	
	{ "136", {  -- Mend Pet
		"pet.health <= 95", 
		"pet.exists", 
		"!pet.dead", 
		"!pet.buff(136)", 
		"!talent(7,3)" }},
	
	
	-- Keybinds / Traps
	{ "19386", "modifier.lalt", "mouseover" }, -- Wyvern Sting	
	{ "60192", "modifier.lalt", "mouseover.ground" }, -- Freeze Trap
	{ "77769", "!player.buff(77769)" }, -- Trap Launcher	
		
		
---------------------------------------------------------------------------------------------------------------------------------------
-- OUT-OF-COMBAT ENDS -- --------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------		
}


ProbablyEngine.rotation.register_custom(
	254, 
	mts_Icon.."|cffABD473Marksman|r", 
	inCombat, outCombat, lib)