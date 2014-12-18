--[[ ///---INFO---////
// Druid Resto //
Thank You For Using My ProFiles
I Hope Your Enjoy Them
MTS
]]

local fetch = ProbablyEngine.interface.fetchKey
local ignoreDebuffs = {'Mark of Arrogance','Displaced Energy'}

								--[[   !!!Dispell function!!!   ]]
						--[[   Checks is member as debuff and can be dispeled.   ]]
--[[  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ]]
local function Dispell()
local prefix = (IsInRaid() and 'raid') or 'party'
	for i = -1, GetNumGroupMembers() - 1 do
	local unit = (i == -1 and 'target') or (i == 0 and 'player') or prefix .. i
		if IsSpellInRange("Nature's Cure", unit) then
			for j = 1, 40 do
			local debuffName, _, _, _, dispelType, duration, expires, _, _, _, spellID, _, isBossDebuff, _, _, _ = UnitDebuff(unit, j)
				if dispelType and dispelType == 'Magic' or dispelType == 'curse' then
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

end	

local inCombat = {

	--	keybinds
		{ "740" , "modifier.shift" }, -- Tranq
		{ "!/focus [target=mouseover]", "modifier.alt" }, -- Mouseover Focus
		{ "20484", "modifier.control", "mouseover" }, -- Rebirth

	--	Buffs
		{ "1126", { -- Mark of the Wild
			"!player.buff(20217).any",
			"!player.buff(115921).any",
			"!player.buff(1126).any",
			"!player.buff(90363).any",
			"!player.buff(69378).any",
			"player.form = 0" 
		}, nil },

	{{-- Dispel
		{ "88423", (function() return Dispell() end) },
	}, (function() return fetch('mtsconfDruidResto','Dispels') end) },

	-- Cooldowns
		{ "29166", { "player.mana < 80", "modifier.cooldowns"}, "player" }, -- Inervate
		{ "132158", { "player.spell(132158).cooldown = 0", "modifier.cooldowns" }, nil }, -- Nature's Swiftness
		{ "106731" , { "@coreHealing.needsHealing(85, 4)", "modifier.cooldowns" }, nil }, -- Incarnation
	
	-- Survival
		{ "#5512", "player.health < 60" }, --Healthstone
	
	{{-- AOE
		{ "48438", "@coreHealing.needsHealing(85, 3)", "lowest" }, -- Wildgrowth
	}, "modifier.multitarget" },

	-- Incarnation: Tree of Life	
		{ "8936", { "player.buff(16870)", "!lowest.buff", "lowest.health < 80", "player.buff(33891)" }, "lowest" }, -- Regrowth
		{ "48438", { "@coreHealing.needsHealing(85, 3)", "player.buff(33891)" }, "lowest" }, -- Wildgrowth
		{ "33763", { "!lowest.buff(33763)", "lowest.health < 100", "player.buff(33891)" }, "lowest" }, -- Lifebloom

	-- Clearcasting
		{ "8936", { "!lowest.buff(8936)", "lowest.health < 80", "!player.moving", "player.buff(16870)" }, "lowest" }, -- Regrowth
		{ "5185", { "lowest.health < 80", "!player.moving", "player.buff(16870)" }, "lowest" }, -- Healing Touch

	-- Life Bloom
		{ "33763", { -- Life Bloom
			(function() return mts_dynamicEval("focus.health <= " .. fetch('mtsconfDruidResto', 'LifeBloomTank')) end),
			"!focus.buff(33763)", 
			"focus.spell(33763).range" 
			}, "focus" }, 
		{ "33763", { -- Life Bloom
			(function() return mts_dynamicEval("tank.health <= " .. fetch('mtsconfDruidResto', 'LifeBloomTank')) end),
			"!tank.buff(33763)", 
			"tank.spell(33763).range" 
		}, "tank" }, 

	-- Swiftmend
		{ "18562", {  -- Swiftmend
			(function() return mts_dynamicEval("focus.health <= " .. fetch('mtsconfDruidResto', 'SwiftmendTank')) end),
			"focus.buff(774)" 
			}, "focus" },
		{ "18562", { -- Swiftmend
			(function() return mts_dynamicEval("tank.health <= " .. fetch('mtsconfDruidResto', 'SwiftmendTank')) end),
			"tank.buff(774)" 
			}, "tank" },
		{ "18562", { "lowest.health < 30", "lowest.buff(774)" }, "focus" }, -- Swiftmend

	-- Rejuvenation
		{ "774", { -- Rejuvenation
			(function() return mts_dynamicEval("focus.health <= " .. fetch('mtsconfDruidResto', 'RejuvenationTank')) end),
			"!focus.buff", 
			"focus.spell(774).range" 
			}, "focus" },
		{ "774", { -- Rejuvenation
			(function() return mts_dynamicEval("tank.health <= " .. fetch('mtsconfDruidResto', 'RejuvenationTank')) end),
			"!tank.buff", 
			"tank.spell(774).range" 
			}, "tank" },
		{ "774", { "!lowest.buff", "lowest.health < 65" }, "lowest" }, -- Rejuvenation

	-- Wild Mushroom	
		{ "145205", { -- Wild Mushroom	
			(function() return mts_WildMushroom() == 'focus' end),
			"!player.totem(145205)"
		}, "focus" },
		{ "145205", { -- Wild Mushroom
			(function() return mts_WildMushroom() == 'player' end),
			"!player.totem(145205)"
		}, "player" },
	
	-- Regrowth	
		{ "8936", {  -- Regrowth
			"lowest.health < 50", 
			"!lowest.buff(8936)", 
			"!player.moving" 
		}, "lowest" },	

	-- Genesis
		{ "145518", { -- Genesis
			"!player.spell(18562).cooldown = 0", 
			"lowest.health < 40", 
			"lowest.buff(774)" 
			}, "lowest" }, 

	-- Healing Touch
	 	{ "5185", {  -- Healing Touch
	 		(function() return mts_dynamicEval("focus.health <= " .. fetch('mtsconfDruidResto', 'HealingTouchTank')) end), 
		 	"!player.moving" 
		 	}, "focus" },
		{ "5185", { -- Healing Touch
			(function() return mts_dynamicEval("tank.health <= " .. fetch('mtsconfDruidResto', 'HealingTouchTank')) end),
			"!player.moving" 
			}, "tank" },
		{ "5185", { "lowest.health < 96", "!player.moving" }, "lowest" }, -- Healing Touch

}

local outCombat = {

	--	keybinds
		{ "!/focus [target=mouseover]", "modifier.alt" }, -- Mouseover Focus
		{ "20484", "modifier.control", "mouseover" }, -- Rebirth

	--	Buffs
		{ "1126", { -- Mark of the Wild
			"!player.buff(20217).any",
			"!player.buff(115921).any",
			"!player.buff(1126).any",
			"!player.buff(90363).any",
			"!player.buff(69378).any",
			"player.form = 0" 
		}, nil },

	-- Life Bloom
		{ "33763", { -- Life Bloom
			(function() return mts_dynamicEval("focus.health <= " .. fetch('mtsconfDruidResto', 'LifeBloomTank')) end),
			"!focus.buff(33763)", 
			"focus.spell(33763).range" 
			}, "focus" },
		{ "33763", { -- Life Bloom
			(function() return mts_dynamicEval("tank.health <= " .. fetch('mtsconfDruidResto', 'LifeBloomTank')) end),
			"!tank.buff(33763)", 
			"tank.spell(33763).range" 
			}, "tank" }, 

}

ProbablyEngine.rotation.register_custom(
	105,
	mts_Icon.."|r[|cff9482C9MTS|r][|cffFF7D0ADruid-Resto|r]", 
	inCombat, 
	outCombat, 
	exeOnLoad)