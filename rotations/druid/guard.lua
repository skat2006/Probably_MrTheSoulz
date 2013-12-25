ProbablyEngine.rotation.register_custom(104, "|r[|cff9482C9MTS|r][|cffFF7D0ADruid-Guardian|r]", {

	--Pause if
		{ "pause", "player.form = 2" }, -- Swim
		{ "pause", "player.form = 3" }, -- Cat
		{ "pause", "player.form = 4" }, -- Travel

	-- If not in form
		{ "!/cast Bear Form", "player.seal = 0" },

	-- keybinds
		{ "Stampeding Roar", "modifier.rshift" }, -- Stampeding Roar
		{ "Mighty Bash", "modifier.lcontrol" }, -- Mighty Bash
		{ "!/focus [target=mouseover]", "modifier.ralt" }, -- Focus

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
		{ "80964", "modifier.lcontrol" }, -- Mighty Bash
		{ "!/focus [target=mouseover]", "modifier.ralt" }, -- Focus

	--	Buffs
		{ "1126", "!player.buff" }, -- Mark of the Wild

},-----------------------------------------------------------------------------------------------------------
function()
	ProbablyEngine.toggle.create('defcd', 'Interface\\Icons\\Spell_holy_devotionaura.png', 'Defensive Cooldowns', 'Enable or Disable Defensive Cooldowns.')
end)



