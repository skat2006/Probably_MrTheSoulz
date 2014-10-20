--[[ ///---INFO---////
// Monk WindWalker //
!Originaly made by Tao!
Thank You For Using My ProFiles
I Hope Your Enjoy Them
MTS
]]

local exeOnLoad = function()

	mtsStart:message("\124cff9482C9*MrTheSoulz - \124cffC41F3BDeathKnight/Blood \124cff9482C9Loaded*")

end

local buffs = {

  { "Legacy of the White Tiger", {
    "!player.buff(Legacy of the White Tiger).any",
    "!player.buff(Leader of the Pack).any",
    "!player.buff(Arcane Brilliance).any",
    "!player.buff(Dalaran Brilliance).any",
    "!player.buff(Bellowing Roar).any",
    "!player.buff(Furious Howl).any",
    "!player.buff(Terrifying Roar).any",
    "!player.buff(Fearless Roar).any",
    "!player.buff(Still Water).any"
  }},
  { "Legacy of the Emperor", {
    "!player.buff(Legacy of the Emperor).any",
    "!player.buff(Mark of the Wild).any",
    "!player.buff(Blessing of Kings).any",
    "!player.buff(Embrace of the Shale Spider).any",
    "!player.buff(Blessing of the Forgotten Kings).any"
  }}

}

local combatTable = {

	-- keybinds
	{ "Paralysis", { "modifier.ctrl", "mouseover.enemy", "!mouseover.dead" }, "mouseover" },
	{ "Crackling Jade Lightning", { "modifier.shift", "modifier.alt" }},
	{ "Healing Sphere", "modifier.alt", "ground" },

	{ "Touch of Death", "player.buff(Death Note)" },
	{ "Tiger's Lust", "target.range >= 15" },
	{ "Spinning Fire Blossom", "target.range >= 10" },
	{ "Expel Harm", { "player.health < 80", "player.chi <= 2" }},
	{ "Fortifying Brew", { "modifier.cooldowns", "player.health <= 30", "!player.buff(Touch of Karma)", "!player.buff(Diffuse Magic)", "!player.buff(Dampen Harm)" }},
	{ "Diffuse Magic", { "player.health <= 45", "!player.buff(Fortifying Brew)", "!player.buff(Touch of Karma)", "!player.buff(Dampen Harm)" }},
	{ "Dampen Harm", { "player.health <= 45", "!player.buff(Fortifying Brew)", "!player.buff(Touch of Karma)", "!player.buff(Diffuse Magic)" }},
	{ "Touch of Karma", { "player.health <= 50", "!player.buff(Fortifying Brew)", "!player.buff(Dampen Harm)", "!player.buff(Diffuse Magic)" }},

	{{ -- Interrumpts
		{ "Charging Ox Wave", { "!target.debuff(Spear Hand Strike)", "player.spell(Spear Hand Strike).cooldown < 11", "player.spell(Spear Hand Strike).cooldown > 0" }},
		{ "Leg Sweep", { "!target.debuff(Spear Hand Strike)", "player.spell(Spear Hand Strike).cooldown < 11", "player.spell(Spear Hand Strike).cooldown > 0" }},
		{ "Spear Hand Strike", { "!target.debuff(Charging Ox Wave)", "!target.debuff(Leg Sweep)", "player.spell(Charging Ox Wave).cooldown < 27", "player.spell(Charging Ox Wave).cooldown > 0", "player.spell(Leg Sweep).cooldown < 40", "player.spell(Leg Sweep).cooldown > 0" }},
		{ "Spear Hand Strike", { "!target.debuff(Charging Ox Wave)", "!target.debuff(Leg Sweep)", "player.spell(Charging Ox Wave).cooldown = 0", "player.spell(Leg Sweep).cooldown = 0"}},
	}, "target.interruptsAt(50)" },

	{ "Chi Brew", { "player.chi <= 2", "player.spell(Chi Brew).charges = 1", "player.spell(Chi Brew).recharge <= 10" }},
	{ "Chi Brew", { "player.chi <= 2", "player.spell(Chi Brew).charges = 2" }},
	{ "Chi Brew", { "player.chi <= 2", "target.ttd < 10" }},
	{ "Tiger Palm", "player.buff(Tiger Power).duration <= 3" },
	{ "Tigereye Brew", { "!player.buff(116740)", "player.spell(Rising Sun Kick).cooldown = 0", "player.chi >= 2", "target.debuff(Rising Sun Kick)", "player.buff(Tiger Power)", "player.buff(125195).count >= 15" }},
	{ "Tigereye Brew", { "!player.buff(116740)", "player.spell(Rising Sun Kick).cooldown = 0", "player.chi >= 2", "target.debuff(Rising Sun Kick)", "player.buff(Tiger Power)", "target.ttd < 40" }},
	{ "Energizing Brew", "player.timetomax > 5" },
	{ "Rising Sun Kick", "!target.debuff(Rising Sun Kick)" },
	{ "Tiger Palm", { "!player.buff(Tiger Power)", "target.debuff(Rising Sun Kick).duration > 1", "player.timetomax > 1" }},
	{ "Invoke Xuen, the White Tiger", "modifier.cooldowns" },

	{{ -- AOE
		{ "Rushing Jade Wind", "modifier.cooldowns"},
		{ "Zen Sphere", "!target.debuff(Zen Sphere)" },
		{ "Chi Wave" },
		{ "Chi Burst" },
		{ "Spinning Crane Kick", "!player.spell(Rushing Jade Wind).exists" }
	}, "modifier.multitarget" },

	{ "Rising Sun Kick" },
	{ "Fists of Fury", { "!player.buff(Energizing Brew)", "player.timetomax > 4", "player.buff(Tiger Power).duration > 4" }},
	{ "Chi Wave", "player.timetomax > 2" },
	{ "Chi Burst", "player.timetomax > 2" },
	{ "Zen Sphere", { "player.timetomax > 2", "!target.debuff(Zen Sphere)" }},
	{ "Blackout Kick", "player.buff(Combo Breaker: Blackout Kick)" },
	{ "Tiger Palm", { "player.buff(Combo Breaker: Tiger Palm)", "player.buff(Combo Breaker: Tiger Palm).duration <= 2", "player.timetomax >= 2" }},

	{ "Jab", { "player.chi <= 2", "!player.spell(Ascension).exists" }},
	{ "Jab", { "player.chi <= 3", "player.spell(Ascension).exists" }},

	{ "Blackout Kick", function ()
		return DSL("energy")("player") + select(2, GetPowerRegen("player")) * DSL("spell.cooldown")("player", "Rising Sun Kick") >= 40
	end }
  
}

local outOfCombatTable = {

  { "Crackling Jade Lightning", { "modifier.shift", "modifier.alt" }},
  { "Healing Sphere", "modifier.alt", "ground" },
  
}

for _, buff in pairs(buffs) do
  combatTable[#combatTable + 1] = buff
  outOfCombatTable[#outOfCombatTable + 1] = buff
end

-- SPEC ID 269
ProbablyEngine.rotation.register_custom(269, "|r[|cff9482C9MTS|r][|cffC41F3BMonk-WindWalker|r]", combatTable, outOfCombatTable, exeOnLoad)
