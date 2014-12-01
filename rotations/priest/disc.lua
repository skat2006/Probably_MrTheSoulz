--[[ ///---INFO---////
//Priest Disc//
Thank You For Using My ProFiles
I Hope Your Enjoy Them
MTS
]]--

local fetch = ProbablyEngine.interface.fetchKey
local ignoreDebuffs = {'Mark of Arrogance','Displaced Energy'}

local function mts_Feathers()
local possibleTank = ProbablyEngine.raid.tank()
  
  if FireHack or oexecute
  and mts_dynamicEval("player.spell(121536).charges >= 1") 
  and fetch('mtsconfPriestDisc','Feathers') then
  
    if UnitExists("focus") then
	  if not mts_dynamicEval("focus.range >= 40")
	  and mts_dynamicEval("!focus.buff(121557)") then
		ProbablyEngine.dsl.parsedTarget = "focus.ground"
	    return true
	  end
	end
	
    if possibleTank then
	  if not mts_dynamicEval("tank.range >= 40")
	  and mts_dynamicEval("!tank.buff(121557)") 
	  and possibleTank ~= "player" then
		ProbablyEngine.dsl.parsedTarget = possibleTank..".ground"
	    return true
      end
	end
	
	if mts_dynamicEval("player.movingfor > 2")
	and mts_dynamicEval("!player.buff(121557)") then
      ProbablyEngine.dsl.parsedTarget = "player.ground"
      return true
	end
	
  end
	return false
end 

-- Prayer of Healing
-- THX woe!
local function PoH()
	local minHeal = (GetSpellBonusDamage(2) * 2.21664) + (GetCombatRatingBonus(CR_VERSATILITY_DAMAGE_DONE) + GetVersatilityBonus(CR_VERSATILITY_DAMAGE_DONE))
	local GetRaidRosterInfo, min, subgroups, member = GetRaidRosterInfo, math.min, {}, {}
	local lowest, lowestHP, _, subgroup = false, 0
 
	local start, groupMembers = 0, GetNumGroupMembers()
 
	if IsInRaid() then
		start = 1
	elseif groupMembers > 0 then
		groupMembers = groupMembers - 1
	end
 
	for i = start, groupMembers do
		_, _, subgroup, _, _, _, _, _, _, _, _ = GetRaidRosterInfo(i)
 
		if not subgroups[subgroup] then
			subgroups[subgroup] = 0
			member[subgroup] = ProbablyEngine.raid.roster[i].unit
		end
 
		subgroups[subgroup] = subgroups[subgroup] + min(minHeal, ProbablyEngine.raid.roster[i].healthMissing)
	end
 
	for i = 1, #subgroups do
		if subgroups[i] > minHeal * 4
		and subgroups[i] > lowestHP then
			lowest = i
			lowestHP = subgroups[i]
		end
	end
 
	if lowest then
		ProbablyEngine.dsl.parsedTarget = member[lowest]
		return true
	end
 
	return false
end

								--[[   !!!Dispell function!!!   ]]
						--[[   Checks is member as debuff and can be dispeled.   ]]
--[[  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ]]
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
	 	{ "62618", "modifier.rshift", "tank.ground" }, --Power Word: Barrier
	 	{ "48045", "modifier.ralt", "tank" }, -- Mind Sear
	 	{ "121135", "modifier.lcontrol", "player" },  --Cascade
		{ "120517", "modifier.lcontrol", "player" }, --Halo
		{ "110744", "modifier.lcontrol", "player" }, --Divine Star
		{ "109964", "modifier.lshift" }, --Spirit Shell

	-- Auto Targets
		{ "/cleartarget", {
			(function() return fetch('mtsconfPriestDisc','AutoTargets') end),
			(function() return UnitIsFriend("player","target") end)
			}},

		{ "/target [target=focustarget, harm, nodead]", {  -- Use Tank Target
			(function() return fetch('mtsconfPriestDisc','AutoTargets') end),
			"target.range > 40" 
			}},
		
		{ "/targetenemy [noexists]", {  -- target enemire if no target
			(function() return fetch('mtsconfPriestDisc','AutoTargets') end), 
			"!target.exists" 
			}},
		
		{ "/targetenemy [dead]", { -- target enemire if current is dead.
			(function() return fetch('mtsconfPriestDisc','AutoTargets') end),
			"target.exists", 
			"target.dead" 
			}}, 

   	-- buffs
		{ "81700", "player.buff(81661).count = 5" }, -- Archangel
	
	-- LoOk aT It GOoZ!!! // Needs to add tank...
		{ "121536", (function() return mts_Feathers() end)},

  	-- Mana/Survival
		{ "123040", { --Mindbender
			"player.mana < 75",
			"target.spell(123040).range"
			}, "target" },
		
		{ "34433", { --Shadowfiend
			"player.mana < 75",
			"target.spell(34433).range"
			}, "target" },
		
		{ "19236", 
			"player.health <= 20", 
				"Player" }, --Desperate Prayer

  	-- HEALTHSTONE 
		{ "#5512", "player.health <= 35" },

  	-- Aggro
		{ "586", "target.threat >= 80" }, -- Fade
 
  	-- Dispel's
  		-- SoO Stuff
		    { "527", {
		    	"player.debuff(146595)",
		    	"@coreHealing.needsDispelled('Mark of Arrogance')"
		    	}, nil },
		    
		    { "527", 
		    	"@coreHealing.needsDispelled('Corrosive Blood')",
		    	nil },
		 	
		 	{ "527", 
		 		"@coreHealing.needsDispelled('Harden Flesh')", 
		 		nil },
		 	
		 	{ "527", "@coreHealing.needsDispelled('Torment')", nil },
		 	
		 	{ "527", 
		 		"@coreHealing.needsDispelled('Breath of Fire')", 
		 		nil },
	 	
	 	-- Dispell ALl
	 	{{ -- Dispell all?
			{ "527", (function() return Dispell() end) },-- Dispel Everything
		}, (function() return fetch('mtsconfPriestDisc','Dispels') end) },

  	-- CD's
		{ "10060", "modifier.cooldowns" }, --Power Infusion
		
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

	-- Surge of light
		{ "2061", {-- Flash Heal
			"lowest.health < 100",
			"player.buff(114255)",
			"!player.moving"
			}, "lowest" }, 
	
	-- Penance	
		{ "!47540", { --Penance
			(function() return mts_dynamicEval("lowest.health <= " .. fetch('mtsconfPriestDisc', 'PenanceRaid')) end),
			"!player.casting(2061)",
			"!player.moving"
			}, "lowest" }, 
	
	-- shields
		{ "17", { 
			(function() return mts_dynamicEval("focus.health <= " .. fetch('mtsconfPriestDisc', 'ShieldTank')) end),
			"!focus.debuff(6788).any", 
			"focus.spell(17).range"
			}, "focus" }, --Power Word: Shield
		
		{ "17", { --Power Word: Shield
			(function() return mts_dynamicEval("tank.health <= " .. fetch('mtsconfPriestDisc', 'ShieldTank')) end),
			"!tank.debuff(6788).any", 
			"tank.spell(17).range"
			}, "tank" },
		
		{ "17", { --Power Word: Shield
			(function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfPriestDisc', 'ShieldPlayer')) end),
			"!player.debuff(6788).any", 
			"!player.buff(17).any" 
			}, "player" },
	
	-- Flash Heal
		{ "!2061", { --Flash Heal
			(function() return mts_dynamicEval("focus.health <= " .. fetch('mtsconfPriestDisc', 'FlashHealTank')) end),
			"focus.spell(2061).range",
			"!player.moving"
			}, "focus" },
		
		{ "!2061", { --Flash Heal
			(function() return mts_dynamicEval("tank.health <= " .. fetch('mtsconfPriestDisc', 'FlashHealTank')) end), 
			"tank.spell(2061).range",
			"!player.moving"
			}, "tank" },
		
		{ "!2061", { --Flash Heal
			(function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfPriestDisc', 'FlashHealPlayer')) end),
			"!player.moving"
			}, "player" },
		
		{ "!2061", { --Flash Heal
			(function() return mts_dynamicEval("lowest.health <= " .. fetch('mtsconfPriestDisc', 'FlashHealRaid')) end),
			"!player.moving"
			}, "lowest" },
	
	-- For Archangel
		{ "14914", { --Holy Fire
			"player.mana > 20",
			"target.spell(14914).range",
			"target.infront"
			}, "target" }, 

	{{-- AOE
		--Prayer of Mending
			{ "33076", { 
				(function() return mts_dynamicEval("tank.health <= " .. fetch('mtsconfPriestDisc', 'PrayerofMendingTank')) end),
				"@coreHealing.needsHealing(90, 3)",
				"!player.moving", 
				"tank.spell(17).range" 
				}, "tank" },

   		-- Holy nova
   			{ "132157", (function() return mts_holyNova() end), nil }, -- Holy Nova

		-- Prayer of Healing
   			{ "596", (function() return PoH() end)},

   		-- Power word Barrier
			{ "62618", {  -- Power word Barrier // w/t CD's and on tank
				"@coreHealing.needsHealing(50, 3)", 
				"modifier.party", 
				"!player.moving", 
				"modifier.cooldowns" 
			}, "tank.ground" },
	}, "modifier.multitarget" },
	
	-- shields 
		{ "17", {  --Power Word: Shield
			(function() return mts_dynamicEval("lowest.health <= " .. fetch('mtsconfPriestDisc', 'ShieldRaid')) end),
			"!lowest.debuff(6788).any", 
			"!lowest.buff(17).any", 
			}, "lowest" },

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
			"!player.moving" 
			}, "target" },
		
		{ "585", {  --Smite
			"player.mana > 20", 
			"!player.moving", 
			"target.spell(585).range" 
			}, "target" },

}

local solo = {

	{{-- Auto Dotting
		{ "32379", (function() return mts_SWD() end) },
		{{-- AoE FH
			{ "589", (function() return mts_SWP() end) }, -- SWP 
		}, "target.area(10).enemies >= 3" },
		{{-- AoE forced
			{ "589", (function() return mts_SWP() end) }, -- SWP 
		}, "modifier.multitarget" },
	}, {"toggle.dotEverything", "player.firehack"} },
	
	-- Auto Targets
		{ "/cleartarget", {
			(function() return fetch('mtsconfPriestDisc','AutoTargets') end),
			(function() return UnitIsFriend("player","target") end)
			}},

		{ "/target [target=focustarget, harm, nodead]", {  -- Use Tank Target
			(function() return fetch('mtsconfPriestDisc','AutoTargets') end),
			"target.range > 40" 
			}},
		
		{ "/targetenemy [noexists]", {  -- target enemire if no target
			(function() return fetch('mtsconfPriestDisc','AutoTargets') end), 
			"!target.exists" 
			}},
		
		{ "/targetenemy [dead]", { -- target enemire if current is dead.
			(function() return fetch('mtsconfPriestDisc','AutoTargets') end),
			"target.exists", 
			"target.dead" 
			}}, 

   	-- buffs
		{ "81700", "player.buff(81661).count = 5" }, -- Archangel
	
	-- LoOk aT It GOoZ!!! // Needs to add tank...
		{ "121536", (function() return mts_Feathers() end)},

  	-- Mana/Survival
		{ "123040", { --Mindbender
			"player.mana < 75",
			"target.spell(123040).range"
			}, "target" },
		
		{ "34433", { --Shadowfiend
			"player.mana < 75",
			"target.spell(34433).range"
			}, "target" },
		
		{ "19236", 
			"player.health <= 20", 
				"Player" }, --Desperate Prayer

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
			"target.spell(14914).range" 
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
			"!player.moving" 
			}, "target" },
		
		{ "585", {  --Smite
			"player.mana > 20", 
			"!player.moving", 
			"target.spell(585).range" 
			}, "target" },

}

local outCombat = {
	
	-- buffs
		{ "21562", {-- Fortitude
			"!player.buff(21562).any",
			"!player.buff(588)"
			}}, 
		
		{ "81700", {--Archangel
			"player.buff(81661).count = 5", 
			"player.buff(81661).duration < 5"
			}},
	
	-- LoOk aT It GOoZ!!! // Needs to add tank...
		{ "121536", (function() return mts_Feathers() end)},
	
	{{-- AOE
   		-- Holy nova
   			{ "132157", (function() return mts_holyNova() end), nil }, -- Holy Nova

		-- Prayer of Healing
   			{ "596", (function() return PoH() end)},

   		-- Power word Barrier
			{ "62618", {  -- Power word Barrier // w/t CD's and on tank
				"@coreHealing.needsHealing(50, 3)", 
				"modifier.party", 
				"!player.moving", 
				"modifier.cooldowns" 
			}, "tank.ground" },
	}, "modifier.multitarget" },
	
	-- Heals
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