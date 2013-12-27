ProbablyEngine.rotation.register_custom(104, "|r[|cff9482C9MTS|r][|cffFF7D0ADruid-Guardian|r]", {

	--Pause if
		{ "pause", "player.form > 1" }, -- Any Player form but bear

	-- If not in form
		{ "!/cast Bear Form", {
			"player.seal = 0",
			"!modifier.lalt"
		}, nil },

	-- keybinds
		{ "77761", "modifier.rshift" }, -- Stampeding Roar
		{ "5211", "modifier.lcontrol" }, -- Mighty Bash
		{ "!/focus [target=mouseover]", "modifier.ralt" }, -- Focus
		
		{{-- Rebirth
			{{ -- Stop if player has Dream of Cenarious
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
			}, "!player.buff(145162)" },
		}, "player.spell(20484).cooldown < .001" },
		
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
				"player.spell(740).cooldown > .006", -- just to detect if tranq been used
				"modifier.lalt"
			}, nil },
		}, "player.spell(108288).exists" },
		
	-- Interrupts
		{ "Skull Bash", "modifier.interrupts" },

	{{ -- Cooldowns
		{ "Berserk" }, -- Berserk
		{ "Nature's Vigil" }, -- Nature's Vigil
		{ "5229" }, -- Enrage
		
		-- Tallents
			{ "106731", { -- Incarnation
				"player.spell(106731).exists",
				"player.spell(106731).cooldown < .001"
			}, nil },
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
			{ "108238", { -- Renewal
				"player.health <= 40",
				"player.spell(108238).exists"
			}, nil }, 
			
	}, "toggle.def" },

	{{-- Dream of Cenarious
		{{ -- if got buff
			-- needs a rebirth here.
			{ "5185", { -- Healing touch /  RAID/PARTY
				"lowest.health < 90",
				"!player.health < 90" -- player instead
			}, "lowest" },
			{ "5185", { -- Healing touch / PLAYER
				"player.health < 90"
			}, "player" },
		}, "player.buff(145162)" },
	}, "player.spell(108373).exists" },

	-- Rotation
		{{-- Single target
			{ "6807", { -- Maul
				"player.buff(135286)", --Tooth and Claw
				"player.rage >= 80"
			}, "target" },
			{ "33878" }, -- Mangle
			{ "77758", "!target.buff" }, -- Thrash
			{ "770", "!target.buff" }, -- Faerie Fire
			{ "33745" }, -- Lacerate
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
		}, "player.spell(108288).exists" },

	--	Buffs
		{ "1126", {-- Mark of the Wild
			"!player.buff",
			"player.form = 0"
		}, nil },

},-----------------------------------------------------------------------------------------------------------
function()
	ProbablyEngine.toggle.create('defcd', 'Interface\\Icons\\Spell_nature_unyeildingstamina.png', 'Defensive Cooldowns', 'Enable or Disable Defensive Cooldowns.')
end)



