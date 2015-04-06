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
	mts.Splash()
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

	{{-- Cooldowns
		{ "29166", "player.mana < 80", "player" }, -- Inervate
		{ "132158" }, -- Nature's Swiftness
		{{ -- Party
			{ "106731", "@coreHealing.needsHealing(85, 3)" },-- Incarnation
			{ "740", "@coreHealing.needsHealing(50, 3)" }, -- Tranq
		}, "modifier.party" },
		{{ -- Raid
			{ "106731", "@coreHealing.needsHealing(85, 6)" },-- Incarnation
			{ "740", "@coreHealing.needsHealing(50, 7)" }, -- Tranq
		}, "modifier.raid" },
	}, "modifier.cooldowns"},
	
	-- Items
		{ "#5512", "player.health < 60" }, --Healthstone
	
	--  Ironbark
		{"Ironbark",{
			"focus.health <= 40",
			"focus.friend",
			"focus.range <= 40"
		},"focus"},
		{"Ironbark",{
			"tank.health <= 40",
			"tank.range <= 40"
		},"tank"},

	-- Genesis
		{ "145518", { -- Genesis
			"!player.spell(18562).cooldown = 0", 
			"lowest.health < 40", 
			"lowest.buff(774)" 
		}, "lowest" }, 

	{{-- FREE Regrowth
		{ "8936", {  
			"lowest.health < 50", 
			"!lowest.buff(8936)", 
			"!player.moving" 
		}, "lowest" },
	}, "player.buff(8936)" },

	{{-- AOE
		{ "48438", { -- Wildgrowth
			"@coreHealing.needsHealing(85, 3)", 
			"!lastcast(48438)"
		}, "lowest" }, 
	}, "modifier.multitarget" },

	{{-- Soul of the Forest
		{ "Regrowth", {
			"!player.moving",
			"focus.range <= 40", 
			"focus.health <=85"
		}, "focus"},
		{ "Regrowth", {
			"!player.moving",
			"tank.range <= 40", 
			"tank.health <=85"
		}, "tank" },
		{ "Regrowth", {
			"!player.moving",
			"lowest.range <= 40", 
			"lowest.health <=85"
		}, "lowest" },
	}, "player.buff(114108)" },

	{{-- Incarnation: Tree of Life
		{ "33763", { -- Lifebloom
			"!lowest.buff(33763)", 
			"lowest.health < 30" 
		}, "lowest" },
		{ "8936", { -- Regrowth
			"player.buff(16870)", 
			"!lowest.buff", 
			"lowest.health < 80" 
		}, "lowest" }, 
	}, "player.buff(33891)" },

	{{-- Clearcasting
		{ "8936", { -- Regrowth
			"!lowest.buff(8936)", 
			"lowest.health < 80", 
			"!player.moving", 
		}, "lowest" }, 
		{ "5185", { -- Healing Touch
			"lowest.health < 80", 
			"!player.moving",
		}, "lowest" },
	}, "player.buff(16870)" },

	{{-- Force of Nature
		{ "102693", {
			"!modifier.last",
			"player.spell(102693).charges >= 1", 
			"tank.range <= 40",
			"@coreHealing.needsHealing(70, 5)"
		}, "tank" },
		{ "102693", {
			"!modifier.last",
			"player.spell(102693).charges >= 1", 
			"lowest.range <= 40",
			"@coreHealing.needsHealing(70, 5)"
		}, "lowest" }, 
		{ "102693", {
			"!modifier.last",
			"player.spell(102693).charges >= 2", 
			"tank.range <= 40", 
			"tank.health <= 70"
		}, "tank" },  
		{ "102693", {
			"!modifier.last",
			"player.spell(102693).charges >= 2", 
			"lowest.range <= 40", 
			"lowest.health <= 70"
		}, "lowest" },
		{ "102693", {
			"!modifier.last",
			"player.spell(102693).charges = 3", 
			"tank.range <= 40", 
			"tank.health <= 92"
		}, "tank" }, 
		{ "102693", {
			"!modifier.last",
			"player.spell(102693).charges = 3", 
			"lowest.range <= 40", 
			"lowest.health <= 92"
		}, "lowest" },  
	},"talent(4,3)"},

	-- Life Bloom
		{ "33763", { -- Life Bloom
			(function() return mts.dynamicEval("focus.health <= " .. fetch('mtsconfDruidResto', 'LifeBloomTank')) end),
			"!focus.buff(33763)", 
			"focus.spell(33763).range" 
		}, "focus" }, 
		{ "33763", { -- Life Bloom
			(function() return mts.dynamicEval("tank.health <= " .. fetch('mtsconfDruidResto', 'LifeBloomTank')) end),
			"!tank.buff(33763)", 
			"tank.spell(33763).range" 
		}, "tank" }, 

	{{-- Wild Mushroom
		{ "145205", "!player.totem(145205)", "focus" }, -- Wild Mushroom
    	{ "145205", "!player.totem(145205)", "tank" }, -- Wild Mushroom
	}, "!glyph(146654)" },

	{{-- Wild Mushroom // Glyph of the Sprouting Mushroom
		{ "145205", "!player.totem(145205)", "focus.ground" }, -- Wild Mushroom
		{ "145205", "!player.totem(145205)", "tank.ground" }, -- Wild Mushroom
	}, "glyph(146654)" },
	
	-- Swiftmend
		{ "18562", {  -- Swiftmend
			(function() return mts.dynamicEval("focus.health <= " .. fetch('mtsconfDruidResto', 'SwiftmendTank')) end),
			"focus.buff(774)" 
		}, "focus" },
		{ "18562", { -- Swiftmend
			(function() return mts.dynamicEval("tank.health <= " .. fetch('mtsconfDruidResto', 'SwiftmendTank')) end),
			"tank.buff(774)" 
		}, "tank" },
		{ "18562", { "lowest.health < 30", "lowest.buff(774)" }, "focus" }, -- Swiftmend

	-- Rejuvenation
		{ "774", {
			(function() return mts.dynamicEval("focus.health <= " .. fetch('mtsconfDruidResto', 'RejuvenationTank')) end),
			"!focus.buff", 
			"focus.spell(774).range" 
			}, "focus" },
		{ "774", {
			(function() return mts.dynamicEval("tank.health <= " .. fetch('mtsconfDruidResto', 'RejuvenationTank')) end),
			"!tank.buff", 
			"tank.spell(774).range" 
			}, "tank" },
		{ "774", {
			"!lowest.buff", 
			"lowest.health < 65" 
		}, "lowest" },

	{{-- Germination // Talent
		{ "774", {
			(function() return mts.dynamicEval("focus.health <= " .. fetch('mtsconfDruidResto', 'RejuvenationTank')) end),
			"!focus.buff(155777)", 
			"focus.spell(774).range" 
		}, "focus" },
		{ "774", {
			(function() return mts.dynamicEval("tank.health <= " .. fetch('mtsconfDruidResto', 'RejuvenationTank')) end),
			"!tank.buff(155777)", 
			"tank.spell(774).range" 
		}, "tank" },
		{ "774", { 
			"!lowest.buff(155777)", 
			"lowest.health < 65" 
		}, "lowest" },
	}, "talent(7,2)" },
	
	{{-- Regrowth EMERGENCY
		{ "!8936", {  -- Regrowth
			"lowest.health < 20", 
			"!player.moving" 
		}, "lowest" },
	}, "!player.casting.percent >= 50" },

	-- Regrowth	
		{ "8936", {  -- Regrowth
			"lowest.health < 50", 
			"!lowest.buff(8936)", 
			"!player.moving" 
		}, "lowest" },

	-- Healing Touch
	 	{ "5185", {  -- Healing Touch
	 		(function() return mts.dynamicEval("focus.health <= " .. fetch('mtsconfDruidResto', 'HealingTouchTank')) end), 
		 	"!player.moving" 
		}, "focus" },
		{ "5185", { -- Healing Touch
			(function() return mts.dynamicEval("tank.health <= " .. fetch('mtsconfDruidResto', 'HealingTouchTank')) end),
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
		}},

	-- Life Bloom
		{ "33763", { -- Life Bloom
			"tank.health < 100",
			"!tank.buff(33763)", 
			"tank.spell(33763).range" 
		}, "tank" }, 

}

ProbablyEngine.rotation.register_custom(
	105,
	mts.Icon.."|r[|cff9482C9MTS|r][|cffFF7D0ADruid-Resto|r]", 
	inCombat, 
	outCombat, 
	exeOnLoad)