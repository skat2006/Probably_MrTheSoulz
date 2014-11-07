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
	mtsStart:message("\124cff9482C9*MTS-\124cffFFFFFFPriest/Holy\124cff9482C9-Loaded*")
	mts_showLive()

end

local inCombat = {
	
  	--keybinds
		{ "32375", "modifier.rcontrol", "player.ground" }, --Mass Dispel
	 	{ "48045", "modifier.ralt", "tank" }, -- Mind Sear
		{ "120517", "modifier.lcontrol", "player" }, --Halo
		{ "110744", "modifier.lcontrol", "player" }, --Divine Star
	
	-- LoOk aT It GOoZ!!! // Needs to add tank...
		{ "121536", {"player.movingfor > 2", "@mtsLib.getConfig('mtsconfPriestHoly','Feathers')", "!player.buff(121557)", "player.spell(121536).charges >= 1" }, "player.ground" },
	
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
	 	{ "527", {"@mtsLib.getConfig('mtsconfPriestHoly','Dispels')", Dispell }},

  	-- CD's
		{ "10060", "modifier.cooldowns" }, --Power Infusion
		{ "123040", {"player.mana < 75", "target.spell(123040).range", "modifier.cooldowns"}, "target" }, --Mindbender
	
	-- Use on cd
		{ "34861", "@coreHealing.needsHealing(95, 3)", "lowest"}, -- Circle of Healing
		{ "121135", {"@coreHealing.needsHealing(95, 3)", "!player.moving"}, "lowest"}, -- cascade

	-- Proc's
		{ "596", {"lowest.health < 100","player.buff(123267)","!player.moving","modifier.party", "!modifier.raid"}, "lowest" }, -- Prayer of healing // Divine Insigt
		{ "2061", {"lowest.health < 100","player.buff(114255)","!player.moving"}, "lowest" }, -- Flash heal // Surge of light

	-- Player dead (Spirit)
		{ "88684", {"lowest.health <= 80", "player.buff(27827)"}, "lowest" }, -- Holy Word Serenity
		{ "2061", {"lowest.health < 100", "player.buff(27827)"}, "lowest" }, --Flash Heal
		{ "34861", {"@coreHealing.needsHealing(95, 3)", "player.buff(27827)"}, "lowest"}, -- Circle of Healing
		{ "121135", {"@coreHealing.needsHealing(95, 3)", "player.buff(27827)"}}, -- cascade
		{ "596", { "@coreHealing.needsHealing(95, 3)", "player.buff(27827)","modifier.party", "!modifier.raid" }, "lowest" }, --Prayer of Healing

	-- Heal Fast Bitch!!
		-- Desperate Prayer
			{ "19236", "@mtsLib.Compare('health','mtsconfPriestHoly','DesperatePrayer','player')", "player" }, --Desperate Prayer

		-- Holy Word Serenity
			{ "88684", {"@mtsLib.Compare('health','mtsconfPriestHoly','HolyWordSerenityTank','focus')", "focus.spell(88684).range"}, "focus" }, -- Holy Word Serenity
			{ "88684", {"tank.health <= 90", "tank.spell(88684).range"}, "tank" }, -- Holy Word Serenity
			{ "88684", "@mtsLib.Compare('health','mtsconfPriestHoly','HolyWordSerenityPlayer','player')", "player" }, -- Holy Word Serenity
			{ "88684", "lowest.health <= 60", "lowest" }, -- Holy Word Serenity

		-- Flash Heal
			{ "2061", {"@mtsLib.Compare('health','mtsconfPriestHoly','FlashHealTank','focus')", "focus.spell(2061).range","!player.moving"}, "focus" }, --Flash Heal
			{ "2061", {"tank.health <= 40", "tank.spell(2061).range","!player.moving"}, "tank" }, --Flash Heal
			{ "2061", {"@mtsLib.Compare('health','mtsconfPriestHoly','FlashHealPlayer','player')","!player.moving"}, "player" }, --Flash Heal
			{ "2061", {"lowest.health <= 20","!player.moving"}, "lowest" }, --Flash Heal

	-- AOE
   		-- Prayer of Healing
   			{ "596", { "modifier.lshift", "!player.moving" }, "mouseover" }, --Prayer of Healing // Raid WorkAround.
   			{ "596", { "@coreHealing.needsHealing(85, 3)", "modifier.party", "!modifier.raid", "!player.moving" }, "lowest" }, --Prayer of Healing
		
		-- Divine Hymn
			{ "64843", { "@coreHealing.needsHealing(50, 3)", "modifier.party" }}, -- Divine Hymn
			{ "64843", { "@coreHealing.needsHealing(60, 5)", "modifier.raid", "!modifier.members > 10" }}, -- Divine Hymn
			{ "64843", { "@coreHealing.needsHealing(60, 8)", "modifier.raid", "modifier.members > 10" }}, -- Divine Hymn

	-- shields
		{ "17", { "@mtsLib.Compare('health','mtsconfPriestHoly','ShieldTank','focus')", "!focus.debuff(6788).any", "focus.spell(17).range", "focus.spell(17).range" }, "focus" }, --Power Word: Shield
		{ "17", { "!tank.debuff(6788).any", "tank.spell(17).range", "tank.spell(17).range" }, "tank" }, --Power Word: Shield
		{ "17", { "@mtsLib.Compare('health','mtsconfPriestHoly','ShieldPlayer','player')", "!player.debuff(6788).any", "!player.buff(17).any" }, "player" }, --Power Word: Shield
		{ "17", { "!lowest.debuff(6788).any", "!lowest.buff(17).any", "lowest.health <= 40" }, "lowest" }, --Power Word: Shield

	-- renew
		{ "139", {"@mtsLib.Compare('health','mtsconfPriestHoly','RenewTank','focus')","!focus.buff(139)", "focus.spell(139).range"}, "focus" }, --renew
		{ "139", {"!tank.buff(139)", "tank.spell(139).range"}, "tank" }, --renew
		{ "139", {"@mtsLib.Compare('health','mtsconfPriestHoly','RenewPlayer','player')", "player.health < 85", "!player.buff(139)"}, "player" }, --renew
		{ "139", {"lowest.health < 85", "!lowest.buff(139)"}, "lowest" }, --renew

	-- Prayer of Mending
		{ "33076", {"@mtsLib.Compare('health','mtsconfPriestHoly','PrayerofMendingTank','focus')", "focus.spell(33076).range","!player.moving"}, "focus" }, --Prayer of Mending
		{ "33076", {"tank.health < 99", "tank.spell(33076).range","!player.moving"}, "tank" }, --Prayer of Mending

	-- binding heal
		{ "32546", { "@mtsLib.Compare('health','mtsconfPriestHoly','BindingHealTank','focus')", "focus.health < 99", "focus.spell(32546).range","!player.moving"}, "focus" }, --binding heal
		{ "32546", { "tank.health < 99", "player.health <= 60", "tank.spell(32546).range","!player.moving"}, "tank" }, --binding heal
		{ "32546", { "lowest.health < 99", "player.health < 60","!player.moving"}, "lowest" }, --binding heal

	-- heal
		{ "2060", {"@mtsLib.Compare('health','mtsconfPriestHoly','HealTank','focus')", "focus.spell(2060).range","!player.moving"}, "focus" }, -- Heal
		{ "2060", {"tank.health <= 95", "tank.spell(2060).range","!player.moving"}, "tank" }, -- Heal
		{ "2060", {"@mtsLib.Compare('health','mtsconfPriestHoly','HealPlayer','player')","!player.moving"}, "player" }, -- Heal	
		{ "2060", {"lowest.health <= 95","!player.moving"}, "lowest" }, -- Heal	

}

local outCombat = {

	--Heal
		-- AoE
			{ "596", { "!player.moving", "@coreHealing.needsHealing(90, 3)", "modifier.party" }, "lowest" }, --Prayer of Healing
			{ "34861", "@coreHealing.needsHealing(90, 3)", "lowest"}, -- Circle of Healing
		
		-- shields 
			{ "17", { "@mtsLib.Compare('health','mtsconfPriestHoly','ShieldTank','focus')", "!focus.debuff(6788).any", "focus.spell(17).range", "focus.spell(17).range" }, "focus" }, --Power Word: Shield
			{ "17", { "!tank.debuff(6788).any", "tank.spell(17).range", "modifier.party" }, "tank" }, --Power Word: Shield
	   	
	   	-- heals
			{ "139", { "lowest.health < 99", "!lowest.buff(139)"}, "lowest" }, --renew			
			{ "2061", { "!player.moving", "lowest.health <= 40" }, "lowest" }, --Flash Heal
			{ "2060", "lowest.health <= 95", "lowest" }, -- Heal

	-- Mouse Over
		{ "139", { "toggle.mouseOver", "!mouseover.buff" }, "mouseover" }, --renew
		{ "2061", { "toggle.mouseOver", "mouseover.health <= 55", "!player.moving" }, "mouseover" },  --Flash Heal
		{ "2050", { "toggle.mouseOver", "mouseover.health <= 95", "!player.moving" }, "mouseover" }, -- Heal
		
	-- buffs
		{ "21562", {"!player.buff(21562).any","!player.buff(588)"}}, -- Fortitude
	
	-- LoOk aT It GOoZ!!!
		{ "121536", {"player.movingfor > 2", "@mtsLib.getConfig('mtsconfPriestHoly','Feathers')", "!player.buff(121557)", "player.spell(121536).charges >= 1" }, "player.ground" },

}

ProbablyEngine.rotation.register_custom(257, mts_Icon.."|r[|cff9482C9MTS|r][|cffFFFFFFPriest-Holy-Party|r]", inCombat, outCombat, exeOnLoad)