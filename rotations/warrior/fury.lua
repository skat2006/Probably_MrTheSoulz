--[[ ///---INFO---////
// Warrior Fury //
Thank You For Using My ProFiles
I Hope Your Enjoy Them
MTS
]]

local fetch = ProbablyEngine.interface.fetchKey

local exeOnLoad = function()

	mtsStart:message("\124cff9482C9*MTS-\124cffC79C6EWarrior/Fury-\124cff9482C9Loaded*")
	--ProbablyEngine.toggle.create( 'GUI', 'Interface\\AddOns\\Probably_MrTheSoulz\\media\\toggle.blp:36:36"', 'Open/Close GUIs','Toggle GUIs', (function() mts_ClassGUI() mts_ConfigGUI() end) )     mts_showLive()
	
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
		{ "6544", "modifier.shift", "mouseover.ground" }, -- Heroic Leap // FH
  		{ "5246", "modifier.control" }, -- Intimidating Shout
		{ "100", { "modifier.alt", "target.spell(100).range" }, "target"}, -- Charge

	-- Interrupt
		{ "6552", {"target.interruptsAt(50)", "modifier.interrupts"}, "target" }, -- Pummel
  		{ "114028", {"target.interruptsAt(50)","modifier.interrupts"}, "target" }, -- Mass Spell Reflection
	
	-- Cooldowns
		{ "12292", "modifier.cooldowns" },--Bloodbath
  		{ "107574", "modifier.cooldowns" },-- Avatar
  		{ "107570", "modifier.cooldowns" }, -- Storm Bolt
  		{ "1719", "modifier.cooldowns" }, -- Recklessness
  		{ "46924", "modifier.cooldowns" }, -- Bladestorm
  		{ "#gloves" },
	
	--[[ Items
		{ "#5512" }, --Healthstone
		{ "#76097", "player.health < 30", "@mtsLib.checkItem(HealthPot)" }, -- Master Health Potion
		{ "#86125", { "modifier.cooldowns","@mtsLib.checkItem(KafaPress)" }}, -- Kafa Press]]

    -- Auto Target
    	{ "/cleartarget", (function() return UnitIsFriend("player","target") end) },
    	{ "/TargetNearestEnemy", "!target.exists" },
        { "/TargetNearestEnemy", { "target.exists", "target.dead" } },
	
    -- Survival
  		{ "97462", { "player.health < 15", "modifier.cooldowns" }}, -- Rallying Cry
  		{ "118038", "player.health < 25" }, -- Die by the Sword

  	-- Proc's
  		{ "5308", "player.buff(Sudden Death)", "target" }, -- Execute
  		{ "100130", "player.buff(Bloodsurge)", "target" }, -- Wild Strike
  		{ "Victory Rush" },

		{{-- can use FH

	    	-- AoE smart
	     	{ "1680", "player.area(8).enemies > 3" }, -- Whirlwind

	  	}, {"player.firehack", (function() return fetch('mtsconf','Firehack') end),}},


	-- AoE
		{ "1680", "modifier.multitarget" }, -- Whirlwind

	-- Rotaion Execute (Target as less then 20% health)
		{ "5308", {"player.rage > 80", "target.health <= 20"}, "target" }, -- Execute
		{ "23881", "target.health <= 20", "target" }, -- Bloodthirst
		{ "5308", {"player.rage >= 60", "target.health <= 20"}, "target" }, -- Execute

	-- Rotation normal
		{ "100130", "player.rage > 80", "target" }, -- Wild Strike
		{ "23881" }, -- Bloodthirst
		{ "85288" }, -- Raging Blow
		
	-- Ranged
		{ "57755", "player.range > 10", "target" } -- Heroic Throw
}

local outCombat = {
	
	-- keybinds
		{ "6544", "modifier.shift", "mouseover.ground" }, -- Heroic Leap // FH
  		{ "5246", "modifier.control" }, -- Intimidating Shout
		{ "100", { "modifier.alt", "target.spell(100).range" }, "target"}, -- Charge

}

for _, Shared in pairs(Shared) do
  inCombat[#inCombat + 1] = Shared
  outCombat[#outCombat + 1] = Shared
end

ProbablyEngine.rotation.register_custom(72, mts_Icon.."|r[|cff9482C9MTS|r][|cffF58CBAWarrior-Fury|r]", inCombat, outCombat, exeOnLoad)