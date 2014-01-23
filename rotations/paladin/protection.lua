-- //////////////////////-----------------------------------------INFO-----------------------------------//////////////////////////////
--													   	//Paladin Protection//
--													Thank Your For Your My ProFiles
--														I Hope Your Enjoy Them
--																  MTS


local lib = function()

-- /////////////////////////-----------------------------------------TOGGLES-----------------------------------//////////////////////////////

	ProbablyEngine.toggle.create('buff', 'Interface\\Icons\\Spell_magic_greaterblessingofkings.png', 'Buffs', 'Enable for Blessing of Kings. \nDisable for Blessing of Might.')
	mtsAlert:message("\124cff9482C9*MrTheSoulz - \124cffF58CBAPaladin/Protection \124cff9482C9Loaded*")

end
-- //////////////////////-----------------------------------------END LIB-----------------------------------//////////////////////////////


local Buffs = {

	-- Buffs
		{ "19740", { -- Blessing of Might
			"!player.buff(19740).any",
			"!player.buff(116956).any",
			"!player.buff(93435).any",
			"!player.buff(128997).any",
			"@mts.getConfig('useBuffs')",
			"!toggle.buff"
		}, nil },
		
		{ "20217", { -- Blessing of Kings
			"!player.buff(20217).any", 
			"!player.buff(115921).any", 
			"!player.buff(1126).any", 
			"!player.buff(90363).any", 
			"!player.buff(69378).any",
			"@mts.getConfig('useBuffs')",
			"toggle.buff" 
		}, nil },
		
		{ "25780", "!player.buff(25780)" }, -- Fury
		
}

-- ////////////////////////-----------------------------------------END BUFFS-----------------------------------//////////////////////////////


local inCombat = {
			
	-- keybinds
		{ "105593", "modifier.control", "target"}, -- Fist of Justice
		{ "853", "modifier.control", "target"}, -- Hammer of Justice
		{ "114158", "modifier.shift", "ground"}, -- Light´s Hammer
		{ "26573", { "player.glyph(54928)", "modifier.alt" }, "ground"}, -- consecration glyphed

	-- Seals
		{ "20165", { "player.seal != 3", "!modifier.multitarget", "@mts.getConfig('changeSeals')"  }, nil }, -- seal of Insight
		{ "20154", { "player.seal != 2", "modifier.multitarget", "@mts.getConfig('ChangeSeals')"  }, nil }, -- seal of righteousness

	-- Hands
		{ "6940", { "lowest.health <= 80", "!player.health <= 40", "!lowest.player" }, "lowest" }, -- Hand of Sacrifice
		{ "1044", "player.state.root" }, -- Hand of Freedom
		{ "1022", { "!lowest.role(tank)", "!lowest.immune.melee", "lowest.health < 25" }, "lowest" }, -- Hand of Protection
		
	-- Interrupt
		{ "96231", "modifier.interrupts" }, -- Rebuke

	-- Defensive Cooldowns
		{ "20925", { "!player.buff(20925)", "@mts.getConfig('pprotDefcd')" }, "player" }, -- Sacred Shield 		
		{ "31850", { "player.health < 30", "@mts.getConfig('pprotDefcd')" }, nil }, --Ardent Defender
		{ "498", { "player.health <= 99", "@mts.getConfig('pprotDefcd')" }, nil }, -- Divine Protection
		{ "86659", { "player.health <= 50", "@mts.getConfig('pprotDefcd')" }, nil }, -- Guardian of Ancient Kings
		{ "#gloves", "@mts.getConfig('pprotDefcd')", nil },
	
	-- Cooldowns
		{ "31884", "modifier.cooldowns" }, -- Avenging Wrath
		{ "105809", "modifier.cooldowns" }, --Holy Avenger
	
	-- Items
		{ "#5512", "player.health < 60" }, --Healthstone
		{ "#76097", { "player.health < 30", "@mts.HealthPot" }, nil }, -- Master Health Potion
		--{ "#86125", "@mts.KafaPress", nil }, -- Kafa Press

	-- Self Heal
		{ "633", "player.health < 20", "player"}, -- Lay on Hands
		{ "114163", { -- Eternal Flame
			"!player.buff(114163)", 
			"player.buff(114637).count = 5", 
			"player.holypower >= 3", 
			"player.health < 60" 
		}, "player"},
		{ "114163", { "player.holypower >= 1", "player.health < 30" }, "player"}, -- Eternal Flame / Low
		{ "85673", { "player.buff(114637).count = 5", "player.holypower >= 3", "player.health < 60" }, "player" }, -- Word of Glory
		{ "85673", { "player.holypower >= 1", "player.health < 30" }, "player" }, -- Word of Glory / Low
		{ "19750", { "player.health < 70", "player.buff(114250).count > 2", "player.buff(114637" }, "player" }, -- Flash of Light 

	-- Raid Heal
		{ "19750", { "lowest.health < 50", "player.buff(114250).count > 2" }, "lowest" }, -- Flash of Light
        { "114163", { "player.holypower >= 1", "player.health < 30" }, "Lowest"}, -- Eternal Flame
        { "85673", { "player.holypower >= 1", "player.health < 30" }, "lowest" }, -- Word of Glory

    -- Auto Target
    	--{ "/TargetNearestEnemy", "!target.exists", nil },
        --{ "/TargetNearestEnemy", { "target.exists", "target.dead" }, nil },

    -- Taunts
		{ "62124", { "@mts.getConfig('getTaunts')", "@mts.bossTaunt" }, "target" }, -- Boss // Reckoning
		{ "62124", { "@mts.getConfig('getTaunts')", "target.threat < 100", "@mts.StopIfBoss" }, "target" }, -- Aggro Control // Reckoning
		{ "62124", { "@mts.getConfig('getTaunts')", "mouseover.threat < 100", "@mts.StopIfBoss" }, "mouseover" }, -- Aggro Control // Reckoning

	-- Rotation
		{ "24275", { -- Hammer of Wrath
			"target.health <= 20", 
			"target.spell(24275).range" 
		}, "target" },
		{ "31935", { -- Avenger´s Shield Proc
			"player.buff(98057)", 
			"target.spell(31935).range" 
		}, "target" },
		{ "53600", { -- Shield of the Righteous
			"player.holypower >= 3", 
			"target.spell(53600).range" 
		}, "target" },
		{ "35395", {  -- Crusader Strike
			"!modifier.multitarget", 
			"target.spell(35395).range" 
		}, "target" },
		{ "53595", { -- Hammer of the Righteous
			"modifier.multitarget", 
			"target.spell(53595).range" 
		}, "target" },
		{ "20271", "target.spell(20271).range", "target" }, -- Judgment
		{ "114165", "target.spell(114165).range", "target" }, -- Holy Prism
		{ "31935", "target.spell(31935).range", "target" },-- Avenger´s Shield Normal
		{ "26573", { -- consecration
			"!player.glyph(54928)", 
			"target.range <= 5", 
			"@mts.getConfig('useConsecration')" 
		}, nil },
		{ "114157", "target.spell(114157).range", "target" }, -- Execution Sentense
		{ "119072" }, -- Holy Wrath
  
}

-- //////////////////////-----------------------------------------END IN-COMBAT-----------------------------------//////////////////////////////

local outCombat = {

-- keybinds
		{ "105593", "modifier.control", "target"}, -- Fist of Justice
		{ "853", "modifier.control", "target"}, -- Hammer of Justice
		{ "114158", "modifier.shift", "ground"}, -- Light´s Hammer
		{ "26573", { "player.glyph(54928)", "modifier.alt" }, "ground"}, -- consecration glyphed

	-- seals
		{ "20165", { "player.seal != 3", "!modifier.multitarget", "@mts.getConfig('changeSeals')"  }, nil }, -- seal of Insight
		{ "20154", { "player.seal != 2", "modifier.multitarget", "@mts.getConfig('ChangeSeals')"  }, nil }, -- seal of righteousness

	-- Hands
		{ "1044", "player.state.root" }, -- Hand of Freedom

}

-- //////////////////////-----------------------------------------END OUT-OF-COMBAT-----------------------------------//////////////////////////////

for _, Buffs in pairs(Buffs) do
  inCombat[#inCombat + 1] = Buffs
  outCombat[#outCombat + 1] = Buffs
end

ProbablyEngine.rotation.register_custom(66, "|r[|cff9482C9MTS|r][|cffF58CBAPaladin-Protection|r]", inCombat, outCombat, lib)