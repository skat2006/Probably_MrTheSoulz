--[[ ///---INFO---////
// Warrior Fury //
Thank You For Using My ProFiles
I Hope Your Enjoy Them
MTS
]]

local Battle_Print = false
local fetch = ProbablyEngine.interface.fetchKey

local exeOnLoad = function()
	mts.Splash("|cff9482C9[MTS]-|cffFFFFFF"..(select(2, GetSpecializationInfo(GetSpecialization())) or "Error").."-|cff9482C9Loaded", 5.0)

end

local inCombat_Defensive = {

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
		{ "Thunder Clap", "target.debuff(Deep Wounds).duration < 2" },
		
}

local inCombat_Gladiator = {

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

local AoE = {
	
	{ "Thunder Clap" },

}

local Survival = {
	
	-- Def Cooldowns
  	{ "Rallying Cry", (function() return mts.dynamicEval("player.health <= " .. fetch('mtsconfigWarrProt', 'RallyingCry')) end) },  
  	{ "Last Stand", (function() return mts.dynamicEval("player.health <= " .. fetch('mtsconfigWarrProt', 'LastStand')) end) },
  	{ "Shield Wall", (function() return mts.dynamicEval("player.health <= " .. fetch('mtsconfigWarrProt', 'ShieldWall')) end) },
  	{ "Shield Block", "!player.buff(Shield Block)" },
  	{ "Shield Barrier", { 
  		"!player.buff(Shield Barrier)",
  		(function() return mts.dynamicEval("player.rage <= " .. fetch('mtsconfigWarrProt', 'ShieldBarrier')) end)
  	}},

  	-- Self Heals
  	{ "Impending Victory", "player.health <= 85" },
  	{ "Victory Rush", "player.health <= 85" },
  	{ "#5512", (function() return mts.dynamicEval("player.health <= " .. fetch('mtsconfigWarrProt', 'Healthstone')) end) }, --Healthstone

}

local Cooldowns = {
	
	{ "Bloodbath" },
  	{ "Avatar" },
  	{ "Recklessness", "target.range <= 8" },
  	{ "Skull Banner" },
  	{ "Bladestorm", "target.range <= 8" },
  	{ "Berserker Rage" },
  	{ "#gloves" },

}

ProbablyEngine.rotation.register_custom(
	73, 
	mts.Icon.."|r[|cff9482C9MTS|r][|cffC79C6EWarrior-Prot|r]", 
	{-- In-Combat CR
		{ "Battle Shout", {
			"!player.buffs.attackpower",
			"player.buff(156291)" -- Gladiator
		}},
		{ "Commanding Shout", {
			"!player.buffs.stamina",
			"!player.buff(156291)" -- Gladiator
		}},
		{ "6544", "modifier.shift", "ground" }, -- Heroic Leap
  		{ "5246", "modifier.control" }, -- Intimidating Shout
		{ "100", { "modifier.alt", "target.spell(100).range" }, "target"}, -- Charge
		{ "6552", "target.interruptsAt(50)", "target" }, -- Pummel
  		{ "Disrupting Shout", {
  			"modifier.interrupts", 
  			"target.range <= 8"
  		} },
  		{ "114028", "target.interruptsAt(50)", "target" }, -- Mass Spell Reflection
  		{ "Will of the Forsaken", "player.state.fear" },
  		{ "Will of the Forsaken", "player.state.charm" },
  		{ "Will of the Forsaken", "player.state.sleep" },
		{ "Heroic Strike", "player.buff(Ultimatum)", "target" },
  		{ "Shield Slam", "player.buff(Sword and Board)", "target" },
  		{ Survival },
  		{ Cooldowns, "modifier.cooldowns" },
  		{ AoE, "modifier.multitarget" },
  		{ AoE, "player.area(8).enemies >= 3" },
		{{ -- Stance 1
			{ inCombat_Gladiator, "talent(7,3)" },
			{ inCombat_Battle, "!talent(7,3)" },
		}, "player.stance = 1" },
		{ inCombat_Defensive, "player.stance = 2" },
		{ "57755", "player.range > 10", "target" } -- Heroic Throw
	},
	{-- Out-Combat CR
		{ "Battle Shout", {
			"!player.buff(Battle Shout)",
			"player.buff(156291)" -- Gladiator
		}},
		{ "Commanding Shout", {
			"!player.buff(Commanding Shout)",
			"!player.buff(156291)" -- Gladiator
		}},
		{ "6544", "modifier.shift", "ground" }, -- Heroic Leap
  		{ "5246", "modifier.control" }, -- Intimidating Shout
		{ "100", { "modifier.alt", "target.spell(100).range" }, "target"}, -- Charge
	}, exeOnLoad)
