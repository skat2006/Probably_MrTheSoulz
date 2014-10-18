--[[ ///---INFO---////
// Warrior Fury //
Thank You For Using My ProFiles
I Hope Your Enjoy Them
MTS
]]

local exeOnLoad = function()

	mtsAlert:message("\124cff9482C9*MrTheSoulz - \124cffC79C6EWarrior/Fury \124cff9482C9Loaded*")

end

local Buffs = {

	-- Buffs
		
		
}

local inCombat = {
			
	-- keybinds
		--{ "", "modifier.control", "target"}, -- **
		--{ "", "modifier.shift", "ground"}, -- **
		{ "100", { "modifier.alt", "target.spell(100).range" }, "target"}, -- Charge

	-- Stances
		{ "2487", { "player.seal != 1", "@mtsLib.getConfig('WarFuryChangeStances')" }, nil  }, -- Battle Stance

	-- Freedoom
		--{ "", "player.state.root" }, -- **
		
	-- Interrupt
		{ "6552", "target.interruptsAt(50)" }, -- Pummel

	-- Defensive Cooldowns		
		--{ "", { "player.health < 30", "@mtsLib.getConfig('WarFuryDefCd')" }, nil }, -- **
		{ "#gloves", "@mtsLib.getConfig('WarFuryDefCd')", nil },
	
	-- Cooldowns
		--{ "", "modifier.cooldowns" }, -- **
	
	-- Items
		{ "#5512", "@mtsLib.ConfigUnitHp('WarFuryHs', 'player')" }, --Healthstone
		{ "#76097", { "@mtsLib.getConfig('WarFuryItems')", "player.health < 30", "@mtsLib.HealthPot" }}, -- Master Health Potion
		--{ "#86125", { "@mtsLib.getConfig('WarFuryItems')","@mtsLib.KafaPress" }}, -- Kafa Press

    -- Auto Target
    	{ "/TargetNearestEnemy", "!target.exists" },
        { "/TargetNearestEnemy", { "target.exists", "target.dead" } },
	
	-- Rotation
	    { "85288", "target.spell(85288).range", "target" }, -- Raging Blow
	    { "5308", { "player.rage >= 65", "target.health <= 20", "modifier.multitarget" }, "target" }, -- Whirlwind
	    { "5308", { "player.rage >= 85", "target.health <= 20", "target.spell(5308).range" }, "target" }, -- Execute
		{ "100130", { "player.rage >= 85", "target.health >= 20", "target.spell(100130).range" }, "target" }, -- Wild Strike
		{ "100130", { "player.rage >= 45", "player.buff(46916)", "target.spell(100130).range" }, "target" }, -- Wild Strike / proc
		{ "100130", { "player.rage >= 45", "player.buff(12880)", "target.spell(100130).range" }, "target" }, -- Wild Strike / enraged
		{ "23881", { "!target.debuff(98057)", "!player.buff(12880)", "target.spell(23881).range" }, "target" }, -- Bloodthirst

}

local outCombat = {

    -- keybinds
		--{ "", "modifier.control", "target"}, -- **
		--{ "", "modifier.shift", "ground"}, -- **
		{ "100", { "modifier.alt", "target.spell(100).range" }, "target"}, -- Charge

	-- Stances
		{ "2487", { "player.seal != 1", "@mtsLib.getConfig('WarFuryChangeStances')" }, nil  }, -- Battle Stance

	-- Freedoom
		--{ "", "player.state.root" }, -- **

}

for _, Buffs in pairs(Buffs) do
  inCombat[#inCombat + 1] = Buffs
  outCombat[#outCombat + 1] = Buffs
end

ProbablyEngine.rotation.register_custom(72, "|r[|cff9482C9MTS|r][|cffF58CBAWarrior-Fury|r]", inCombat, outCombat, exeOnLoad)