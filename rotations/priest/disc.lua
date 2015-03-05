local fetch = ProbablyEngine.interface.fetchKey

local ignoreDebuffs = {
	'Mark of Arrogance',
	'Displaced Energy'
}

-- Dispell function
local function Dispell()
local prefix = (IsInRaid() and 'raid') or 'party'
	for i = -1, GetNumGroupMembers() - 1 do
	local unit = (i == -1 and 'target') or (i == 0 and 'player') or prefix .. i
		if IsSpellInRange('Purify', unit) then
			for j = 1, 40 do
			local debuffName, _, _, _, dispelType, duration, expires, _, _, _, spellID, _, isBossDebuff, _, _, _ = UnitDebuff(unit, j)
				if dispelType and dispelType == 'Magic' or dispelType == 'Disease' then
				local ignore = false
				for k = 1, #ignoreDebuffs do
					if debuffName == ignoreDebuffs[k] then
						ignore = true
						break
					end
				end
					if not ignore then
						--print("Dispelled: "..debuffName.." on: "..unit)
						ProbablyEngine.dsl.parsedTarget = unit
						return true
					end
				end
				if not debuffName then
					break
				end
			end
		end
	end
		return false
end

local exeOnLoad = function()
mts.Splash("|cff9482C9[MTS]-|cffFFFFFF"..(select(2, GetSpecializationInfo(GetSpecialization())) or "Error").."-|cff9482C9Loaded", 5.0)

	ProbablyEngine.toggle.create(
		'dotEverything', 
		'Interface\\Icons\\Ability_creature_cursed_05.png', 
		'Dot All The Things! (SOLO)', 
		'Click here to dot all the things while in Solo mode!\nSome Spells require Multitarget enabled also.\nOnly Works if using FireHack.')

end

local BorrowedTime = {
	
	{ "17", { 
		"!focus.debuff(6788).any",
		"!focus.buff(10).any",
		"focus.range <= 40",
	}, "focus" }, 
	{ "17", {
		"!tank.debuff(6788).any",
		"!tank.buff(10).any",
		"tank.range <= 40",
	}, "tank" },
	{ "17", {
		"!player.debuff(6788).any",
		"!player.buff(10).any",
	}, "player" },
	{ "17", {
		"lowest.health < 100",
		"!lowest.debuff(6788).any",
		"!lowest.buff(10).any",
	}, "lowest" }, 

}

local Attonement = {

	{ "14914", { --Holy Fire
		"player.mana > 20",
		"target.spell(14914).range",
	}, "target" },
	{{-- not moving
		{ "47540", "target.spell(47540).range", "target" } ,-- Penance
		{ "585", "target.spell(585).range", "target" }, --Smite
	}, "!player.moving" },

}

local SpiritShell = {

	-- Prayer of Healing
   	{ "596", "@mtsLib.PoH" },
	-- Flash Heal
	{ "!2061", {
		"lowest.health <= 40",
		"!player.moving"
	}, "lowest" },
	-- Heal
	{ "2060", {
		"lowest.health >= 40",
		"!player.moving"
	}, "lowest" }, 

}

local Cooldowns = {

	
	{ "10060", "player.mana < 80" },-- Power Infusion
	{ "109964", {-- Spirit Shell // Party
		"@coreHealing.needsHealing(50, 5)",
		"modifier.party"
	} },
	{ "109964", {-- Spirit Shell // Raid
		"@coreHealing.needsHealing(50, 3)",
		"modifier.raid"
	} }, 

	--Pain Suppression	
		-- ALL
			{ "33206", { 
				(function() return fetch("mtsconfPriestDisc", "PainSuppression") == 'Focus' end),
				(function() return fetch("mtsconfPriestDisc", "PainSuppressionTG") == 'Allways' end),
				(function() return mts.dynamicEval("focus.health <= " .. fetch('mtsconfPriestDisc', 'PainSuppressionHP')) end)
			}, "focus" },
			{ "33206", {
				(function() return fetch("mtsconfPriestDisc", "PainSuppression") == 'Tank' end),
				(function() return fetch("mtsconfPriestDisc", "PainSuppressionTG") == 'Allways' end),
				(function() return mts.dynamicEval("tank.health <= " .. fetch('mtsconfPriestDisc', 'PainSuppressionHP')) end)
			}, "tank" },
			{ "33206", {
				(function() return fetch("mtsconfPriestDisc", "PainSuppression") == 'Lowest' end),
				(function() return fetch("mtsconfPriestDisc", "PainSuppressionTG") == 'Allways' end),
				(function() return mts.dynamicEval("lowest.health <= " .. fetch('mtsconfPriestDisc', 'PainSuppressionHP')) end)
			}, "lowest" },

		-- Boss
			{ "33206", { 
				(function() return fetch("mtsconfPriestDisc", "PainSuppression") == 'Focus' end),
				(function() return fetch("mtsconfPriestDisc", "PainSuppressionTG") == 'Boss' end),
				(function() return mts.dynamicEval("focus.health <= " .. fetch('mtsconfPriestDisc', 'PainSuppressionHP')) end),
				"target.boss"
			}, "focus" },
			{ "33206", {
				(function() return fetch("mtsconfPriestDisc", "PainSuppression") == 'Tank' end),
				(function() return fetch("mtsconfPriestDisc", "PainSuppressionTG") == 'Boss' end),
				(function() return mts.dynamicEval("tank.health <= " .. fetch('mtsconfPriestDisc', 'PainSuppressionHP')) end),
				"target.boss"
			}, "tank" },
			{ "33206", {
				(function() return fetch("mtsconfPriestDisc", "PainSuppression") == 'Lowest' end),
				(function() return fetch("mtsconfPriestDisc", "PainSuppressionTG") == 'Boss' end),
				(function() return mts.dynamicEval("lowest.health <= " .. fetch('mtsconfPriestDisc', 'PainSuppressionHP')) end),
				"target.boss"
			}, "lowest" },

}

local AoE = {

	{ "62618", {  -- Power word Barrier // w/t CD's and on tank // PArty
		"@coreHealing.needsHealing(50, 3)", 
		"modifier.party", 
		"!player.moving", 
		"modifier.cooldowns",
		(function() return fetch("mtsconfPriestDisc", "PowerWordBarrier") end)
	}, "tank.ground" },
	{ "62618", {  -- Power word Barrier // w/t CD's and on tank // raid
		"@coreHealing.needsHealing(50, 5)", 
		"modifier.raid", 
		"!player.moving", 
		"modifier.cooldowns",
		(function() return fetch("mtsconfPriestDisc", "PowerWordBarrier") end)
	}, "tank.ground" },
	{ "121135", { -- cascade
		"@coreHealing.needsHealing(95, 3)", 
		"!player.moving"
	}, "lowest"},
	{ "33076", { --Prayer of Mending
		(function() return mts.dynamicEval("tank.health <= " .. fetch('mtsconfPriestDisc', 'PrayerofMendingTank')) end),
		"@coreHealing.needsHealing(90, 3)",
		"!player.moving", 
		"tank.spell(33076).range" 
	}, "tank" },
 	{ "596", "@mtsLib.PoH" },-- Prayer of Healing
   	{ "132157", "@mtsLib.holyNova", nil }, -- Holy Nova

}

local FlashHeal = {
	
	{ "!2061", {
		(function() return mts.dynamicEval("focus.health <= " .. fetch('mtsconfPriestDisc', 'FlashHealTank')) end),
		"focus.spell(2061).range",
		"!player.moving"
	}, "focus" },
	{ "!2061", {
		(function() return mts.dynamicEval("tank.health <= " .. fetch('mtsconfPriestDisc', 'FlashHealTank')) end), 
		"tank.spell(2061).range",
		"!player.moving"
	}, "tank" },
	{ "!2061", {
		(function() return mts.dynamicEval("player.health <= " .. fetch('mtsconfPriestDisc', 'FlashHealPlayer')) end),
			"!player.moving"
	}, "player" },
		{ "!2061", {
			(function() return mts.dynamicEval("lowest.health <= " .. fetch('mtsconfPriestDisc', 'FlashHealRaid')) end),
			"!player.moving"
	}, "lowest" },

}

local Normal = {

	-- Penance	
		{ "!47540", {
			(function() return mts.dynamicEval("lowest.health <= " .. fetch('mtsconfPriestDisc', 'PenanceRaid')) end),
			"!player.casting(2061)",
			"!player.moving",
			"!player.casting.percent >= 50"
		}, "lowest" }, 
	
	{{-- WorkAround a ID issue
	--Power Word: Shield
		{ "17", { 
			(function() return mts.dynamicEval("focus.health <= " .. fetch('mtsconfPriestDisc', 'ShieldTank')) end),
			"!focus.debuff(6788).any", 
			"focus.spell(17).range",
			"!focus.buff(17).any", 
		}, "focus" }, 
		{ "17", {
			(function() return mts.dynamicEval("tank.health <= " .. fetch('mtsconfPriestDisc', 'ShieldTank')) end),
			"!tank.debuff(6788).any", 
			"tank.spell(17).range",
			"!focus.buff(17).any", 
		}, "tank" },
		{ "17", {  --Power Word: Shield
			(function() return mts.dynamicEval("lowest.health <= " .. fetch('mtsconfPriestDisc', 'ShieldRaid')) end),
			"!lowest.debuff(6788).any", 
			"!lowest.buff(17).any", 
		}, "lowest" },
		{ "17", {
			(function() return mts.dynamicEval("player.health <= " .. fetch('mtsconfPriestDisc', 'ShieldPlayer')) end),
			"!player.debuff(6788).any", 
			"!player.buff(17).any", 
		}, "player" },
	}, "!lastcast(17)" },

	-- heal
		{ "2060", { -- Heal
			(function() return mts.dynamicEval("focus.health <= " .. fetch('mtsconfPriestDisc', 'HealTank')) end),
			"focus.spell(2060).range",
			"!player.moving"
		}, "focus" },
		{ "2060", {
			(function() return mts.dynamicEval("tank.health <= " .. fetch('mtsconfPriestDisc', 'HealTank')) end),
			"tank.spell(2060).range",
			"!player.moving"
		}, "tank" }, -- Heal
		{ "2060", { -- Heal	
			(function() return mts.dynamicEval("player.health <= " .. fetch('mtsconfPriestDisc', 'HealPlayer')) end),
			"!player.moving"
		}, "player" },
		{ "2060", {-- Heal
			(function() return mts.dynamicEval("lowest.health <= " .. fetch('mtsconfPriestDisc', 'HealRaid')) end),
			"!player.moving"
		}, "lowest" }, 

}

local Solo = {

	{{-- Auto Dotting
		{ "32379", "@mtsLib.mtsDot(32379, 0, 20)" }, -- SW:D
		{ "589", "@mtsLib.mtsDot(589, 2, 100)" }, -- SW:P 
	}, "toggle.dotEverything" },

  	-- CD's
		{ "10060", "modifier.cooldowns" }, --Power Infusion 

	-- Flash Heal
		{ "2061", { --Flash Heal
			(function() return mts.dynamicEval("player.health <= " .. fetch('mtsconfPriestDisc', 'FlashHealPlayer')) end),
			"!player.moving"
		}, "player" },
	
	-- shields
		{ "17", { --Power Word: Shield
			(function() return mts.dynamicEval("player.health <= " .. fetch('mtsconfPriestDisc', 'ShieldPlayer')) end),
			"!player.debuff(6788).any", 
			"!player.buff(17).any" 
		}, "player" },

}

local outCombat = {
	
	-- Heals 
		{ "!47540", { --Penance
			(function() return mts.dynamicEval("lowest.health <= " .. fetch('mtsconfPriestDisc', 'PenanceRaid')) end),
			"!player.casting(2061)",
			"!player.moving"
		}, "lowest" },
		{ "2060", {-- Heal
			(function() return mts.dynamicEval("lowest.health <= " .. fetch('mtsconfPriestDisc', 'HealRaid')) end),
			"!player.moving"
		}, "lowest" }, 

}

local Clarity_of_Will = {
	
	{ "152118", { -- tank
		(function() return mts.dynamicEval("tank.health < " .. fetch('mtsconfPriestDisc', 'CoWTank_spin')) end),
		(function() return fetch('mtsconfPriestDisc', 'CoWTank_check') end) 
		"!player.moving",
		"!tank.buff(152118)" -- Should we go any higher? 		
	}, "tank" },
	{ "152118", { -- tank
		(function() return mts.dynamicEval("lowest.health < " .. fetch('mtsconfPriestDisc', 'CoW_spin')) end),
		(function() return fetch('mtsconfPriestDisc', 'CoW_check') end) 
		"!player.moving",
		"!lowest.buff(152118)" -- Should we go any higher? 		
	}, "lowest" },

}

local SavingGrace = {
	
	{ "!152116", {
		(function() return mts.dynamicEval("focus.health <= " .. fetch('mtsconfPriestDisc', 'SavingGraceTank_spin')) end), 
		(function() return fetch('mtsconfPriestDisc', 'SavingGraceTank_check') end),
		"!player.moving",
	}, "focus" },
	{ "!152116", {
		(function() return mts.dynamicEval("tank.health <= " .. fetch('mtsconfPriestDisc', 'SavingGraceTank_spin')) end), 
		(function() return fetch('mtsconfPriestDisc', 'SavingGraceTank_check') end),
		"!player.moving",
	}, "tank" },
	{ "!152116", {
		(function() return mts.dynamicEval("lowest.health <= " .. fetch('mtsconfPriestDisc', 'SavingGrace_spin')) end), 
		(function() return fetch('mtsconfPriestDisc', 'SavingGrace_check') end),
		"!player.moving",
	}, "lowest" },

}

local All = {

	-- Key Binds
		{ "48045", "modifier.alt", "target" }, -- Mind Sear
	
	-- buffs
		{ "21562", "!player.buffs.stamina" }, -- Fortitude
		{ "81700", "player.buff(81661).count = 5" }, -- Archangel
	
	{{-- Dispell ALl // Dont interrumpt if castbar more then 50%
		{ "!527", (function() return Dispell() end) },-- Dispel Everything
	}, "!player.casting.percent >= 50", (function() return fetch('mtsconfPriestDisc','Dispels') end) },

	-- Sulvival
		{ "19236", "player.health <= 20", "player" }, --Desperate Prayer
		{ "#5512", "player.health <= 35" }, -- Health Stone
		{ "586", "target.threat >= 80" }, -- Fade
			-- Surge of light
			{ "2061", {-- Flash Heal
				"lowest.health < 100",
				"player.buff(114255)",
				"!player.moving"
			}, "lowest" },

	{{-- LoOk aT It GOoZ!!!
		{ "121536", { 
			"player.movingfor > 2", 
			"!player.buff(121557)", 
			"player.spell(121536).charges >= 1" 
		}, "player.ground" },
		{ "17", {
			"talent(2, 1)", 
			"player.movingfor > 2", 
			"!player.buff(17)",
		}, "player" },
	}, -- We only want to run these on unlockers that can cast on unit.ground
		(function()
			if FireHack or oexecute then
				return fetch('mtsconfPriestDisc', 'Feathers') 
			end
		end)  
	},

}
	
ProbablyEngine.rotation.register_custom(
	256, 
	mts.Icon.."|r[|cff9482C9MTS|r][|cffFFFFFFPriest-Disc-Party|r]", 
	{ ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ In-Combat
		 	------------------------------------------------------------------------------------------------------------------------------------- All in combat
		 		{ All },																									-- Shared across all
		 	------------------------------------------------------------------------------------------------------------------ Mana
			 	{ "123040", { ----------------------------------------------------------- Mindbender
					"player.mana < 85",				-- Need mana
					"target.range <= 40"			-- Spell in range
				}, "target" },--------------------------------------------------
				{ "34433", { ----------------------------------------------------------- Shadowfiend
					"player.mana < 85",				-- Need mana
					"target.range <= 40"			-- Spell in range
				}, "target" },--------------------------------------------------
				{ "129250", { ----------------------------------------------------------- PW:Solance
					"target.spell(129250).range",	-- Spell in range
					"talent(3,3)",					-- Got talent
					"target.infront"
				}, "target" },------------------------------------------------------------------------------------------
		{{ ------------------------------------------------------------------------------------------------------------------------------------- Party/Raid CR
				{ "32375", "modifier.control", "player.ground" }, 															-- Mass Dispel
				{ "62618", "modifier.shift", "tank.ground" },																-- Power word Barrier // w/t CD's and on tank // PArty
				{ Cooldowns, "modifier.cooldowns" },																		-- Cooldowns
				{ SavingGrace, {---------------------------------------------------------------------------------------------- Saving Grace // Talent
					"talent(7,3)",
					(function() return mts.dynamicEval("!player.debuff(155274) >= " .. fetch('mtsconfPriestDisc', 'SavingGraceStacks')) end),
				}}, 
				{ Clarity_of_Will, "talent(7,1)" },																			-- Clarity of Will // Talent
				{ FlashHeal, {------------------------------------------------------------------------------------------------ Flash Heal // dont interrumpt if castbar more then 50%
					"!player.casting.percent >= 50",
					"!talent(7,3)"
				}},	
		 		{ BorrowedTime, "player.buff(59889).duration <= 2" },														-- BorrowedTime // Passive Buff
		 		{ SpiritShell, "player.buff(109964)" },																		-- SpiritShell // Talent
			 	{ Attonement, {----------------------------------------------------------------------------------------------- Attonement
			 		(function() return mts.dynamicEval("lowest.health >= " .. fetch('mtsconfPriestDisc', 'Attonement')) end),
					(function() return mts.Infront('target') end),
					--"!player.buff(81661).count = 5",
					"!player.mana < 20",
					--"target.range <= 30",
					--"target.infront"
			 	}}, ----------------------------------------------------------------------------------------------------------
		 		{ AoE, "modifier.multitarget" },																			-- AoE Heals
				{ Normal}																									-- Normal Heals
		}, "modifier.party" },
		{{ ------------------------------------------------------------------------------------------------------------------------------------- Solo CR
			{ FlashHeal, "!player.casting.percent >= 50" },
			{ Solo },
			{ Attonement },
		}, "!modifier.party" },
	},  
	{ ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ Out-Combat
		{ All },
		{ FlashHeal, "!player.casting.percent >= 50" },
		{outCombat}
	}, exeOnLoad)