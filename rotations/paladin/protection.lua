-- //////////////////////-----------------------------------------INFO-----------------------------------//////////////////////////////
--													   	//Paladin Protection//
--													Thank Your For Your My ProFiles
--														I Hope Your Enjoy Them
--																  MTS


local fetch = ProbablyEngine.interface.fetchKey

local function seal(txt)
	local _seal = ProbablyEngine.interface.fetchKey("mtsconfPalaProt", "seal")
	
	if _seal == 'Insight' and txt == 'Insight' 
		or _seal == 'Righteousness'and txt == 'Righteousness'
		or _seal == 'Truth' and txt == 'Truth' then
			return true
	end
	 	
	 	return false
end

local lib = function()

	ProbablyEngine.toggle.create('defcd', 
		'Interface\\Icons\\Spell_holy_devotionaura.png', 
		'Defensive Cooldowns', 
		'Enable or Disable Defensive Cooldowns.')
	
	mtsStart:message("\124cff9482C9*MTS-\124cffF58CBAPaladin/Protection-\124cff9482C9Loaded*")
	
	ProbablyEngine.toggle.create( 'GUI', 
		'Interface\\AddOns\\Probably_MrTheSoulz\\media\\toggle.blp:36:36"', 
		'Open/Close GUIs',
		'Toggle GUIs', 
		(function() mts_ClassGUI() mts_ConfigGUI() end) )     

	mts_showLive()
	
end

local inCombat = {
	
	-- Buffs
		--{ "20217", { "player.buffs.stats", "@mtsLib.Dropdown('Kings')" }, nil },
		--{ "19740", { "player.buffs.attackpower", "@mtsLib.Dropdown('Might')" }, nil },
		{ "25780", "!player.buff(25780).any" }, -- Fury

	-- Seals
		{ "20165", { -- seal of Insigh
			"player.seal != 3", 
			(function() return seal('Insight') end),
			}, nil }, 
		
		{ "20154", { -- seal of Righteousness
			"player.seal != 2",
			(function() return seal('Righteousness') end),
			}, nil },
		
		{ "31801", { -- seal of truth
			"player.seal != 1", 
			(function() return seal('Truth') end),
			}, nil },

	-- run fast
		{ "85499", { -- Speed of Light
			"player.movingfor > 3", 
			(function() return fetch('mtsconfPalaProt','RunFaster') end),
			}},

	-- keybinds
		{ "105593", "modifier.control", "target" }, -- Fist of Justice
		{ "853", "modifier.control", "target" }, -- Hammer of Justice
		{ "114158", "modifier.shift", "target.ground" }, -- Light´s Hammer
	
	-- Auto Targets
		{ "/cleartarget", {
			(function() return fetch('mtsconfPalaProt','AutoTarget') end), 
			(function() return UnitIsFriend("player","target") end)
			}},

		{ "/target [target=focustarget, harm, nodead]", { -- Use Tank Target
			(function() return fetch('mtsconfPalaProt','AutoTarget') end),
			"target.range > 40"
			 }}, 
		{ "/targetenemy [noexists]", { -- target enemire if no target
			(function() return fetch('mtsconfPalaProt','AutoTarget') end),
			"!target.exists" 
			}},
		{ "/targetenemy [dead]", { -- target enemire if current is dead.
			(function() return fetch('mtsconfPalaProt','AutoTarget') end), 
			"target.exists", 
			"target.dead" 
			}},

	-- Hands
		--{ "6940", { "lowest.health <= 80", "!player.health <= 40" }, "lowest" }, -- Hand of Sacrifice
		{ "1044", "player.state.root" }, -- Hand of Freedom

	-- Interrupt
		{ "96231", "modifier.interrupts", "target" }, -- Rebuke

	-- Defensive Cooldowns
		{ "20925", (function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfPalaProt', 'SacredShield')) end), "player" }, -- Sacred Shield
		{ "31850", (function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfPalaProt', 'ArdentDefender')) end) }, --Ardent Defender
		{ "498", (function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfPalaProt', 'DivineProtection')) end) }, -- Divine Protection
		{ "86659", (function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfPalaProt', 'GuardianofAncientKings')) end) }, -- Guardian of Ancient Kings

	-- Cooldowns
		{ "31884", "modifier.cooldowns" }, -- Avenging Wrath
		{ "105809", "modifier.cooldowns" }, --Holy Avenger
		{ "114158", {"modifier.cooldowns", "target.range <= 30"}, "target.ground" }, -- Light´s Hammer
		{ "#gloves", "modifier.cooldowns" },
		
	-- Self Heal
		{ "#5512", (function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfPalaProt', 'Healthstone')) end) }, --Healthstone
		{ "633", (function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfPalaProt', 'LayonHands')) end), "player"}, -- Lay on Hands
		{ "114163", { -- Eternal Flame
			"!player.buff(114163)", 
			"player.buff(114637).count = 5", 
			"player.holypower >= 3",
			(function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfPalaProt', 'EternalFlame')) end)
			}, "player"},

		{ "85673", { -- Word of Glory
			"player.buff(114637).count = 5", 
			"player.holypower >= 3",
			(function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfPalaProt', 'WordofGlory')) end)
			}, "player" },

	-- Procs
		{ "31935", { "modifier.multitarget", "player.buff(Grand Crusader)" }, "target" }, -- Avenger's Shield

	-- Holy Ditchers
		{ "53600", {"target.spell(53600).range", "player.holypower > 3"}, "target" }, -- Shield of Righteous

	-- AOE Rotation
		{ "53595", { "target.spell(Crusader Strike).range", "modifier.multitarget" }, "target" }, -- Hammer of the Righteous
		{ "31935", "modifier.multitarget", "target" }, -- Avenger's Shield
		{ "26573", { "modifier.multitarget", "target.range <= 10", "!player.moving" }}, -- Consecration
		{ "119072", { "modifier.multitarget", "target.range <= 10"  }}, -- Holy Wrath
	
	-- Rotation
		{ "35395", "target.spell(35395).range", "target" }, -- Crusader Strike
		{ "20271", "target.spell(20271).range", "target" }, -- Judgment
		{ "31935", "target.spell(31935).range", "target" }, -- Avenger´s Shield
		{ "24275", "target.health <= 20", "target" }, -- Hammer of Wrath
		{ "26573", "target.range <= 6", "ground" }, -- consecration
		{ "119072", "target.range <= 10" }, -- Holy Wrath
		{ "114165", { "target.spell(114165).range", "talent(5, 1)" }, "target"}, -- Holy Prism
		{ "114157", "target.spell(114157).range", "target" }, -- Execution Sentence

}

local outCombat = {
	
	-- keybinds
		{ "105593", "modifier.control", "target" }, -- Fist of Justice
		{ "853", "modifier.control", "target" }, -- Hammer of Justice
		{ "114158", "modifier.shift", "target.ground" }, -- Light´s Hammer

	-- Hands
		{ "1044", "player.state.root" }, -- Hand of Freedom

	-- Buffs
		--{ "20217", { "!player.buffs.stats", "@mtsLib.Dropdown('Kings')" }, nil },
		--{ "19740", { "!player.buffs.attackpower", "@mtsLib.Dropdown('Might')" }, nil },
		{ "25780", "!player.buff(25780).any" }, -- Fury

	-- Seals
		{ "20165", { -- seal of Insigh
			"player.seal != 3", 
			(function() return seal('Insight') end),
			}, nil }, 
		
		{ "20154", { -- seal of Righteousness
			"player.seal != 2",
			(function() return seal('Righteousness') end),
			}, nil },
		
		{ "31801", { -- seal of truth
			"player.seal != 1", 
			(function() return seal('Truth') end),
			}, nil },

	-- run fast
		{ "85499", { -- Speed of Light
			"player.movingfor > 3", 
			(function() return fetch('mtsconfPalaProt','RunFaster') end),
			}},

}

ProbablyEngine.rotation.register_custom(
	66, 
	mts_Icon.."|r[|cff9482C9MTS|r][|cffF58CBAPaladin-Protection|r]", 
	inCombat, 
	outCombat, 
	lib)