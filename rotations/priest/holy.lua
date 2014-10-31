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
Dispell = function ()
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

	ProbablyEngine.toggle.create( 'mouseOver', 'Interface\\Icons\\Priest_spell_leapoffaith_a', 'MouseOver Heal', 'Toggle Mouse-Over Healing')
	ProbablyEngine.toggle.create( 'feather', 'Interface\\Icons\\Ability_priest_angelicfeather.png', "Use Feather's", "Toggle Enables The Use Of Feather's")
	ProbablyEngine.toggle.create('dispel', 'Interface\\Icons\\Ability_paladin_sacredcleansing.png', 'Dispel Everything', 'Dispels everything it finds \nThis does not effect SoO dispels.')
	mtsStart:message("\124cff9482C9*MTS-\124cffFFFFFFPriest/Holy\124cff9482C9-Loaded*")

end

local inCombat = {
	
  	--keybinds
		{ "32375", "modifier.rcontrol", "player.ground" }, --Mass Dispel
	 	{ "48045", "modifier.ralt", "tank" }, -- Mind Sear
	 	{ "121135", "modifier.lcontrol", "player" },  --Cascade
		{ "120517", "modifier.lcontrol", "player" }, --Halo
		{ "110744", "modifier.lcontrol", "player" }, --Divine Star
	
	-- LoOk aT It GOoZ!!! // Needs to add tank...
		{ "121536", {"player.movingfor > 2", "toggle.feather", "!player.buff(121557)", "player.spell(121536).charges >= 1" }, "player.ground" },
	
	-- Mouse Over
		{ "139", { "toggle.mouseOver", "!mouseover.buff" }, "mouseover" }, --renew
		{ "2061", { "toggle.mouseOver", "mouseover.health <= 55", "!player.moving" }, "mouseover" },  --Flash Heal
		{ "2060", { "toggle.mouseOver", "mouseover.health <= 95", "!player.moving" }, "mouseover" }, -- Heal

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
	 	{ "527", {"toggle.dispel", Dispell }},

  	-- CD's
		{ "10060", "modifier.cooldowns" }, --Power Infusion
		{ "123040", {"player.mana < 75", "target.spell(123040).range", "modifier.cooldowns"}, "target" }, --Mindbender
	
	-- Player dead (Spirit)
		{ "88684", {"lowest.health <= 80", "player.buff(27827)"}, "lowest" }, -- Holy Word Serenity
		{ "2061", {"lowest.health < 100", "player.buff(27827)"}, "lowest" }, --Flash Heal
		{ "34861", {"@coreHealing.needsHealing(95, 3)", "player.buff(27827)"}, "lowest"}, -- Circle of Healing
		{ "121135", {"@coreHealing.needsHealing(95, 3)", "player.buff(27827)"}}, -- cascade
		{ "596", { "@coreHealing.needsHealing(95, 3)", "!player.moving", "player.buff(27827)" }, "lowest" }, --Prayer of Healing

	-- Heal Fast Bitch!!
		-- Desperate Prayer
			{ "19236", "player.health <= 20", "Player" }, --Desperate Prayer

		-- Holy Word Serenity
			{ "88684", {"focus.health <= 90", "focus.spell(88684).range"}, "focus" }, -- Holy Word Serenity
			{ "88684", {"tank.health <= 90", "tank.spell(88684).range"}, "tank" }, -- Holy Word Serenity
			{ "88684", "player.health <= 60", "player" }, -- Holy Word Serenity
			{ "88684", "lowest.health <= 60", "lowest" }, -- Holy Word Serenity

		-- Flash Heal
			{ "2061", {"focus.health <= 40", "focus.spell(2061).range"}, "focus" }, --Flash Heal
			{ "2061", {"tank.health <= 40", "tank.spell(2061).range"}, "tank" }, --Flash Heal
			{ "2061", "player.health <= 40", "player" }, --Flash Heal
			{ "2061", "lowest.health <= 20", "lowest" }, --Flash Heal

	-- AOE
		-- Shared
			{ "34861", "@coreHealing.needsHealing(95, 3)", "lowest"}, -- Circle of Healing
			{ "121135", "@coreHealing.needsHealing(95, 3)"}, -- cascade
   		
   		-- Prayer of Healing
   			{ "596", {"player.buff(109964)","player.buff(109964).duration > 2.5", "modifier.party"}, "lowest" }, --Prayer of Healing
   			{ "596", { "modifier.lshift", "!player.moving" }, "mouseover" }, --Prayer of Healing // Raid WorkAround.
   			{ "596", { "@coreHealing.needsHealing(85, 3)", "modifier.party", "!modifier.raid", "!player.moving" }, "lowest" }, --Prayer of Healing
		
		-- Divine Hymn
			{ "64843", { "@coreHealing.needsHealing(50, 3)", "modifier.party" }}, -- Divine Hymn
			{ "64843", { "@coreHealing.needsHealing(60, 5)", "modifier.raid", "!modifier.members > 10" }}, -- Divine Hymn
			{ "64843", { "@coreHealing.needsHealing(60, 8)", "modifier.raid", "modifier.members > 10" }}, -- Divine Hymn

	-- shields
		{ "17", { "!focus.debuff(6788).any", "focus.spell(17).range", "focus.spell(17).range" }, "focus" }, --Power Word: Shield
		{ "17", { "!tank.debuff(6788).any", "tank.spell(17).range", "tank.spell(17).range" }, "tank" }, --Power Word: Shield
		{ "17", { "!player.debuff(6788).any", "!player.buff(17).any", "player.health <= 70" }, "player" }, --Power Word: Shield
		{ "17", { "!lowest.debuff(6788).any", "!lowest.buff(17).any", "lowest.health <= 40" }, "lowest" }, --Power Word: Shield

	-- renew
		{ "139", {"!focus.buff(139)", "focus.spell(139).range"}, "focus" }, --renew
		{ "139", {"!tank.buff(139)", "tank.spell(139).range"}, "tank" }, --renew
		{ "139", {"player.health < 85", "!player.buff(139)"}, "player" }, --renew
		{ "139", {"lowest.health < 85", "!lowest.buff(139)"}, "lowest" }, --renew

	-- Prayer of Mending
		{ "33076", {"focus.health < 99", "focus.spell(33076).range"}, "focus" }, --Prayer of Mending
		{ "33076", {"tank.health < 99", "tank.spell(33076).range"}, "tank" }, --Prayer of Mending

	-- binding heal
		{ "32546", { "focus.health < 99", "player.health <= 60", "focus.spell(32546).range"}, "focus" }, --binding heal
		{ "32546", { "tank.health < 99", "player.health <= 60", "tank.spell(32546).range"}, "tank" }, --binding heal
		{ "32546", { "lowest.health < 99", "player.health < 60"}, "lowest" }, --binding heal

	-- heal
		{ "2060", {"focus.health <= 95", "focus.spell(2060).range"}, "focus" }, -- Heal
		{ "2060", {"tank.health <= 95", "tank.spell(2060).range"}, "tank" }, -- Heal
		{ "2060", "lowest.health <= 95", "lowest" }, -- Heal	

}

local inCombatSolo = {

  	-- Auto Target
		{ "/target [target=focustarget, harm, nodead]", { "toggle.autotarget", "target.range > 40" }}, -- Use Tank Target
		{ "/targetenemy [noexists]", { "toggle.autotarget", "!target.exists" }}, -- target enemire if no target
		{ "/targetenemy [dead]", { "toggle.autotarget", "target.exists", "target.dead" }}, -- target enemire if current is dead.
	
	-- Mana
		{ "123040", { "player.mana < 75","target.spell(123040).range" }, "target" }, --Mindbender
		{ "34433", { "player.mana < 75", "target.spell(34433).range" }, "target" }, --Shadowfiend

	-- LoOk aT It GOoZ!!!
		{ "121536", {"player.movingfor > 2", "toggle.feather", "!player.buff(121557)", "player.spell(121536).charges >= 1" }, "player.ground" },

	-- Heal
		{ "17", { "!player.debuff(6788).any", "!player.buff(17).any", "player.health <= 60" }}, --Power Word Shield
		{ "2061", "player.health <= 35", "Player" }, --Flash Heal

  	--DPS
  		{ "32379", {"target.health < 20","target.spell(32379).range" }, "target" }, -- Shadow Word: Death
		{ "589", { "target.debuff(589).duration < 2","target.spell(589).range"}, "target" }, --Shadow Word:Pain
		{ "129250", { "target.spell(129250).range" }, "target" }, -- Power Word: Solace
		{ "14914", { "target.spell(14914).range" }, "target" }, --Holy Fire
		{ "585", "target.spell(585).range", "target" },	--Smite

}

local outCombat = {

	--Heal
		-- AoE
			{ "596", { "!player.moving", "@coreHealing.needsHealing(90, 3)", "modifier.party" }, "lowest" }, --Prayer of Healing
			{ "34861", "@coreHealing.needsHealing(90, 3)", "lowest"}, -- Circle of Healing
		
		-- shields 
			{ "17", { "!focus.debuff(6788).any", "focus.spell(17).range" }, "focus" }, --Power Word: Shield
			{ "17", { "!tank.debuff(6788).any", "tank.spell(17).range", "modifier.party" }, "tank" }, --Power Word: Shield
	   	
	   	-- heals
			{ "139", { "lowest.health < 99", "!lowest.buff(139)"}, "lowest" }, --renew			
			{ "2061", { "!player.moving", "lowest.health <= 40" }, "lowest" }, --Flash Heal
			{ "2060", "lowest.health <= 95", "tank" }, -- Heal

	-- Mouse Over
		{ "139", { "toggle.mouseOver", "!mouseover.buff" }, "mouseover" }, --renew
		{ "2061", { "toggle.mouseOver", "mouseover.health <= 55", "!player.moving" }, "mouseover" },  --Flash Heal
		{ "2050", { "toggle.mouseOver", "mouseover.health <= 95", "!player.moving" }, "mouseover" }, -- Heal
		
	-- buffs
		{ "21562", {"!player.buff(21562).any","!player.buff(588)"}}, -- Fortitude
	
	-- LoOk aT It GOoZ!!!
		{ "121536", {"player.movingfor > 2", "toggle.feather", "!player.buff(121557)", "player.spell(121536).charges >= 1" }, "player.ground" },

}

ProbablyEngine.rotation.register_custom(257, "|r[|cff9482C9MTS|r][|cffFFFFFFPriest-Holy-Party|r]", inCombat, outCombat, exeOnLoad)
ProbablyEngine.rotation.register_custom(257, "|r[|cff9482C9MTS|r][|cffFFFFFFPriest-Holy-Solo|r]", inCombatSolo, outCombat, exeOnLoad)