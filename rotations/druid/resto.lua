ProbablyEngine.rotation.register_custom(105, "|r[|cff9482C9MTS|r][|cffFF7D0ADruid-Resto|r]", {
-- Party/Raid Rotation

	--Pause if
		{ "pause", "player.form > 1" }, -- Any Player from but bear
	
	-- KeyBinds
		{ "106731" , "modifier.rcontrol" }, -- Incarnation
		{ "740" , "modifier.rshift" }, -- Tranquility
		{ "20484", "modifier.lshift", "mouseover" }, -- Rebirth
		{ "!/focus [target=mouseover]", "modifier.ralt" }, -- Mouseover Focus

	--Dispel
		{ "88423", { "player.buff(Gift of the Titans)", "@coreHealing.needsDispelled('Mark of Arrogance')" }, nil },
		{ "88423", "@coreHealing.needsDispelled('Shadow Word: Bane')", nil },
		{ "88423", "@coreHealing.needsDispelled('Corrosive Blood')", nil },
		{ "88423", "@coreHealing.needsDispelled('Harden Flesh')", nil },
		{ "88423", "@coreHealing.needsDispelled('Torment')", nil },
		{ "88423", "@coreHealing.needsDispelled('Breath of Fire')", nil },
		{ "88423", { "toggle.dispel", "@druiddispell.druid()" }, nil },

	{{-- Cooldowns
		{ "29166", "player.mana < 80", "player" }, -- Inervate
		{ "132158", "player.spell(132158).cooldown = 0" }, -- Nature's Swiftness
	}, "modifier.cooldowns" },
	
	-- Survival
		{ "#5512", "player.health <= 45"}, --Healthstone
	
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
		{ "145205", { "lowest.health < 100", "!lowest.health < 60" }, "lowest" }, -- Wild Mushroom
		{ "102791", { "lowest.health < 100", "!lowest.health < 60", "player.totem(145205).duration >= 1" }, "lowest" }, -- Wild Mushroom - Bloom
		{ "50464", { "player.buff(100977).duration <= 2", "!lowest.health < 60", "lowest.health < 97", "!player.moving" }, "lowest" }, -- Nourish
		{ "8936", { "lowest.health < 60", "!lowest.health < 40", "!lowest.buff(8936)", "!player.moving" }, "lowest" }, -- Regrowth
		{ "5185", { "lowest.health < 40", "!player.moving" }, "lowest", } -- Healing Touch

},{------------------------------------------------------------------------ Out Of Combat
	
	-- KeyBinds
		{ "106731" , "modifier.rcontrol" }, -- Incarnation
		{ "740" , "modifier.rshift" }, -- Tranq
		{ "!/focus [target=mouseover]", "modifier.ralt" }, -- Mouseover Focus
		{ "20484", "modifier.lshift", "mouseover" }, -- Rebirth

	-- Healing
		{ "774", { "lowest.health < 99", "!lowest.buff", "player.form = 0" }, "lowest" }, -- Rejuvenation
	
	--	Buffs
		{ "1126", { "!player.buff(20217).any", "!player.buff(115921).any", "!player.buff(1126).any", "!player.buff(90363).any", "!player.buff(69378).any", "player.form = 0" }, nil }, -- Mark of the Wild

},		
------------------------------------------------------------------------------------------------------------
-- Party/Raid Toggles
function()
	ProbablyEngine.toggle.create('dispel', 'Interface\\Icons\\ability_shaman_cleansespirit', 'Dispel Everything', 'Dispels everything it finds.')
end)