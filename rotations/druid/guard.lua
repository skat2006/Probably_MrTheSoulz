ProbablyEngine.rotation.register_custom(104, "|r[|cff9482C9MTS|r][|cffFF7D0ADruid-Guardian|r]", {

	--Pause if
		{ "pause", "player.form > 1" }, -- Any Player form but bear

	-- If not in form
		{ "!/cast Bear Form", { "player.seal = 0", "!modifier.lalt" }, nil },

	--	keybinds
		{ "77761", "modifier.rshift" }, -- Stampeding Roar
		{ "5211", "modifier.lcontrol" }, -- Mighty Bash
		{ "!/focus [target=mouseover]", "modifier.ralt" }, -- Focus
		-- Rebirth
			{ "!/cancelform", { "player.form > 0", "modifier.lshift" }, nil }, -- remove bear form
			{ "20484", "modifier.lshift", "mouseover" }, -- Rebirth
			{ "!/cast Bear Form", { "!player.casting", "!player.form = 1", "modifier.lshift" }, nil }, -- bear form
			{{-- HotW + Tranq
				{ "108288", { "modifier.lalt", "player.spell(108288).cooldown < .001", "player.spell(740).cooldown < .001" }, nil }, -- Hearth of the Wild
				{ "!/cancelform", { "player.form > 0", "player.spell(740).cooldown < .001", "modifier.lalt" }, nil }, -- remove bear form
				{ "740", { "modifier.lalt", "player.spell(740).cooldown < .001" }, nil }, -- Tranq
				{ "!/cast Bear Form", { "!player.casting", "!player.form = 1", "modifier.lalt" }, nil }, -- bear form
			}, "talent(16)" },
	
	--	Buffs
		{ "1126", { "!player.buff(20217).any", "!player.buff(115921).any", "!player.buff(1126).any", "!player.buff(90363).any", "!player.buff(69378).any", "player.form = 0" }, nil }, -- Mark of the Wild
	
	-- Interrupts
		{ "80964", "modifier.interrupts)" }, -- skull bash
		{ "132469", "modifier.interrupts)"}, -- typhoon
	
	{{-- Aggro Control
		{ "6795", { "mouseover.threat < 100" }, "mouseover" }, -- Growl / Mouse-Over
		{ "6795", { "target.threat < 100" }, "target" }, -- Growl
	}, "toggle.aggro" },
	
	{{ -- Cooldowns
		{ "50334" }, -- Berserk
		{ "124974" }, -- Nature's Vigil
		{ "5229" }, -- Enrage
		{ "106731", "player.spell(106731).cooldown < .001" }, -- Incarnation
	}, "modifier.cooldowns" },
 
	{{--Defensive
		{ "62606", { "!player.buff", "player.health <= 95" }, nil }, -- Savage Defense
		{ "22842", { "!player.buff", "player.health <= 70", "player.rage >= 20" }, nil }, -- Frenzied Regeneration
		{ "22812", "player.health <= 70" }, -- Barkskin
		{ "102351", "player.health <= 60", "player" }, -- Cenarion Ward
		{ "61336", "player.health <= 40" }, -- Survival Instincts
		{ "106922", "player.health < 30" }, -- Might of Ursoc
		{ "108238", "player.health <= 40" }, -- Renewal		
	}, "toggle.defcd" },

	-- Dream of Cenarious
		-- Needs a Rebirth here
		{ "5185", { "lowest.health < 90", "!player.health < 90", "player.buff(145162)" }, "lowest" }, -- Healing touch /  RAID/PARTY
		{ "5185", { "player.health < 90", "player.buff(145162)" }, "player" }, -- Healing touch / PLAYER

	-- Rotation
		{ "6807", { "player.buff(135286)", "target.spell(6807).range" }, "target" }, -- Maul / proc
	
		{{-- AOE
			{ "77758", "!target.buff(77758)" }, -- Thrash
			{ "33878" }, -- Mangle
			{ "779" }, -- Swipe
		}, "modifier.multitarget" },
		
		{{-- Single
			{ "6807", "player.rage >= 80" }, -- Maul
			{ "33878" }, -- Mangle
			{ "77758", "!target.buff(77758)" }, -- Thrash
			{ "770", "!target.buff(113746)" }, -- Faerie Fire
			{ "33745" }, -- Lacerate
		}, "!modifier.multitarget" },

},{-------------------------------- out of combat

	--	keybinds
		{ "77761", "modifier.rshift" }, -- Stampeding Roar
		{ "5211", "modifier.lcontrol" }, -- Mighty Bash
		{ "!/focus [target=mouseover]", "modifier.ralt" }, -- Focus
		-- Rebirth
			{ "!/cancelform", { "player.form > 0", "modifier.lshift" }, nil }, -- remove bear form
			{ "20484", "modifier.lshift", "mouseover" }, -- Rebirth
			{ "!/cast Bear Form", { "!player.casting", "!player.form = 1", "modifier.lshift" }, nil }, -- bear form
			{{-- HotW + Tranq
				{ "108288", { "modifier.lalt", "player.spell(108288).cooldown < .001", "player.spell(740).cooldown < .001" }, nil }, -- Hearth of the Wild
				{ "!/cancelform", { "player.form > 0", "player.spell(740).cooldown < .001", "modifier.lalt" }, nil }, -- remove bear form
				{ "740", { "modifier.lalt", "player.spell(740).cooldown < .001" }, nil }, -- Tranq
				{ "!/cast Bear Form", { "!player.casting", "!player.form = 1", "modifier.lalt" }, nil }, -- bear form
			}, "talent(16)" },

	--	Buffs
		{ "1126", { "!player.buff(20217).any", "!player.buff(115921).any", "!player.buff(1126).any", "!player.buff(90363).any", "!player.buff(69378).any", "player.form = 0" }, nil }, -- Mark of the Wild

},-----------------------------------------------------------------------------------------------------------
function()
	ProbablyEngine.toggle.create('defcd', 'Interface\\Icons\\Ability_racial_bearform.png', 'Defensive Cooldowns', 'Enable or Disable Defensive Cooldowns.')
	ProbablyEngine.toggle.create('aggro', 'Interface\\Icons\\Ability_warrior_stalwartprotector.png', 'Aggro Control', 'Auto Taunts on mouse-over ot target if dosent have aggro.')
end)



