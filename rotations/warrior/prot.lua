--[[ ///---INFO---////
// Warrior Fury //
Thank You For Using My ProFiles
I Hope Your Enjoy Them
MTS
]]

local Battle_Print = false
local Glad_Print = false
local fetch = ProbablyEngine.interface.fetchKey

local exeOnLoad = function()
mts_Splash("|cff9482C9[MTS]-|cffFFFFFF"..(select(2, GetSpecializationInfo(GetSpecialization())) or "Error").."-|cff9482C9Loaded", 5.0)
	ProbablyEngine.toggle.create('tc', 
		'Interface\\Icons\\ability_deathwing_bloodcorruption_death', 
		'Threat Control', 
		'')
	
end

local inCombat_Defensive = {

	-- Buffs
		{ "Battle Shout", "!player.buff(Battle Shout)" },

	-- Freedoom
		{ "Will of the Forsaken", "player.state.fear" },
  		{ "Will of the Forsaken", "player.state.charm" },
  		{ "Will of the Forsaken", "player.state.sleep" },
		
	-- keybinds
		{ "6544", "modifier.shift", "ground" }, -- Heroic Leap
  		{ "5246", "modifier.control" }, -- Intimidating Shout
		{ "100", { "modifier.alt", "target.spell(100).range" }, "target"}, -- Charge

	-- Interrupt
		{ "6552", "target.interruptsAt(50)", "target" }, -- Pummel
  		{ "Disrupting Shout", {
  			"modifier.interrupts", 
  			"target.range <= 8"
  		} },
  		{ "114028", "target.interruptsAt(50)", "target" }, -- Mass Spell Reflection
	
	-- Cooldowns
		{ "Bloodbath", "modifier.cooldowns"  },
  		{ "Avatar", "modifier.cooldowns"  },
  		{ "Recklessness", "target.range <= 8", "modifier.cooldowns" },
  		{ "Skull Banner", "modifier.cooldowns"  },
  		{ "Bladestorm", "target.range <= 8", "modifier.cooldowns" },
  		{ "Berserker Rage", "modifier.cooldowns" },
	
	-- Items
		{ "#5512", (function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfigWarrProt', 'Healthstone')) end) }, --Healthstone
		{ "#gloves" },
	
	-- Threat Control w/ Toggle
    	{ "Taunt", "toggle.tc", "target.threat < 100" },
  		{ "Taunt", "toggle.tc", "mouseover.threat < 100", "mouseover" },

    -- Def Cooldowns
  		{ "Rallying Cry", (function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfigWarrProt', 'RallyingCry')) end) },  
  		{ "Last Stand", (function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfigWarrProt', 'LastStand')) end) },
  		{ "Shield Wall", (function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfigWarrProt', 'ShieldWall')) end) },
  		{ "Shield Block", "!player.buff(Shield Block)" },
  		{ "Shield Barrier", { 
  			"!player.buff(Shield Barrier)",
  			(function() return mts_dynamicEval("player.rage <= " .. fetch('mtsconfigWarrProt', 'ShieldBarrier')) end)
  		}},

  	-- Self Heals
  		{ "Impending Victory", "player.health <= 85" },
  		{ "Victory Rush", "player.health <= 85" },

  	-- Proc's
  		{ "Heroic Strike", "player.buff(Ultimatum)", "target"},
  		{ "Shield Slam", "player.buff(Sword and Board)", "target"},

	-- AoE
		{ "Thunder Clap", "modifier.multitarget" },

	-- Rotation normal
		{ "Heroic Strike", {
			"player.rage > 75", 
			"target.health >=20"
		}, "target"},
		{ "Execute", {
			"player.rage > 75", 
			"target.health <=20"
		}, "target"},
		{ "Shield Slam"},
		{ "Revenge"},
		{ "Devastate"},
		{ "Thunder Clap", "taget.debuff(Deep Wounds).duration < 2" },
		
	-- Ranged
		{ "57755", "player.range > 10", "target" } -- Heroic Throw
}

local inCombat_Gladiator = {

	-- AoE
		{ "Thunder Clap", "modifier.multitarget" },

	-- ST
		{ "Shield Charge", "!player.buff(Shield Charge)" },
		{ "Shield Charge", "spell(Shield Charge).charges >= 2" },
		{ "Heroic Strike", "player.buff(Shield Charge)" },
		{ "Heroic Strike", "player.buff(Ultimatum)" },
		{ "Heroic Strike", "player.rage >= 95" },
		{ "Shield Slam" },
		{ "Revenge" },
		{ "Execute" },
		{ "Devastate" }

}

local inCombat_Battle = {

	{ "/run print('[MTS] This stance is not yet supported! :(')", 
		(function() 
			if Battle_Print == false then 
				Battle_Print = true 
				return true 
			end
			return false
		end)
	},
	{"71", {
		"player.stance != 2",
		(function() 
			Battle_Print = false 
			return true
		end)
	} },

}

local outCombat = {
	
	-- keybinds
		{ "6544", "modifier.shift", "ground" }, -- Heroic Leap
  		{ "5246", "modifier.control" }, -- Intimidating Shout
		{ "100", { "modifier.alt", "target.spell(100).range" }, "target"}, -- Charge

}

ProbablyEngine.rotation.register_custom(
	73, 
	mts_Icon.."|r[|cff9482C9MTS|r][|cffC79C6EWarrior-Prot|r]", 
	{-- Dyn Change CR
		{ inCombat_Battle, "player.stance = 1" },
		{ inCombat_Defensive, "player.stance = 2" },
		{ inCombat_Gladiator, "player.stance = 3" }
	},  
	outCombat, exeOnLoad)