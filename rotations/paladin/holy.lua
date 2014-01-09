-- ///////////////////-----------------------------------------INFO-----------------------------------//////////////////////////////
--														 //Paladin Holy//
--												  Thank Your For Your My ProFiles
--													  I Hope Your Enjoy Them
--															    MTS


local lib = function()
	
-- ///////////////////-----------------------------------------TOGGLES-----------------------------------//////////////////////////////
	ProbablyEngine.toggle.create('dispel', 'Interface\\Icons\\Ability_paladin_sacredcleansing.png', 'Dispel Everything', 'Dispels everything it finds \nThis does not effect SoO dispels.')
	ProbablyEngine.toggle.create('buff', 'Interface\\Icons\\spell_magic_greaterblessingofkings.png', 'Buffs', 'Enable for Blessing of Kings. \nDisable for Blessing of Might.')
	mts:message("\124cff9482C9*MrTheSoulz - \124cffF58CBAPaladin/Holy \124cff9482C9Loaded*")
	
--///////////////////-----------------------------------------COMMANDS-----------------------------------//////////////////////////////
	ProbablyEngine.command.register('mts', function(msg, box)
	local command, text = msg:match("^(%S*)%s*(.-)$")
		
		if command == 'ver' then
			GetVer()
		end
			
	end)

-- ///////////////////-----------------------------------------DISPELS-----------------------------------//////////////////////////////
	
	-- Made by Tao
	local ignoreDebuffs = {
	  'Mark of Arrogance',
	  'Displaced Energy'
	}
	
	ProbablyEngine.library.register('dispell', {
	  Cleanse = function(spell)
		local prefix = (IsInRaid() and 'raid') or 'party'
		for i = -1, GetNumGroupMembers() - 1 do
		  local unit = (i == -1 and 'target') or (i == 0 and 'player') or prefix .. i
		  if IsSpellInRange('cleanse', unit) then
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
	  end})
	
-- ///////////////////-----------------------------------------NOTIFICATIONS-----------------------------------//////////////////////////////
	ProbablyEngine.listener.register("COMBAT_LOG_EVENT_UNFILTERED", function(...)
	local event = select(2, ...)
	local source = select(4, ...)
	local spellId = select(12, ...)
	if source ~= UnitGUID("player") then return false end
	if event == "SPELL_CAST_SUCCESS" then

	-- Keybinds
		if spellId == 114158 then
			mts:message("*Casted Light´s Hammer*")
		end
			
	-- Stuns
		if spellId == 105593 then
			mts:message("*Stunned Target*")
		end
		if spellId == 853 then
			mts:message("*Stunned Target*")
		end
			
	-- Free Yourself
		if spellId == 1044 then
			mts:message("*Casted Hand of Freedom*")
		end

	-- Cooldowns
		if spellId == 633 then
			mts:message("*Casted Lay On Hands*")
		end
		if spellId == 31821 then
					mts:message("*Casted Devotion Aura*")
		end
		if spellId == 31884 then
			mts:message("*Casted Avenging Wrath*")
		end
		if spellId == 86669 then
			mts:message("*Casted Guardian of Ancient Kings*")
		end
		if spellId == 31842 then
			mts:message("*Casted Divine Favor*")
		end
		if spellId == 6940 then
			mts:message("*Casted Hand of Sacrifice*")
		end
		if spellId == 105809 then
			mts:message("*Casted Holy Avenger*")
		end
		
	end
end)

end
-- //////////////////////-----------------------------------------END LIB-----------------------------------//////////////////////////////

local Shared = {

	-- Buffs
		{ "19740", { -- Blessing of Might
			"!player.buff(19740).any",
			"!player.buff(116956).any",
			"!player.buff(93435).any",
			"!player.buff(128997).any",
			"!toggle.buff"
		}, nil },
		{ "20217", { -- Blessing of Kings
			"!player.buff(20217).any",
			"!player.buff(115921).any",
			"!player.buff(1126).any",
			"!player.buff(90363).any",
			"!player.buff(69378).any",
			"toggle.buff"
		}, nil },
	
	-- Seals
		{ "20165", "player.seal != 3" }, -- Seal of Insight
	
	-- Mana Regen
		{ "28730", "player.mana < 90", nil }, -- Arcane torrent
		{ "54428", "player.mana < 85", nil }, -- Divine Plea
		{ "#trinket1", "player.mana < 85", nil }, -- Trinket 1
		{ "#trinket2", "player.mana < 85", nil }, -- Trinket 2
		
	-- Hands
		{ "1044", "player.state.root" }, -- Hand of Freedom
	
	-- keybinds
		{ "114158", "modifier.shift", "ground"}, -- Light´s Hammer
		{ "!/focus [target=mouseover]", "modifier.alt" }, -- Mouseover Focus
		
}
-- ////////////////////////-----------------------------------------END SHARED-----------------------------------//////////////////////////////

local inCombat = {
	
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
		{ "31842", "@coreHealing.needsHealing(90, 4", nil }, -- Divine Favor
		{ "105809", "talent(13)", nil }, -- Holy Avenger
	}, "modifier.cooldowns" },
	
	-- Dispel
		{ "4987", { "player.buff(Gift of the Titans)", "@coreHealing.needsDispelled('Mark of Arrogance')" }, nil },
		{ "4987", "@coreHealing.needsDispelled('Shadow Word: Bane')", nil },
		{ "4987", "@coreHealing.needsDispelled('Corrosive Blood')", nil },
		{ "4987", "@coreHealing.needsDispelled('Harden Flesh')", nil },
		{ "4987", "@coreHealing.needsDispelled('Torment')", nil },
		{ "4987", "@coreHealing.needsDispelled('Breath of Fire')", nil },
		{ "4987", { "toggle.dispel", "@dispell.Cleanse()" }, nil },
	
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
	}, "talent(7)" },		

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
		{ "20925", { "spell.charges(20925) >= 2", "lowest.health < 90", "!lowest.buff(148039)", "lowest.spell(20925).range", "!modifier.last" }, "lowest" }, -- Sacred Shield
		{ "19750", { "lowest.health < 30", "!player.moving" }, "lowest" }, -- Flash of light

	-- Dps
		{ "35395", "target.spell(35395).range", "target" }, -- Crusader Strike
		
	-- Tank
		{ "53563", { "!tank.buff(53563)", "tank.spell(53563).range" }, "tank" }, -- Beacon of light
		{ "114157", "tank.health < 85", "tank" }, -- Execution Sentence
		{ "114163", { "player.holypower >= 3", "!tank.buff(114163)", "tank.health <= 75" }, "tank" }, -- Eternal Flame
		{ "20925", { "spell.charges(20925) >= 1", "tank.health < 95", "!tank.buff(148039)", "tank.spell(20925).range", "!modifier.last" }, "tank" }, -- Sacred Shield
		{ "82326", { "tank.health < 65", "tank.spell(82326).range", "!player.moving" }, "tank" }, -- Divine Light
		
	-- Single target
		{ "114165", { "lowest.health < 85", "!player.moving" }, "lowest"}, -- Holy Prism
		{ "635", { "lowest.health < 97", "!lowest.health < 65", "!player.moving" }, "lowest" }, -- Holy Light
		{ "82326", { "lowest.health < 35", "!player.moving" }, "lowest" }, -- Divine Light
  
} -- ///////////////////-----------------------------------------END IN-COMBAT-----------------------------------//////////////////////////////

local outCombat = {
 
	-- Tank
		{ "53563", { "!tank.buff(53563)", "tank.spell(53563).range" }, "tank" }, -- Beacon of light

	-- Healing
		{ "20473", "lowest.health < 100", "lowest" }, -- Holy Shock	
  
}-- ///////////////////-----------------------------------------END OUT-OF-COMBAT-----------------------------------//////////////////////////////

for _, Shared in pairs(Shared) do
  inCombat[#inCombat + 1] = Shared
  outCombat[#outCombat + 1] = Shared
end

ProbablyEngine.rotation.register_custom(65, "|r[|cff9482C9MTS|r][|cffF58CBAPaladin|r-Holy|r]", inCombat, outCombat, lib)