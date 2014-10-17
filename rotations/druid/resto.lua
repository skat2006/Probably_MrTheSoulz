--[[ ///---INFO---////
// Druid Resto //
Thank You For Using My ProFiles
I Hope Your Enjoy Them
MTS
]]

local exeOnLoad = function()

	mtsAlert:message("\124cff9482C9*MrTheSoulz - \124cffFF7D0ADruid/Restoration \124cff9482C9Loaded*")

end	

local Buffs = {

	--	Buffs
		{ "1126", { -- Mark of the Wild
			"!player.buff(20217).any",
			"!player.buff(115921).any",
			"!player.buff(1126).any",
			"!player.buff(90363).any",
			"!player.buff(69378).any",
			"@mtsLib.getConfig('DoodRestoBuffs')",
			"player.form = 0" 
		}, nil },
  
}

local inCombat = {

	--	keybinds
		{ "740" , "modifier.shift" }, -- Tranq
		{ "!/focus [target=mouseover]", "modifier.alt" }, -- Mouseover Focus
		{ "20484", "modifier.control", "mouseover" }, -- Rebirth
  
	--Pause if
		{ "pause", "player.form > 1" }, -- Any from but bear

	--Dispel
		{ "88423", { "player.buff(Gift of the Titans)", "@coreHealing.needsDispelled('Mark of Arrogance')" }, nil },
		{ "88423", "@coreHealing.needsDispelled('Shadow Word: Bane')", nil },
		{ "88423", "@coreHealing.needsDispelled('Corrosive Blood')", nil },
		{ "88423", "@coreHealing.needsDispelled('Harden Flesh')", nil },
		{ "88423", "@coreHealing.needsDispelled('Torment')", nil },
		{ "88423", "@coreHealing.needsDispelled('Breath of Fire')", nil },
		{ "88423", { "@mtsLib.getConfig('DoodRestoDispells')", "mtsLib.Dispell('Nature's Cure')" }, nil },

	-- Cooldowns
		{ "29166", { "player.mana < 80", "modifier.cooldowns"}, "player" }, -- Inervate
		{ "132158", { "player.spell(132158).cooldown = 0", "modifier.cooldowns" }, nil }, -- Nature's Swiftness
		{ "106731" , { "@coreHealing.needsHealing(85, 4)", "modifier.cooldowns" }, nil }, -- Incarnation
	
	-- Survival
		{ "#5512", "@mtsLib.ConfigUnitHp('DoodRestoHs', 'player')" }, --Healthstone
	
	-- AOE
		{ "48438", "@coreHealing.needsHealing(85, 3)", "lowest" }, -- Wildgrowth

	-- Incarnation: Tree of Life	
		{ "8936", { "player.buff(16870)", "!lowest.buff", "lowest.health < 80", "player.buff(33891)" }, "lowest" }, -- Regrowth
		{ "48438", { "@coreHealing.needsHealing(85, 3)", "player.buff(33891)" }, "lowest" }, -- Wildgrowth
		{ "33763", { "!lowest.buff(33763)", "lowest.health < 100", "player.buff(33891)" }, "lowest" }, -- Lifebloom

	-- Clearcasting
		{ "8936", { "!lowest.buff(8936)", "lowest.health < 80", "!player.moving", "player.buff(16870)" }, "lowest" }, -- Regrowth
		{ "5185", { "lowest.health < 80", "!player.moving", "player.buff(16870)" }, "lowest" }, -- Healing Touch

	-- Tank
		{ "33763", { "tank.buff(33763).duration < 2", "tank.spell(33763).range" }, "tank" }, -- Renew - Life Bloom
		{ "774", { "!tank.buff", "tank.health < 95", "tank.spell(774).range" }, "tank" }, -- Rejuvenation
		{ "33763", { "tank.buff(33763).count < 3", "tank.spell(33763).range" }, "tank" }, -- Life Bloom
	
	-- Single target
		{ "5185", { "player.buff(144871).count = 5", "lowest.health < 80", "!player.moving" }, "lowest" }, -- Healing Touch tier set - 2
		{ "18562", { "lowest.health < 80", "lowest.buff(774)" }, "lowest" }, -- Swiftmend
		{ "145518", { "!player.spell(18562).cooldown = 0", "lowest.health < 40", "lowest.buff(774)" }, "lowest" }, -- Genesis
		{ "774", { "lowest.health < 85", "!lowest.health < 60", "!lowest.buff" }, "lowest" }, -- Rejuvenation
		{ "145205", { "@mtsLib.ConfigUnitHp('toUseDoodRestoMr', 'lowest')", "@mtsLib.getConfig('DoodRestoMr')", "!lowest.health < 60" }, "lowest" }, -- Wild Mushroom
		{ "102791", { "@mtsLib.ConfigUnitHp('toUseDoodRestoMr', 'lowest')", "@mtsLib.getConfig('DoodRestoMr')", "!lowest.health < 60", "player.totem(145205).duration >= 1" }, "lowest" }, -- Wild Mushroom - Bloom
		{ "50464", { "player.buff(100977).duration <= 2", "!lowest.health < 60", "lowest.health < 97", "!player.moving" }, "lowest" }, -- Nourish
		{ "8936", { "lowest.health < 60", "!lowest.health < 40", "!lowest.buff(8936)", "!player.moving" }, "lowest" }, -- Regrowth
		{ "5185", { "lowest.health < 40", "!player.moving" }, "lowest", } -- Healing Touch
  
}

local outCombat = {

	--	keybinds
		{ "740" , "modifier.shift" }, -- Tranq
		{ "!/focus [target=mouseover]", "modifier.alt" }, -- Mouseover Focus
		{ "20484", "modifier.control", "mouseover" }, -- Rebirth

	-- Healing
		{ "774", { "lowest.health < 99", "!lowest.buff", "player.form = 0" }, "lowest" }, -- Rejuvenation

}

for _, Buffs in pairs(Buffs) do
  inCombat[#inCombat + 1] = Buffs
  outCombat[#outCombat + 1] = Buffs
end

ProbablyEngine.rotation.register_custom(105, "|r[|cff9482C9MTS|r][|cffFF7D0ADruid-Resto|r]", inCombat, outCombat, exeOnLoad)