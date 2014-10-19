-- //////////////////////-----------------------------------------INFO-----------------------------------//////////////////////////////
--													   	//Paladin Protection//
--													Thank Your For Your My ProFiles
--														I Hope Your Enjoy Them
--																  MTS
local lib = function()

	ProbablyEngine.toggle.create('autotarget', 'Interface\\Icons\\Ability_spy.png', 'Auto Target', 'Automatically target the nearest enemy when target dies or does not exist')
	ProbablyEngine.toggle.create('defcd', 'Interface\\Icons\\Spell_holy_devotionaura.png', 'Defensive Cooldowns', 'Enable or Disable Defensive Cooldowns.')
	ProbablyEngine.toggle.create('buff', 'Interface\\Icons\\Spell_magic_greaterblessingofkings.png', 'Buffs', 'Enable for Blessing of Kings. \nDisable for Blessing of Might.')
	mtsAlert:message("\124cff9482C9*MrTheSoulz - \124cffF58CBAPaladin/Protection \124cff9482C9Loaded*")

end


local Buffs = {

	-- Buffs
		{ "19740", { "!player.buff(19740).any", "!player.buff(116956).any", "!player.buff(93435).any", "!player.buff(128997).any", "!toggle.buff" }}, -- Blessing of Might
		{ "20217", { "!player.buff(20217).any", "!player.buff(115921).any", "!player.buff(1126).any", "!player.buff(90363).any", "!player.buff(69378).any", "toggle.buff" }}, -- Blessing of Kings
		{ "25780", "!player.buff(25780).any" }, -- Fury
		
}

local inCombat = {
			
	-- keybinds
		{ "105593", "modifier.control", "target" }, -- Fist of Justice
		{ "853", "modifier.control", "target" }, -- Hammer of Justice
		{ "114158", "modifier.shift", "target.ground" }, -- Light´s Hammer
		{ "26573", "modifier.alt", "target.ground" }, -- consecration
		
		{ "121536", "player.moving", "player.ground" }, -- consecration
	
	-- Auto Target
		{ "/targetenemy [noexists]", { "toggle.autotarget", "!target.exists" }},
   		{ "/targetenemy [dead]", { "toggle.autotarget", "target.exists", "target.dead" }},

	-- seals
		{ "20165", { -- seal of Insight
			"player.seal != 3",
		}, nil },

	-- Hands
		{ "6940", { "lowest.health <= 80", "!player.health <= 40" }, "lowest" }, -- Hand of Sacrifice
		{ "1044", "player.state.root" }, -- Hand of Freedom
		
	-- Interrupt
		{ "96231", "modifier.interrupts"}, -- Rebuke

	{{-- Defensive Cooldowns
		{ "20925", "!player.buff(20925)", "player" }, -- Sacred Shield 		
		{ "31850", "player.health < 30" }, --Ardent Defender
		{ "498", "player.health <= 99" }, -- Divine Protection
		{ "86659", "player.health <= 50" }, -- Guardian of Ancient Kings
		{ "#gloves" },
	}, "toggle.defcd" },
	
	-- Cooldowns
		{ "31884", "modifier.cooldowns" }, -- Avenging Wrath
		{ "105809", "modifier.cooldowns" }, --Holy Avenger
		
	-- Self Heal
		{ "#5512", "player.health <= 60" }, --Healthstone
		{ "633", "player.health <= 20", "player"}, -- Lay on Hands
		{ "114163", { -- Eternal Flame
			"!player.buff(114163)",
			"player.buff(114637).count = 5",
			"player.holypower >= 3",
			"player.health <= 85"
		}, "player"},
		{ "85673", {  -- Word of Glory
			"player.buff(114637).count = 5",
			"player.holypower >= 3",
			"player.health <= 40"
		}, "player" },

	-- Rotation
		{ "24275", { -- Hammer of Wrath
			"target.health <= 20",
			"target.spell(24275).range"
		}, "target" },
		{ "31935", { -- Avenger´s Shield Pro
			"player.buff(98057)",
			"target.spell(31935).range"
		}, "target" },
		{ "53600", { -- Shield of the Righteous
			"player.holypower >= 3", 
			"target.spell(53600).range" 
		}, "target" },
		{ "35395", { -- Crusader Strike
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
		{ "114157", "target.spell(114157).range", "target" }, -- Execution Sentense
		{ "119072" }, -- Holy Wrath
  
}

local outCombat = {

-- keybinds
		{ "105593", "modifier.control", "target" }, -- Fist of Justice
		{ "853", "modifier.control", "target" }, -- Hammer of Justice
		{ "114158", "modifier.shift", "target.ground" }, -- Light´s Hammer
		{ "26573", "modifier.alt", "target.ground" }, -- consecration

	-- seals
		{ "20165", { -- seal of Insight
			"player.seal != 3",
		}, nil },

	-- Hands
		{ "1044", "player.state.root" }, -- Hand of Freedom

}

for _, Buffs in pairs(Buffs) do
  inCombat[#inCombat + 1] = Buffs
  outCombat[#outCombat + 1] = Buffs
end

ProbablyEngine.rotation.register_custom(66, "|r[|cff9482C9MTS|r][|cffF58CBAPaladin-Protection|r]", inCombat, outCombat, lib)