-- ///////////////////-----------------------------------------INFO-----------------------------------//////////////////////////////
--														//Druid- Guardian//
--												Thank Your For Your My ProFiles
--													I Hope Your Enjoy Them
--																MTS


local lib = function()

-- ///////////////////////-----------------------------------------TOGGLES-----------------------------------//////////////////////////////

	mtsAlert:message("\124cff9482C9*MrTheSoulz - \124cffFF7D0ADruid/Guardian \124cff9482C9Loaded*")

end
-- /////////////////////////-----------------------------------------END LIB-----------------------------------//////////////////////////////

local Buffs = {

	--	Buffs
		{ "1126", { -- Mark of the Wild
			"!player.buff(20217).any",
			"!player.buff(115921).any",
			"!player.buff(1126).any",
			"!player.buff(90363).any",
			"!player.buff(69378).any",
			"@mts.getConfig('DoodGuardBuffs')",
			"player.form = 0" 
		}, nil },
  
}
-- ////////////////////////-----------------------------------------END BUFFS-----------------------------------//////////////////////////////

local inCombat = {
  
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
		{ "!/cast Bear Form", { "player.seal = 0", "!modifier.lalt" }, nil },
	
	--	Buffs
		{ "1126", { "!player.buff(20217).any", "!player.buff(115921).any", "!player.buff(1126).any", "!player.buff(90363).any", "!player.buff(69378).any", "player.form = 0" }, nil }, -- Mark of the Wild
	
	{{-- Interrupts
		{ "80964" }, -- skull bash
		{ "132469" }, -- typhoon
	}, "target.interruptsAt(50)" },
	
	-- Aggro Control
		{ "62124", { "@mts.ShouldTaunt('DoodGuardTaunts')", "@mts.bossTaunt" }, "target" }, -- Boss // Reckoning
		{ "6795", { "mouseover.threat < 100", "@mts.ShouldTaunt('DoodGuardTaunts')" }, "mouseover" }, -- Growl / Mouse-Over
		{ "6795", { "target.threat < 100", "@mts.ShouldTaunt('DoodGuardTaunts')" }, "target" }, -- Growl
	
	-- Items
		{ "#5512", "@mts.ConfigUnitHp('DoodGuardHs', 'player')" }, --Healthstone
		{ "#76097", { "@mts.getConfig('DoodGuardItems')", "player.health < 30", "@mts.HealthPot" }}, -- Master Health Potion
		--{ "#86125", { "@mts.getConfig('DoodGuardItems')","@mts.KafaPress" }}, -- Kafa Press
	
	-- Cooldowns
		{ "50334", "modifier.cooldowns" }, -- Berserk
		{ "124974", "modifier.cooldowns" }, -- Nature's Vigil
		{ "5229", "modifier.cooldowns" }, -- Enrage
		{ "106731", "modifier.cooldowns" }, -- Incarnation
 
	--Defensive
		{ "62606", { "!player.buff", "player.health <= 95", "@mts.getConfig('DoodGuardDefCd')" }, nil }, -- Savage Defense
		{ "22842", { "!player.buff", "player.health <= 70", "player.rage >= 20", "@mts.getConfig('DoodGuardDefCd')" }, nil }, -- Frenzied Regeneration
		{ "22812", { "player.health <= 70", "@mts.getConfig('DoodGuardDefCd')" }, nil }, -- Barkskin
		{ "102351", { "player.health <= 60", "@mts.getConfig('DoodGuardDefCd')" }, "player" }, -- Cenarion Ward
		{ "61336", { "player.health <= 40", "@mts.getConfig('DoodGuardDefCd')" }, nil }, -- Survival Instincts
		{ "106922", { "player.health < 30", "@mts.getConfig('DoodGuardDefCd')" }, nil }, -- Might of Ursoc
		{ "108238", { "player.health <= 40", "@mts.getConfig('DoodGuardDefCd')" }, nil }, -- Renewal		

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
  
}
-- /////////////////////-----------------------------------------END IN-COMBAT-----------------------------------//////////////////////////////

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
-- //////////////////////-----------------------------------------END OUT-OF-COMBAT-----------------------------------//////////////////////////////

for _, Buffs in pairs(Buffs) do
  inCombat[#inCombat + 1] = Buffs
  outCombat[#outCombat + 1] = Buffs
end

ProbablyEngine.rotation.register_custom(104, "|r[|cff9482C9MTS|r][|cffFF7D0ADruid-Guardian|r]", inCombat, outCombat, lib)


