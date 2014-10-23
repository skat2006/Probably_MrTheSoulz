--[[ ///---INFO---////
// Monk WindWalker //
!Originaly made by Tao!
Thank You For Using My ProFiles
I Hope Your Enjoy Them
MTS
]]
sefUnits = {}
lastSEFCount = 0
lastSEFTarget = nil

function SEF()
  if (UnitGUID('target') ~= nil) then
    local count = DSL('buff.count')('player', '137639')
    if count > mtsLib.lastSEFCount and mtsLib.lastSEFTarget then
    mtsLib.sefUnits[mtsLib.lastSEFTarget], mtsLib.lastSEFCount, mtsLib.lastSEFTarget = true, count, nil
    end
    if count < 2 and DSL('enemy')('mouseover') then
    local mouseover, target = UnitGUID('mouseover'), UnitGUID('target')
    if mouseover and target ~= mouseover and not mtsLib.sefUnits[mouseover] then
      mtsLib.lastSEFTarget = mouseover
      return true
    end
    end
    if (count == 0) then
    sefUnits, lastSEFCount, lastSEFTarget = {}, 0, nil
    end
  end
  return false
end



function cancelSEF()
  if DSL('buff')('player', '137639') then
     --and DSL('modifier.enemies')() < 2 then
    sefUnits, lastSEFCount, lastSEFTarget = {}, 0, nil
    return true
  end
  return
end

local exeOnLoad = function()

	ProbablyEngine.toggle.create('chistacker', 'Interface\\Icons\\ability_monk_expelharm', 'Stack Chi', 'Keep Chi at full even OoC...')
	ProbablyEngine.toggle.create('autotarget', 'Interface\\Icons\\ability_hunter_snipershot', 'Auto Target', 'Automatically target the nearest enemy when target dies or does not exist')
	ProbablyEngine.toggle.create('fof', 'Interface\\Icons\\monk_ability_fistoffury', 'Fists of Fury', 'Enable use of Fists of Fury')
	ProbablyEngine.toggle.create('autosef', 'Interface\\Icons\\spell_sandstorm', 'Auto SEF', 'Automatically cast SEF on mouseover targets')
	mtsStart:message("\124cff9482C9*MTS-\124cff00FF96Monk/WW-\124cff9482C9Loaded*")

end

local buffs = {

  { "Legacy of the White Tiger", {"!player.buff(Legacy of the White Tiger).any","!player.buff(Leader of the Pack).any","!player.buff(Arcane Brilliance).any","!player.buff(Dalaran Brilliance).any","!player.buff(Bellowing Roar).any","!player.buff(Furious Howl).any","!player.buff(Terrifying Roar).any","!player.buff(Fearless Roar).any","!player.buff(Still Water).any"}},
  { "Legacy of the Emperor", {"!player.buff(Legacy of the Emperor).any","!player.buff(Mark of the Wild).any","!player.buff(Blessing of Kings).any","!player.buff(Embrace of the Shale Spider).any","!player.buff(Blessing of the Forgotten Kings).any"}}

}

local combatTable = {

	-- Pause
		{ "pause", "modifier.lshift" },

	-- AutoTarget
		{ "/targetenemy [noexists]", { "toggle.autotarget", "!target.exists" } },
		{ "/targetenemy [dead]", { "toggle.autotarget", "target.exists", "target.dead" } },

	-- Keyboard modifiers
		{ "Leg Sweep", "modifier.lcontrol" },              -- Leg Sweep
		{ "Touch of Karma", "modifier.lalt" },              -- Touch of Karma

	-- SEF on mouseover
		{ "Storm, Earth, and Fire", { SEF(), "toggle.autosef" }, "mouseover" },
		{ "/cancelaura Storm, Earth, and Fire", { "target.debuff(Storm, Earth, and Fire)", "toggle.autosef" }},

	-- Interrupts
		{ "Paralysis", { -- Paralysis when SHS, and Quaking Palm are all on CD
			"!target.debuff(Spear Hand Strike)",
			"player.spell(Spear Hand Strike).cooldown > 0",
			"player.spell(Quaking Palm).cooldown > 0",
			"!modifier.last(Spear Hand Strike)", 
			"target.interruptAt(30)" 
		}},
  { "Ring of Peace", { -- Ring of Peace when SHS is on CD
     "!target.debuff(Spear Hand Strike)",
     "player.spell(Spear Hand Strike).cooldown > 0",
     "!modifier.last(Spear Hand Strike)", 
     "target.interruptAt(30)" 
  }},
  { "Leg Sweep", { -- Leg Sweep when SHS is on CD
     "player.spell(116705).cooldown > 0",
     "target.range <= 5",
     "!modifier.last(116705)", 
     "target.interruptAt(30)" 
  }},
  { "Charging Ox Wave", { -- Charging Ox Wave when SHS is on CD
     "player.spell(116705).cooldown > 0",
     "target.range <= 30",
     "!modifier.last(116705)", 
     "target.interruptAt(30)" 
  }},
  { "Quaking Palm", { -- Quaking Palm when SHS is on CD
     "!target.debuff(Spear Hand Strike)",
     "player.spell(Spear Hand Strike).cooldown > 0",
     "!modifier.last(Spear Hand Strike)", 
     "target.interruptAt(30)" 
  }},
  { "Spear Hand Strike" , "target.interruptAt(30)" }, -- Spear Hand Strike

	-- Queued Spells
	  { "!122470", "@mtsLib.checkQueue(122470)" }, -- Touch of Karma
	  { "!116845", "@mtsLib.checkQueue(Ring of Peace)" }, -- Ring of Peace
	  { "!119392", "@mtsLib.checkQueue(119392)" }, -- Charging Ox Wave
	  { "!119381", "@mtsLib.checkQueue(119381)" }, -- Leg Sweep
	  { "!Tiger's Lust", "@mtsLib.checkQueue(Tiger's Lust)" }, -- Tiger's Lust
	  { "!Dampen Harm", "@mtsLib.checkQueue(Dampen Harm)" }, -- Dampen Harm
	  { "!Diffuse Magic", "@mtsLib.checkQueue(Diffuse Magic)" }, -- Diffuse Magic
	  --{ "!115460", "@mtsLib.checkQueue(115460)", "ground" }, -- Healing Sphere

	-- Survival
		{ "Expel Harm", { "player.health <= 80", "player.chi < 4" }},
		{ "Chi Wave", "player.health <= 75" },
		{ "Fortifying Brew", { -- Forifying Brew at < 30% health and when DM & DH buff is not up
			"player.health < 30",
			"!player.buff(Diffuse Magic)", --DM
			"!player.buff(Dampen Harm)" --DH
		}},
		{ "#5512", "player.health < 40" }, -- Healthstone
		{ "Detox", "player.dispellable(Detox)", "player" }, -- Detox yourself if you can be dispelled
		{ "Nimble Brew", "player.state.disorient" }, -- Nimble Brew = Nimble Brew
		{ "Nimble Brew", "player.state.fear" },
		{ "Nimble Brew", "player.state.stun" },
		{ "Nimble Brew", "player.state.root" },
		{ "Nimble Brew", "player.state.horror" },
		{ "Nimble Brew", "player.state.snare" },
		{ "Tiger's Lust", "player.state.disorient" }, -- Tiger's Lust = Tiger's Lust
		{ "Tiger's Lust", "player.state.stun" },
		{ "Tiger's Lust", "player.state.root" },
		{ "Tiger's Lust", "player.state.snare" },

	-- Shared
	{ "Chi Sphere", { "player.spell(Power Strikes).exists", "player.buff(Chi Sphere)", "player.chi < 4" }},
	-- Cooldowns/Racials
		{ "Lifeblood", "modifier.cooldowns" },
		{ "Berserking", "modifier.cooldowns" },
		{ "Blood Fury", "modifier.cooldowns" },
		{ "Bear Hug", "modifier.cooldowns" },
		{ "Invoke Xuen, the White Tiger", "modifier.cooldowns" },

	-- Melee range only
		{ "Touch of Death", "player.buff(Death Note)" },

  {{
    { "Chi Brew", { "!modifier.last(Chi Brew)", "player.spell(Chi Brew).charges = 2" }},
    --{ "Chi Brew", "target.ttd < 10" },
    { "Chi Brew", { "player.spell(Chi Brew).charges = 1", "player.spell(Chi Brew).recharge <= 10", "!modifier.last(Chi Brew)" }},
  }, {"player.chi <= 2", "player.buff(Tigereye Brew).count <= 16" }},

	-- Tiger Palm
		{"Tiger Palm", "player.buff(Tiger Power).duration <= 3" },
	  -- Tigereye Brew
		  {{
			{ "116740", "player.buff(125195).count = 20" },
			{{
			  { "116740", { "player.chi >= 3", "player.buff(125195).count >= 10", "player.spell(Fists of Fury).cooldown < 1" }},
				{{
				  { "116740", { "player.buff(125195).count >= 16" }},
				  --{ "116740", { "target.ttd < 40" }},
				},{ "player.chi >= 2" }},
			},{ "target.debuff(130320)", "player.buff(125359)" }},
		  },{ "!player.buff(116740)", "!modifier.last(116740)" }},
	-- TODO: Implement TeB with Hurricane Strike & Serenity
		{ "Rising Sun Kick", "!target.debuff(Rising Sun Kick)" },
		{ "Rising Sun Kick", "target.debuff(Rising Sun Kick).duration < 3" },
		{ "Tiger Palm", { "!player.buff(Tiger Power)", "target.debuff(Rising Sun Kick).duration > 1", "player.timetomax > 1" }},
  -- TODO: Implement Serenity

	-- AoE
		-- TODO: Implement Chi Explosion
			{ "Rushing Jade Wind" }, -- Rushing Jade Wind
			{ "Rising Sun Kick", { "player.chi = 4", "!player.spell(Ascension).exists" }}, -- Rising Sun Kick
			{ "Rising Sun Kick", { "player.chi = 5", "player.spell(Ascension).exists" }}, -- Rising Sun Kick
			{ "Fists of Fury", {
				"!player.moving",
				"player.spell(Rushing Jade Wind).exists",
				"player.timetomax > 4",
				"player.buff(Tiger Power).duration > 4",
				"target.debuff(Rising Sun Kick).duration > 4",
				"toggle.fof" }},

		-- TODO: Implement Hurricane Strike
			{ "Zen Sphere", { "!player.buff(Zen Sphere)" }, "target" },
			{ "Chi Wave", "player.timetomax > 2" }, -- Chi Wave (40yrd range!)
			{ "Chi Burst", { "!player.moving", "player.timetomax > 2" }}, -- Chi Burst (40yrd range!)
			{ "Blackout Kick", { "player.spell(Rushing Jade Wind).exists", "player.buff(Combo Breaker: Blackout Kick)" }},
			{ "Tiger Palm", { "player.spell(Rushing Jade Wind).exists", "player.buff(Combo Breaker: Tiger Palm)", "player.buff(Combo Breaker: Tiger Palm).duration <= 2" }},
			{ "Blackout Kick", { "player.spell(Rushing Jade Wind).exists", "player.chi <= 2" }},
			{ "Spinning Crane Kick", "!player.spell(Rushing Jade Wind).exists" }, -- Spinning Crane Kick
			{ "Jab", { "player.spell(Rushing Jade Wind).exists", "player.chi <= 2" }},
  
  -- Single

	-- Fists of Fury
		{ "Fists of Fury", {"!player.moving","target.debuff(Rising Sun Kick).duration > 4","toggle.fof" }},

	-- TODO: Implement Hurricane Strike
		{ "Energizing Brew", { "player.spell(Fists of Fury).cooldown > 6", "player.timetomax > 5" }},
		{ "Rising Sun Kick" }, -- Rising Sun Kick
		{ "Chi Wave" }, -- Chi Wave (40 yard range!)
		{ "Zen Sphere", { "!player.buff(Zen Sphere)", "player.timetomax > 2" }, "target" },
		{ "Chi Burst", {"!player.moving", "player.timetomax > 2"} }, -- Chi Burst (40 yard range!)
		{ "Blackout Kick", "player.buff(Combo Breaker: Blackout Kick)" }, -- Blackout Kick

	-- TODO: Implement Chi Explosion
		{ "Tiger Palm", { "player.buff(125359)", "player.buff(125359).duration <= 2" }},
		{ "Tiger Palm",  "player.buff(Combo Breaker: Tiger Palm)" },
		{ "Blackout Kick", { "player.chi <= 2" , "player.spell(Fists of Fury).cooldown > 2" , "!player.moving"}},
		{ "Blackout Kick", { "player.chi <= 2" , "player.moving"}},
		{ "Blackout Kick", { "player.chi <= 2" , "!toggle.fof" }},

	-- TODO: Implement Chi Explosion
		{ "Jab", { "player.chi <= 2", "!player.spell(Ascension).exists" }},
		{ "Jab", { "player.chi <= 3", "player.spell(Ascension).exists" }},

	-- Ranged
		-- Tiger's Lust if the target is at least 15 yards away and we are moving
		{ "Tiger's Lust", { "target.range >= 15", "player.moving" }},
		{ "Zen Sphere", "!target.debuff(Zen Sphere)" }, -- 40 yard range!
		{ "Chi Wave" }, -- Chi Wave (40yrd range!)
		{ "Chi Burst" }, -- Chi Burst (40yrd range!)
	-- Crackling Jade Lightning
		{ "Crackling Jade Lightning", { "target.range > 5", "target.range <= 40", "!player.moving" }},
		{ "Expel Harm", "player.chi < 4" } -- Expel Harm
  
}

local outOfCombatTable = {

  { "Crackling Jade Lightning", { "modifier.shift", "modifier.alt" }},
  { "Healing Sphere", "modifier.alt", "ground" },
  
}

for _, buff in pairs(buffs) do
  combatTable[#combatTable + 1] = buff
  outOfCombatTable[#outOfCombatTable + 1] = buff
end

ProbablyEngine.rotation.register_custom(269, "|r[|cff9482C9MTS|r][|cff00FF96Monk-WindWalker|r]", combatTable, outOfCombatTable, exeOnLoad)
