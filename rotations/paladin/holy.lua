-- ///////////////////-----------------------------------------INFO-----------------------------------//////////////////////////////
--														 //Paladin Holy//
--												  Thank Your For Your My ProFiles
--													  I Hope Your Enjoy Them
--															    MTS

local ignoreDebuffs = {'Mark of Arrogance','Displaced Energy'}

							--[[   !!!Dispell function!!!   ]]
						--[[   Checks is member as debuff and can be dispeled.   ]]
--[[  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ]]
Dispell = function ()
local prefix = (IsInRaid() and 'raid') or 'party'
	for i = -1, GetNumGroupMembers() - 1 do
	local unit = (i == -1 and 'target') or (i == 0 and 'player') or prefix .. i
		if IsSpellInRange('Cleanse', unit) then
			for j = 1, 40 do
			local debuffName, _, _, _, dispelType, duration, expires, _, _, _, spellID, _, isBossDebuff, _, _, _ = UnitDebuff(unit, j)
				if dispelType and dispelType == 'Magic' or dispelType == 'Poison' or dispelType == 'Disease' then
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

local lib = function()
	
	ProbablyEngine.toggle.create('dispel', 'Interface\\Icons\\Ability_paladin_sacredcleansing.png', 'Dispel Everything', 'Dispels everything it finds \nThis does not effect SoO dispels.')
	ProbablyEngine.toggle.create('buff', 'Interface\\Icons\\spell_magic_greaterblessingofkings.png', 'Buffs', 'Enable for Blessing of Kings. \nDisable for Blessing of Might.')
	mtsStart:message("\124cff9482C9*MTS-\124cffF58CBAPaladin/Holy-\124cff9482C9Loaded*")
	mts_showLive()
	
end

local Shared = {

	-- Buffs
		{ "19740", { -- Blessing of Might
			"!player.buff(19740).any", 
			"!player.buff(116956).any", 
			"!player.buff(93435).any", 
			"!player.buff(128997).any", 
			"!toggle.buff" }}, 
		{ "20217", { -- Blessing of Kings
			"!player.buff(20217).any",
			"!player.buff(115921).any", 
			"!player.buff(1126).any", 
			"!player.buff(90363).any", 
			"!player.buff(69378).any",
			"toggle.buff" }}, 
	
	-- Seals
		{ "20165", "player.seal != 3" }, -- Seal of Insight


}

local inCombat = {
	
	--Racials
        -- Dwarves
			{ "20594", "player.health <= 65" },
		-- Humans
			{ "59752", "player.state.charm" },
			{ "59752", "player.state.fear" },
			{ "59752", "player.state.incapacitate" },
			{ "59752", "player.state.sleep" },
			{ "59752", "player.state.stun" },
		-- Draenei
			{ "28880", "player.health <= 70", "player" },
		-- Gnomes
			{ "20589", "player.state.root" },
			{ "20589", "player.state.snare" },
		-- Forsaken
			{ "7744", "player.state.fear" },
			{ "7744", "player.state.charm" },
			{ "7744", "player.state.sleep" },
		-- Goblins
			{ "69041", "player.moving" },

	-- keybinds
		{ "114158", {"modifier.shift", "@mtsLib.CanFireHack()"}, "target.ground"}, -- Light´s Hammer // FH
		{ "114158", "modifier.shift", "ground"}, -- Light´s Hammer // FH
		{ "!/focus [target=mouseover]", "modifier.alt" }, -- Mouseover Focus

	-- Mana Regen
		{ "28730", "player.mana < 90", nil }, -- Arcane torrent
		{ "54428", "player.mana < 85", nil }, -- Divine Plea
		{ "#trinket1", "player.mana < 85", nil }, -- Trinket 1
		{ "#trinket2", "player.mana < 85", nil }, -- Trinket 2

	-- Tank
		{ "53563", { "!tank.buff(53563)", "tank.spell(53563).range" }, "tank" }, -- Beacon of light

	-- Interrupts
		{ "96231", "modifier.interrupts", "target" }, -- Rebuke
		
	-- Hands
		{ "6940", { "tank.spell(6940).range", "tank.health < 40" }, "tank" }, -- Hand of Sacrifice

	-- Survival
		{ "#5512", "player.health <= 45", nil }, -- Healthstone       
		{ "498", "player.health <= 90", "player" }, -- Divine Protection
		{ "642", "player.health <= 20", "player" }, -- Divine Shield

	{{-- Cooldowns
		{ "#gloves" }, -- gloves
		{ "31821", "@coreHealing.needsHealing(40, 5)", nil }, -- Devotion Aura	
		{ "31884", "@coreHealing.needsHealing(95, 4)", nil }, -- Avenging Wrath
		{ "86669", "@coreHealing.needsHealing(85, 4)", nil }, -- Guardian of Ancient Kings
		{ "31842", "@coreHealing.needsHealing(90, 4)", nil }, -- Divine Favor
		{ "105809", "talent(5, 1)", nil }, -- Holy Avenger
	}, "modifier.cooldowns" },
	
	-- Dispel
		{ "4987", { "player.buff(Gift of the Titans)", "@coreHealing.needsDispelled('Mark of Arrogance')" }, nil },
		{ "4987", "@coreHealing.needsDispelled('Shadow Word: Bane')", nil },
		{ "4987", "@coreHealing.needsDispelled('Corrosive Blood')", nil },
		{ "4987", "@coreHealing.needsDispelled('Harden Flesh')", nil },
		{ "4987", "@coreHealing.needsDispelled('Torment')", nil },
		{ "4987", "@coreHealing.needsDispelled('Breath of Fire')", nil },
		{ "4987", { "toggle.dispel", Dispell }, nil },
	
	{{-- Divine Purpose
		{ "85673", "lowest.health <= 80", "lowest"  }, -- Word of Glory
		{ "114163", { "!lowest.buff(114163)", "lowest.health <= 85" }, "lowest" }, -- Eternal Flame
	}, "player.buff(86172)" },
	
	{{-- Selfless Healer
		{ "!/target [target=focustarget, harm, nodead]", "!target.exists" }, -- Target focus target
		{ "20271", "target.spell(20271).range", "target" }, -- Judgment
		{{ -- If got buff
			{ "19750", { "lowest.health < 85", "!lowest.health < 65", "!@coreHealing.needsHealing(95, 4)", "!player.moving" }, "lowest" }, -- Flash of light
			{ "82326", { "lowest.health < 65", "!@coreHealing.needsHealing(95, 4)", "!player.moving" }, "lowest" }, -- Divine Light
			{ "82327", { "@coreHealing.needsHealing(95, 4)", "!player.moving" }, "lowest" }, -- Holy Radiance
		}, "player.buff(114250).count = 3" }
	}, "talent(3, 1)" },		

	-- Infusion of Light
		{ "20473", "lowest.health < 100", "lowest" }, -- Holy Shock
		{ "82326", { "lowest.health < 75", "!@coreHealing.needsHealing(90, 4)", "!player.moving", "player.buff(54149)" }, "lowest" }, -- Divine Light
	
	-- AOE
		-- Party
			{ "85222", { "@coreHealing.needsHealing(90, 3)", "player.holypower >= 3", "modifier.party" }, "lowest" }, -- Light of Dawn
			{ "82327", { "@coreHealing.needsHealing(80, 3)", "!modifier.last", "!player.moving", "modifier.party" }, "lowest" }, -- Holy Radiance - Party
		-- RAID
			{ "85222", { "@coreHealing.needsHealing(90, 5)", "player.holypower >= 3", "modifier.raid", "!modifier.members > 10" }, "lowest" }, -- Light of Dawn
			{ "82327", { "@coreHealing.needsHealing(90, 5)", "!modifier.last", "!player.moving", "modifier.raid", "!modifier.members > 10" }, "lowest" }, -- Holy Radiance - Raid 10
		-- Raid 25
			{ "85222", { "@coreHealing.needsHealing(90, 8)", "player.holypower >= 3", "modifier.members > 10" }, "lowest" }, -- Light of Dawn
			{ "82327", { "@coreHealing.needsHealing(90, 8)", "!modifier.last", "!player.moving", "modifier.members > 10" }, "lowest" }, -- Holy Radiance 10+
	
	-- HEAL FAST BITCH
		{ "633", "lowest.health < 15", "lowest" }, -- Lay on Hands
		{ "85673", { "player.holypower >= 3", "lowest.health <= 80" }, "lowest"  }, -- Word of Glory
		{ "114163", { "player.holypower >= 1", "!lowest.buff(114163)", "lowest.health <= 93" }, "lowest" }, -- Eternal Flame
		{ "Sacred Shield", { "player.spell(Sacred Shield).charges >= 2", "lowest.health < 100", "!lowest.buff(Sacred Shield)" }, "lowest" }, -- Sacred Shield
		{ "19750", { "lowest.health < 30", "!player.moving" }, "lowest" }, -- Flash of light

	-- Dps
		{ "35395", "target.spell(35395).range", "target" }, -- Crusader Strike
		
	-- Tank
		{ "114157", "tank.health < 85", "tank" }, -- Execution Sentence
		{ "114163", { "player.holypower >= 3", "!tank.buff(114163)", "tank.health <= 75" }, "tank" }, -- Eternal Flame
		{ "Sacred Shield", { "player.spell(Sacred Shield).charges >= 2", "tank.health < 100", "!tank.buff(Sacred Shield)", "tank.spell(Sacred Shield).range" }, "tank" }, -- Sacred Shield
		{ "82326", { "tank.health < 65", "tank.spell(82326).range", "!player.moving" }, "tank" }, -- Divine Light
		
	-- Single target
		{ "114165", { "lowest.health < 85", "!player.moving" }, "lowest"}, -- Holy Prism
		{ "635", { "lowest.health < 97", "!lowest.health < 65", "!player.moving" }, "lowest" }, -- Holy Light
		{ "82326", { "lowest.health < 35", "!player.moving" }, "lowest" }, -- Divine Light
  
} 

local outCombat = {
	
	-- keybinds
		{ "114158", {"modifier.shift", "@mtsLib.CanFireHack()"}, "target.ground"}, -- Light´s Hammer // FH
		{ "114158", "modifier.shift", "mouseover.ground"}, -- Light´s Hammer // FH
		{ "!/focus [target=mouseover]", "modifier.alt" }, -- Mouseover Focus

	-- hands
		{ "1044", "player.state.root" }, -- Hand of Freedom

	-- Start
		{ "20473", "lowest.health < 100", "lowest" }, -- Holy Shock

}

for _, Shared in pairs(Shared) do
  inCombat[#inCombat + 1] = Shared
  outCombat[#outCombat + 1] = Shared
end


ProbablyEngine.rotation.register_custom(65, "|r[|cff9482C9MTS|r][|cffF58CBAPaladin-Holy|r]", inCombat, outCombat, lib)