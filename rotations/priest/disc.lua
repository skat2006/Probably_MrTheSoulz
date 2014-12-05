--[[ ///---INFO---////
//Priest Disc//
Thank You For Using My ProFiles
I Hope Your Enjoy Them
MTS
]]--

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

	ProbablyEngine.toggle.create(
		'dotEverything', 
		'Interface\\Icons\\Ability_creature_cursed_05.png', 
		'Dot All The Things! (SOLO)', 
		'Click here to dot all the things while in Solo mode!\nSome Spells require Multitarget enabled also.\nOnly Works if using FireHack.')

end

local inCombat = {
	
  	--keybinds
		{ "32375", "modifier.rcontrol", "player.ground" }, --Mass Dispel
	 	{ "48045", "modifier.ralt", "tank" }, -- Mind Sear

	-- Dispel's
  		{{-- Dont interrumpt if castbar more then 50%
		 	-- Dispell ALl
				{ "!527", (function() return Dispell() end) },-- Dispel Everything
		}, "!player.casting.percent >= 50", (function() return fetch('mtsconfPriestDisc','Dispels') end)  },  

   	-- buffs
		{ "81700", "player.buff(81661).count = 5" }, -- Archangel
	
	-- LoOk aT It GOoZ!!!
		{ "121536", {
			(function() return fetch('mtsconfPriestDisc', 'Feathers') end), 
			"player.movingfor > 2", 
			"!player.buff(121557)", 
			"player.spell(121536).charges >= 1" 
		}, "player.ground" },
		{ "17", {
			"talent(2, 1)", 
			"player.movingfor > 2", 
			"!player.buff(6788)", 
			(function() return fetch('mtsconfPriestDisc', 'Feathers') end)
		}, "player" },

  	-- Mana/Survival
		{ "123040", { --Mindbender
			"player.mana < 75",
			"target.spell(123040).range"
		}, "target" },
		{ "34433", { --Shadowfiend
			"player.mana < 75",
			"target.spell(34433).range"
		}, "target" },
		{ "19236", "player.health <= 20", "Player" }, --Desperate Prayer

  	-- HEALTHSTONE 
		{ "#5512", "player.health <= 35" },

  	-- Aggro
		{ "586", "target.threat >= 80" }, -- Fade

  	-- CD's --Power Infusion
		{ "10060", {
			"modifier.cooldowns",
			"player.mana < 80"
		}},
		{ "109964", { -- Spirit Shell
			"modifier.cooldowns",
			"@coreHealing.needsHealing(50, 5)"
		}},
		
		--Pain Suppression	
			-- ALL
				{ "33206", { 
					(function() return fetch("mtsconfPriestDisc", "PainSuppression") == 'Focus' end),
					(function() return fetch("mtsconfPriestDisc", "PainSuppressionTG") == 'Allways' end),
					(function() return mts_dynamicEval("focus.health <= " .. fetch('mtsconfPriestDisc', 'PainSuppressionHP')) end)
				}, "focus" },
				{ "33206", {
					(function() return fetch("mtsconfPriestDisc", "PainSuppression") == 'Tank' end),
					(function() return fetch("mtsconfPriestDisc", "PainSuppressionTG") == 'Allways' end),
					(function() return mts_dynamicEval("tank.health <= " .. fetch('mtsconfPriestDisc', 'PainSuppressionHP')) end)
				}, "tank" },
				{ "33206", {
					(function() return fetch("mtsconfPriestDisc", "PainSuppression") == 'Lowest' end),
					(function() return fetch("mtsconfPriestDisc", "PainSuppressionTG") == 'Allways' end),
					(function() return mts_dynamicEval("lowest.health <= " .. fetch('mtsconfPriestDisc', 'PainSuppressionHP')) end)
				}, "lowest" },
			
			-- Boss
				{ "33206", { 
					(function() return fetch("mtsconfPriestDisc", "PainSuppression") == 'Focus' end),
					(function() return fetch("mtsconfPriestDisc", "PainSuppressionTG") == 'Boss' end),
					(function() return mts_dynamicEval("focus.health <= " .. fetch('mtsconfPriestDisc', 'PainSuppressionHP')) end),
					"target.boss"
				}, "focus" },
				{ "33206", {
					(function() return fetch("mtsconfPriestDisc", "PainSuppression") == 'Tank' end),
					(function() return fetch("mtsconfPriestDisc", "PainSuppressionTG") == 'Boss' end),
					(function() return mts_dynamicEval("tank.health <= " .. fetch('mtsconfPriestDisc', 'PainSuppressionHP')) end),
					"target.boss"
				}, "tank" },
				{ "33206", {
					(function() return fetch("mtsconfPriestDisc", "PainSuppression") == 'Lowest' end),
					(function() return fetch("mtsconfPriestDisc", "PainSuppressionTG") == 'Boss' end),
					(function() return mts_dynamicEval("lowest.health <= " .. fetch('mtsconfPriestDisc', 'PainSuppressionHP')) end),
					"target.boss"
				}, "lowest" },

	-- For Archangel
		{ "14914", { --Holy Fire
			"player.mana > 20",
			"target.spell(14914).range",
			"target.infront"
		}, "target" },

	-- Surge of light
		{ "2061", {-- Flash Heal
			"lowest.health < 100",
			"player.buff(114255)",
			"!player.moving"
		}, "lowest" },

	{{ -- spirit shell
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
	}, "player.buff(109964)"},

	{{-- AOE
		{ "62618", {  -- Power word Barrier // w/t CD's and on tank
			"@coreHealing.needsHealing(50, 5)", 
			"modifier.party", 
			"!player.moving", 
			"modifier.cooldowns" 
		}, "tank.ground" },
		{ "121135", { -- cascade
			"@coreHealing.needsHealing(95, 3)", 
				"!player.moving"
		}, "lowest"},
		{ "33076", { --Prayer of Mending
			(function() return mts_dynamicEval("tank.health <= " .. fetch('mtsconfPriestDisc', 'PrayerofMendingTank')) end),
			"@coreHealing.needsHealing(90, 3)",
			"!player.moving", 
			"tank.spell(17).range" 
		}, "tank" },
 		{ "596", "@mtsLib.PoH" },-- Prayer of Healing
   		{ "132157", "@mtsLib.holyNova", nil }, -- Holy Nova
	}, "modifier.multitarget" },
	
	-- Penance	
		{ "!47540", {
			(function() return mts_dynamicEval("lowest.health <= " .. fetch('mtsconfPriestDisc', 'PenanceRaid')) end),
			"!player.casting(2061)",
			"!player.moving",
			"!player.casting.percent >= 50"
		}, "lowest" }, 
	
	--Power Word: Shield
		{ "17", { 
			(function() return mts_dynamicEval("focus.health <= " .. fetch('mtsconfPriestDisc', 'ShieldTank')) end),
			"!focus.debuff(6788).any", 
			"focus.spell(17).range",
			"!modifier.last" 
		}, "focus" }, 
		{ "17", {
			(function() return mts_dynamicEval("tank.health <= " .. fetch('mtsconfPriestDisc', 'ShieldTank')) end),
			"!tank.debuff(6788).any", 
			"tank.spell(17).range",
			"!modifier.last" 
		}, "tank" },
		{ "17", {  --Power Word: Shield
			(function() return mts_dynamicEval("lowest.health <= " .. fetch('mtsconfPriestDisc', 'ShieldRaid')) end),
			"!lowest.debuff(6788).any", 
			"!lowest.buff(17).any", 
		}, "lowest" },
		{ "17", {
			(function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfPriestDisc', 'ShieldPlayer')) end),
			"!player.debuff(6788).any", 
			"!player.buff(17).any",
			"!modifier.last" 
		}, "player" },
	
	{{-- Flash Heal // dont interrumpt if castbar more then 50%
		{ "!2061", {
			(function() return mts_dynamicEval("focus.health <= " .. fetch('mtsconfPriestDisc', 'FlashHealTank')) end),
			"focus.spell(2061).range",
			"!player.moving"
		}, "focus" },
		{ "!2061", {
			(function() return mts_dynamicEval("tank.health <= " .. fetch('mtsconfPriestDisc', 'FlashHealTank')) end), 
			"tank.spell(2061).range",
			"!player.moving"
		}, "tank" },
		{ "!2061", {
			(function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfPriestDisc', 'FlashHealPlayer')) end),
			"!player.moving"
		}, "player" },
		{ "!2061", {
			(function() return mts_dynamicEval("lowest.health <= " .. fetch('mtsconfPriestDisc', 'FlashHealRaid')) end),
			"!player.moving"
		}, "lowest" },
	}, "!player.casting.percent >= 50" },

	-- heal
		{ "2060", { -- Heal
			(function() return mts_dynamicEval("focus.health <= " .. fetch('mtsconfPriestDisc', 'HealTank')) end),
			"focus.spell(2060).range",
			"!player.moving"
		}, "focus" },
		{ "2060", {
			(function() return mts_dynamicEval("tank.health <= " .. fetch('mtsconfPriestDisc', 'HealTank')) end),
			"tank.spell(2060).range",
			"!player.moving"
		}, "tank" }, -- Heal
		{ "2060", { -- Heal	
			(function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfPriestDisc', 'HealPlayer')) end),
			"!player.moving"
		}, "player" },
		{ "2060", {-- Heal
			(function() return mts_dynamicEval("lowest.health <= " .. fetch('mtsconfPriestDisc', 'HealRaid')) end),
			"!player.moving"
		}, "lowest" }, 

	--Attonement 
		{ "47540", { --Penance
			"player.mana > 20", 
			"target.spell(47540).range", 
			"!player.moving",
			"target.infront" 
		}, "target" },
		{ "585", {  --Smite
			"player.mana > 20", 
			"!player.moving", 
			"target.spell(585).range",
			"target.infront"
		}, "target" },

}

local solo = {

	{{-- Auto Dotting
		{ "32379", "@mtsLib.SWD" },
		{{-- AoE FH
			{ "589", "@mtsLib.SWP" }, -- SWP 
		}, "target.area(10).enemies >= 3" },
		{{-- AoE forced
			{ "589", "@mtsLib.SWP" }, -- SWP 
		}, "modifier.multitarget" },
	}, {"toggle.dotEverything"} },

   	-- buffs
		{ "81700", "player.buff(81661).count = 5" }, -- Archangel
	
	-- LoOk aT It GOoZ!!!
		{ "121536", {
			(function() return fetch('mtsconfPriestDisc', 'Feathers') end), 
			"player.movingfor > 2", 
			"!player.buff(121557)", 
			"player.spell(121536).charges >= 1" 
		}, "player.ground" },
		{ "17", {
			"talent(2, 1)", 
			"player.movingfor > 2", 
			"!player.buff(6788)", 
			(function() return fetch('mtsconfPriestDisc', 'Feathers') end)
		}, "player" },

  	-- Mana/Survival
		{ "123040", { --Mindbender
			"player.mana < 75",
			"target.spell(123040).range"
		}, "target" },
		{ "34433", { --Shadowfiend
			"player.mana < 75",
			"target.spell(34433).range"
		}, "target" },
		
		{ "19236", "player.health <= 20", "Player" }, --Desperate Prayer

  	-- HEALTHSTONE 
		{ "#5512", "player.health <= 35" },

  	-- Aggro
		{ "586", "target.threat >= 80" }, -- Fade
 
  	-- Dispel's
	 	{{ -- Dispell all?
			{ "527", (function() return Dispell() end) },-- Dispel Everything
		}, (function() return fetch('mtsconfPriestDisc','Dispels') end) },

  	-- CD's
		{ "10060", "modifier.cooldowns" }, --Power Infusion
	
	-- For Archangel
		{ "14914", { --Holy Fire
			"player.mana > 20",
			"target.spell(14914).range",
			"target.infront" 
		}, "target" }, 

	-- Surge of light
		{ "2061", {-- Flash Heal
			"lowest.health < 100",
			"player.buff(114255)",
			"!player.moving"
		}, "lowest" }, 

	-- Flash Heal
		{ "2061", { --Flash Heal
			(function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfPriestDisc', 'FlashHealPlayer')) end),
			"!player.moving"
		}, "player" },
	
	-- shields
		{ "17", { --Power Word: Shield
			(function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfPriestDisc', 'ShieldPlayer')) end),
			"!player.debuff(6788).any", 
			"!player.buff(17).any" 
		}, "player" },

	--Attonement 
		{ "47540", { --Penance
			"player.mana > 20", 
			"target.spell(47540).range", 
			"!player.moving",
			"target.infront"
		}, "target" },
		{ "585", {  --Smite
			"player.mana > 20", 
			"!player.moving", 
			"target.spell(585).range",
			"target.infront"
		}, "target" },

}

local outCombat = {
	
	-- buffs
		{ "21562", {-- Fortitude
			"buffs.stamina"
			}}, 
		
		{ "81700", {--Archangel
			"player.buff(81661).count = 5", 
			"player.buff(81661).duration < 5"
			}},
	
	-- LoOk aT It GOoZ!!!
		{ "121536", {
			(function() return fetch('mtsconfPriestDisc', 'Feathers') end), 
			"player.movingfor > 2", 
			"!player.buff(121557)", 
			"player.spell(121536).charges >= 1" 
		}, "player.ground" },
		{ "17", {
			"talent(2, 1)", 
			"player.movingfor > 2", 
			"!player.buff(6788)", 
			(function() return fetch('mtsconfPriestDisc', 'Feathers') end)
		}, "player" },
	
	{{-- AOE
		-- Prayer of Healing
   			{ "596", "@mtsLib.PoH" },
   		-- Holy nova
   			{ "132157", "@mtsLib.holyNova", nil }, -- Holy Nova
	}, "modifier.multitarget" },
	
	-- Heals
		-- Surge of light
		{ "2061", {-- Flash Heal
			"lowest.health < 100",
			"player.buff(114255)",
			"!player.moving"
		}, "lowest" }, 
		{ "!47540", { --Penance
			(function() return mts_dynamicEval("lowest.health <= " .. fetch('mtsconfPriestDisc', 'PenanceRaid')) end),
			"!player.casting(2061)",
			"!player.moving"
			}, "lowest" },
		{ "2060", {-- Heal
			(function() return mts_dynamicEval("lowest.health <= " .. fetch('mtsconfPriestDisc', 'HealRaid')) end),
			"!player.moving"
			}, "lowest" }, 

}
	
ProbablyEngine.rotation.register_custom(256, mts_Icon.."|r[|cff9482C9MTS|r][|cffFFFFFFPriest-Disc-Party|r]", {
	{ inCombat, "modifier.party" },
	{ solo, "!modifier.party" },
},  outCombat, exeOnLoad)