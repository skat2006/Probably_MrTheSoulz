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
Dispell = function()
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

	ProbablyEngine.toggle.create( 'painSup', 'Interface\\Icons\\Spell_holy_painsupression.png', 'Pain Suppression', 'Toggle Enables Pain Suppression')
	ProbablyEngine.toggle.create( 'mouseOver', 'Interface\\Icons\\Priest_spell_leapoffaith_a', 'MouseOver Heal', 'Toggle Mouse-Over Healing')
	mtsStart:message("\124cff9482C9*MTS-\124cffFFFFFFPriest/Disc\124cff9482C9-Loaded*")
	mts_showLive()

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
		{ "/target [target=focustarget, harm, nodead]", { "@mtsLib.getConfig('mtsconfPriestDisc','AutoTargets')", "target.range > 40" }}, -- Use Tank Target
		{ "/targetenemy [noexists]", { "@mtsLib.getConfig('mtsconfPriestDisc','AutoTargets')", "!target.exists" }}, -- target enemire if no target
		{ "/targetenemy [dead]", { "@mtsLib.getConfig('mtsconfPriestDisc','AutoTargets')", "target.exists", "target.dead" }}, -- target enemire if current is dead.

   	-- buffs
		{ "81700", "player.buff(81661).count = 5" },--Archangel
	
	-- LoOk aT It GOoZ!!! // Needs to add tank...
		{ "121536", {"player.movingfor > 2", "@mtsLib.getConfig('mtsconfPriestDisc','Feathers')", "!player.buff(121557)", "player.spell(121536).charges >= 1" }, "player.ground" },
	
	-- Mouse Over
		{ "139", { "toggle.mouseOver", "!mouseover.buff" }, "mouseover" }, --renew
		{ "47540", { "toggle.mouseOver", "mouseover.health <= 85", "!player.moving" }, "mouseover" }, --Penance
		{ "2061", { "toggle.mouseOver", "mouseover.health <= 55", "!player.moving" }, "mouseover" },  --Flash Heal
		{ "2050", { "toggle.mouseOver", "mouseover.health <= 95", "!player.moving" }, "mouseover" }, -- Heal

  	-- Mana/Survival
		{ "123040", {"player.mana < 75","target.spell(123040).range"}, "target" }, --Mindbender
		{ "34433", {"player.mana < 75","target.spell(34433).range"}, "target" }, --Shadowfiend
		{ "19236", {"player.health <= 20" }, "Player" }, --Desperate Prayer

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
	 	{ "527", {"@mtsLib.getConfig('mtsconfPriestDisc','Dispels')", Dispell}},

  	-- CD's
		{ "10060", "modifier.cooldowns" }, --Power Infusion
		{ "33206", { "toggle.painSup", "lowest.health <= 25 " }, "lowest" }, --Pain Suppression
	
	-- For Archangel
		{ "14914", { "!toggle.mouseOver", "player.mana > 20","target.spell(14914).range" }, "target" }, --Holy Fire

	-- Surge of light
		{ "2061", {"lowest.health < 100","player.buff(114255)","!player.moving"}, "lowest" }, -- Flash Heal

	-- Flash Heal
		{ "2061", {"@mtsLib.Compare('health','mtsconfPriestDisc','FlashHealTank','focus')", "focus.spell(2061).range","!player.moving"}, "focus" }, --Flash Heal
		{ "2061", {"tank.health <= 40", "tank.spell(2061).range","!player.moving"}, "tank" }, --Flash Heal
		{ "2061", {"@mtsLib.Compare('health','mtsconfPriestDisc','FlashHealPlayer','player')","!player.moving"}, "player" }, --Flash Heal
		{ "2061", {"lowest.health <= 20","!player.moving"}, "lowest" }, --Flash Heal

	-- AOE
   		-- Holy nova
   			{ "132157", "modifier.multitarget" }, -- Holy Nova

   		-- Prayer of Healing
   			{ "596", {"player.buff(109964)","player.buff(109964).duration > 2.5","!player.moving"}, "lowest" }, --Prayer of Healing
   			{ "596", { "@coreHealing.needsHealing(80, 3)", "modifier.party", "!modifier.raid", "!player.moving" }, "lowest" }, --Prayer of Healing
   			{ "596", { "modifier.lshift", "!player.moving" }, "mouseover" }, --Prayer of Healing // Raid WorkAround.

   		-- Power word Barrier
			{ "62618", { "@coreHealing.needsHealing(50, 3)", "modifier.party", "!player.moving", "modifier.cooldowns" }, "tank.ground" }, -- Power word Barrier // w/t CD's and on tank
	
	-- shields
		{ "17", { "@mtsLib.Compare('health','mtsconfPriestDisc','ShieldTank','focus')", "!focus.debuff(6788).any", "focus.spell(17).range", "focus.spell(17).range" }, "focus" }, --Power Word: Shield
		{ "17", { "!tank.debuff(6788).any", "tank.spell(17).range", "tank.spell(17).range" }, "tank" }, --Power Word: Shield
		{ "17", { "@mtsLib.Compare('health','mtsconfPriestDisc','ShieldPlayer','player')", "!player.debuff(6788).any", "!player.buff(17).any" }, "player" }, --Power Word: Shield
		{ "17", { "!lowest.debuff(6788).any", "!lowest.buff(17).any", "lowest.health <= 40" }, "lowest" }, --Power Word: Shield
	
	-- Prayer of Mending
		{ "33076", {"@mtsLib.Compare('health','mtsconfPriestDisc','PrayerofMendingTank','focus')", "focus.spell(33076).range","!player.moving"}, "focus" }, --Prayer of Mending
		{ "33076", { "tank.health <= 95", "!player.moving", "tank.spell(17).range" }, "tank" }, --Prayer of Mending

	 --Penance	
		{ "47540", {"lowest.health <= 85","!player.moving"}, "lowest" }, --Penance

	-- heal
		{ "2060", {"@mtsLib.Compare('health','mtsconfPriestDisc','HealTank','focus')", "focus.spell(2060).range","!player.moving"}, "focus" }, -- Heal
		{ "2060", {"tank.health <= 90", "tank.spell(2060).range","!player.moving"}, "tank" }, -- Heal
		{ "2060", {"@mtsLib.Compare('health','mtsconfPriestDisc','HealPlayer','player')","!player.moving"}, "player" }, -- Heal	
		{ "2060", {"lowest.health <= 90","!player.moving"}, "lowest" }, -- Heal	

	--Attonement 
		{ "47540", { "player.mana > 20", "target.spell(47540).range", "!player.moving" }, "target" }, --Penance
		{ "585", { "player.mana > 20", "!player.moving", "target.spell(585).range" }, "target" }, --Smite

}

local inCombatSolo = {

  	-- Auto Targets
		{ "/target [target=focustarget, harm, nodead]", { "@mtsLib.getConfig('mtsconfPriestDisc','AutoTargets')", "target.range > 40" }}, -- Use Tank Target
		{ "/targetenemy [noexists]", { "@mtsLib.getConfig('mtsconfPriestDisc','AutoTargets')", "!target.exists" }}, -- target enemire if no target
		{ "/targetenemy [dead]", { "@mtsLib.getConfig('mtsconfPriestDisc','AutoTargets')", "target.exists", "target.dead" }}, -- target enemire if current is dead.
	
	-- Mana
		{ "123040", { "player.mana < 75","target.spell(123040).range" }, "target" }, --Mindbender
		{ "34433", { "player.mana < 75", "target.spell(34433).range" }, "target" }, --Shadowfiend

	-- LoOk aT It GOoZ!!!
		{ "121536", {"player.movingfor > 2", "@mtsLib.getConfig('mtsconfPriestDisc','Feathers')", "!player.buff(121557)", "player.spell(121536).charges >= 1" }, "player.ground" },

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
		-- AoE
			{ "596", { "!player.moving", "@coreHealing.needsHealing(90, 3)" }, "lowest" }, --Prayer of Healing
		
		-- Shields
			{ "17", { "!focus.debuff(6788).any", "focus.spell(17).range" }, "focus" }, --Power Word: Shield
	    	{ "17", { "!tank.debuff(6788).any", "tank.spell(17).range", "modifier.party" }, "tank" }, --Power Word: Shield
	   
	   	-- Heals
			{ "47540", { "lowest.health <= 85", "!player.moving" }, "lowest" }, --Penance
			{ "2061", { "!player.moving", "lowest.health <= 75" }, "lowest" }, --Flash Heal

	-- Mouse Over
		{ "139", { "toggle.mouseOver", "!mouseover.buff" }, "mouseover" }, --renew
		{ "47540", { "toggle.mouseOver", "mouseover.health <= 85", "!player.moving" }, "mouseover" }, --Penance
		{ "2061", { "toggle.mouseOver", "mouseover.health <= 55", "!player.moving" }, "mouseover" },  --Flash Heal
		{ "2050", { "toggle.mouseOver", "mouseover.health <= 95", "!player.moving" }, "mouseover" }, -- Heal
		
	-- buffs
		{ "21562", {"!player.buff(21562).any","!player.buff(588)"}}, -- Fortitude
		{ "81700", "player.buff(81661).count = 5", "player.buff(81661).duration < 5" },--Archangel
	
	-- LoOk aT It GOoZ!!!
		{ "121536", {"player.movingfor > 2", "@mtsLib.getConfig('mtsconfPriestDisc','Feathers')", "!player.buff(121557)", "player.spell(121536).charges >= 1" }, "player.ground" },

}

ProbablyEngine.rotation.register_custom(256, mts_Icon.."|r[|cff9482C9MTS|r][|cffFFFFFFPriest-Disc-Party|r]", inCombat, outCombat, exeOnLoad)
ProbablyEngine.rotation.register_custom(256, mts_Icon.."|r[|cff9482C9MTS|r][|cffFFFFFFPriest-Disc-Solo|r]", inCombatSolo, outCombat, exeOnLoad)