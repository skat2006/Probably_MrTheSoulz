local fetch = ProbablyEngine.interface.fetchKey

local exeOnLoad = function()

  ProbablyEngine.toggle.create(
	'dotEverything', 
	'Interface\\Icons\\Ability_creature_cursed_05.png', 
	'Dot All The Things!', 
	'Click here to dot all the things!\nSome Spells require Multitarget enabled also.\nOnly Works if using FireHack.')
	
end

local inCombat = {
		
	-- Bird form // ???
	    --{ "player.form = 4" },  
			
	-- Interrupts
		{ "78675", "target.interruptsAt(50)" }, -- Solar Beam
	
	-- Items
		{ "#5512", "player.health < 50" }, --Healthstone
	
	-- Cooldowns
		{ "112071", "modifier.cooldowns" }, --Celestial Alignment
 
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

local outCombat = {

	--	keybinds
	--	{ "5185", "player.health < 85"}, --Full Healh ooc
	
	-- Rebirth
		{ "20484", { 
			"modifier.lshift", 
			"!target.alive" 
			}, "target" }, -- Rebirth
		
	-- Buffs
  		{ -- Cancel player form
  			"player.form > 0",  -- Is in any form
  			"!player.buff(20217).any", -- kings
			"!player.buff(115921).any", -- Legacy of the Emperor
			"!player.buff(1126).any",   -- Mark of the Wild
			"!player.buff(90363).any",  -- embrace of the Shale Spider
			"!player.buff(69378).any",  -- Blessing of Forgotten Kings
  			"!player.buff(5215)" },-- Not in Stealth
		{ "1126", {  -- Mark of the Wild
			"!player.buff(20217).any", -- kings
			"!player.buff(115921).any", -- Legacy of the Emperor
			"!player.buff(1126).any",   -- Mark of the Wild
			"!player.buff(90363).any",  -- embrace of the Shale Spider
			"!player.buff(69378).any",  -- Blessing of Forgotten Kings
			"!player.buff(5215)",-- Not in Stealth
			"player.form = 0" }}, -- Player not in form

}

ProbablyEngine.rotation.register_custom(
	102, 
	mts_Icon.."|r[|cff9482C9MTS|r][|cffFF7D0ADruid-Boomkin|r]", 
	inCombat, outCombat, exeOnLoad)