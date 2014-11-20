-- ///////////////////-----------------------------------------INFO-----------------------------------//////////////////////////////
--														 //Paladin Holy//
--												  Thank Your For Your My ProFiles
--													  I Hope Your Enjoy Them
--															    MTS

local fetch = ProbablyEngine.interface.fetchKey
local ignoreDebuffs = {
	'Mark of Arrogance',
	'Displaced Energy'
}

							--[[   !!!Dispell function!!!   ]]
						--[[   Checks is member as debuff and can be dispeled.   ]]
--[[  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ]]
local Dispell = function()
local prefix = (IsInRaid() and 'raid') or 'party'
	for i = -1, GetNumGroupMembers() - 1 do
	local unit = (i == -1 and 'target') or (i == 0 and 'player') or prefix .. i
		if IsSpellInRange('Cleanse', unit) then
			for j = 1, 40 do
			local debuffName, _, _, _, dispelType, duration, expires, _, _, _, spellID, _, isBossDebuff, _, _, _ = UnitDebuff(unit, j)
				if dispelType and dispelType == 'Magic' or dispelType == 'Poison' or dispelType == 'Disease' then
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

local lib = function()
	
	mtsStart:message("\124cff9482C9*MTS-\124cffF58CBAPaladin/Holy-\124cff9482C9Loaded*")
	mts_showLive()
	
end

local inCombat = {
	
	--Racials
        -- Dwarves
			{ "20594", "player.health <= 65" },
		-- Humans
			{ "59752", "player.state.charm" },
			{ "59752", "player.state.fear" },
			{ "59752", "player.state.incapacitate" },
			{ "59752", "player.state.sleep" },
			{ "59752", "player.state.stun" },
		-- Draenei
			{ "28880", "player.health <= 70", "player" },
		-- Gnomes
			{ "20589", "player.state.root" },
			{ "20589", "player.state.snare" },
		-- Forsaken
			{ "7744", "player.state.fear" },
			{ "7744", "player.state.charm" },
			{ "7744", "player.state.sleep" },
		-- Goblins
			{ "69041", "player.moving" },
		-- Belf
			{ "28730", "player.mana < 90", nil }, -- Arcane torrent

	-- Buffs
		{ "20217", { -- Blessing of Kings
			"!player.buff(20217).any",
			"!player.buff(115921).any", 
			"!player.buff(1126).any", 
			"!player.buff(90363).any", 
			"!player.buff(69378).any",
			(function() return fetch("mtsconfPalaHoly", "Buff") == 'Kings' end),
			}, nil },
		{ "19740", { -- Blessing of Might
			"!player.buff(19740).any", 
			"!player.buff(116956).any", 
			"!player.buff(93435).any", 
			"!player.buff(128997).any", 
			(function() return fetch("mtsconfPalaHoly", "Buff") == 'Might' end),
			}, nil }, 
	
	-- Seals
		{ "20165", { -- seal of Insigh
			"player.seal != 2", 
			(function() return fetch("mtsconfPalaHoly", "seal") == 'Insight' end),
			}, nil }, 
		{ "105361", { -- seal of Command
			"player.seal != 1",
			(function() return fetch("mtsconfPalaHoly", "seal") == 'Command' end),
			}, nil },

	-- keybinds
		{ "114158", "modifier.shift", "target.ground"}, -- Light´s Hammer
		{ "!/focus [target=mouseover]", "modifier.alt" }, -- Mouseover Focus

	-- Items
		{ "#5512", (function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfPalaHoly', 'Healthstone')) end), nil }, -- Healthstone
		{ "#trinket1", (function() return mts_dynamicEval("player.mana <= " .. fetch('mtsconfPalaHoly', 'Trinket1')) end), nil }, -- Trinket 1
		{ "#trinket2", (function() return mts_dynamicEval("player.mana <= " .. fetch('mtsconfPalaHoly', 'Trinket2')) end), nil }, -- Trinket 2

	-- Beacon of light
		{ "53563", {
			(function() return fetch("mtsconfPalaHoly", "Beacon") == 'Tank' end),
			"!tank.buff(53563)", 
			"tank.spell(53563).range" 
			}, "tank" },
		{ "53563", {
			(function() return fetch("mtsconfPalaHoly", "Beacon") == 'Focus' end),
			"!focus.buff(53563)", 
			"focus.spell(53563).range" 
			}, "focus" }, 

	-- Interrupts
		{ "96231", "modifier.interrupts", "target" }, -- Rebuke
		
	-- Hands
		{ "6940", { -- Hand of Sacrifice
			"tank.spell(6940).range",
			(function() return mts_dynamicEval("tank.health <= " .. fetch('mtsconfPalaHoly', 'HandofSacrifice')) end)
			"tank.health < 40" 
			}, "tank" },
		{ "6940", { -- Hand of Sacrifice
			"focus.spell(6940).range",
			(function() return mts_dynamicEval("focus.health <= " .. fetch('mtsconfPalaHoly', 'HandofSacrifice')) end)
			}, "focus" },

	-- Survival     
		{ "498", (function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfPalaHoly', 'Healthstone')) end), nil }, -- Divine Protection
		{ "642", (function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfPalaHoly', 'Healthstone')) end), nil }, -- Divine Shield

	-- HEAL FAST BITCH
		{ "633", "lowest.health < 15", "lowest" }, -- Lay on Hands
		{ "19750", { -- Flash of light
			"lowest.health < 30", 
			"!player.moving" 
			}, "lowest" },

	{{-- Cooldowns
		{ "#gloves" }, -- gloves
		{ "31821", "@coreHealing.needsHealing(40, 5)", nil }, -- Devotion Aura	
		{ "31884", "@coreHealing.needsHealing(95, 4)", nil }, -- Avenging Wrath
		{ "86669", "@coreHealing.needsHealing(85, 4)", nil }, -- Guardian of Ancient Kings
		{ "31842", "@coreHealing.needsHealing(90, 4)", nil }, -- Divine Favor
		{ "105809", "talent(5, 1)", nil }, -- Holy Avenger
	}, "modifier.cooldowns" },
	
	-- Dispel
		{ "4987", { 
			"player.buff(Gift of the Titans)",
			"@coreHealing.needsDispelled('Mark of Arrogance')" 
			}, nil },
		{ "4987", "@coreHealing.needsDispelled('Shadow Word: Bane')", nil },
		{ "4987", "@coreHealing.needsDispelled('Corrosive Blood')", nil },
		{ "4987", "@coreHealing.needsDispelled('Harden Flesh')", nil },
		{ "4987", "@coreHealing.needsDispelled('Torment')", nil },
		{ "4987", "@coreHealing.needsDispelled('Breath of Fire')", nil },
		{ "4987", { -- Dispel Everything
			(function() return fetch('mtsconfPriestHoly','Dispels') end), 
			(function() return Dispell end) 
			}},
	
	-- Execution Sentence // Talent
		{ "114157", "tank.health < 85", "tank" },
		{ "114157", "focus.health < 85", "focus" }, 

	{{-- Divine Purpose
		{ "85673", "lowest.health <= 80", "lowest"  }, -- Word of Glory
		{ "114163", { -- Eternal Flame
			"!lowest.buff(114163)", 
			"lowest.health <= 85" 
			}, "lowest" },
	}, "player.buff(86172)" },
	
	{{-- Selfless Healer
		{ "!/target [target=focustarget, harm, nodead]", "!target.exists" }, -- Target focus target
		{ "20271", "target.spell(20271).range", "target" }, -- Judgment
		{{ -- If got buff
			{ "19750", { -- Flash of light
				"lowest.health < 85", 
				"!lowest.health < 65", 
				"!@coreHealing.needsHealing(95, 4)", 
				"!player.moving" 
				}, "lowest" }, 
			{ "82326", { -- Divine Light
				"lowest.health < 65", 
				"!@coreHealing.needsHealing(95, 4)", 
				"!player.moving" 
				}, "lowest" }, 
			{ "82327", { -- Holy Radiance
				"@coreHealing.needsHealing(95, 4)", 
				"!player.moving" 
				}, "lowest" }, 
		}, "player.buff(114250).count = 3" }
	}, "talent(3, 1)" },		
	
	-- Infusion of Light
		{ "82326", { -- Divine Light
			"lowest.health < 75", 
			"!@coreHealing.needsHealing(90, 4)", 
			"!player.moving", 
			"player.buff(54149)" 
			}, "lowest" }, 

	-- Holy Shock
		{ "20473", "lowest.health < 100", "lowest" }, 

	-- Eternal Flame // talent
		{ "114163", { 
			"player.holypower >= 3", 
			"!tank.buff(114163)", 
			"tank.health <= 75" 
			}, "tank" },
		{ "114163", { 
			"player.holypower >= 1", 
			"!lowest.buff(114163)", 
			"lowest.health <= 93" 
			}, "lowest" },
		
	-- Holy Prism // Talent
		{ "114165", { -- Holy Prism
			"lowest.health < 85", 
			"!player.moving" 
			}, "lowest"},

	-- Sacred Shield // Talent
		{ "Sacred Shield", { 
			"player.spell(Sacred Shield).charges >= 1", 
			"tank.health < 100", 
			"!tank.buff(Sacred Shield)", 
			"tank.spell(Sacred Shield).range" 
			}, "tank" },
		{ "Sacred Shield", { -- Sacred Shield
			"player.spell(Sacred Shield).charges >= 2", 
			"lowest.health < 80", 
			"!lowest.buff(Sacred Shield)" 
			}, "lowest" },

	-- Word of Glory
		{ "85673", {
			"player.holypower >= 3", 
			"lowest.health <= 80" 
			}, "lowest"  },

	-- AOE
		-- Party
			{ "85222", { -- Light of Dawn
				"@coreHealing.needsHealing(90, 3)", 
				"player.holypower >= 3",
				"modifier.party" 
				}, "lowest" },
			{ "82327", { -- Holy Radiance - Party
				"@coreHealing.needsHealing(80, 3)", 
				"!modifier.last",
				"!player.moving", 
				"modifier.party" 
				}, "lowest" }, 
		
		-- RAID
			{ "85222", { -- Light of Dawn
				"@coreHealing.needsHealing(90, 5)", 
				"player.holypower >= 3", 
				"modifier.raid", 
				"!modifier.members > 10" 
				}, "lowest" }, 
			{ "82327", { -- Holy Radiance - Raid 10
				"@coreHealing.needsHealing(90, 5)", 
				"!modifier.last", 
				"!player.moving", 
				"modifier.raid", 
				"!modifier.members > 10" 
				}, "lowest" }, 
		
		-- Raid 25
			{ "85222", { -- Light of Dawn
				"@coreHealing.needsHealing(90, 8)", 
				"player.holypower >= 3", 
				"modifier.members > 10" 
				}, "lowest" }, 
			{ "82327", { -- Holy Radiance 10+
				"@coreHealing.needsHealing(90, 8)", 
				"!modifier.last", 
				"!player.moving", 
				"modifier.members > 10" 
				}, "lowest" }, 

	-- Crusader Strike
		{ "35395", "target.range <= 6", "target" },

	-- Holy Light
		{ "82326", { 
			"lowest.health < 100",
			"!player.moving" 
			}, "lowest" },

} 

local outCombat = {
	
	-- keybinds
		{ "114158", "modifier.shift", "mouseover.ground"}, -- Light´s Hammer
		{ "!/focus [target=mouseover]", "modifier.alt" }, -- Mouseover Focus

	-- Buffs
		{ "20217", { -- Blessing of Kings
			"!player.buff(20217).any",
			"!player.buff(115921).any", 
			"!player.buff(1126).any", 
			"!player.buff(90363).any", 
			"!player.buff(69378).any",
			(function() return fetch("mtsconfPalaHoly", "Buff") == 'Kings' end),
			}, nil },
		{ "19740", { -- Blessing of Might
			"!player.buff(19740).any", 
			"!player.buff(116956).any", 
			"!player.buff(93435).any", 
			"!player.buff(128997).any", 
			(function() return fetch("mtsconfPalaHoly", "Buff") == 'Might' end),
			}, nil }, 
	
	-- Seals
		{ "20165", { -- seal of Insigh
			"player.seal != 2", 
			(function() return fetch("mtsconfPalaHoly", "seal") == 'Insight' end),
			}, nil }, 
		{ "105361", { -- seal of Command
			"player.seal != 1",
			(function() return fetch("mtsconfPalaHoly", "seal") == 'Command' end),
			}, nil },

	-- Beacon of light
		{ "53563", {
			(function() return fetch("mtsconfPalaHoly", "Beacon") == 'Tank' end),
			"!tank.buff(53563)", 
			"tank.spell(53563).range" 
			}, "tank" },
		{ "53563", {
			(function() return fetch("mtsconfPalaHoly", "Beacon") == 'Focus' end),
			"!focus.buff(53563)", 
			"focus.spell(53563).range" 
			}, "focus" }, 

	-- hands
		{ "1044", "player.state.root" }, -- Hand of Freedom

	-- Start
		{ "20473", "lowest.health < 100", "lowest" }, -- Holy Shock

}

ProbablyEngine.rotation.register_custom(
	65,
	mts_Icon.."|r[|cff9482C9MTS|r][|cffF58CBAPaladin-Holy|r]", 
	inCombat, 
	outCombat, 
	lib)