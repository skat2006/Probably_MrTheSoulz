local fetch = ProbablyEngine.interface.fetchKey

local exeOnLoad = function()
	mts.Splash("|cff9482C9[MTS]|r-[|cffF58CBAPaladin-Protection|r]-|cff9482C9Loaded", 5.0)
	
end

local EmpoweredSeals = {

	------------------------------------------------------------------------------ Seal of Truth
	{ "31801", { 
		"player.seal != 1", 					-- Seal of Truth
		"!player.buff(156990).duration > 3", 	-- Maraad's Truth
		"player.spell(20271).cooldown <= 1" 	-- Judment  CD less then 1
	}},
	------------------------------------------------------------------------------ Seal of Righteousness
	{ "20154", {
		"player.seal != 2", 					-- Seal of Righteousness
		"!player.buff(156989).duration > 3", 	-- Liadrin's Righteousness
		"player.buff(156990)", 					-- Maraad's Truth
		"player.spell(20271).cooldown <= 1" 	-- Judment  CD less then 1
	}},
		------------------------------------------------------------------------------ Seal of Insigh
	{ "20165", {
		"player.seal != 3", 					-- Seal of Insigh
		"!player.buff(156988).duration > 3", 	-- Uther's Insight
		"player.buff(156990)", 					-- Maraad's Truth
		"player.buff(156989)", 					-- Liadrin's Righteousness
		"player.spell(20271).cooldown <= 1" 	-- Judment  CD less then 1
	}},
		
	------------------------------------------------------------------------------ Judgment
	{ "20271", { 
		"player.buff(156989).duration < 3", 	-- Liadrin's Righteousness
		"player.seal != 2"						-- Seal of Righteousness
	}},
	{ "20271", { 
		"player.buff(156990).duration < 3",		-- Maraad's Truth
		"player.seal != 1"						-- Seal of Truth
	}},
	{ "20271", {
		"player.buff(156988).duration < 3", 	-- Uther's Insight
		"player.seal != 3"						-- Seal of Insigh
	}},

}

local Seals_AoE = {

	---------------------------------------------------------------------------------------------------- Seal of Insigh
	{ "20165", { 
		"player.seal != 3", 															-- Seal of Insigh
		(function() return fetch("mtsconfPalaProt", "sealAoE") == 'Insight' end),		-- GUI option
	}},
	---------------------------------------------------------------------------------------------------- Seal of Righteousness
	{ "20154", { 
		"player.seal != 2",																-- Seal of Righteousness
		(function() return fetch("mtsconfPalaProt", "sealAoE") == 'Righteousness' end),	-- GUI option
	}},
	---------------------------------------------------------------------------------------------------- Seal of truth
	{ "31801", {
		"player.seal != 1",																-- Seal of truth
		(function() return fetch("mtsconfPalaProt", "sealAoE") == 'Truth' end),			-- GUI option
	}},

}

local Seals = {
	
	---------------------------------------------------------------------------------------------------- Seal of Insigh
	{ "20165", { 
		"player.seal != 3", 															-- Seal of Insigh
		(function() return fetch("mtsconfPalaProt", "seal") == 'Insight' end),			-- GUI option
	}},
		---------------------------------------------------------------------------------------------------- Seal of Righteousness
	{ "20154", { 
		"player.seal != 2",																-- Seal of Righteousness
		(function() return fetch("mtsconfPalaProt", "seal") == 'Righteousness' end),	-- GUI option
	}},
		---------------------------------------------------------------------------------------------------- Seal of truth
	{ "31801", {
		"player.seal != 1",																-- Seal of truth
		(function() return fetch("mtsconfPalaProt", "seal") == 'Truth' end),			-- GUI option
	}},

}

local Cooldowns = {
	
		{ "31884" }, 											-- Avenging Wrath
		{ "105809" }, 											-- Holy Avenger
		{ "114158", "target.range <= 30", "target.ground" }, 	-- Light´s Hammer
		{ "#gloves" },											-- Gloves
		{{ ------------------------------------------------------- Seraphim
			{ "Seraphim" },   -- Seraphim
			{ "Holy Avenger", { ------------------- Holy Avenger
				"player.holypower < 3",  -- 3 Holy Power
				"player.buff(Seraphim)", -- Buff Seraphin
			}},
		}, "talent(7, 2)" },

}
--[[ ///---INFO---////
Tanking multiple targets basically follows the single target priority except you 
  replace Crusader Strike and Judgment with Hammer of the Righteous. 
Use Avenger's Shield as much as possible and watch for Grand Crusader procs. 
Next, cast Consecration and Holy Wrath on cooldown. Seal of Righteousness replaces Seal of Truth for AoE tanking.
  ///---INFO---////  ]]
local AoE = {

		{ "53595", "target.spell(Crusader Strike).range", "target" }, 	-- Hammer of the Righteous
		{ "31935" }, 													-- Avenger's Shield
		{ "26573", { 	-------------------------------------------------- Consecration 
			"target.range <= 10",  	-- range less then 10
			"!player.moving" 		-- Not Moving
		}},
		{ "119072", "target.range <= 10" }, 							-- Holy Wrath

}

local Heals = {

	{ "#5512", (function() return mts.dynamicEval("player.health <= " .. fetch('mtsconfPalaProt', 'Healthstone')) end) }, 		-- Healthstone
	{ "633", (function() return mts.dynamicEval("player.health <= " .. fetch('mtsconfPalaProt', 'LayonHands')) end), "player"}, -- Lay on Hands
	{ "114163", { ---------------------------------------------------------------------------------------------------------------- Eternal Flame
		"!player.buff(114163)", 
		"player.buff(114637).count = 5", 
		"player.holypower >= 3",
		(function() return mts.dynamicEval("player.health <= " .. fetch('mtsconfPalaProt', 'EternalFlame')) end)
	}, "player"},
	{ "85673", { ---------------------------------------------------------------------------------------------------------------- Word of Glory
		"player.buff(114637).count = 5", 
		"player.holypower >= 3",
		(function() return mts.dynamicEval("player.health <= " .. fetch('mtsconfPalaProt', 'WordofGlory')) end)
	}, "player" },

}

local RaidHeals = {

	{ "Flash of Light", { 
		"player.buff(Selfless Healer).count = 3", 
		(function() return dynamicEval("lowest.health <= " .. fetch('mtsconfPalaProt', 'FlashOfLight_Raid')) end), 
	}, "lowest" },		
	{ "Lay on Hands", (function() return dynamicEval("lowest.health <= " .. fetch('mtsconfPalaProt', 'LayOnHands_Raid')) end), "lowest" },
	{ "Hand of Protection", { 
		"lowest.alive", 
		"!lowest.role(tank)", 
		"!lowest.immune.melee", 
		(function() return dynamicEval("lowest.health <= " .. fetch('mtsconfPalaProt', 'HandOfProtection_Raid')) end), 
	}, "lowest" }


}

local DefCooldowns = {
	
	{ "20925", (function() return mts.dynamicEval("player.health <= " .. fetch('mtsconfPalaProt', 'SacredShield')) end), "player" }, 	-- Sacred Shield
	{ "31850", (function() return mts.dynamicEval("player.health <= " .. fetch('mtsconfPalaProt', 'ArdentDefender')) end) }, 			-- Ardent Defender
	{ "498", (function() return mts.dynamicEval("player.health <= " .. fetch('mtsconfPalaProt', 'DivineProtection')) end) }, 			-- Divine Protection
	{ "86659", (function() return mts.dynamicEval("player.health <= " .. fetch('mtsconfPalaProt', 'GuardianofAncientKings')) end) }, 	-- Guardian of Ancient Kings

}

local All = {

		--{ "6940", { ---------------------------------------- Hand of Sacrifice
			--"lowest.health <= 80", 	-- Lowest less then 80% hp.
			--"!player.health <= 40"	-- Player not less then 40% hp.
		--}, "lowest" }, 
		{ "1044", "player.state.root" }, 					-- Hand of Freedom
		{ "20217", { ----------------------------------------- Blessing of Kings
			"!player.buff(20217).any",
			"!player.buff(115921).any", 
			"!player.buff(1126).any", 
			"!player.buff(90363).any", 
			"!player.buff(69378).any",
			(function() return fetch("mtsconfPalaProt", "Buff") == 'Kings' end),
		}},
		{ "19740", { ----------------------------------------- Blessing of Might
			"!player.buff(19740).any", 
			"!player.buff(116956).any", 
			"!player.buff(93435).any", 
			"!player.buff(128997).any", 
			(function() return fetch("mtsconfPalaProt", "Buff") == 'Might' end),
		}},
		{ "25780", "!player.buff(25780).any" }, 			-- Fury
		{ "85499", { ----------------------------------------- Speed of Light
			"player.movingfor > 3", 	-- Moving for 3 Sec.
			(function() return fetch('mtsconfPalaProt','RunFaster') end),
		}},

}

--[[ ///---INFO---////

  ///---INFO---////  ]]
local Normal = { 
		


}

ProbablyEngine.rotation.register_custom(70, mts.Icon.."|r[|cff9482C9MTS|r][|cffF58CBAPaladin-Retribution|r]", 
	{ -- In-Combat
		{ DefCooldowns },											-- Defencive Cooldowns
		{ Heals },													-- Heals
		{ RaidHeals },												-- Raid Heals
		{ All },													-- Shared across all
		{ "96231", "modifier.interrupts", "target" }, 				-- Rebuke
		{ "105593", "modifier.control", "target" }, 				-- Fist of Justice
		{ "853", "modifier.control", "target" }, 					-- Hammer of Justice
		{ "114158", "modifier.shift", "target.ground" }, 			-- Light´s Hammer
		{ "62124", "@mtsLib.CanTaunt" },							-- Taunt
		{ EmpoweredSeals, "talent(7,1)" },							-- EmpoweredSeals // Talent
		{ Seals_AoE, { ----------------------------------------------- Seals AoE
			"!talent(7,1)", 				-- Dont have EmpoweredSeals
			"modifier.multitarget"			-- Multi-target Toggle
		}},
		{ Seals_AoE, { ----------------------------------------------- Seals AoE AUTO
			"!talent(7,1)", 				-- Dont have EmpoweredSeals
			"player.area(8).enemies >= 3",	-- 3 or more enemies around
			"!modifier.multitarget"			-- Dont bother if Multi-target Toggle beacuse we already checking it
		}},
		{ Seals, { --------------------------------------------------- Seals
			"!talent(7,1)", 				-- Dont have EmpoweredSeals
			"!player.area(8).enemies >= 3", -- Not AoE
			"!modifier.multitarget"			-- Not AoE
		}},
		{ Cooldowns, "modifier.cooldowns" },						-- Cooldowns
		{ "31935", "player.buff(Grand Crusader)", "target" }, 		-- Avenger's Shield // Proc
		{ AoE, "modifier.multitarget" },							-- AoE Normal
		{ AoE, "player.area(8).enemies >= 3" },						-- AoE Smart
		{ Normal }													-- Normal CR
	}, 
	{ -- Out combat
		{ Heals },	-- Heals
		{ All },	-- Shared across all
	}, exeOnLoad)