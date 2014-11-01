-- //////////////////////-----------------------------------------INFO-----------------------------------//////////////////////////////
--													   	//Paladin Protection//
--													Thank Your For Your My ProFiles
--														I Hope Your Enjoy Them
--																  MTS
local lib = function()

	ProbablyEngine.toggle.create('autotarget', 'Interface\\Icons\\Ability_spy.png', 'Auto Target', 'Automatically target the nearest enemy when target dies or does not exist')
	ProbablyEngine.toggle.create('defcd', 'Interface\\Icons\\Spell_holy_devotionaura.png', 'Defensive Cooldowns', 'Enable or Disable Defensive Cooldowns.')
	ProbablyEngine.toggle.create('buff', 'Interface\\Icons\\Spell_magic_greaterblessingofkings.png', 'Buffs', 'Enable for Blessing of Kings. \nDisable for Blessing of Might.')
	ProbablyEngine.toggle.create('run', 'Interface\\Icons\\Inv_boots_plate_dungeonplate_c_05.png', 'Enable Unholy Presence Outside of Combat', 'Enable/Disable Unholy Presence Outside of Combat \nMakes you run/fly faster when outside of combat.')
	mtsStart:message("\124cff9482C9*MTS-\124cffF58CBAPaladin/Protection-\124cff9482C9Loaded*")
	mts_showLive()
	
end


local Shared = {

	-- Buffs
		{ "19740", { "!player.buff(19740).any", "!player.buff(116956).any", "!player.buff(93435).any", "!player.buff(128997).any", "!toggle.buff" }}, -- Blessing of Might
		{ "20217", { "!player.buff(20217).any", "!player.buff(115921).any", "!player.buff(1126).any", "!player.buff(90363).any", "!player.buff(69378).any", "toggle.buff" }}, -- Blessing of Kings
		{ "25780", "!player.buff(25780).any" }, -- Fury

	-- Seals
		{ "20165", "player.seal != 3", nil }, -- seal of Insigh
		
}

local inCombat = {
	
	-- run fast
		{ "85499", {"player.moving", "toggle.run"} }, -- Speed of Light

	-- keybinds
		{ "105593", "modifier.control", "target" }, -- Fist of Justice
		{ "853", "modifier.control", "target" }, -- Hammer of Justice
		{ "114158", "modifier.shift", "target.ground" }, -- Light´s Hammer

	--[[ Items
		{ "#5512" }, --Healthstone
		{ "#76097", "player.health < 30", "@mtsLib.checkItem(HealthPot)" }, -- Master Health Potion
		{ "/use Kafa Press", { "modifier.cooldowns","@mtsLib.checkItem('Kafa Press')" }}, -- Kafa Press]]
	
	-- Auto Target
		{ "/target [target=focustarget, harm, nodead]", "target.range > 40" },
		{ "/targetenemy [noexists]", { "toggle.autotarget", "!target.exists" }},
   		{ "/targetenemy [dead]", { "toggle.autotarget", "target.exists", "target.dead" }},

	-- Hands
		{ "6940", { "lowest.health <= 80", "!player.health <= 40" }, "lowest" }, -- Hand of Sacrifice
		{ "1044", "player.state.root" }, -- Hand of Freedom
		
	-- Interrupt
		{ "96231", "modifier.interrupts", "target" }, -- Rebuke

	-- Defensive Cooldowns
		{ "20925", {"!player.buff(20925)", "toggle.defcd"}, "player" }, -- Sacred Shield 		
		{ "31850", {"player.health < 30", "toggle.defcd"} }, --Ardent Defender
		{ "498", {"player.health <= 99", "toggle.defcd"} }, -- Divine Protection
		{ "86659", {"player.health <= 50", "toggle.defcd"} }, -- Guardian of Ancient Kings
		{ "#gloves", "toggle.defcd" },
	
	-- Cooldowns
		{ "31884", "modifier.cooldowns" }, -- Avenging Wrath
		{ "105809", "modifier.cooldowns" }, --Holy Avenger
		{ "114158", {"modifier.cooldowns", "target.range <= 30"}, "target.ground" }, -- Light´s Hammer
		
	-- Self Heal
		{ "#5512", "player.health <= 60" }, --Healthstone
		{ "633", "player.health <= 20", "player"}, -- Lay on Hands
		{ "114163", { "!player.buff(114163)", "player.buff(114637).count = 5", "player.holypower >= 3", "player.health <= 85" }, "player"}, -- Eternal Flame
		{ "85673", { "player.buff(114637).count = 5", "player.holypower >= 3", "player.health <= 40" }, "player" },-- Word of Glory

	-- AOE Rotation
		{ "31935", { "modifier.multitarget", "player.buff(Grand Crusader)" }, "target" }, -- Avenger's Shield
		{ "53595", { "target.spell(Crusader Strike).range", "modifier.multitarget" } }, -- Hammer of the Righteous
		{ "20271", "modifier.multitarget" }, -- Judgment
		{ "119072", { "modifier.multitarget", "target.spell(Crusader Strike).range", "talent(5, 2)", "!toggle.smartAOE" } }, -- Holy Wrath
		{ "114165", { "modifier.multitarget", "target.spell(Crusader Strike).range", "talent(5, 1)" }, "player" }, -- Holy Prism
		{ "31935", "modifier.multitarget" }, -- Avenger's Shield
		{ "26573", { "modifier.multitarget", "target.spell(Crusader Strike).range", "!player.moving" }, "target.ground" }, -- Consecration
		{ "119072", { "modifier.multitarget", "target.range <= 10"  } }, -- Holy Wrath

	-- Single Rotation
		{ "53600", {"target.spell(53600).range", "player.holypower > 3"}, "target" }, -- Shield of Righteous
		{ "35395", "target.spell(35395).range", "target" }, -- Crusader Strike
		{ "20271", "target.spell(20271).range", "target" }, -- Judgment
		{ "26573", "target.range <= 6", "target.ground" }, -- consecration
		{ "119072", {"target.range <= 10", "talent(5, 2)" } }, -- Holy Wrath
		{ "31935", "target.spell(31935).range", "target" }, -- Avenger´s Shield
		{ "114165", { "target.spell(114165).range", "talent(5, 1)" } }, -- Holy Prism
		{ "114157", "target.spell(114157).range", "target" }, -- Execution Sentence
		{ "24275", "target.health <= 20", "target" }, -- Hammer of Wrath
		{ "119072", "target.range <= 10" }, -- Holy Wrath
  
}

local outCombat = {
	
	-- keybinds
		{ "105593", "modifier.control", "target" }, -- Fist of Justice
		{ "853", "modifier.control", "target" }, -- Hammer of Justice
		{ "114158", "modifier.shift", "target.ground" }, -- Light´s Hammer

	-- Hands
		{ "1044", "player.state.root" }, -- Hand of Freedom

	-- run fast
		{ "85499", {"player.moving", "toggle.run"} }, -- Speed of Light

}

for _, Shared in pairs(Shared) do
  inCombat[#inCombat + 1] = Shared
  outCombat[#outCombat + 1] = Shared
end

ProbablyEngine.rotation.register_custom(66, "|r[|cff9482C9MTS|r][|cffF58CBAPaladin-Protection|r]", inCombat, outCombat, lib)