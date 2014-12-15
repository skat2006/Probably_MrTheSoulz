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

--[[ Dispell function ]]
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
	
  	--[[ Chakra ]]
  		{ "81208", {--Serenity
  			"player.chakra != 3",
  			(function() return fetch("mtsconfPriestHoly", "Chakra") == 'Serenity' end),
  			}, nil },

		{ "81206", {--Sanctuary
			"player.chakra != 2",
			(function() return fetch("mtsconfPriestHoly", "Chakra") == 'Sanctuary' end),
			}, nil },
		
		{ "81209", {--Serenity
			"player.chakra != 1",
			(function() return fetch("mtsconfPriestHoly", "Chakra") == 'Chastise' end),
		}, nil },

  	-- buffs
		{ "21562", { -- Fortitude
			(function() return fetch('mtsconfPriestHoly','Buff') end),
			"!player.buff(21562).any",
			"!player.buff(588)"
		}},

  	--[[ keybinds ]]
		{ "32375", "modifier.rcontrol", "player.ground" }, --Mass Dispel
	 	{ "48045", "modifier.ralt", "tank" }, -- Mind Sear
		{ "120517", "modifier.lcontrol", "player" }, --Halo
		{ "110744", "modifier.lcontrol", "player" }, --Divine Star
	
	-- PW:S
		{ "129250" },
	
	-- LoOk aT It GOoZ!!!,
		{ "121536", {
			(function() return fetch('mtsconfPriestHoly', 'Feathers') end), 
			"player.movingfor > 2", 
			"!player.buff(121557)", 
			"player.spell(121536).charges >= 1" 
		}, "player.ground" },
		{ "17", {
			"talent(2, 1)", 
			"player.movingfor > 2", 
			"!player.buff(6788)", 
			(function() return fetch('mtsconfPriestHoly', 'Feathers') end)
		}, "player" },

  	-- HEALTHSTONE 
		{ "#5512", (function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfPriestHoly', 'Healthstone')) end) },

  	-- Aggro
		{ "586", "target.threat >= 80" }, -- Fade
 
  	-- Dispel's
	 	{{ -- Dispell all?
			{ "527", (function() return Dispell() end) },-- Dispel Everything
		}, (function() return fetch('mtsconfPriestHoly','Dispels') end) },

  	-- CD's
		{ "10060", "modifier.cooldowns" }, --Power Infusion
		{ "123040", { --Mindbender
			"player.mana < 75", 
			"target.spell(123040).range",
			 "modifier.cooldowns"
			 }, "target" },
	-- Proc's
		{ "596", { -- Prayer of healing // Divine Insigt
			"@coreHealing.needsHealing(95, 3)",
			"player.buff(123267)",
			"!player.moving",
			"modifier.party", 
			"!modifier.raid"
			}, "lowest" },
		{ "2061", { -- Flash heal // Surge of light
			"lowest.health < 100",
			"player.buff(114255)",
			"!player.moving"
			}, "lowest" },

	-- Player dead (Spirit)
		{ "88684", { -- Holy Word Serenity
			"lowest.health <= 80", 
			"player.buff(27827)" -- Player Dead
			}, "lowest" },
		{ "2061", { --Flash Heal
			"lowest.health < 100", 
			"player.buff(27827)" -- Player Dead
			}, "lowest" },
		{ "34861", { -- Circle of Healing
			"@coreHealing.needsHealing(95, 3)", 
			"player.buff(27827)" -- Player Dead
			}, "lowest"},
		{ "121135", { -- cascade
			"@coreHealing.needsHealing(95, 3)", 
			"player.buff(27827)"
			}},
		{ "596", { --Prayer of Healing
			"@coreHealing.needsHealing(95, 3)", 
			"player.buff(27827)", -- Player Dead
			"modifier.party",  -- Player is in Party
			"!modifier.raid"  -- Player os not in raid
			}, "lowest" },

	{{-- AOE
   		{ "34861", "@coreHealing.needsHealing(90, 3)", "lowest"}, -- Circle of Healing
		{ "121135", { -- cascade
			"@coreHealing.needsHealing(95, 3)", 
			"!player.moving"
		}, "lowest"},
		-- Divine Hymn
			{ "64843", { -- Divine Hymn
				"@coreHealing.needsHealing(50, 3)", 
				"modifier.party" 
			}},
			{ "64843", { -- Divine Hymn
				"@coreHealing.needsHealing(60, 5)", 
				"modifier.raid", 
				"!modifier.members > 10" 
			}},
			{ "64843", {  -- Divine Hymn
				"@coreHealing.needsHealing(60, 8)", 
				"modifier.raid", 
				"modifier.members > 10" 
			}},
		{ "596", "@mtsLib.PoH" },-- Prayer of Healing
   		{ "155245", "@mtsLib.ClarityOfPurpose", "lowest" },-- Clarity Of Purpose
	}, "modifier.multitarget" },

	{{-- Heal Fast Bitch!!
		-- Desperate Prayer
			{ "!19236",  --Desperate Prayer
				(function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfPriestHoly', 'DesperatePrayer')) end),
				"player" },

		-- Holy Word Serenity
			{ "!88684", { -- Holy Word Serenity
				(function() return mts_dynamicEval("focus.health <= " .. fetch('mtsconfPriestHoly', 'HolyWordSerenityTank')) end),
				"focus.spell(88684).range"
				}, "focus" },
			{ "!88684", { -- Holy Word Serenity
				(function() return mts_dynamicEval("tank.health <= " .. fetch('mtsconfPriestHoly', 'HolyWordSerenityTank')) end),
				"tank.spell(88684).range"
				}, "tank" },
			{ "!88684", -- Holy Word Serenity
				(function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfPriestHoly', 'HolyWordSerenityPlayer')) end), 
				"player" }, 
			{ "!88684", -- Holy Word Serenity
				(function() return mts_dynamicEval("lowest.health <= " .. fetch('mtsconfPriestHoly', 'HolyWordSerenityRaid')) end),
				"lowest" }, 

		-- Flash Heal
			{ "!2061", { --Flash Heal
				(function() return mts_dynamicEval("focus.health <= " .. fetch('mtsconfPriestHoly', 'FlashHealTank')) end),
				"focus.spell(2061).range",
				"!player.moving"
				}, "focus" },
			{ "!2061", { --Flash Heal
				(function() return mts_dynamicEval("tank.health <= " .. fetch('mtsconfPriestHoly', 'FlashHealTank')) end),
				"tank.spell(2061).range",
				"!player.moving"
				}, "tank" },
			{ "!2061", { --Flash Heal
				(function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfPriestHoly', 'FlashHealPlayer')) end),
				"!player.moving"
				}, "player" },
			{ "!2061", { --Flash Heal
				(function() return mts_dynamicEval("lowest.health <= " .. fetch('mtsconfPriestHoly', 'FlashHealRaid')) end),
				"!player.moving"
				}, "lowest" },
	}, "!player.casting.percent >= 50" },

	-- shields
		{ "17", {  --Power Word: Shield
			(function() return mts_dynamicEval("focus.health <= " .. fetch('mtsconfPriestHoly', 'ShieldTank')) end),
			"!focus.debuff(6788).any", 
			"focus.spell(17).range"
			}, "focus" },
		{ "17", {  --Power Word: Shield
			(function() return mts_dynamicEval("tank.health <= " .. fetch('mtsconfPriestHoly', 'ShieldTank')) end),
			"!tank.debuff(6788).any",
			"tank.spell(17).range"
			}, "tank" },
		{ "17", { --Power Word: Shield
			(function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfPriestHoly', 'ShieldPlayer')) end),
			"!player.debuff(6788).any", 
			"!player.buff(17).any"
			}, "player" }, 
		{ "17", { --Power Word: Shield
			(function() return mts_dynamicEval("lowest.health <= " .. fetch('mtsconfPriestHoly', 'ShieldRaid')) end),
		 	"!lowest.debuff(6788).any", 
		 	"!lowest.buff(17).any",  
		 	}, "lowest" },

	-- renew
		{ "139", { --renew
			(function() return mts_dynamicEval("focus.health <= " .. fetch('mtsconfPriestHoly', 'RenewTank')) end),
			"!focus.buff(139)", 
			"focus.spell(139).range"
			}, "focus" },
		{ "139", { --renew
			(function() return mts_dynamicEval("tank.health <= " .. fetch('mtsconfPriestHoly', 'RenewTank')) end),
			"!tank.buff(139)", 
			"tank.spell(139).range"
			}, "tank" },
		{ "139", { --renew
			(function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfPriestHoly', 'RenewPlayer')) end), 
			"!player.buff(139)"
			}, "player" },
		{ "139", { --renew
			(function() return mts_dynamicEval("lowest.health <= " .. fetch('mtsconfPriestHoly', 'RenewRaid')) end),
			"!lowest.buff(139)"
			}, "lowest" },

	-- Prayer of Mending
		{ "33076", { --Prayer of Mending
			(function() return mts_dynamicEval("focus.health <= " .. fetch('mtsconfPriestHoly', 'PrayerofMendingTank')) end),
			"focus.spell(33076).range",
			"!player.moving"
			}, "focus" },
		{ "33076", { --Prayer of Mending
			(function() return mts_dynamicEval("tank.health <= " .. fetch('mtsconfPriestHoly', 'PrayerofMendingTank')) end),
			"tank.spell(33076).range",
			"!player.moving"
			}, "tank" },

	-- binding heal
		{ "32546", {
			(function() return mts_dynamicEval("focus.health <= " .. fetch('mtsconfPriestHoly', 'BindingHealTank')) end),
			"player.health < 60",
			"focus.spell(32546).range",
			"!player.moving"
			}, "focus" },
		{ "32546", {
			(function() return mts_dynamicEval("tank.health <= " .. fetch('mtsconfPriestHoly', 'BindingHealTank')) end),
			"player.health <= 60", 
			"tank.spell(32546).range",
			"!player.moving"
			}, "tank" },
		{ "32546", {
			(function() return mts_dynamicEval("lowest.health <= " .. fetch('mtsconfPriestHoly', 'BindingHealRaid')) end),
			"player.health < 60",
			"!player.moving"
			}, "lowest" },

	-- heal
		{ "2060", { -- Heal
			(function() return mts_dynamicEval("focus.health <= " .. fetch('mtsconfPriestHoly', 'HealTank')) end), 
			"focus.spell(2060).range",
			"!player.moving"
			}, "focus" },
		{ "2060", { -- Heal
			(function() return mts_dynamicEval("tank.health <= " .. fetch('mtsconfPriestHoly', 'HealTank')) end), 
			"tank.spell(2060).range",
			"!player.moving"
			}, "tank" },
		{ "2060", { -- Heal	
			(function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfPriestHoly', 'Heal')) end),
			"!player.moving"
			}, "player" },
		{ "2060", { -- Heal	
			(function() return mts_dynamicEval("lowest.health <= " .. fetch('mtsconfPriestHoly', 'HealRaid')) end),
			"!player.moving"
			}, "lowest" },

}

local solo = {
	
  	--[[ Chakra ]]
  		{ "81208", {--Serenity
  			"player.chakra != 3",
  			(function() return fetch("mtsconfPriestHoly", "Chakra") == 'Serenity' end),
  			}, nil },

		{ "81206", {--Sanctuary
			"player.chakra != 2",
			(function() return fetch("mtsconfPriestHoly", "Chakra") == 'Sanctuary' end),
			}, nil },
		
		{ "81209", {--Serenity
			"player.chakra != 1",
			(function() return fetch("mtsconfPriestHoly", "Chakra") == 'Chastise' end),
			}, nil },

  	-- buffs
		{ "21562", { -- Fortitude
			(function() return fetch('mtsconfPriestHoly','Buff') end),
			"!player.buff(21562).any",
			"!player.buff(588)"
			}},
	
	-- LoOk aT It GOoZ!!!
		{ "121536", {
			(function() return fetch('mtsconfPriestHoly', 'Feathers') end), 
			"player.movingfor > 2", 
			"!player.buff(121557)", 
			"player.spell(121536).charges >= 1" 
		}, "player.ground" },
		{ "17", {
			"talent(2, 1)", 
			"player.movingfor > 2", 
			"!player.buff(6788)", 
			(function() return fetch('mtsconfPriestHoly', 'Feathers') end)
		}, "player" },

  	-- HEALTHSTONE 
		{ "#5512", (function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfPriestHoly', 'Healthstone')) end) },
 
  	-- Dispel's
	 	{{ -- Dispell all?
			{ "527", (function() return Dispell() end) },-- Dispel Everything
		}, (function() return fetch('mtsconfPriestHoly','Dispels') end) },

  	-- CD's
		{ "10060", "modifier.cooldowns" }, --Power Infusion
		
		{ "123040", { --Mindbender
			"player.mana < 75", 
			"target.spell(123040).range",
			 "modifier.cooldowns"
			 }, "target" },

	-- Proc's
		{ "596", { -- Prayer of healing // Divine Insigt
			"@coreHealing.needsHealing(95, 3)",
			"player.buff(123267)",
			"!player.moving",
			"modifier.party", 
			"!modifier.raid"
			}, "lowest" },
		{ "2061", { -- Flash heal // Surge of light
			"lowest.health < 100",
			"player.buff(114255)",
			"!player.moving"
			}, "lowest" },

	-- Heal Fast Bitch!!
		-- Desperate Prayer
			{ "19236",  --Desperate Prayer
				(function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfPriestHoly', 'DesperatePrayer')) end),
				"player" },

		-- Holy Word Serenity
			{ "88684", -- Holy Word Serenity
				(function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfPriestHoly', 'HolyWordSerenityPlayer')) end), 
				"player" },

		-- Flash Heal
			{ "2061", { --Flash Heal
				(function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfPriestHoly', 'FlashHealPlayer')) end),
				"!player.moving"
				}, "player" },

	-- shields
		{ "17", { --Power Word: Shield
			(function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfPriestHoly', 'ShieldPlayer')) end),
			"!player.debuff(6788).any", 
			"!player.buff(17).any"
			}, "player" },

	-- renew
		{ "139", { --renew
			(function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfPriestHoly', 'RenewPlayer')) end), 
			"!player.buff(139)"
			}, "player" },
	
	{{-- Auto Dotting
		{ "32379", "@mtsLib.SWD" },
		{{-- AoE FH
			{ "589", "@mtsLib.SWP" }, -- SWP 
		}, "target.area(10).enemies >= 3" },
		{{-- AoE forced
			{ "589", "@mtsLib.SWP" }, -- SWP 
		}, "modifier.multitarget" },
	}, {"toggle.dotEverything"} },
	
	-- DPS
		-- AoE FH
		{ "48045", "target.area(10).enemies >= 3", "target" }, -- mind sear
		
		-- AoE
		{ "48045", "modifier.multitarget", "target" }, -- mind sear
			
		-- Single
		{ "129250" }, -- PW:S
		{ "589", "!target.debuff(589)", "target" }, -- SW:P
		{ "585", {  --Smite
			"!player.moving", 
			"target.spell(585).range" 
			}, "target" },

}

local outCombat = {
		
	--[[ Chakra ]]
  		{ "81208", {--Serenity
  			"player.chakra != 3",
  			(function() return fetch("mtsconfPriestHoly", "Chakra") == 'Serenity' end),
  			}, nil },

		{ "81206", {--Sanctuary
			"player.chakra != 2",
			(function() return fetch("mtsconfPriestHoly", "Chakra") == 'Sanctuary' end),
			}, nil },
		
		{ "81209", {--Serenity
			"player.chakra != 1",
			(function() return fetch("mtsconfPriestHoly", "Chakra") == 'Chastise' end),
			}, nil },

	{{-- AOE
   		{ "34861", "@coreHealing.needsHealing(90, 3)", "lowest"}, -- Circle of Healing
		{ "121135", { -- cascade
			"@coreHealing.needsHealing(95, 3)", 
			"!player.moving"
		}, "lowest"},
		-- Divine Hymn
			{ "64843", { -- Divine Hymn
				"@coreHealing.needsHealing(50, 3)", 
				"modifier.party" 
			}},
			{ "64843", { -- Divine Hymn
				"@coreHealing.needsHealing(60, 5)", 
				"modifier.raid", 
				"!modifier.members > 10" 
			}},
			{ "64843", {  -- Divine Hymn
				"@coreHealing.needsHealing(60, 8)", 
				"modifier.raid", 
				"modifier.members > 10" 
			}},
		{ "596", "@mtsLib.PoH" },-- Prayer of Healing
   		{ "155245", "@mtsLib.ClarityOfPurpose", "lowest" },-- Clarity Of Purpose
	}, "modifier.multitarget" },
		
	-- shields 
		{ "17", { --Power Word: Shield
			(function() return mts_dynamicEval("focus.health <= " .. fetch('mtsconfPriestHoly', 'ShieldTank')) end),
			"!focus.debuff(6788).any", 
			"focus.spell(17).range", 
			"focus.spell(17).range" 
			}, "focus" },
			
		{ "17", {  --Power Word: Shield
			(function() return mts_dynamicEval("tank.health <= " .. fetch('mtsconfPriestHoly', 'ShieldTank')) end),
			"!tank.debuff(6788).any", 
			"tank.spell(17).range", 
			"modifier.party" 
			}, "tank" },
	   	
	-- heals
		{ "139", {  --renew
			(function() return mts_dynamicEval("lowest.health <= " .. fetch('mtsconfPriestHoly', 'RenewRaid')) end),
			"!lowest.buff(139)"
		}, "lowest" },	
			
		{ "2061", {  --Flash Heal
			"!player.moving", 
			(function() return mts_dynamicEval("lowest.health <= " .. fetch('mtsconfPriestHoly', 'FlashHealRaid')) end),
		}, "lowest" },
			
		{ "2060", { -- Heal
			(function() return mts_dynamicEval("lowest.health <= " .. fetch('mtsconfPriestHoly', 'HealRaid')) end),
			"!player.moving"
		}, "lowest" },
		
	-- buffs
		{ "21562", { -- Fortitude
			(function() return fetch('mtsconfPriestHoly','Buff') end),
			"!player.buff(21562).any",
			"!player.buff(588)"
		}},
	
	-- LoOk aT It GOoZ!!!
		{ "121536", {
			(function() return fetch('mtsconfPriestHoly', 'Feathers') end), 
			"player.movingfor > 2", 
			"!player.buff(121557)", 
			"player.spell(121536).charges >= 1" 
		}, "player.ground" },
		{ "17", {
			"talent(2, 1)", 
			"player.movingfor > 2", 
			"!player.buff(6788)", 
			(function() return fetch('mtsconfPriestHoly', 'Feathers') end)
		}, "player" },

}

	
ProbablyEngine.rotation.register_custom(
	257, 
	mts_Icon.."|r[|cff9482C9MTS|r][|cffFFFFFFPriest-Holy|r]", 
	{-- Dyn Change CR
		{ inCombat, "modifier.party" },
		{ solo, "!modifier.party" },
	}, 
 	outCombat, exeOnLoad)