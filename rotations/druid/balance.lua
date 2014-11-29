--[[ ///---INFO---////
// Druid Guard //
Thank You For Using My ProFiles
I Hope Your Enjoy Them
MTS
]]

local fetch = ProbablyEngine.interface.fetchKey

local exeOnLoad = function()

  ProbablyEngine.toggle.create(
	'mouseoverdots', 
	'Interface\\Icons\\INV_Helmet_131.png',
	'MouseOver Doting', 
	'Mouseover to to anything thats not doted.')

  ProbablyEngine.toggle.create(
	'dotEverything', 
	'Interface\\Icons\\Ability_creature_cursed_05.png', 
	'Dot All The Things!', 
	'Click here to dot all the things!\nSome Spells require Multitarget enabled also.\nOnly Works if using FireHack.')
	
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
			
	-- Interrupts
		{ "78675", "target.interruptsAt(50)" }, -- Solar Beam
	
	-- Items
		{ "#5512", "player.health < 50" }, --Healthstone
	
	-- Cooldowns
		{ "112071", "modifier.cooldowns" }, --Celestial Alignment
 
	--Defensive
		{ "Barkskin", "player.health <= 80", "player" },
		{ "#5512", "player.health < 40"}, --Healthstone when less than 40% health
		{ "108238", "player.health < 60", "player"}, --Instant renewal when less than 40% health
	
	{{ -- Auto Dotting	
		{ "164812", (function() return mts_MoonFire() end) }, -- moonfire
	}, {"toggle.dotEverything", "player.firehack", "modifier.multitarget"} },
	
	-- Auto Target
		{ "/target [target=focustarget, harm, nodead]", {
			"target.range > 40", "!target.exists",
			"toggle.autotarget"
			} },
		{ "/targetenemy [noexists]", { 
			"toggle.autotarget", 
			"!target.exists" 
			}},
   		{ "/targetenemy [dead]", { 
			"toggle.autotarget", 
			"target.exists", 
			"target.dead" 
			}},

	{{ -- AoE smart
		{ "48505", "player.area(8).enemies >= 4", "target" }, -- Starfall  // FH SMARTH AoE
	}, {"player.firehack", (function() return fetch('mtsconf','Firehack') end)}},

	-- AoE
		{ "164812", "target.debuff(Moonfire).duration <= 2", "target"}, --Moonfire
		{ "48505", "modifier.multitarget", "target" }, -- Starfire
	
	-- Proc's
		{ "78674", "player.buff(Shooting Stars)", "target" }, --Starsurge with Shooting Stars Proc
		{ "164815", "player.buff(Solar Peak)", "target" }, --SunFire on proc
		{ "164812", "player.buff(Lunar Peak)", "target" }, --MoonFire on proc
	
	-- Rotation
		{ "164812", "target.debuff(Moonfire).duration <= 2"}, --MoonFire
		{ "164815", "target.debuff(Sunfire).duration <= 2"}, --SunFire
		{ "2912", "player.buff(Lunar Empowerment).count >= 1" }, --Starfire with Lunar Empowerment
		{ "5176", "player.buff(Solar Empowerment).count >= 1" }, --Wrath with Solar Empowerment
		{ "78674"}, --Starsurge
		{ "2912", "balance.moon"}, --StarFire
		{ "5176", "balance.sun"},  --Wrath
  
}

local outCombat = {

	--	keybinds
		{ "5185", "player.health < 75"}, --Full Healh ooc
	
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

ProbablyEngine.rotation.register_custom(102, mts_Icon.."|r[|cff9482C9MTS|r][|cffFF7D0ADruid-Boomkin|r]", inCombat, outCombat, exeOnLoad, lib)