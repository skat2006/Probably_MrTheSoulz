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
    if count > lastSEFCount and lastSEFTarget then
    sefUnits[lastSEFTarget], lastSEFCount, lastSEFTarget = true, count, nil
    end
    if count < 2 and UnitReaction('mouseover') <= 4 then
    local mouseover, target = UnitGUID('mouseover'), UnitGUID('target')
    if mouseover and target ~= mouseover and not sefUnits[mouseover] then
      lastSEFTarget = mouseover
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

	ProbablyEngine.toggle.create('autotarget', 'Interface\\Icons\\ability_hunter_snipershot', 'Auto Target', 'Automatically target the nearest enemy when target dies or does not exist')
	ProbablyEngine.toggle.create('autosef', 'Interface\\Icons\\spell_sandstorm', 'Auto SEF', 'Automatically cast SEF on mouseover targets')
	mtsStart:message("\124cff9482C9*MTS-\124cff00FF96Monk/WW-\124cff9482C9Loaded*")

end

local inCombat = {

	-- Keybinds
		{ "pause", "modifier.shift" },
		{ "Leg Sweep", "modifier.control" }, -- Leg Sweep
		{ "Touch of Karma", "modifier.alt" }, -- Touch of Karma

	-- SEF on mouseover // Broken?
  		{ "Storm, Earth, and Fire", { SEF(), "toggle.autosef" }, "mouseover" },
  		{ "/cancelaura Storm, Earth, and Fire", { "target.debuff(Storm, Earth, and Fire)", "toggle.autosef" }, "mouseover"},

	-- Auto Target
		{ "/target [target=focustarget, harm, nodead]", {"target.range > 40", "!target.exists","toggle.autotarget"} },
		{ "/targetenemy [noexists]", { "toggle.autotarget", "!target.exists" }},
   		{ "/targetenemy [dead]", { "toggle.autotarget", "target.exists", "target.dead" }},

	-- Survival
		{ "Expel Harm", { "player.health <= 80", "player.chi < 4" }},
		{ "Chi Wave", "player.health <= 75" },
		{ "Fortifying Brew", { -- Forifying Brew at < 30% health and when DM & DH buff is not up
		  "player.health < 30",
		  "!player.buff(Diffuse Magic)", --DM
		  "!player.buff(Dampen Harm)"}}, --DH
		{ "#5512", "player.health < 40" }, -- Healthstone

	-- Interrupts
	  	{ "Paralysis", { -- Paralysis when SHS, and Quaking Palm are all on CD
	     	"!target.debuff(Spear Hand Strike)",
	     	"player.spell(Spear Hand Strike).cooldown > 0",
	     	"player.spell(Quaking Palm).cooldown > 0",
	     	"!modifier.last(Spear Hand Strike)"}},
	  	{ "Ring of Peace", { -- Ring of Peace when SHS is on CD
	     	"!target.debuff(Spear Hand Strike)",
	     	"player.spell(Spear Hand Strike).cooldown > 0",
	     	"!modifier.last(Spear Hand Strike)"}},
	  	{ "Leg Sweep", { -- Leg Sweep when SHS is on CD
	     	"player.spell(116705).cooldown > 0",
	     	"target.range <= 5",
	     	"!modifier.last(116705)"}},
	  	{ "Charging Ox Wave", { -- Charging Ox Wave when SHS is on CD
	     	"player.spell(116705).cooldown > 0",
	     	"target.range <= 30",
	     	"!modifier.last(116705)"}},
	  	{ "Quaking Palm", { -- Quaking Palm when SHS is on CD
	     	"!target.debuff(Spear Hand Strike)",
	     	"player.spell(Spear Hand Strike).cooldown > 0",
	     	"!modifier.last(Spear Hand Strike)"}},
	  	{ "Spear Hand Strike" }, -- Spear Hand Strike

	-- Cooldowns
		{ "Energizing Brew", "modifier.cooldowns" }, -- Nimble Brew = Nimble Brew
		{ "Invoke Xuen, the White Tiger", "modifier.cooldowns" }, -- Nimble Brew = Nimble Brew

	-- FREEDOOM!
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

	-- buffs
		{ "Touch of Death", "player.buff(Death Note)" },
		{ "116740", "player.buff(125195).count = 10" }, -- Tigereye Brew

	-- Procs
		{ "Blackout Kick", "player.buff(Combo Breaker: Blackout Kick)"},
		{ "Tiger Palm", "player.buff(Combo Breaker: Tiger Palm)"},

	-- Rotation
		{ "Rising Sun Kick", "target.debuff(Rising Sun Kick).duration < 3" },
		{ "Fists of Fury", "!player.moving" },

		-- AoE
			{ "Spinning Crane Kick", { "player.area(8).enemies > 3", "@mtsLib.CanFireHack()" }}, -- Spinning Crane Kick // FH Smarth
			{ "Spinning Crane Kick", "modifier.multitarget" }, -- Spinning Crane Kick

		{ "Blackout Kick", "player.chi >= 3" },
		{ "Tiger Palm", "!player.buff(Tiger Power)"},
		{ "Jab", "player.chi <= 3" },
	
	-- Ranged
		{ "Tiger's Lust", { "target.range >= 15", "player.moving" }},-- Tiger's Lust if the target is at least 15 yards away and we are moving
		{ "Zen Sphere", "!target.debuff(Zen Sphere)" }, -- 40 yard range!
		{ "Chi Wave" }, -- Chi Wave (40yrd range!)
		{ "Chi Burst" }, -- Chi Burst (40yrd range!)
		{ "Crackling Jade Lightning", { "target.range > 5", "target.range <= 40", "!player.moving" }},
		{ "Expel Harm", "player.chi < 4" } -- Expel Harm
		
		  
}

local outCombat = {

 	{ "Legacy of the White Tiger", {
	  	"!player.buff(Legacy of the White Tiger).any",
	  	"!player.buff(Leader of the Pack).any",
	  	"!player.buff(Arcane Brilliance).any",
	  	"!player.buff(Dalaran Brilliance).any",
	  	"!player.buff(Bellowing Roar).any",
	  	"!player.buff(Furious Howl).any",
	  	"!player.buff(Terrifying Roar).any",
	  	"!player.buff(Fearless Roar).any",
	  	"!player.buff(Still Water).any"}},
  	{ "Legacy of the Emperor", {
  		"!player.buff(Legacy of the Emperor).any",
  		"!player.buff(Mark of the Wild).any",
  		"!player.buff(Blessing of Kings).any",
  		"!player.buff(Embrace of the Shale Spider).any",
  		"!player.buff(Blessing of the Forgotten Kings).any"}}
  
}

ProbablyEngine.rotation.register_custom(269, "|r[|cff9482C9MTS|r][|cff00FF96Monk-WindWalker|r]", inCombat, outCombat, exeOnLoad)
