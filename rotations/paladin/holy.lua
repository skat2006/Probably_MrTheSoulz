ProbablyEngine.rotation.register_custom(65, "|r[|cff9482C9MTS|r][|cffF58CBAHoly-Paladin|r]", {
-- Party Rotation

	-- KeyBinds
		{ "114158", "modifier.shift", "ground"}, -- Light´s Hammer
		{ "!/focus [target=mouseover]", "modifier.alt" }, -- Mouseover Focus

	--Buffs
		{ "19740", { -- Blessing of Might
			"!player.buff(19740).any",
			"!player.buff(116956).any",
			"!player.buff(93435).any",
			"!player.buff(128997).any",
			"!toggle.buff"
		}, nil },
		{ "20217", { -- Blessing of Kings
			"!player.buff(20217).any",
			"!player.buff(115921).any",
			"!player.buff(1126).any",
			"!player.buff(90363).any",
			"!player.buff(69378).any",
			"toggle.buff"
		}, nil },
	
	-- Seal
        { "20165", "player.seal != 3", nil }, -- Seal of Insight
	
	-- Interrupts
		{ "96231", "modifier.interrupts", "target" }, -- Rebuke
	
	-- Mana Regen
		{ "28730", "player.mana < 90", nil }, -- Arcane torrent
		{ "54428", "player.mana < 85", nil }, -- Divine Plea
		{ "#trinket1", "player.mana < 85", nil }, -- Trinket 1
		{ "#trinket2", "player.mana < 85", nil }, -- Trinket 2
		
	-- Hands
		{ "1044", "player.state.root" , nil }, -- Hand of Freedom
		{ "6940", { -- Hand of Sacrifice
			"tank.spell(6940).range", 
			"tank.health < 40"
		}, "tank" },

	-- Survival
		{ "#5512", "player.health <= 45", nil }, -- Healthstone       
		{ "498", "player.health <= 90", "player" }, -- Divine Protection
		{ "642", "player.health <= 20", "player" }, -- Divine Shield

	{{-- Cooldowns
		{ "#gloves" }, -- gloves
		{ "31821", "@coreHealing.needsHealing(40, 5)", nil }, -- Devotion Aura	
		{ "31884", "@coreHealing.needsHealing(95, 4)", nil }, -- Avenging Wrath
		{ "86669", "@coreHealing.needsHealing(85, 4)", nil }, -- Guardian of Ancient Kings
		{ "31842", "@coreHealing.needsHealing(90, 4", nil }, -- Divine Favor
		{ "105809", "talent(13)", nil }, -- Holy Avenger
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
		{ "4987", { "toggle.dispel", "@paladispell.Cleanse()" }, nil },
	
	{{-- Divine Purpose
		{ "85673", { -- Word of Glory
			"lowest.health <= 80",
		}, "lowest"  },
		{ "114163", { --Eternal Flame
			"!lowest.buff(114163)",
			"lowest.health <= 85"
		}, "lowest" },
	}, "player.buff(86172)" },
	
	{{-- Selfless Healer
		{ "!/target [target=focustarget, harm, nodead]", "!target.exists" }, -- Target focus target
		{ "20271", "target.spell(20271).range", "target" }, -- Judgment
		{{ -- If got buff
			{ "19750", {-- Flash of light
				"lowest.health < 85",
				"!lowest.health < 65", -- DL instead
				"!@coreHealing.needsHealing(95, 4)", -- HR instead
				"!player.moving",
			}, "lowest" },
			{ "82326", { -- Divine Light
				"lowest.health < 65",
				"!@coreHealing.needsHealing(95, 4)", -- HR instead
				"!player.moving"
			}, "lowest" },
			{ "82327", { -- Holy Radiance
				"@coreHealing.needsHealing(95, 4)",
				"!player.moving"
			}, "lowest" },
		}, "player.buff(114250).count = 3" }
	}, "talent(7)" },		

	-- Infusion of Light
		{ "20473", "lowest.health < 100", "lowest" }, -- Holy Shock
		{{ -- If got buff
			{ "82326", { -- Divine Light
				"lowest.health < 75",
				"!@coreHealing.needsHealing(90, 4)", -- HR instead
				"!player.moving"
			}, "lowest" },
		}, "player.buff(54149)" },

	{{ -- AOE
		{{ -- Party
			{ "85222", { -- Light of Dawn
				"@coreHealing.needsHealing(90, 3)",
				"player.holypower >= 3"
			}, "lowest" },
			{ "82327", { -- Holy Radiance - Party
				"@coreHealing.needsHealing(80, 3)",
				"!modifier.last",
				"!player.moving"
			}, "lowest" },
		}, "modifier.party" },
		{{ -- RAID
			{{ -- Stop If 10+
				{ "85222", { -- Light of Dawn
					"@coreHealing.needsHealing(90, 5)",
					"player.holypower >= 3"
				}, "lowest" },
				{ "82327", { -- Holy Radiance - Raid 10
					"@coreHealing.needsHealing(90, 5)",
					"!modifier.last",
					"!player.moving"
				}, "lowest" },
			}, "modifier.raid" },
		}, "!modifier.members > 10" },
		{{ -- Raid 25
			{ "85222", { -- Light of Dawn
				"@coreHealing.needsHealing(90, 8)",
				"player.holypower >= 3"
			}, "lowest" },
			{ "82327", { -- Holy Radiance 10+
				"@coreHealing.needsHealing(90, 8)",
				"!modifier.last",
				"!player.moving"
			}, "lowest" },
		}, "modifier.members > 10" },
	}, "!toggle.aoe" },
	
	{{-- AOE - Forced
		{ "85222", "player.holypower >= 3", "lowest" }, -- Light of Dawn
		{ "82327", { -- Holy Radiance
			"!player.moving" ,
			"modifier.multitarget",
		}, "lowest" },
	}, "toggle.aoe" },
	
	-- HEAL FAST BITCH
		{ "633", "lowest.health < 15", "lowest" }, -- Lay on Hands
		{ "85673", { -- Word of Glory
			"player.holypower >= 3",
			"lowest.health <= 80",
		}, "lowest"  },
		{ "114163", { --Eternal Flame
			"player.holypower >= 1",
			"!lowest.buff(114163)",
			"lowest.health <= 85"
		}, "lowest" },
		{ "20925", { -- Sacred Shield
			"spell.charges(20925) >= 2",
			"lowest.health < 90",
			"!lowest.buff(148039)",
			"lowest.spell(20925).range",
			"!modifier.last"
		}, "lowest" },
		{ "19750", {-- Flash of light
			"lowest.health < 30",
			"!player.moving",
		}, "lowest" },

	-- Dps
		{ "35395", "target.spell(35395).range", "target" }, -- Crusader Strike
		
	-- Tank
		{ "53563", { -- Beacon of light
			"!tank.buff(53563)",
			"tank.spell(53563).range",
		}, "tank" },
		{ "114157", "tank.health < 85", "tank" }, -- Execution Sentence
		{ "114163", { -- Eternal Flame
			"player.holypower >= 3",
			"!tank.buff(114163)",
			"tank.health <= 75"
		}, "tank" },
		{ "20925", { -- Sacred Shield
			"spell.charges(20925) >= 1",
			"tank.health < 95",
			"!tank.buff(148039)",
			"tank.spell(20925).range",
			"!modifier.last"
		}, "tank" },
		{ "82326", { -- Divine Light
			"tank.health < 65",
			"tank.spell(82326).range",
			"!player.moving"
		}, "tank" },
		
	-- Single target
		{ "114165", { -- Holy Prism
			"lowest.health < 85",
			"!player.moving"
		}, "lowest"},
		{ "635", { -- Holy Light
			"lowest.health < 97",
			"!lowest.health < 65", -- DL instead
			"!player.moving"
		}, "lowest" },
		{ "82326", { -- Divine Light
			"lowest.health < 35",
			"!player.moving"
		}, "lowest" },
		
},{------------------------------------------------------------------------ Out Of Combat

	-- Keybinds
		{ "114158", "modifier.shift", "ground"}, -- Light´s Hammer
		{ "!/focus [target=mouseover]", "modifier.alt" }, -- Mouseover Focus

	-- Seal
        { "20165", "player.seal != 3", nil }, -- Seal of Insight
	
	-- Mana Regen
		{ "28730", "player.mana < 90", nil }, -- Arcane torrent
		{ "54428", "player.mana < 85", nil }, -- Divine Plea
		{ "#trinket1", "player.mana < 85", nil }, -- Trinket 1
		{ "#trinket2", "player.mana < 85", nil }, -- Trinket 2
		
	-- Hands
		{ "1044", "player.state.root" , nil }, -- Hand of Freedom
	
	-- Tank
		{ "53563", { -- Beacon of light
			"!tank.buff(53563)",
			"tank.spell(53563).range",
		}, "tank" },

	--Buffs
		{ "19740", { -- Blessing of Might
			"!player.buff(19740).any",
			"!player.buff(116956).any",
			"!player.buff(93435).any",
			"!player.buff(128997).any",
			"!toggle.buff"
		}, nil },
		{ "20217", { -- Blessing of Kings
			"!player.buff(20217).any",
			"!player.buff(115921).any",
			"!player.buff(1126).any",
			"!player.buff(90363).any",
			"!player.buff(69378).any",
			"toggle.buff"
		}, nil },

	-- Healing
		{ "20473", "lowest.health < 100", "lowest" }, -- Holy Shock	
	
	-- Hands
		{ "1044", "player.state.root", nil } -- Hand of Freedom	
	
},		
------------------------------------------------------------------------------------------------------------
-- Party Toggles
function()
	ProbablyEngine.toggle.create('dispel', 'Interface\\Icons\\Ability_paladin_sacredcleansing.png', 'Dispel Everything', 'Dispels everything it finds \nThis does not effect SoO dispels.')
	ProbablyEngine.toggle.create('buff', 'Interface\\Icons\\spell_magic_greaterblessingofkings.png', 'Buffs', 'Enable for Blessing of Kings. \nDisable for Blessing of Might.')
	ProbablyEngine.toggle.create('aoe', 'Interface\\Icons\\Achievement_bg_killingblow_startingrock.png', 'Manual AOE Healing', 'Manualy control Holy Radiance and Light of Dawn \nEnabling this means you will have to enable "Muli-Target" toggle everytime you want to cast Holy Radiance and/or Light of Dawn.')
end)