--[[ ///---INFO---////
//Priest Disc//
Thank You For Using My ProFiles
I Hope Your Enjoy Them
MTS
]]--

local ignoreDebuffs = {'Mark of Arrogance','Displaced Energy'}

								--[[   !!!Dispell function!!!   ]]
						--[[   Checks is member as debuff and can be dispeled.   ]]
--[[  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ]]
function Dispell()
local prefix = (IsInRaid() and 'raid') or 'party'
	for i = -1, GetNumGroupMembers() - 1 do
	local unit = (i == -1 and 'target') or (i == 0 and 'player') or prefix .. i
		if IsSpellInRange('Purify', unit) then
			for j = 1, 40 do
			local debuffName, _, _, _, dispelType, duration, expires, _, _, _, spellID, _, isBossDebuff, _, _, _ = UnitDebuff(unit, j)
				if dispelType and dispelType == 'Magic' or dispelType == 'Disease' then
				local ignore = false
				for k = 1, #ignoreDebuffs do
					if debuffName == ignoreDebuffs[k] then
						ignore = true
						break
					end
				end
					if not ignore then
						ProbablyEngine.dsl.parsedTarget = unit
						return true
					end
				end
				if not debuffName then
					break
				end
			end
		end
	end
		return false
end 

local exeOnLoad = function()

	ProbablyEngine.toggle.create('autotarget', 'Interface\\Icons\\Ability_spy.png', 'Auto Target', 'Automatically target the nearest enemy when target dies or does not exist')
	ProbablyEngine.toggle.create( 'painSup', 'Interface\\Icons\\Spell_holy_painsupression.png', 'Pain Suppression', 'Toggle Enables Pain Suppression')
	ProbablyEngine.toggle.create( 'mouseOver', 'Interface\\Icons\\Priest_spell_leapoffaith_a', 'MouseOver Heal', 'Toggle Mouse-Over Healing')
	ProbablyEngine.toggle.create( 'feather', 'Interface\\Icons\\Ability_priest_angelicfeather.png', "Use Feather's", "Toggle Enables The Use Of Feather's")
	ProbablyEngine.toggle.create('dispel', 'Interface\\Icons\\Ability_paladin_sacredcleansing.png', 'Dispel Everything', 'Dispels everything it finds \nThis does not effect SoO dispels.')
	mtsStart:message("\124cff9482C9*MTS-\124cffFFFFFFPriest/Dist\124cff9482C9-Loaded*")

end

local inCombat = {
	
  	--keybinds
		{ "32375", "modifier.rcontrol", "player.ground" }, --Mass Dispel
	 	{ "62618", "modifier.rshift", "tank.ground" }, --Power Word: Barrier
	 	{ "48045", "modifier.ralt", "tank" }, -- Mind Sear
	 	{ "121135", "modifier.lcontrol", "player" },  --Cascade
		{ "120517", "modifier.lcontrol", "player" }, --Halo
		{ "110744", "modifier.lcontrol", "player" }, --Divine Star
		{ "109964", "modifier.lshift" }, --Spirit Shell

	-- Auto Targets
		{ "/target [target=focustarget, harm, nodead]", { "toggle.autotarget", "target.range > 40" }}, -- Use Tank Target
		{ "/targetenemy ", { "toggle.autotarget", "target.friendly" }}, -- Target a enemie if target is friendly
		{ "/targetenemy [noexists]", { "toggle.autotarget", "!target.exists" }}, -- target enemire if no target
   		{ "/targetenemy [dead]", { "toggle.autotarget", "target.exists", "target.dead" }}, -- target enemire if current is dead.

   	-- buffs
		{ "81700", "player.buff(81661).count = 5" },--Archangel
	
	-- LoOk aT It GOoZ!!! // Needs to add tank...
		{ "121536", {"player.movingfor > 2", "toggle.feather", "!player.buff(121557)", "player.spell(121536).charges >= 1" }, "player.ground" },
	
	-- Mouse Over
	    { "47540", { "toggle.mouseOver", "!player.moving" }, "mouseover" },  --Penance
		{ "2061", { "toggle.mouseOver", "!player.moving" }, "mouseover" },  --Flash Heal

  	-- Mana/Survival
		{ "123040", {"player.mana < 75","target.spell(123040).range"}, "target" }, --Mindbender
		{ "34433", {"player.mana < 75","target.spell(34433).range"}, "target" },	 --Shadowfiend
		{ "19236", {"player.health <= 20" }, "Player" }, --Desperate Prayer
		{ "64901", {"player.mana < 70"}, "player"}, --Hymn of hope

  	-- HEALTHSTONE 
		{ "#5512", "player.health <= 35" },

  	-- Aggro
		{ "586", "target.threat >= 80" }, -- Fade
 
  	-- Dispel's
	    { "527", {"player.debuff(146595)","@coreHealing.needsDispelled('Mark of Arrogance')"}, nil },
	    { "527", "@coreHealing.needsDispelled('Corrosive Blood')", nil },
	 	{ "527", "@coreHealing.needsDispelled('Harden Flesh')", nil },
	 	{ "527", "@coreHealing.needsDispelled('Torment')", nil },
	 	{ "527", "@coreHealing.needsDispelled('Breath of Fire')", nil },
	 	{ "527", {"toggle.dispel", function() return Dispell() end}},

  	-- CD's
		{ "10060", "modifier.cooldowns" }, --Power Infusion
		{ "33206", { "toggle.painSup", "lowest.health <= 25 " }, "lowest" }, --Pain Suppression
	    { "596", { "!player.moving", "modifier.lalt" }, "lowest" }, --Prayer of Healing
	
	-- SHIELDZ ME BITCH
		{ "17", { "!tank.debuff(6788).any", "!tank.buff(17).any" }, "tank" }, --Power Word: Shield
		{ "17", { "!focus.debuff(6788).any", "!focus.buff(17).any" }, "focus" }, --Power Word: Shield
		{ "17", { "!player.debuff(6788).any", "!player.buff(17).any", "player.health <= 70" }, "player" }, --Power Word: Shield
		{ "17", { "!lowest.debuff(6788).any", "!lowest.buff(17).any", "lowest.health <= 40" }, "lowest" }, --Power Word: Shield
	
	-- AOE
   		--Shared
   			{ "596", {"player.buff(109964)","player.buff(109964).duration > 2.5"}, "lowest" }, --Prayer of Healing
		-- Party
			{ "596", { "@coreHealing.needsHealing(80, 3)", "modifier.party", "!player.moving" }, "lowest" }, --Prayer of Healing
			--{ "132157", { "@coreHealing.needsHealing(95, 3)", "!modifier.last", "player.area(10).friendly > 2", "@mtsLib.CanFireHack()", "modifier.party" }}, -- Holy Nova

	-- Heal FAST BITCH
		{ "2061", "tank.health <= 50", "tank" }, --Flash Heal
		{ "2061", "lowest.health <= 20", "lowest" }, --Flash Heal
	
	-- Tank
		{ "2060", "tank.health <= 60", "tank" }, --Greater Healing
		{ "33076", { "tank.health <= 95", "!player.moving" }, "tank" }, --Prayer of Mending
		{ "2050", {"!tank.health <= 50", "tank.health < 85"}, "tank" }, -- Heal
	
	-- Singe Target
		{ "47540", "lowest.health <= 85", "lowest" }, --Penance
		{ "2060", "lowest.health <= 50", "lowest" }, --Greater Healing
		{ "2050", "lowest.health <= 85", "lowest" }, -- Heal

	--Attonement    
		{ "14914", { "!toggle.mouseOver", "player.mana > 20","target.spell(14914).range" }, "target" }, --Holy Fire
		{ "47540", { "player.mana > 20", "target.spell(47540).range", "!player.moving" }, "target" }, --Penance
		{ "585", { "player.mana > 20", "!player.moving", "target.spell(585).range" }, "target" }, --Smite

}

local inCombatSolo = {

  	-- Auto Target
		{ "/target [target=focustarget, harm, nodead]", { "toggle.autotarget", "target.range > 40", "tank.combat" }}, -- Use Tank Target
		{ "/targetenemy ", { "toggle.autotarget", "target.friendly", "tank.combat" }}, -- Target a enemie if target is friendly
		{ "/targetenemy [noexists]", { "toggle.autotarget", "!target.exists", "tank.combat" }}, -- target enemire if no target
		{ "/targetenemy [dead]", { "toggle.autotarget", "target.exists", "target.dead", "tank.combat" }}, -- target enemire if current is dead.
		
	-- Start ICC
		{ "589", "tank.combat", "lowest" }, --dot
	
	-- Mana
		{ "123040", { "player.mana < 75","target.spell(123040).range" }, "target" }, --Mindbender
		{ "34433", { "player.mana < 75", "target.spell(34433).range" }, "target" }, --Shadowfiend

	-- Heal
		{ "17", { "!player.debuff(6788).any", "!player.buff(17).any", "player.health <= 60" }}, --Power Word Shield
		{ "2061", "player.health <= 35", "Player" }, --Flash Heal

  	--DPS
		{ "589", { "target.debuff(589).duration < 2","target.spell(589).range"}, "target" }, --Shadow Word:Pain
		{ "129250", { "target.spell(129250).range" }, "target" }, -- Power Word: Solace
		{ "14914", { "target.spell(14914).range" }, "target" }, --Holy Fire
		{ "47540", "target.spell(47540).range", "target" }, --Penance 
		{ "585", "target.spell(585).range", "target" },	--Smite
		{ "32379", {"target.health < 20","target.spell(32379).range" }, "target" }, -- Shadow Word: Death

}

local outCombat = {

	--Heal
		{ "17", { "!tank.debuff(6788).any", "!tank.buff(17).any" }, "tank" }, --Power Word: Shield
	    { "21562", { "!player.buff(21562).any", "!player.buff(588)" }}, -- Fortitude
		{ "47540", { "lowest.health <= 85", "!player.moving" }, "lowest" }, --Penance
		{ "2061", { "!player.moving", "lowest.health <= 75" }, "lowest" }, --Flash Heal
		{ "596", { "!player.moving", "@coreHealing.needsHealing(90, 3)" }, "lowest" }, --Prayer of Healing

	-- Mouse Over
	    { "47540", { "toggle.mouseOver", "!player.moving" }, "mouseover" },  --Penance
		{ "2061", { "toggle.mouseOver", "!player.moving" }, "mouseover" },  --Flash Heal
		
	-- buffs
		{ "21562", {"!player.buff(21562).any","!player.buff(588)"}}, -- Fortitude
		{ "81700", "player.buff(81661).count = 5", "player.buff(81661).duration < 5" },--Archangel
	
	-- LoOk aT It GOoZ!!!
		{ "121536", {"player.movingfor > 2", "toggle.feather", "!player.buff(121557)", "player.spell(121536).charges >= 1" }, "player.ground" },

}

ProbablyEngine.rotation.register_custom(256, "|r[|cff9482C9MTS|r][|cffFFFFFFPriest-Dist-Party|r]", inCombat, outCombat, exeOnLoad)
ProbablyEngine.rotation.register_custom(256, "|r[|cff9482C9MTS|r][|cffFFFFFFPriest-Dist-Solo|r]", inCombatSolo, outCombat, exeOnLoad)