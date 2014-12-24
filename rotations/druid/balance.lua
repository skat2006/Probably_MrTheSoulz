local fetch = ProbablyEngine.interface.fetchKey

local exeOnLoad = function()
mts_Splash("|cff9482C9[MTS]-|cffFFFFFF"..(select(2, GetSpecializationInfo(GetSpecialization())) or "Error").."-|cff9482C9Loaded", 5.0)

  ProbablyEngine.toggle.create(
	'dotEverything', 
	'Interface\\Icons\\Ability_creature_cursed_05.png', 
	'Dot All The Things!', 
	'Click here to dot all the things!\nSome Spells require Multitarget enabled also.\nOnly Works if using FireHack.')
	
end

local BoomkinForm = {
			
	-- Interrupts
		{ "78675", "target.interruptsAt(50)" }, -- Solar Beam
	
	-- Items
		{ "#5512", "player.health < 50" }, --Healthstone
	
	-- Cooldowns
		{ "112071", "modifier.cooldowns" }, --Celestial Alignment
		{ "#trinket1", "modifier.cooldowns" }, --trinket 1
		{ "#trinket2", "modifier.cooldowns" }, --trinket 2
		{ "#57723", "player.hashero" }, --  Int Pot on lust
 
	--Defensive
		{ "Barkskin", "player.health <= 50", "player" },
		{ "#5512", "player.health < 40"}, --Healthstone when less than 40% health
		{ "108238", "player.health < 60", "player"}, --Instant renewal when less than 40% health
	
	{{ -- Auto Dotting	
		{ "164812", "@mtsLib.MoonFire" }, -- moonfire
		{ "164815", "@mtsLib.SunFire" }, --SunFire
	}, "toggle.dotEverything" },

	{{ -- AoE smart
		{ "48505", "player.area(8).enemies >= 4", "target" }, -- Starfall  // FH SMART AoE
	}, (function() return fetch('mtsconf','Firehack') end) },

	-- AoE
		{ "48505", "modifier.multitarget", "target" }, -- Starfall
	
	-- Proc's
		{ "78674", "player.buff(Shooting Stars)", "target" }, --Starsurge with Shooting Stars Proc
		{ "164815", "player.buff(Solar Peak)", "target" }, --SunFire on proc
		{ "164812", "player.buff(Lunar Peak)", "target" }, --MoonFire on proc
	
	-- Rotation
		{ "78674", "player.spell(78674).charges >= 2" }, --StarSurge with more then 2 charges
		{ "78674", "player.buff(112071}" }, --StarSurge with Celestial Alignment buff
		{ "164812", "target.debuff(Moonfire).duration <= 2"}, --MoonFire
		{ "164815", "target.debuff(Sunfire).duration <= 2"}, --SunFire
		{ "2912", "player.buff(Lunar Empowerment).count >= 1" }, --Starfire with Lunar Empowerment
		{ "5176", "player.buff(Solar Empowerment).count >= 1" }, --Wrath with Solar Empowerment
		{ "2912", "balance.moon"}, --StarFire
		{ "5176", "balance.sun"},  --Wrath
		{ "2912" }, --StarFire Filler
  
}

ProbablyEngine.rotation.register_custom(102, mts.Icon.."|r[|cff9482C9MTS|r][|cffFF7D0ADruid-Boomkin|r]", 
	{ ------------------------------------------------------------------------------------------------------------------ In Combat
		{ "1126", {  -- Mark of the Wild
			"!player.buff(20217).any", -- kings
			"!player.buff(115921).any", -- Legacy of the Emperor
			"!player.buff(1126).any",   -- Mark of the Wild
			"!player.buff(90363).any",  -- embrace of the Shale Spider
			"!player.buff(69378).any",  -- Blessing of Forgotten Kings
			"!player.buff(5215)",-- Not in Stealth
			"player.form = 0", -- Player not in form
			(function() return fetch('mtsconfDruidBalance','Buffs') end),
		}},
		{ "20484", { -- Rebirth
			"modifier.lshift", 
			"!mouseover.alive" 
		}, "mouseover" },
	  	{ "/run CancelShapeshiftForm();", (function() 
	  		if mts.dynamicEval("player.form = 0") or fetch('mtsconfDruidBalance', 'Form') == 'MANUAL' then
	  			return false
	  		elseif mts.dynamicEval("player.form != 0") and fetch('mtsconfDruidBalance', 'Form') == '0' then
	  			return true
	  		else
	  			return mts.dynamicEval("player.form != " .. fetch('mtsconfDruidBalance', 'Form'))
	  		end
	  	end) },
		{ "768", { -- catform
	  		"player.form != 2", -- Stop if cat
	  		"!modifier.lalt", -- Stop if pressing left alt
	  		"!player.buff(5215)", -- Not in Stealth
	  		(function() return fetch('mtsconfDruidBalance','Form') == '2' end),
	  	}},
	  	{ "783", { -- Travel
	  		"player.form != 3", -- Stop if cat
	  		"!modifier.lalt", -- Stop if pressing left alt
	  		"!player.buff(5215)", -- Not in Stealth
	  		(function() return fetch('mtsconfDruidBalance','Form') == '3' end),
	  	}},
	  	{ "5487", { -- catform
	  		"player.form != 1", -- Stop if cat
	  		"!modifier.lalt", -- Stop if pressing left alt
	  		"!player.buff(5215)", -- Not in Stealth
	  		(function() return fetch('mtsconfDruidBalance','Form') == '1' end),
	  	}},
	  	{ "24858", { -- boomkin
	  		"!player.buff(24858)", 
	  		"!modifier.lalt", -- Stop if pressing left alt
	  		"!player.buff(5215)", -- Not in Stealth
	  		(function() return fetch('mtsconfDruidBalance','Form') == '4' end),
	  	}},
	  	{{ --------------------------------------------------------------------------------- Boomkin Form
	  		{ BoomkinForm },
		}, "player.form = 4" },
	}, 
	{ ------------------------------------------------------------------------------------------------------------------ Out Combat
		{ "1126", {  -- Mark of the Wild
			"!player.buff(20217).any", -- kings
			"!player.buff(115921).any", -- Legacy of the Emperor
			"!player.buff(1126).any",   -- Mark of the Wild
			"!player.buff(90363).any",  -- embrace of the Shale Spider
			"!player.buff(69378).any",  -- Blessing of Forgotten Kings
			"!player.buff(5215)",-- Not in Stealth
			"player.form = 0", -- Player not in form
			(function() return fetch('mtsconfDruidBalance','Buffs') end),
		}},
		{ "20484", { -- Rebirth
			"modifier.lshift", 
			"!mouseover.alive" 
		}, "mouseover" },
	  	{ "/run CancelShapeshiftForm();", (function() 
	  		if mts.dynamicEval("player.form = 0") or fetch('mtsconfDruidBalance', 'FormOCC') == 'MANUAL' then
	  			return false
	  		elseif mts.dynamicEval("player.form != 0") and fetch('mtsconfDruidBalance', 'FormOCC') == '0' then
	  			return true
	  		else
	  			return mts.dynamicEval("player.form != " .. fetch('mtsconfDruidBalance', 'FormOCC'))
	  		end
	  	end) },
		{ "768", { -- catform
	  		"player.form != 2", -- Stop if cat
	  		"!modifier.lalt", -- Stop if pressing left alt
	  		"!player.buff(5215)", -- Not in Stealth
	  		(function() return fetch('mtsconfDruidBalance','FormOCC') == '2' end),
	  	}},
	  	{ "783", { -- Travel
	  		"player.form != 3", -- Stop if cat
	  		"!modifier.lalt", -- Stop if pressing left alt
	  		"!player.buff(5215)", -- Not in Stealth
	  		(function() return fetch('mtsconfDruidBalance','FormOCC') == '3' end),
	  	}},
	  	{ "5487", { -- catform
	  		"player.form != 1", -- Stop if cat
	  		"!modifier.lalt", -- Stop if pressing left alt
	  		"!player.buff(5215)", -- Not in Stealth
	  		(function() return fetch('mtsconfDruidBalance','FormOCC') == '1' end),
	  	}},
		{ "24858", { -- boomkin
	  		"!player.buff(24858)", 
	  		"!modifier.lalt", -- Stop if pressing left alt
	  		"!player.buff(5215)", -- Not in Stealth
	  		(function() return fetch('mtsconfDruidBalance','FormOCC') == '4' end),
	  	}},
	}, exeOnLoad)