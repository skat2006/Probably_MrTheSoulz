ProbablyEngine.rotation.register_custom(65, "|r[|cff9482C9MTS|r][|cffF58CBAHoly-Paladin|r]-[Solo]", {
-- Solo Rotation

	-- KeyBinds
		{ "114158", { -- Light´s Hammer
			"player.spell(114158).exists",
			"modifier.lshift"
		}, "ground"},
		{ "31842" , "modifier.lcontrol" }, -- Divine Favor
		{ "31884" , "modifier.lalt" }, -- Avenging Wrath
		{ "105809" , "modifier.rcontrol" }, -- Holy Avenger
		{ "86669" , "modifier.rshift" }, -- Guardian of Ancient Kings
		{ "!/focus [target=mouseover]", "modifier.ralt" }, -- Mouseover Focus
        
	-- Stuff
        { "20165", "player.seal != 3" }, -- Seal of Insight
        { "1044", "player.state.root"}, -- Hand of Freedom
        { "#5512", "player.health <= 45"}, --Healthstone
        { "54428", "player.mana < 85" }, -- Divine Plea
        { "28730", { -- Arcane torrent
        	"player.mana < 80", 
            "player.spell(28730).exists"
        }, nil },
        { "31821", "@coreHealing.needsHealing < 40, 5" }, -- Devotion Aura
        { "#gloves" }, -- gloves
        { "96231", "modifier.interrupts", "target" }, -- Rebuke        
        { "498", "player.health <= 90", "player" }, --Divine Protection
        { "642", "player.health <= 20", "player" }, -- Divine Shield
	 
	--Sefl Heal
		{ "114163", { -- Eternal Flame
			"player.spell(114163).exists",
			"player.holypower >= 3",
			"!player.buff(114163)",
			"player.health <= 75"
		},	"player" },
		{ "85673", { -- Word of Glory
			"player.holypower >= 3", 
			"player.health < 70"
		}, "player" },
		{ "20925", { -- Sacred Shield
			"player.spell(20925).exists",
			"spell.charges(20925) >= 1",
			"!player.buff", 
			"player.health < 50",
			"!modifier.last"
		}, "player" },
		{ "19750", { -- Flash of light
			"player.health < 70",
			"!player.moving"
		}, "player" },
		
	-- DPS
		{ "2812", { -- Denounce
			"!target.debuff(2812)",
			"target.spell(2812).range",
			"!modifier.last",
			"!player.moving"
		}, "target" },
		{ "35395", "target.spell(35395).range", "target" }, -- Crusader Strike
		{ "20271", "target.spell(20271).range", "target" }, -- Judgment
		{ "20473", "target.spell(20473).range", "target" }, --Holy Shock
		{ "24275", { -- Hammer of Wrath
			"target.health <= 20",
			"target.spell(24275).range"
		}, "target" },
		
},{-------------------------------------------------------------------- Out Of Combat

	-- Keybinds
		{ "114158", { --Light´s Hammer
			"player.spell(114158).exists",
			"modifier.lshift"
		}, "ground"},
		{ "!/focus [target=mouseover]", "modifier.ralt" }, -- Mouseover Focus
		
	-- Healing
		{ "20473", "player.health < 100", "player" }, -- Holy Shock
		{ "635", { -- Holy Light
			"player.health < 100",
			"!player.moving"
		}, "player" },
		
	--Buffs
		{ "19740", { --Blessing of Might
			"!player.buff",
			"!toggle.buff"
		}, nil },
		{ "20217", { --Blessing of Kings
			"!player.buff",
			"toggle.buff"
		}, nil },
		{ "20165", "player.seal != 3" }, -- seal of Insight
},
------------------------------------------------------------------------------------------------------------
-- Solo Toggles
function()
ProbablyEngine.toggle.create('buff', 'Interface\\Icons\\spell_magic_greaterblessingofkings.png', 'Buffs', 'Enable for Blessing of Kings. \nDisable for Blessing of Might.')
end)


------------------------------------------------------------------------------------------------------------
ProbablyEngine.rotation.register_custom(65, "|r[|cff9482C9MTS|r][|cffF58CBAHoly-Paladin|r]-[Party/Raid]", {
-- Party Rotation

	-- KeyBinds
		{ "114158", { -- Light´s Hammer
			"player.spell(114158).exists",
			"modifier.lshift"
		}, "ground"},
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
		{ "4987", { "toggle.dispel", "@paladispell.paladin()" }, nil },

	{{-- Cooldowns
		{ "54428", { -- Divine Plea
			"player.mana < 85",
			"player.spell(28730).cooldown < .001"			
		}, nil },
		{ "114157", { -- Execution Sentence
			"player.spell(114157).exists",
			"lowest.health < 85",
			"!player.moving"
		}, "lowest" },
		{ "#gloves" }, -- gloves
		{ "31821", "@coreHealing.needsHealing < 40, 5" }, -- Devotion Aura
		
		-- Racials
			{ "28730", { -- Arcane torrent
			"player.mana < 80", 
			"player.spell(28730).exists",
			"player.spell(28730).cooldown < .001"
			}, nil },
			
	}, "modifier.cooldowns" },
        
	-- Stuff
        { "20165", "player.seal != 3" }, -- Seal of Insight
        { "1044", "player.state.root"}, -- Hand of Freedom
        { "#5512", "player.health <= 45"}, --Healthstone
        { "96231", "modifier.interrupts", "target" }, -- Rebuke        
        { "498", "player.health <= 90", "player" }, --Divine Protection
        { "642", "player.health <= 20", "player" }, -- Divine Shield
		{ "20165", "player.seal != 3" }, -- Seal of Insight
		
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
	}, "player.spell(85804).exists" },		

	-- Infusion of Light
		{ "20473", "lowest.health < 100", "lowest" }, -- Holy Shock
		{{ -- If got buff
			{ "82326", { -- Divine Light
				"lowest.health < 75",
				"!@coreHealing.needsHealing(90, 4)", -- HR instead
				"!player.moving"
			}, "lowest" },
		}, "player.buff(54149)" },
	
	-- AOE
		{ "85222", { -- Light of Dawn
			"@coreHealing.needsHealing(90, 3)",
			"player.holypower >= 3"
		}, "lowest" },
		
		{{ -- Normal HR
			{{ -- Party
				{ "82327", { -- Holy Radiance - Party
					"@coreHealing.needsHealing(80, 3)",
					"!modifier.last",
					"!player.moving"
				}, "lowest" },
			}, "modifier.party" },
			{{ -- RAID
				{{ -- Stop If 10+
					{ "82327", { -- Holy Radiance - Raid 10
						"@coreHealing.needsHealing(80, 5)",
						"!modifier.last",
						"!player.moving"
					}, "lowest" },
				}, "modifier.raid" },
			}, "!modifier.members > 10" },
			{{ -- Raid 25
				{ "82327", { -- Holy Radiance 10+
					"@coreHealing.needsHealing(80, 8)",
					"!modifier.last",
					"!player.moving"
				}, "lowest" },
			}, "modifier.members > 10" },
		}, "!toggle.hr" },
	
		{{-- Holy Radiance - Forced
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
			"!@coreHealing.needsHealing(90, 3)", -- Use LoD instead.
		}, "lowest"  },
		{ "19750", {-- Flash of light
			"lowest.health < 30",
			"!player.moving",
		}, "lowest" },
		{ "114163", { --Eternal Flame
			"player.spell(114163).exists",
			"!@coreHealing.needsHealing(90, 3)", -- Use LoD instead.
			"player.holypower >= 1",
			"tank.buff(114163)",
			"lowest.health < 75"
		}, "lowest" },
		{ "20925", { -- Sacred Shield
			"player.spell(20925).exists",
			"spell.charges(20925) >= 2",
			"lowest.health < 90",
			"!lowest.buff(148039)",
			"lowest.spell(20925).range",
			"!modifier.last"
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
		{ "114163", { --Eternal Flame
			"player.spell(114163).exists",
			"player.holypower >= 3",
			"!tank.buff(114163)",
			"tank.health < 75"
		}, "tank" },
		{ "20925", { -- Sacred Shield
			"player.spell(20925).exists",
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
			"player.spell(114165).exists",
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
		{ "114158", { --Light´s Hammer
			"player.spell(114158).exists",
			"modifier.lshift"
		}, "ground"},
		{ "!/focus [target=mouseover]", "modifier.ralt" }, -- Mouseover Focus

	-- Tank
		{ "53563", { -- Beacon of light
			"!tank.buff(53563)",
			"tank.spell(53563).range",
		}, "tank" },
		
	-- Healing
		{ "20473", "lowest.health < 100", "lowest" }, -- Holy Shock
		{ "635", { -- Holy Light
			"lowest.health < 97",
			"!lowest.health < 65", -- DL instead
			"!player.moving"
		}, "lowest" },
		{ "82326", { -- Divine Light
			"lowest.health < 65",
			"!lowest.health < 30", -- Flash Light Instead
			"!modifier.last",
			"!player.moving"
		}, "lowest" },
		{ "19750", {-- Flash of light
			"lowest.health < 30",
			"!player.moving",
		}, "lowest" },

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
	ProbablyEngine.toggle.create('dispel', 'Interface\\Icons\\Ability_paladin_sacredcleansing.png', 'Dispel Everything', 'Dispels everything it finds.')
	ProbablyEngine.toggle.create('buff', 'Interface\\Icons\\spell_magic_greaterblessingofkings.png', 'Buffs', 'Enable for Blessing of Kings. \nDisable for Blessing of Might.')
	ProbablyEngine.toggle.create('hr', 'Interface\\Icons\\Achievement_bg_killingblow_startingrock.png', 'Manual Holy Radiance', 'Manualy control Holy Radiance. \nEnabling this means you will have to enable "Muli-Target" toggle everytime you want to cast Holy Radiance.')
end)