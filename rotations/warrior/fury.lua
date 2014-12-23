--[[ ///---INFO---////
Fury Warrior DPS is based on maintaining a high uptime on Enrage to generally buff 
  your damage while also using as many Execute as possible. 
  ///---INFO---////  ]]

local fetch = ProbablyEngine.interface.fetchKey

local exeOnLoad = function()
mts_Splash("|cff9482C9[MTS]-|cffFFFFFF"..(select(2, GetSpecializationInfo(GetSpecialization())) or "Error").."-|cff9482C9Loaded", 5.0)

	
	
end

local All = {

		{ "6673", "!player.buff(6673)" }, 						-- Battle Shout
		{ "2487", "player.seal != 1", nil  }, 					-- Battle Stance
		{ "6544", "modifier.shift", "mouseover.ground" }, 		-- Heroic Leap // FH
	  	{ "5246", "modifier.control" }, 						-- Intimidating Shout
		{ "100", { 		------------------------------------------ Charge
			"modifier.alt", 			-- Holding Alt Key
			"target.spell(100).range" 	-- Spell in range
		}, "target"},
		
}

local racials = {
	
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

}

local Cooldowns = {
	
	-- Cooldowns
		{ "12292" },			-- Bloodbath
  		{ "107574" },			-- Avatar
  		{ "107570" }, 			-- Storm Bolt
  		{ "1719" }, 			-- Recklessness Use as often as possible. Stack with other DPS cooldowns.
  		{ "46924" }, 			-- Bladestorm
  		{ "Berserker Rage" },	-- Berserker Rage Use as needed to maintain Enrage.
  		{ "#gloves" },
	
	--[[ Items
		{ "#5512" }, --Healthstone
		{ "#76097", { "player.health < 30", "@mtsLib.checkItem(HealthPot)" }}, -- Master Health Potion
		{ "#86125", { "modifier.cooldowns","@mtsLib.checkItem(KafaPress)" }}, -- Kafa Press]]

}

local Survival = {
	
	{ "97462", "player.health < 15" }, 		-- Rallying Cry
  	{ "118038", "player.health < 25" }, 	-- Die by the Sword

}

--[[ ///---INFO---////
With 3 or less targets, you should use Bloodthirst on cooldown to maintain Enrage. 
Use Whirlwind with >= 80 Rage and to stack the Raging Blow buff. 
Use Raging Blow when there are 2-3 stacks of the buff. 
Use Wild Strike as needed to consume Bloodsurge procs. 
With 4+ targets, place a higher emphasis on Whirlwind and continue to use it to dump Rage even with max Raging Blow stacks.
  ///---INFO---////  ]]
local AoE = {

	{ "23881" }, 									-- Bloodthirst on cooldown to maintain Enrage. Procs Bloodsurge.
	{ "1680", "player.rage >= 80" }, 				-- Whirlwind as a Rage dump and to build Raging Blow stacks.
	{ "85288" }, 									-- Raging Blow with Raging Blow stacks.

}

--[[ ///---INFO---////
The Execute priorty is similar to the Normal priority but places more emphasis on the use of Execute. 
To follow this priority, use Execute instead of Wild Strike to prevent capping your Rage. 
Continue to use Bloodthirst on cooldown when not Enraged in order to proc Enrage and Bloodsurge. 
Now, use Execute while Enrage or whenever you go above 60 Rage. 
Finally, continue to use Wild Strike while Enrage or to consume Bloodsurge procs.
  ///---INFO---////  ]]
local Execute = {

	{ "34428" }, 									-- Victory Rush
	{ "5308", "player.rage >= 80", "target" }, 		-- Execute to prevent capping your Rage.
	{ "23881" }, 									-- Bloodthirst on cooldown to maintain Enrage. Procs Bloodsurge.
	{ "5308", "player.rage >= 60", "target" }, 		-- Execute while Enrage.
	{ "5308", "player.buff(Enraged)", "target" }, 	-- Execute with >= 60 Rage.
	{ "100130", "player.buff(Enraged)", "target" }, -- Wild Strike while Enrage or with Bloodsurge procs.

}

--[[ ///---INFO---////
The Normal rotation should be followed while your target is above 20% health and 
  then you should switch to the Exectue rotation when your target drops below 20% health.
The Normal priority uses Wild Strike when necessary to prevent capping your Rage. 
After this, use Bloodthirst on cooldown when not Enraged in order to try and proc Enrage as well as Bloodsurge. 
Next, use Raging Blow whenever available. 
Also, use Wild Strike when Enraged or to consume Bloodsurge procs.
  ///---INFO---////  ]]
local Normal = {

	{ "34428" }, 									-- Victory Rush
	{ "100130", "player.rage > 80", "target" },	 	-- Wild Strike to prevent capping your Rage.
	{ "23881", "!player.buff(Enraged)", "target" }, -- Bloodthirst on cooldown when not Enraged. Procs Bloodsurge.
	{ "85288" }, 									-- Raging Blow when available.
	{ "100130", "player.buff(Enraged)", "target" }, -- Wild Strike when Enraged.
	{ "57755", "player.range > 10", "target" } 		-- Heroic Throw

}

ProbablyEngine.rotation.register_custom(72, mts_Icon.."|r[|cff9482C9MTS|r][|cffF58CBAWarrior-Fury|r]", 
	{-- Incombat
		{ "6552", "target.interruptsAt(50)" }, 			-- Pummel
		{ "114028", "target.interruptsAt(50)" }, 		-- Mass Spell Reflection
		{ All },										-- Shared across all
		{ Survival },									-- Survival
		{ Cooldowns, "modifier.cooldowns" },			-- Cooldowns
		{ "5308", "player.buff(29725)", "target" }, 	-- Proc // Execute, Sudden Death
		{ "100130", "player.buff(46916)", "target" },	-- Wild Strike to consume Bloodsurge procs.
		{ Execute, "target.health <= 20" },				-- Execute
		{ AoE, "modifier.multitarget" },				-- AoE Forced
		{ AoE, "player.area(8).enemies >= 3" },			-- AoE
		{ Normal, "target.health >= 20" }				-- Normal CR
	}, 
	{ -- Out Combat
		{ All }
	}, 
	exeOnLoad)