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
		{ "88423", { 
			"player.buff(Gift of the Titans)",
			"@coreHealing.needsDispelled('Mark of Arrogance')" 
		}, nil },
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
		
	-- HEAL FAST BITCH
	
			{{-- Incarnation: Tree of Life	
				{ "8936", { -- Regrowth
					"player.buff(16870)", -- Clearcasting
					"!lowest.buff", 
					"lowest.health < 80"
				}, "lowest" },
				{ "48438", { -- Wildgrowth
					"@coreHealing.needsHealing(85, 3)"
				}, "lowest" },
				{ "33763", { -- Lifebloom
					"!lowest.buff(33763)",
					"lowest.health < 100"
				}, "lowest" },
			}, "player.buff(33891)" },
			
			{{ -- Clearcasting
				{ "8936", { -- Regrowth
					"!lowest.buff(8936)", 
					"lowest.health < 80",
					"!player.moving"
				}, "lowest" },
				{ "5185", { -- Healing Touch
					"lowest.health < 80",
					"!player.moving"
				}, "lowest" },
			}, "player.buff(16870)" }, 
			
		{ "5185", { -- Healing Touch tier set - 2
			"player.buff(144871).count = 5", 
			"lowest.health < 80",
			"!player.moving"
		}, "lowest" },
		
	-- Tank
		{ "33763", { -- Renew - Life Bloom
			"tank.buff(33763).duration < 2",
			"tank.spell(33763).range",
		}, "tank" },
		{ "774", { -- Rejuvenation
			"!tank.buff",
			"tank.health < 95",
			"tank.spell(774).range"
		}, "tank" },
		{ "33763", { -- Life Bloom
			"tank.buff(33763).count < 3",
			"tank.spell(33763).range"
		}, "tank" },
	
	-- Single target
		{ "18562", { -- Swiftmend
			"lowest.health < 80", 
			"lowest.buff(774)" -- if Rejuvenation buff
		}, "lowest" },
		{ "145518", { -- Genesis
			"!player.spell(18562).cooldown = 0",
			"lowest.health < 40", 
			"lowest.buff(774)" -- if Rejuvenation buff
		}, "lowest" },
		{ "774", { -- Rejuvenation
			"lowest.health < 85", 
			"!lowest.health < 60", -- Regrowth instead
			"!lowest.buff"
		}, "lowest" },
		{ "145205", { -- Wild Mushroom
			"lowest.health < 100", 
			"!lowest.health < 60" -- Regrowth instead
		}, "lowest" },
		{ "102791", { -- Wild Mushroom - Bloom
			"lowest.health < 100", 
			"!lowest.health < 60", -- Regrowth instead
			"player.totem(145205).duration >= 1",
		}, "lowest" },
		{ "50464", { -- Nourish
			"player.buff(100977).duration <= 2", -- Harmony
			"!lowest.health < 60", -- Regrowth instead
			"lowest.health < 97",
			"!player.moving"
		}, "lowest" },
		{ "8936", { -- Regrowth
			"lowest.health < 60", 
			"!lowest.health < 40", -- Healing Touch instead
			"!lowest.buff(8936)",
			"!player.moving"
		}, "lowest" },
		{ "5185", { -- Healing Touch
			"lowest.health < 40",
			"!player.moving"
		}, "lowest", }

},{------------------------------------------------------------------------ Out Of Combat
	
	-- KeyBinds
		{ "106731" , "modifier.rcontrol" }, -- Incarnation
		{ "740" , "modifier.rshift" }, -- Tranq
		{ "!/focus [target=mouseover]", "modifier.ralt" }, -- Mouseover Focus
		{ "20484", "modifier.lshift", "mouseover" }, -- Rebirth

	-- Healing
		{ "774", { -- Rejuvenation
			"lowest.health < 99", 
			"!lowest.buff",
			"player.form = 0"
		}, "lowest" },
	
	--	Buffs
		{ "1126", {-- Mark of the Wild
			"!player.buff",
			"player.form = 0"
		}, nil },
},		
------------------------------------------------------------------------------------------------------------
-- Party/Raid Toggles
function()
	ProbablyEngine.toggle.create('dispel', 'Interface\\Icons\\ability_shaman_cleansespirit', 'Dispel Everything', 'Dispels everything it finds.')
end)