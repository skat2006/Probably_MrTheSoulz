--[[ ///---INFO---////
// Druid Guard //
Thank You For Using My ProFiles
I Hope Your Enjoy Them
MTS
]]

local exeOnLoad = function()

	ProbablyEngine.toggle.create('autotarget', 'Interface\\Icons\\Ability_spy.png', 'Auto Target', 'Automatically target the nearest enemy when target dies or does not exist')
	mtsStart:message("\124cff9482C9*MrTheSoulz - \124cffFF7D0ADruid/Guardian \124cff9482C9Loaded*")

end

local Shared = {

	--	Buffs
		{ "1126", { -- Mark of the Wild
			"!player.buff(20217).any",
			"!player.buff(115921).any",
			"!player.buff(1126).any",
			"!player.buff(90363).any",
			"!player.buff(69378).any",
			--"@mtsLib.getConfig('DoodGuardBuffs')",
			"player.form = 0" 
		}, nil },
  
}

local inCombat = {

	--Racials
        -- Dwarves
			{ "20594", "player.health <= 65" },
		-- Humans
			{ "59752", "player.state.charm" },
			{ "59752", "player.state.fear" },
			{ "59752", "player.state.incapacitate" },
			{ "59752", "player.state.sleep" },
			{ "59752", "player.state.stun" },
		-- Draenei
			{ "28880", "player.health <= 70", "player" },
		-- Gnomes
			{ "20589", "player.state.root" },
			{ "20589", "player.state.snare" },
		-- Forsaken
			{ "7744", "player.state.fear" },
			{ "7744", "player.state.charm" },
			{ "7744", "player.state.sleep" },
		-- Goblins
			{ "69041", "player.moving" },

	--	keybinds
		{ "77761", "modifier.rshift" }, -- Stampeding Roar
		{ "5211", "modifier.lcontrol" }, -- Mighty Bash
		{ "!/focus [target=mouseover]", "modifier.ralt" }, -- Focus
		-- Rebirth
			{ "!/cancelform", { "player.form > 0", "player.spell(20484).cooldown < .001", "modifier.lshift" }, nil }, -- remove bear form
			{ "20484", { "modifier.lshift", "!target.alive" }, "target" }, -- Rebirth
			{ "!/cast Bear Form", { "!player.casting", "!player.form = 1", "modifier.last(20484)", "modifier.lshift" }, nil }, -- bear form
		{{-- HotW + Tranq
			{ "108288", { "modifier.lalt", "player.spell(108288).cooldown < .001", "player.spell(740).cooldown < .001" }, nil }, -- Hearth of the Wild
			{ "!/cancelform", { "player.form > 0", "player.spell(740).cooldown < .001", "modifier.lalt" }, nil }, -- remove bear form
			{ "740", { "modifier.lalt", "player.spell(740).cooldown < .001" }, nil }, -- Tranq
			{ "!/cast Bear Form", { "!player.casting", "!player.form = 1", "modifier.lalt" }, nil }, -- bear form
		}, "talent(16)" },

	--Pause if
		{ "pause", "player.form > 1" }, -- Any Player form but bear

	-- If not in form
		{ "/cast Bear Form", { "player.form != 1", "!modifier.lalt" }},

	-- Auto Target
		{ "/targetenemy [noexists]", { "toggle.autotarget", "!target.exists" }},
   		{ "/targetenemy [dead]", { "toggle.autotarget", "target.exists", "target.dead" }},

	{{-- Interrupts
		{ "80964" }, -- skull bash
		{ "132469" }, -- typhoon
	}, "target.interruptsAt(50)" },
	
	{{-- Aggro Control
		{ "62124", "@mtsBossLib.bossTaunt", "target" }, -- Boss // Reckoning
		{ "6795", { "mouseover.threat < 100", "@mtsLib.StopIfBoss" }, "mouseover" }, -- Growl / Mouse-Over
		{ "6795", { "target.threat < 100", "@mtsLib.StopIfBoss" }, "target" }, -- Growl
	},{ "@mtsLib.dummy()", "@mtsLib.ShouldTaunt('DoodGuardTaunts')" }},
	
	-- Items
		--{ "#5512", "@mtsLib.ConfigUnitHp('DoodGuardHs', 'player')" }, --Healthstone
		--{ "#76097", { "@mtsLib.getConfig('DoodGuardItems')", "player.health < 30", "@mtsLib.HealthPot" }}, -- Master Health Potion
		--{ "#86125", { "@mtsLib.getConfig('DoodGuardItems')","@mtsLib.KafaPress" }}, -- Kafa Press
	
	-- Cooldowns
		{ "50334", "modifier.cooldowns" }, -- Berserk
		{ "124974", "modifier.cooldowns" }, -- Nature's Vigil
		{ "5229", "modifier.cooldowns" }, -- Enrage
		{ "106731", "modifier.cooldowns" }, -- Incarnation
 
	--Defensive
		--{ "62606", { "!player.buff", "player.health <= 95", "@mtsLib.getConfig('DoodGuardDefCd')" }, nil }, -- Savage Defense
		--{ "22842", { "!player.buff", "player.health <= 70", "player.rage >= 20", "@mtsLib.getConfig('DoodGuardDefCd')" }, nil }, -- Frenzied Regeneration
		--{ "22812", { "player.health <= 70", "@mtsLib.getConfig('DoodGuardDefCd')" }, nil }, -- Barkskin
		--{ "102351", { "player.health <= 60", "@mtsLib.getConfig('DoodGuardDefCd')" }, "player" }, -- Cenarion Ward
		--{ "61336", { "player.health <= 40", "@mtsLib.getConfig('DoodGuardDefCd')" }, nil }, -- Survival Instincts
		--{ "106922", { "player.health < 30", "@mtsLib.getConfig('DoodGuardDefCd')" }, nil }, -- Might of Ursoc
		--{ "108238", { "player.health <= 40", "@mtsLib.getConfig('DoodGuardDefCd')" }, nil }, -- Renewal		

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
			{ "770", "!target.debuff(770)" }, -- Faerie Fire
			{ "33745" }, -- Lacerate
		}, "!modifier.multitarget" },
  
}

local outCombat = {

	--	keybinds
		{ "77761", "modifier.rshift" }, -- Stampeding Roar
		{ "5211", "modifier.lcontrol" }, -- Mighty Bash
		{ "!/focus [target=mouseover]", "modifier.ralt" }, -- Focus
		-- Rebirth
			{ "!/cancelform", { "player.form > 0", "player.spell(20484).cooldown < .001", "modifier.lshift" }, nil }, -- remove bear form
			{ "20484", { "modifier.lshift", "!target.alive" }, "target" }, -- Rebirth
			{ "!/cast Bear Form", { "!player.casting", "!player.form = 1", "modifier.last(20484)", "modifier.lshift" }, nil }, -- bear form
		{{-- HotW + Tranq
			{ "108288", { "modifier.lalt", "player.spell(108288).cooldown < .001", "player.spell(740).cooldown < .001" }, nil }, -- Hearth of the Wild
			{ "!/cancelform", { "player.form > 0", "player.spell(740).cooldown < .001", "modifier.lalt" }, nil }, -- remove bear form
			{ "740", { "modifier.lalt", "player.spell(740).cooldown < .001" }, nil }, -- Tranq
			{ "!/cast Bear Form", { "!player.casting", "!player.form = 1", "modifier.lalt" }, nil }, -- bear form
		}, "talent(16)" },

}

for _, Shared in pairs(Shared) do
  inCombat[#inCombat + 1] = Shared
  outCombat[#outCombat + 1] = Shared
end

ProbablyEngine.rotation.register_custom(104, "|r[|cff9482C9MTS|r][|cffFF7D0ADruid-Guardian|r]", inCombat, outCombat, exeOnLoad)


