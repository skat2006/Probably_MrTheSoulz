ProbablyEngine.rotation.register_custom(104, "|r[|cff9482C9MTS|r][|cffFF7D0ADruid-Guardian|r]", {

	--Pause if
		{ "pause", "player.form > 1" }, -- Any Player form but bear

	-- If not in form
		{ "!/cast Bear Form", {
			"player.seal = 0",
			"!modifier.lalt"
		}, nil },

	--	keybinds
		{ "77761", "modifier.rshift" }, -- Stampeding Roar
		{ "5211", "modifier.lcontrol" }, -- Mighty Bash
		{ "!/focus [target=mouseover]", "modifier.ralt" }, -- Focus
		-- Rebirth
			{ "!/cancelform", { -- remove bear form
				"player.form > 0",
				"modifier.lshift"
			}, nil },
			{ "20484", "modifier.lshift", "mouseover" }, -- Rebirth
			{ "!/cast Bear Form", { -- bear form
				"!player.casting",
				"!player.form = 1",
				"modifier.lshift"
			}, nil },
			{{-- HotW + Tranq
				{ "108288", { -- Hearth of the Wild
					"modifier.lalt",
					"player.spell(108288).cooldown < .001",
					"player.spell(740).cooldown < .001"
				}, nil },
				{ "!/cancelform", { -- remove bear form
					"player.form > 0",
					"player.spell(740).cooldown < .001",
					"modifier.lalt"
				}, nil },
				{ "740", { -- Tranq
					"modifier.lalt",
					"player.spell(740).cooldown < .001"
				}, nil },
				{ "!/cast Bear Form", { -- bear form
					"!player.casting",
					"!player.form = 1",
					"modifier.lalt"
				}, nil },
			}, "talent(16)" },

	--	Buffs
		{ "1126", { -- Mark of the Wild
			"!player.buff(20217).any",
			"!player.buff(115921).any",
			"!player.buff(1126).any",
			"!player.buff(90363).any",
			"!player.buff(69378).any",
			"player.form = 0"
		}, nil },
	
	--	Buffs
		{ "1126", { -- Mark of the Wild
			"!player.buff(20217).any",
			"!player.buff(115921).any",
			"!player.buff(1126).any",
			"!player.buff(90363).any",
			"!player.buff(69378).any",
			"player.form = 0"
		}, nil },
	
	-- Interrupts
		{ "Skull Bash", "modifier.interruptAt(50)" },

	{{ -- Cooldowns
		{ "Berserk" }, -- Berserk
		{ "Nature's Vigil" }, -- Nature's Vigil
		{ "5229" }, -- Enrage
		
		-- Tallents
			{ "106731", "player.spell(106731).cooldown < .001" }, -- Incarnation
	}, "modifier.cooldowns" },
 
	{{--Defensive
		{ "62606", {  --Savage Defense
			"!player.buff",
			"player.health <= 95"
		}, nil },
		{ "22842", { --Frenzied Regeneration
			"!player.buff",
			"player.health <= 70",
			"player.rage >= 20"
		}, nil },
		{ "22812", "player.health <= 70" }, -- Barkskin
		{ "Cenarion Ward" , "player.health <= 60", "player" }, -- Cenarion Ward
		{ "61336", "player.health <= 40" }, -- Survival Instincts
		{ "Might of Ursoc", "player.health < 30" }, -- Might of Ursoc
		
		-- Talents
			{ "108238", "player.health <= 40" }, -- Renewal
			
	}, "toggle.def" },

	{{-- Dream of Cenarious
		{{ -- if got buff
			{ "20484", "lowest.dead" }, -- Rebirth
			{ "5185", { -- Healing touch /  RAID/PARTY
				"lowest.health < 90",
				"!player.health < 90" -- player instead
			}, "lowest" },
			{ "5185", { -- Healing touch / PLAYER
				"player.health < 90"
			}, "player" },
		}, "player.buff(145162)" },
	}, "talent(17)" },

	-- Rotation
		{{-- Single target
			{ "6807", { -- Maul
				"player.buff(135286)", --Tooth and Claw
				"player.rage >= 80"
			}, "target" },
			{ "33878", "target" }, -- Mangle
			{ "77758", "!target.buff(77758)", "target" }, -- Thrash
			{ "770", "!target.buff(113746)", "target" }, -- Faerie Fire
			{ "33745", "target" }, -- Lacerate
		}, "!modifier.multitarget" },
		
		{{-- Multi Target
			{ "77758", "!target.buff" }, -- Thrash
			{ "33878" }, -- Mangle
			{ "779" }, -- Swipe
		}, "modifier.multitarget" }, 

},{-------------------------------- out of combat

	--	keybinds
		{ "77761", "modifier.rshift" }, -- Stampeding Roar
		{ "5211", "modifier.lcontrol" }, -- Mighty Bash
		{ "!/focus [target=mouseover]", "modifier.ralt" }, -- Focus
		-- Rebirth
			{ "!/cancelform", { -- remove bear form
				"player.form > 0",
				"modifier.lshift"
			}, nil },
			{ "20484", "modifier.lshift", "mouseover" }, -- Rebirth
			{ "!/cast Bear Form", { -- bear form
				"!player.casting",
				"!player.form = 1",
				"modifier.lshift"
			}, nil },
			{{-- HotW + Tranq
				{ "108288", { -- Hearth of the Wild
					"modifier.lalt",
					"player.spell(108288).cooldown < .001",
					"player.spell(740).cooldown < .001"
				}, nil },
				{ "!/cancelform", { -- remove bear form
					"player.form > 0",
					"player.spell(740).cooldown < .001",
					"modifier.lalt"
				}, nil },
				{ "740", { -- Tranq
					"modifier.lalt",
					"player.spell(740).cooldown < .001"
				}, nil },
				{ "!/cast Bear Form", { -- bear form
					"!player.casting",
					"!player.form = 1",
					"modifier.lalt"
				}, nil },
			}, "talent(16)" },

	--	Buffs
		{ "1126", { -- Mark of the Wild
			"!player.buff(20217).any",
			"!player.buff(115921).any",
			"!player.buff(1126).any",
			"!player.buff(90363).any",
			"!player.buff(69378).any",
			"player.form = 0"
		}, nil },

},-----------------------------------------------------------------------------------------------------------
function()
	ProbablyEngine.toggle.create('defcd', 'Interface\\Icons\\Spell_nature_unyeildingstamina.png', 'Defensive Cooldowns', 'Enable or Disable Defensive Cooldowns.')
end)



