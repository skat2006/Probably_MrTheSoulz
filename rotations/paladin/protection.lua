local fetch = ProbablyEngine.interface.fetchKey

local lib = function()
mts_Splash("|cff9482C9[MTS]-|cffFFFFFF"..(select(2, GetSpecializationInfo(GetSpecialization())) or "Error").."-|cff9482C9Loaded", 5.0)
	
end

EmpoweredSeals = {

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

local Seals = {
	
	{{ ---------------------------------------------------------------------------------------------------------------------- Single Target
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
	}, "!modifier.multitarget" },
	
	{{ ---------------------------------------------------------------------------------------------------------------------- MultiTarget
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
	}, "modifier.multitarget" }

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

	{ "#5512", (function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfPalaProt', 'Healthstone')) end) }, 		-- Healthstone
	{ "633", (function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfPalaProt', 'LayonHands')) end), "player"}, -- Lay on Hands
	{ "114163", { ---------------------------------------------------------------------------------------------------------------- Eternal Flame
		"!player.buff(114163)", 
		"player.buff(114637).count = 5", 
		"player.holypower >= 3",
		(function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfPalaProt', 'EternalFlame')) end)
	}, "player"},
	{ "85673", { ---------------------------------------------------------------------------------------------------------------- Word of Glory
		"player.buff(114637).count = 5", 
		"player.holypower >= 3",
		(function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfPalaProt', 'WordofGlory')) end)
	}, "player" },

}

local DefCooldowns = {
	
	{ "20925", (function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfPalaProt', 'SacredShield')) end), "player" }, 	-- Sacred Shield
	{ "31850", (function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfPalaProt', 'ArdentDefender')) end) }, 			-- Ardent Defender
	{ "498", (function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfPalaProt', 'DivineProtection')) end) }, 			-- Divine Protection
	{ "86659", (function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfPalaProt', 'GuardianofAncientKings')) end) }, 	-- Guardian of Ancient Kings

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
The key to the Protection Paladin tanking priority is to maximize your Holy Power generation so 
  that you can spend it on Shield of the Righteous and Word of Glory as often as possible.
You will build Holy Power by using Crusader Strike and Judgment on cooldown. 
Prioritize Avenger's Shield when Grand Crusader procs. 
Your next priority is to use Hammer of Wrath when available on targets below 20% health. 
After this, cast Consecration and Holy Wrath as time and Mana allow.
The choice between spending Holy Power on Shield of the Righteous and Word of Glory depends on the specific encounter. 
Shield of the Righteous is your go-to Holy Power spender and should be maintained as much as possible to reduce physical 
  damage taken, but may be delayed by a few sec to line up with periods of high incoming melee damage. 
Word of Glory is a strong self-heal that should be used as often as Holy Power allows. 
It is okay to save a full stack of Bastion of Glory for a large Word of Glory if you expect to take a high amount of damage.
  ///---INFO---////  ]]
local Normal = { 
		
	-- Rotation
		{ "35395", "target.spell(35395).range", "target" }, 	-- Crusader Strike
		{ "20271", "target.spell(20271).range", "target" }, 	-- Judgment
		{ "31935", "target.spell(31935).range", "target" }, 	-- Avenger´s Shield
		{ "24275", "target.health <= 20", "target" }, 			-- Hammer of Wrath
		{ "26573", "target.range <= 6", "ground" }, 			-- consecration
		{ "119072", "target.range <= 10" }, 					-- Holy Wrath
		{ "114165", { 				------------------------------ Holy Prism
			"target.spell(114165).range", 	-- Spell in Range
			"talent(5, 1)" 					-- Got Talent
		}, "target"},
		{ "114157", "target.spell(114157).range", "target" }, 	-- Execution Sentence

}

ProbablyEngine.rotation.register_custom(66, mts_Icon.."|r[|cff9482C9MTS|r][|cffF58CBAPaladin-Protection|r]", 
	{ -- Dyn Change In-Combat CR
		{ DefCooldowns },										-- Defencive Cooldowns
		{ Heals },												-- Heals
		{ All },												-- Shared across all
		{ "96231", "modifier.interrupts", "target" }, 			-- Rebuke
		{ "105593", "modifier.control", "target" }, 			-- Fist of Justice
		{ "853", "modifier.control", "target" }, 				-- Hammer of Justice
		{ "114158", "modifier.shift", "target.ground" }, 		-- Light´s Hammer
		{ "62124", "@mtsLib.CanTaunt" },						-- Taunt
		{ EmpoweredSeals, "talent(7,1)" },						-- EmpoweredSeals // Talent
		{ seals, "!talent(7,1)" },								-- Smart Seals
		{ Cooldowns, "modifier.cooldowns" },					-- Cooldowns
		{ "31935", "player.buff(Grand Crusader)", "target" }, 	-- Avenger's Shield // Proc
		{ "53600", { 				------------------------------ Shield of Righteous
			"target.spell(53600).range", 	-- Spell in range
			"player.holypower > 3"			-- 3 Holy Power
		}, "target" },
		{ AoE, "modifier.multitarget" },						-- AoE Normal
		{ AoE, "player.area(8).enemies >= 3" },					-- AoE Smart
		{ Normal }												-- Normal CR
	}, 
	{
		{ Heals },	-- Heals
		{ All },	-- Shared across all
	}, lib)