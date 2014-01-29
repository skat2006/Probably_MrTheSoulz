-- Originaly made by Tao

local UnitID = UnitID
local DSL = ProbablyEngine.dsl.get
local lastState, lastShift, shiftCount, loadedMultiState = false, false, 0, false

local function toggleMultiTarget()
  if not loadedMultiState then
    ProbablyEngine.buttons.setInactive("multitarget")
    ProbablyEngine.buttons.text("multitarget", "Off")
    loadedMultiState = true
  end

  local shiftState, altState = DSL("modifier.shift")(), DSL("modifier.alt")()

  if shiftCount == 0 and ProbablyEngine.config.read("button_states", "multitarget", false) then
    shiftState, lastState, altState = true, false, false
  end

  if shiftCount > 0 and not ProbablyEngine.config.read("button_states", "multitarget", false) then
    shiftCount = 0
  end

  if shiftState ~= lastState and not altState then
    if shiftState == true then
      shiftCount = (shiftCount + 1) % 3

      if shiftCount > 1 and lastShift and GetTime() - lastShift > 1 then
        shiftCount = 0
      end

      local text = shiftCount
      if shiftCount == 0 then
        ProbablyEngine.buttons.setInactive("multitarget")
        text = "Off"
      else
        ProbablyEngine.buttons.setActive("multitarget")
        text = text == 1 and "SEF" or "SCK"
      end
      ProbablyEngine.buttons.text("multitarget", text)

      lastShift = GetTime()
    end
    lastState = shiftState
  end
  return false
end

local sefUnits, lastSEFCount, lastSEFTarget = {}, 0
local function SEF()
  if shiftCount == 0 then return false end

  local count = DSL("buff.count")("player", "Storm, Earth, and Fire")
  if count > lastSEFCount and lastSEFTarget then
    sefUnits[lastSEFTarget], lastSEFCount, lastSEFTarget = true, count, nil
  end

  if count < 2
     and DSL("enemy")("mouseover")
     and DSL("modifier.enemies")() >= 3
     and DSL("ttd")("target") > 10 then

    local mouseover, target = UnitGUID("mouseover"), UnitGUID("target")

    if mouseover and target ~= mouseover and not sefUnits[mouseover] and DSL("ttd")("mouseover") > 10 then
      lastSEFTarget = mouseover
      return true
    end
  end

  return false
end

local function cancelSEF()
  if DSL("buff")("player", "Storm, Earth, and Fire")
     and (shiftCount == 0 or DSL("modifier.enemies")() < 3) then
    sefUnits, lastSEFCount, lastSEFTarget = {}, 0, nil
    return true
  end
  return false
end

local function multiTargetEnabled()
  return shiftCount > 0
end

local function SCK()
  return shiftCount == 2
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

local multitarget = {

  { "Rushing Jade Wind", { "modifier.cooldowns", SCK }},
  { "Zen Sphere", "!target.debuff(Zen Sphere)" },
  { "Chi Wave" },
  { "Chi Burst" },
  { "Spinning Crane Kick", { "!player.spell(Rushing Jade Wind).exists", SCK }}
  
}

local combatTable = {

	-- keybinds
	{ "Paralysis", { "modifier.ctrl", "mouseover.enemy", "!mouseover.dead" }, "mouseover" },
	{ "Crackling Jade Lightning", { "modifier.shift", "modifier.alt" }},
	{ "Healing Sphere", "modifier.alt", "ground" }, 
	{ "pause", toggleMultiTarget },

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

	{ "Storm, Earth, and Fire", SEF, "mouseover" },

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

	{ multitarget, multiTargetEnabled },
	{ "/cancelaura Storm, Earth, and Fire", cancelSEF },

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

  { "Storm, Earth, and Fire", SEF, "mouseover" },
  { "/cancelaura Storm, Earth, and Fire", cancelSEF },
  { "Crackling Jade Lightning", { "modifier.shift", "modifier.alt" }},
  { "Healing Sphere", "modifier.alt", "ground" }, 
  { "pause", toggleMultiTarget },
  
}

for _, buff in pairs(buffs) do
  combatTable[#combatTable + 1] = buff
  outOfCombatTable[#outOfCombatTable + 1] = buff
end

-- SPEC ID 269
ProbablyEngine.rotation.register_custom(269, "|r[|cff9482C9MTS|r][|cffC41F3BMonk-WindWalker|r]", combatTable, outOfCombatTable)
