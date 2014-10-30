--[[ ///---INFO---////
// Druid Resto //
Thank You For Using My ProFiles
I Hope Your Enjoy Them
MTS
]]


local ignoreDebuffs = {'Mark of Arrogance','Displaced Energy'}

								--[[   !!!Dispell function!!!   ]]
						--[[   Checks is member as debuff and can be dispeled.   ]]
--[[  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ]]
Dispell = function ()
local prefix = (IsInRaid() and 'raid') or 'party'
	for i = -1, GetNumGroupMembers() - 1 do
	local unit = (i == -1 and 'target') or (i == 0 and 'player') or prefix .. i
		if IsSpellInRange("Nature's Cure", unit) then
			for j = 1, 40 do
			local debuffName, _, _, _, dispelType, duration, expires, _, _, _, spellID, _, isBossDebuff, _, _, _ = UnitDebuff(unit, j)
				if dispelType and dispelType == 'Magic' or dispelType == 'curse' then
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

	ProbablyEngine.toggle.create('dispel', 'Interface\\Icons\\Ability_paladin_sacredcleansing.png', 'Dispel Everything', 'Dispels everything it finds \nThis does not effect SoO dispels.')
	mtsStart:message("\124cff9482C9*MrTheSoulz - \124cffFF7D0ADruid/Restoration \124cff9482C9Loaded*")

end	

local Buffs = {

	--	Buffs
		{ "1126", { -- Mark of the Wild
			"!player.buff(20217).any",
			"!player.buff(115921).any",
			"!player.buff(1126).any",
			"!player.buff(90363).any",
			"!player.buff(69378).any",
			"player.form = 0" 
		}, nil },
  
}

local inCombat = {

	--	keybinds
		{ "740" , "modifier.shift" }, -- Tranq
		{ "!/focus [target=mouseover]", "modifier.alt" }, -- Mouseover Focus
		{ "20484", "modifier.control", "mouseover" }, -- Rebirth

	-- Dispel
		{ "88423", { "player.buff(Gift of the Titans)", "@coreHealing.needsDispelled('Mark of Arrogance')" }, nil },
		{ "88423", "@coreHealing.needsDispelled('Shadow Word: Bane')", nil },
		{ "88423", "@coreHealing.needsDispelled('Corrosive Blood')", nil },
		{ "88423", "@coreHealing.needsDispelled('Harden Flesh')", nil },
		{ "88423", "@coreHealing.needsDispelled('Torment')", nil },
		{ "88423", "@coreHealing.needsDispelled('Breath of Fire')", nil },
		{ "88423", {"toggle.dispel", Dispell }},

	-- Cooldowns
		{ "29166", { "player.mana < 80", "modifier.cooldowns"}, "player" }, -- Inervate
		{ "132158", { "player.spell(132158).cooldown = 0", "modifier.cooldowns" }, nil }, -- Nature's Swiftness
		{ "106731" , { "@coreHealing.needsHealing(85, 4)", "modifier.cooldowns" }, nil }, -- Incarnation
	
	-- Survival
		{ "#5512", "player.health < 60" }, --Healthstone
	
	-- AOE
		{ "48438", "@coreHealing.needsHealing(85, 3)", "lowest" }, -- Wildgrowth

	-- Incarnation: Tree of Life	
		{ "8936", { "player.buff(16870)", "!lowest.buff", "lowest.health < 80", "player.buff(33891)" }, "lowest" }, -- Regrowth
		{ "48438", { "@coreHealing.needsHealing(85, 3)", "player.buff(33891)" }, "lowest" }, -- Wildgrowth
		{ "33763", { "!lowest.buff(33763)", "lowest.health < 100", "player.buff(33891)" }, "lowest" }, -- Lifebloom

	-- Clearcasting
		{ "8936", { "!lowest.buff(8936)", "lowest.health < 80", "!player.moving", "player.buff(16870)" }, "lowest" }, -- Regrowth
		{ "5185", { "lowest.health < 80", "!player.moving", "player.buff(16870)" }, "lowest" }, -- Healing Touch

	-- HoTs
		-- Focus
			{ "18562", { "focus.health < 80", "focus.buff(774)" }, "focus" }, -- Swiftmend
			{ "33763", { "focus.buff(33763).duration < 2", "focus.spell(33763).range" }, "focus" }, -- Life Bloom
			{ "774", { "!focus.buff", "focus.health < 95", "focus.spell(774).range" }, "focus" }, -- Rejuvenation

		-- Tank
			{ "18562", { "tank.health < 80", "tank.buff(774)" }, "tank" }, -- Swiftmend
			{ "33763", { "tank.buff(33763).duration < 2", "tank.spell(33763).range" }, "tank" }, -- Life Bloom
			{ "774", { "!tank.buff", "tank.health < 95", "tank.spell(774).range" }, "tank" }, -- Rejuvenation

		-- Noobs
			{ "18562", { "lowest.health < 30", "lowest.buff(774)" }, "focus" }, -- Swiftmend
			{ "774", { "!lowest.buff", "lowest.health < 65" }, "lowest" }, -- Rejuvenation

	-- Heals
		-- Focus
			{ "5185", { "focus.health < 96", "!player.moving" }, "focus" }, -- Healing Touch
			{ "145205", {"focus.health < 100","!player.totem(145205)"}, "focus" }, -- Wild Mushroom

		-- Tank
			{ "5185", { "tank.health < 96", "!player.moving" }, "tank" }, -- Healing Touch
			{ "145205", {"tank.health < 100","!player.totem(145205)"}, "tank" }, -- Wild Mushroom
		
		-- noobs
			{ "8936", { "lowest.health < 50", "!lowest.buff(8936)", "!player.moving" }, "lowest" }, -- Regrowth
			{ "145518", { "!player.spell(18562).cooldown = 0", "lowest.health < 40", "lowest.buff(774)" }, "lowest" }, -- Genesis
			{ "5185", { "lowest.health < 96", "!player.moving" }, "lowest" }, -- Healing Touch

}

local outCombat = {

	--	keybinds
		{ "!/focus [target=mouseover]", "modifier.alt" }, -- Mouseover Focus
		{ "20484", "modifier.control", "mouseover" }, -- Rebirth

	-- Healing
		-- Focus
			{ "33763", { "focus.buff(33763).duration < 2", "focus.spell(33763).range" }, "focus" }, -- Life Bloom

		-- Tank
			{ "33763", { "tank.buff(33763).duration < 2", "modifer.party", "tank.spell(33763).range" }, "tank" }, -- Life Bloom

}

for _, Buffs in pairs(Buffs) do
  inCombat[#inCombat + 1] = Buffs
  outCombat[#outCombat + 1] = Buffs
end

ProbablyEngine.rotation.register_custom(105, "|r[|cff9482C9MTS|r][|cffFF7D0ADruid-Resto|r]", inCombat, outCombat, exeOnLoad)