ProbablyEngine.rotation.register_custom(65, "|r[|cff9482C9MTS|r][|cffF58CBAHoly-Paladin|r]", {
-- Party Rotation

	-- KeyBinds
		{ "114158", "modifier.lshift", "ground"}, -- Light´s Hammer
		{ "31842" , "modifier.lcontrol" }, -- Divine Favor
		{ "31884" , "modifier.lalt" }, -- Avenging Wrath
		{ "105809" , "modifier.rcontrol" }, -- Holy Avenger
		{ "86669" , "modifier.rshift" }, -- Guardian of Ancient Kings
		{ "!/focus [target=mouseover]", "modifier.ralt" }, -- Mouseover Focus

	--Dispel
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

	-- Interrumpt
		{ "96231", "modifier.interruptAt(50)", "target" }, -- Rebuke

	-- Mana Regen
		{ "54428", "player.mana < 85" }, -- Divine Plea
		-- Racials
			{ "28730", "player.mana < 80" },-- Arcane torrent
			
	{{-- Cooldowns
		{ "114157", { -- Execution Sentence
			"lowest.health < 85",
			"!player.moving"
		}, "lowest" },
		{ "#gloves" }, -- gloves
		{ "31821", "@coreHealing.needsHealing < 40, 5" }, -- Devotion Aura	
	}, "modifier.cooldowns" },
        
	-- Stuff
        { "20165", "player.seal != 3" }, -- Seal of Insight
        { "1044", "player.state.root"}, -- Hand of Freedom
        { "#5512", "player.health <= 45"}, --Healthstone       
        { "498", "player.health <= 90", "player" }, --Divine Protection
        { "642", "player.health <= 20", "player" }, -- Divine Shield
		{ "20165", "player.seal != 3" }, -- Seal of Insight
	
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
				"!@coreHealing.needsHealing(90, 4)", -- HR instead
				"!player.moving",
			}, "lowest" },
			{ "82326", { -- Divine Light
				"lowest.health < 65",
				"!@coreHealing.needsHealing(90, 4)", -- HR instead
				"!player.moving"
			}, "lowest" },
			{ "82327", { -- Holy Radiance
				"@coreHealing.needsHealing(90, 4)",
				"!player.moving"
			}, "lowest" },
		}, "player.buff(114250)" }
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
			}, nil },
		}, "toggle.hr" },
	
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
		{ "6940", { -- Hand of Sacrifice
			"tank.spell(6940).range", 
			"tank.health <= 40"
		}, "tank" },
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
			"lowest.health < 65",
			"!player.moving"
		}, "lowest" },
		
},{------------------------------------------------------------------------ Out Of Combat

	-- Keybinds
		{ "114158", "modifier.lshift", "ground"}, -- Light´s Hammer
		{ "31842" , "modifier.lcontrol" }, -- Divine Favor
		{ "31884" , "modifier.lalt" }, -- Avenging Wrath
		{ "105809" , "modifier.rcontrol" }, -- Holy Avenger
		{ "86669" , "modifier.rshift" }, -- Guardian of Ancient Kings
		{ "!/focus [target=mouseover]", "modifier.ralt" }, -- Mouseover Focus

	-- Tank
		{ "53563", { -- Beacon of light
			"!tank.buff(53563)",
			"tank.spell(53563).range",
		}, "tank" },
		
	-- Healing
		{ "20473", "lowest.health < 100", "lowest" }, -- Holy Shock

	--Buffs
		{ "19740", { --Blessing of Might
			"!player.buff",
			"!toggle.buff"
		}, nil },
		{ "20217", { --Blessing of Kings
			"!player.buff",
			"toggle.buff"
		}, nil },
},		
------------------------------------------------------------------------------------------------------------
-- Party Toggles
function()
	ProbablyEngine.toggle.create('dispel', 'Interface\\Icons\\Ability_paladin_sacredcleansing.png', 'Dispel Everything', 'Dispels everything it finds \nThis does not effect SoO dispels.')
	ProbablyEngine.toggle.create('buff', 'Interface\\Icons\\spell_magic_greaterblessingofkings.png', 'Buffs', 'Enable for Blessing of Kings. \nDisable for Blessing of Might.')
	ProbablyEngine.toggle.create('aoe', 'Interface\\Icons\\Achievement_bg_killingblow_startingrock.png', 'Manual AOE Healing', 'Manualy control Holy Radiance and Light of Dawn \nEnabling this means you will have to enable "Muli-Target" toggle everytime you want to cast Holy Radiance and/or Light of Dawn.')
end)