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
local function Dispell()
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
mts.Splash("|cff9482C9[MTS]-|cffFFFFFF"..(select(2, GetSpecializationInfo(GetSpecialization())) or "Error").."-|cff9482C9Loaded", 5.0)
	
	
	
end

local inCombat = {
	
	{{ -- Dispell all?
		{ "4987", (function() return Dispell() end) },-- Dispel Everything
	}, (function() return fetch('mtsconfPalaHoly','Dispels') end) },

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

	-- Hand of Freedom
		{ "1044", "player.state.root" },

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
		{ "#5512", (function() return mts.dynamicEval("player.health <= " .. fetch('mtsconfPalaHoly', 'Healthstone')) end), nil }, -- Healthstone
		{ "#trinket1", (function() return mts.dynamicEval("player.mana <= " .. fetch('mtsconfPalaHoly', 'Trinket1')) end), nil }, -- Trinket 1
		{ "#trinket2", (function() return mts.dynamicEval("player.mana <= " .. fetch('mtsconfPalaHoly', 'Trinket2')) end), nil }, -- Trinket 2

	{{-- Beacon of Faith
		{ "156910", {
			"!player.buff(53563)",
			"!player.buff(156910)"
		}, "player" },
	}, "talent(7,1)" },

	-- Beacon of light
		{ "53563", {
			(function() return fetch("mtsconfPalaHoly", "Beacon") == 'Tank' end),
			"!tank.buff(53563)",
			"!tank.buff(156910)",
			"tank.spell(53563).range" 
		}, "tank" },
		{ "53563", {
			(function() return fetch("mtsconfPalaHoly", "Beacon") == 'Focus' end),
			"!focus.buff(53563)",
			"!focus.buff(156910)",
			"focus.spell(53563).range" 
		}, "focus" }, 

	-- Interrupts
		{ "96231", {"modifier.interrupts", "target.range <= 6"}, "target" }, -- Rebuke
		
	-- Hands
		{ "6940", { -- Hand of Sacrifice
			"tank.spell(6940).range",
			(function() return mts.dynamicEval("tank.health <= " .. fetch('mtsconfPalaHoly', 'HandofSacrifice')) end)
		}, "tank" },
		{ "6940", { -- Hand of Sacrifice
			"focus.spell(6940).range",
			(function() return mts.dynamicEval("focus.health <= " .. fetch('mtsconfPalaHoly', 'HandofSacrifice')) end)
		}, "focus" },

	-- Survival     
		{ "498", (function() return mts.dynamicEval("player.health <= " .. fetch('mtsconfPalaHoly', 'DivineProtection')) end), nil }, -- Divine Protection
		{ "642", (function() return mts.dynamicEval("player.health <= " .. fetch('mtsconfPalaHoly', 'DivineShield')) end), nil }, -- Divine Shield

	-- Lay on Hands
		{ "!633", {
			(function() return mts.dynamicEval("focus.health <= " .. fetch('mtsconfPalaHoly', 'LayonHandsTank')) end),
			"focus.spell(633).range"
		}, "focus" }, 
		{ "!633", {
			(function() return mts.dynamicEval("tank.health <= " .. fetch('mtsconfPalaHoly', 'LayonHandsTank')) end),
			"tank.spell(633).range"
		}, "tank" }, 
		{ "!633", (function() return mts.dynamicEval("lowest.health <= " .. fetch('mtsconfPalaHoly', 'LayonHands')) end), "lowest" }, 
		
	-- Infusion of Light // proc
		{{-- AoE
			{ "82327", { -- Holy Radiance - Party
				"@coreHealing.needsHealing(80, 3)", 
				"player.buff(54149)",
				"!player.moving"
			}, "lowest" }, 
		}, "modifier.multitarget" }, 
		{ "82326", { -- Holy Light
			(function() return mts.dynamicEval("lowest.health <= " .. fetch('mtsconfPalaHoly', 'HolyLightIL')) end),
			"player.buff(54149)",
			"!player.moving" 
		}, "lowest" },

	-- Holy Shock
		{ "20473", {
			(function() return mts.dynamicEval("focus.health <= " .. fetch('mtsconfPalaHoly', 'HolyShockTank')) end),
			"focus.spell(20473).range"
		}, "focus" },
		{ "20473", {
			(function() return mts.dynamicEval("tank.health <= " .. fetch('mtsconfPalaHoly', 'HolyShockTank')) end),
			"tank.spell(20473).range"
		}, "tank" }, 
		{ "20473", (function() return mts.dynamicEval("lowest.health <= " .. fetch('mtsconfPalaHoly', 'HolyShock')) end), "lowest" }, 

	{{-- AoE
	-- Light of Dawn
		{ "85222", { -- party
			"@coreHealing.needsHealing(90, 3)", 
			"player.holypower >= 3",
			"modifier.party" 
		}, "lowest" },
		{ "85222", { -- raid
			"@coreHealing.needsHealing(90, 5)", 
			"player.holypower >= 3", 
			"modifier.raid", 
			"!modifier.members > 10" 
		}, "lowest" }, 
		{ "85222", { -- raid 25
			"@coreHealing.needsHealing(90, 8)", 
			"player.holypower >= 3", 
			"modifier.members > 10" 
		}, "lowest" },
	-- Holy Radiance 
		{ "82327", { -- Holy Radiance - Party
			"@coreHealing.needsHealing(80, 3)", 
			"!modifier.last",
			"!player.moving", 
			"modifier.party" 
		}, "lowest" }, 
		{ "82327", { -- Holy Radiance - Raid 10
			"@coreHealing.needsHealing(90, 5)", 
			"!modifier.last", 
			"!player.moving", 
			"modifier.raid", 
			"!modifier.members > 10" 
		}, "lowest" }, 
		{ "82327", { -- Holy Radiance 10+
			"@coreHealing.needsHealing(90, 8)", 
			"!modifier.last", 
			"!player.moving", 
			"modifier.members > 10" 
		}, "lowest" }, 
	}, "modifier.multitarget" },

	{{-- Beacon of Insight
		{ "157007", nil, "lowest" },
		{ "19750", { -- flash of light
			"lowest.health <= 40", 
			"!player.moving" 
		}, "lowest" },
		{ "82326", { -- Holy Light
			"lowest.health < 80",
			"!player.moving" 
		}, "lowest" },
	}, "talent(7,2)" },

	-- Flash of Light
		{ "!19750", { -- focus
			(function() return mts.dynamicEval("focus.health <= " .. fetch('mtsconfPalaHoly', 'FlashofLightTank')) end), 
			"!player.moving",
			"focus.spell(19750).range"
		}, "focus" },
		{ "!19750", { -- tank
			(function() return mts.dynamicEval("tank.health <= " .. fetch('mtsconfPalaHoly', 'FlashofLightTank')) end), 
			"!player.moving",
			"tank.spell(19750).range"
		}, "tank" },
		{ "!19750", { -- lowest
			(function() return mts.dynamicEval("lowest.health <= " .. fetch('mtsconfPalaHoly', 'FlashofLight')) end), 
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
	
	-- Execution Sentence // Talent
		{ "114157", {
			(function() return mts.dynamicEval("focus.health <= " .. fetch('mtsconfPalaHoly', 'ExecutionSentenceTank')) end),
			"focus.spell(114157).range"
		}, "focus" },
		{ "114157", {
			(function() return mts.dynamicEval("tank.health <= " .. fetch('mtsconfPalaHoly', 'ExecutionSentenceTank')) end),
			"tank.spell(114157).range"
		}, "tank" },
		{ "114157", (function() return mts.dynamicEval("lowest.health <= " .. fetch('mtsconfPalaHoly', 'ExecutionSentence')) end), "lowest" },

	{{-- Divine Purpose
		{ "85222", { -- Light of Dawn
			"@coreHealing.needsHealing(90, 3)", 
			"player.holypower >= 1",
			"modifier.party" 
			}, "lowest" },
		{ "85673", (function() return mts.dynamicEval("lowest.health <= " .. fetch('mtsconfPalaHoly', 'WordofGloryDP')) end), "lowest"  }, -- Word of Glory
		{ "114163", { -- Eternal Flame
			"!lowest.buff(114163)", 
			(function() return mts.dynamicEval("lowest.health <= " .. fetch('mtsconfPalaHoly', 'EternalFlameDP')) end) 
			}, "lowest" },
	}, "player.buff(86172)" },
	
	{{-- Selfless Healer
		{ "20271", "target.spell(20271).range", "target" }, -- Judgment
		{{ -- If got buff
			{ "19750", { -- Flash of light
				(function() return mts.dynamicEval("lowest.health <= " .. fetch('mtsconfPalaHoly', 'FlashofLightSH')) end),  
				"!player.moving" 
				}, "lowest" }, 
		}, "player.buff(114250).count = 3" }
	}, "talent(3, 1)" },

	{{-- Sacred Shield // Talent
		{ "148039", { 
			"player.spell(148039).charges >= 1", 
			(function() return mts.dynamicEval("tank.health <= " .. fetch('mtsconfPalaHoly', 'SacredShieldTank')) end), 
			"!tank.buff(148039)", -- SS
			"tank.range < 40" 
		}, "tank" },
		{ "148039", { 
			"player.spell(148039).charges >= 1", 
			(function() return mts.dynamicEval("focus.health <= " .. fetch('mtsconfPalaHoly', 'SacredShieldTank')) end), 
			"!focus.buff(148039)", 
			"focus.range < 40" 
		}, "focus" },
		{ "148039", { -- Sacred Shield
			"player.spell(148039).charges >= 2", 
			"player.health <= 100", 
			"!player.buff(148039)" 
		}, "player" },
		{ "148039", { -- Sacred Shield
			"player.spell(148039).charges >= 2", 
			"lowest.health <= 100", 
			"!lowest.buff(148039)" 
		}, "lowest" },
	}, "talent(3,3)" },

	{{-- Eternal Flame // talent
		{ "114163", { 
			"player.holypower >= 3", 
			"!focus.buff(114163)",
			"focus.spell(114163).range",
			(function() return mts.dynamicEval("lowest.health <= " .. fetch('mtsconfPalaHoly', 'EternalFlameTank')) end)
		}, "focus" },
		{ "114163", { 
			"player.holypower >= 3", 
			"!tank.buff(114163)",
			"focus.spell(114163).range",
			(function() return mts.dynamicEval("lowest.health <= " .. fetch('mtsconfPalaHoly', 'EternalFlameTank')) end)
		}, "tank" },
		{ "114163", { 
			"player.holypower >= 1", 
			"!lowest.buff(114163)", 
			(function() return mts.dynamicEval("lowest.health <= " .. fetch('mtsconfPalaHoly', 'EternalFlame')) end)
		}, "lowest" },
	}, "talent(3,2)" },

	-- Word of Glory
		{ "85673", {
			"player.holypower >= 3",
			"focus.spell(85673).range",
			(function() return mts.dynamicEval("lowest.health <= " .. fetch('mtsconfPalaHoly', 'WordofGloryTank')) end) 
		}, "focus" },
		{ "85673", {
			"player.holypower >= 3",
			"focus.spell(85673).range",
			(function() return mts.dynamicEval("lowest.health <= " .. fetch('mtsconfPalaHoly', 'WordofGloryTank')) end)
		}, "tank"  },
		{ "85673", {
			"player.holypower >= 3", 
			(function() return mts.dynamicEval("lowest.health <= " .. fetch('mtsconfPalaHoly', 'WordofGlory')) end)
		}, "lowest"  },
		
	-- Crusader Strike
		{ "35395", {
			"target.range <= 6", 
			(function() return fetch('mtsconfPalaHoly', 'CrusaderStrike') end) 
		}, "target" },

	-- Holy Prism // Talent
		{ "114165", { -- Holy Prism
			"player.holypower >= 3",
			(function() return mts.dynamicEval("focus.health <= " .. fetch('mtsconfPalaHoly', 'HolyPrismTank')) end), 
			"!player.moving",
			"focus.spell(114165).range" 
		}, "focus"},
		{ "114165", { -- Holy Prism
			(function() return mts.dynamicEval("tank.health <= " .. fetch('mtsconfPalaHoly', 'HolyPrismTank')) end), 
			"!player.moving",
			"tank.spell(114165).range" 
		}, "tank"},
		{ "114165", { -- Holy Prism
			(function() return mts.dynamicEval("lowest.health <= " .. fetch('mtsconfPalaHoly', 'HolyPrism')) end), 
			"!player.moving" 
		}, "lowest"},

	-- Holy Light
		{ "82326", { 
			(function() return mts.dynamicEval("focus.health < " .. fetch('mtsconfPalaHoly', 'HolyLightTank')) end),
			"!player.moving",
			"focus.spell(82326).range" 
		}, "focus" },
		{ "82326", { 
			(function() return mts.dynamicEval("tank.health < " .. fetch('mtsconfPalaHoly', 'HolyLightTank')) end),
			"!player.moving",
			"focus.spell(82326).range" 
		}, "tank" },
		{ "82326", { 
			(function() return mts.dynamicEval("lowest.health < " .. fetch('mtsconfPalaHoly', 'HolyLight')) end),
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

	{{-- Beacon of Faith
		{ "156910", {
			"!player.buff(53563)",
			"!player.buff(156910)"
		}, "player" },
	}, "talent(7,1)" },

	-- Beacon of light
		{ "53563", {
			(function() return fetch("mtsconfPalaHoly", "Beacon") == 'Tank' end),
			"!tank.buff(53563)",
			"!tank.buff(156910)",
			"tank.spell(53563).range" 
		}, "tank" },
		{ "53563", {
			(function() return fetch("mtsconfPalaHoly", "Beacon") == 'Focus' end),
			"!focus.buff(53563)",
			"!focus.buff(156910)",
			"focus.spell(53563).range" 
		}, "focus" }, 

	-- hands
		{ "1044", "player.state.root" }, -- Hand of Freedom

	-- Start
		{ "20473", "lowest.health < 100", "lowest" }, -- Holy Shock

	{{-- AoE
	-- Light of Dawn
		{ "85222", { -- party
			"@coreHealing.needsHealing(90, 3)", 
			"player.holypower >= 3",
			"modifier.party" 
		}, "lowest" },
		{ "85222", { -- raid
			"@coreHealing.needsHealing(90, 5)", 
			"player.holypower >= 3", 
			"modifier.raid", 
			"!modifier.members > 10" 
		}, "lowest" }, 
		{ "85222", { -- raid 25
			"@coreHealing.needsHealing(90, 8)", 
			"player.holypower >= 3", 
			"modifier.members > 10" 
		}, "lowest" },
	-- Holy Radiance 
		{ "82327", { -- Holy Radiance - Party
			"@coreHealing.needsHealing(80, 3)", 
			"!modifier.last",
			"!player.moving", 
			"modifier.party" 
		}, "lowest" }, 
		{ "82327", { -- Holy Radiance - Raid 10
			"@coreHealing.needsHealing(90, 5)", 
			"!modifier.last", 
			"!player.moving", 
			"modifier.raid", 
			"!modifier.members > 10" 
		}, "lowest" }, 
		{ "82327", { -- Holy Radiance 10+
			"@coreHealing.needsHealing(90, 8)", 
			"!modifier.last", 
			"!player.moving", 
			"modifier.members > 10" 
		}, "lowest" }, 
	}, "modifier.multitarget" },

	-- Holy Light
		{ "82326", { 
			(function() return mts.dynamicEval("lowest.health < " .. fetch('mtsconfPalaHoly', 'HolyLightOCC')) end),
			"!player.moving" 
		}, "lowest" },

}

ProbablyEngine.rotation.register_custom(
	65,
	mts.Icon.."|r[|cff9482C9MTS|r][|cffF58CBAPaladin-Holy|r]", 
	inCombat, 
	outCombat, 
	lib)