--[[ ///---INFO---////
// Warrior Fury //
Thank You For Using My ProFiles
I Hope Your Enjoy Them
MTS
]]

local exeOnLoad = function()

	ProbablyEngine.toggle.create('autotarget', 'Interface\\Icons\\Ability_spy.png', 'Auto Target', 'Automatically target the nearest enemy when target dies or does not exist')
	ProbablyEngine.toggle.create('tc', 'Interface\\Icons\\ability_deathwing_bloodcorruption_death', 'Threat Control', '')
	ProbablyEngine.toggle.create('defcd', 'Interface\\Icons\\Inv_shield_55.png', 'Defensive Cooldowns & Heals', 'Enable or Disable Defensive & Healing Cooldowns.')
	mtsStart:message("\124cff9482C9*MTS-\124cffC79C6EWarrior/Prot-\124cff9482C9Loaded*")
	ProbablyEngine.toggle.create( 'GUI', 'Interface\\AddOns\\Probably_MrTheSoulz\\media\\toggle.blp:36:36"', 'Open/Close GUIs','Toggle GUIs', (function() mts_ClassGUI() mts_ConfigGUI() end) )     mts_showLive()
	
end

local Shared = {
	
	-- Buffs
		{ "Battle Shout", "!player.buff(Battle Shout)" },

	-- Stances
		{ "2487", "player.seal != 1", nil  }, -- Battle Stance
		
		
}

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

	-- Freedoom
		{ "Will of the Forsaken", "player.state.fear" },
  		{ "Will of the Forsaken", "player.state.charm" },
  		{ "Will of the Forsaken", "player.state.sleep" },
		
	-- keybinds
		{ "6544", "modifier.shift", "ground" }, -- Heroic Leap
  		{ "5246", "modifier.control" }, -- Intimidating Shout
		{ "100", { "modifier.alt", "target.spell(100).range" }, "target"}, -- Charge

	-- Interrupt
		{ "6552", {"target.interruptsAt(50)", "modifier.interrupts"}, "target" }, -- Pummel
  		{ "Disrupting Shout", "modifier.interrupts", "target.range <= 8" },
  		{ "114028", {"target.interruptsAt(50)","modifier.interrupts"}, "target" }, -- Mass Spell Reflection
	
	-- Cooldowns
		{ "Bloodbath", "modifier.cooldowns"  },
  		{ "Avatar", "modifier.cooldowns"  },
  		{ "Recklessness", "target.range <= 8", "modifier.cooldowns" },
  		{ "Skull Banner", "modifier.cooldowns"  },
  		{ "Bladestorm", "target.range <= 8", "modifier.cooldowns" },
  		{ "Berserker Rage", "modifier.cooldowns" },
  		{ "#gloves" },
	
	--[[ Items
		{ "#5512" }, --Healthstone
		{ "#76097", "player.health < 30", "@mtsLib.checkItem(HealthPot)" }, -- Master Health Potion
		{ "#86125", { "modifier.cooldowns","@mtsLib.checkItem(KafaPress)" }}, -- Kafa Press]]

    -- Auto Target
    	{ "/TargetNearestEnemy", "!target.exists" },
        { "/TargetNearestEnemy", { "target.exists", "target.dead" } },
	
	-- Threat Control w/ Toggle
    	{ "Taunt", "toggle.tc", "target.threat < 100" },
  		{ "Taunt", "toggle.tc", "mouseover.threat < 100", "mouseover" },

    -- Def Cooldowns
  		{ "Rallying Cry", { "player.health < 10", "toggle.defcd"}},  
  		{ "Last Stand", {"player.health < 20", "toggle.defcd" }},
  		{ "Shield Wall", { "player.health < 30", "toggle.defcd" }},
  		{ "Shield Block", {"!player.buff(Shield Block)", "toggle.defcd"} },
  		{ "Shield Barrier", { "!player.buff(Shield Barrier)", "player.rage > 80", "toggle.defcd" }},

  	-- Self Heals
  		{ "Impending Victory", "player.health <= 85" },
  		{ "Victory Rush", "player.health <= 85" },

  	-- Proc's
  		{"Heroic Strike", "player.buff(Ultimatum)", "target"},
  		{"Shield Slam", "player.buff(Sword and Board)", "target"},

	-- AoE
		{ "Thunder Clap", {"modifier.multitarget", "taget.buff(Deep Wounds)" }},

	-- Rotation normal
		{"Heroic Strike", {"player.rage > 75", "target.health >=20"}, "target"},
		{"Execute", {"player.rage > 75", "target.health <=20"}, "target"},
		{"Shield Slam"},
		{"Revenge"},
		{"Devastate"},
		{"Thunder Clap", "taget.debuff(Deep Wounds).duration < 2" },
		
	-- Ranged
		{ "57755", "player.range > 10", "target" } -- Heroic Throw
}

local outCombat = {
	
	-- keybinds
		{ "6544", "modifier.shift", "ground" }, -- Heroic Leap
  		{ "5246", "modifier.control" }, -- Intimidating Shout
		{ "100", { "modifier.alt", "target.spell(100).range" }, "target"}, -- Charge

}

for _, Shared in pairs(Shared) do
  inCombat[#inCombat + 1] = Shared
  outCombat[#outCombat + 1] = Shared
end

ProbablyEngine.rotation.register_custom(73, mts_Icon.."|r[|cff9482C9MTS|r][|cffF58CBAWarrior-Prot|r]", inCombat, outCombat, exeOnLoad)