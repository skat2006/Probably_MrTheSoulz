--[[ ///---INFO---////
// Monk WindWalker //
!Originaly made by Tao!
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
		if IsSpellInRange('Purify', unit) then
			for j = 1, 40 do
			local debuffName, _, _, _, dispelType, duration, expires, _, _, _, spellID, _, isBossDebuff, _, _, _ = UnitDebuff(unit, j)
				if dispelType and dispelType == 'Magic' or dispelType == 'Posion' or dispelType == 'Disease' then
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

	ProbablyEngine.toggle.create('autotarget', 'Interface\\Icons\\ability_hunter_snipershot', 'Auto Target', 'Automatically target the nearest enemy when target dies or does not exist')
	ProbablyEngine.toggle.create('dispel', 'Interface\\Icons\\Ability_paladin_sacredcleansing.png', 'Dispel Everything', 'Dispels everything it finds \nThis does not effect SoO dispels.')
	mtsStart:message("\124cff9482C9*MTS-\124cff00FF96Monk/WW\124cff9482C9-Loaded*")
	mts_showLive()
	
end

local Buffs = {

	-- Buffs
  	{ "116781", {-- Legacy of the White Tiger
      	"!player.buff(116781)",
      	"!player.buff(17007)",
      	"!player.buff(1459)",
      	"!player.buff(61316)",
      	"!player.buff(24604)",
      	"!player.buff(90309)",
      	"!player.buff(126373)",
      	"!player.buff(126309)"}},
  	{ "117666", {-- Legacy of the Emperor
      	"!player.buff(117666)",
      	"!player.buff(1126)",
      	"!player.buff(20217)",
      	"!player.buff(90363)"}},

}

							-- [[ !!!Stance of the Wise Serpent!!!]]
--[[!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!]]
local inCombatSerpente = {

	-- Keybinds
		{"101546", "modifier.shift"}, -- Spinning Crane Kick
  		{ "115313" , "modifier.control", "tank.ground" },-- Summon Jade Serpent Statue
  
  	-- Interrupt
  		{ "116705", "modifier.interrupts" },

	-- Dispel
		{ "115450", { "player.buff(Gift of the Titans)", "@coreHealing.needsDispelled('Mark of Arrogance')" }, nil },
		{ "115450", "@coreHealing.needsDispelled('Shadow Word: Bane')", nil },
		{ "115450", "@coreHealing.needsDispelled('Corrosive Blood')", nil },
		{ "115450", "@coreHealing.needsDispelled('Harden Flesh')", nil },
		{ "115450", "@coreHealing.needsDispelled('Torment')", nil },
		{ "115450", "@coreHealing.needsDispelled('Breath of Fire')", nil },
		{ "115450", { "toggle.dispel", Dispell }, nil },

	-- Cooldowns
  		{ "116849", "lowest.health <= 25" },-- Life Coccon

	-- Give me Mana
		{ "115294", { "player.mana < 95", "player.buff(115867).count >= 2" }}, -- mana tea

	-- AoE
		{ "115310", "@coreHealing.needsHealing(50, 9)", nil }, -- Revival
  		{ "116680", {"@coreHealing.needsHealing(80, 3)", "player.chi >= 3", "!player.buff(116680)"}},-- Uplift with Thunder Focus Tea Condition

	-- Single target
		-- Focus
			{ "124682", { "focus.chi >= 3","focus.health < 90","player.casting(Soothing Mist)" }, "focus" }, -- Enveloping Mist
			{ "116694", { "player.casting(Soothing Mist)", "focus.health <= 99" }, "focus" }, -- Surging Mist
		
		-- Tank
			{ "124682", { "player.chi >= 3","tank.health < 90","player.casting(Soothing Mist)" }, "tank" }, -- Enveloping Mist 
			{ "116694", { "player.casting(Soothing Mist)", "tank.health <= 99" }, "tank" }, -- Surging Mist

		-- Player
			{"115072", "player.health < 70", "player"},--Expel Harm

		-- Noobs
			{ "124682", { "player.casting(115175)", "player.chi >= 3", "lowest.health < 90" }, "lowest" }, -- Enveloping Mist
			{ "115151", { "lowest.buff(119611).duration <= 2", "lowest.health < 100"}, "lowest"}, -- Renewing Mist
			{ "116694", { "player.casting(Soothing Mist)", "lowest.health <= 95", "!lowest.buff(119611)"}, "lowest" }, -- Surging Mist 

	-- Soothing Mist
	  	{ "115175", {"lowest.health < 100", "!player.moving"}, "lowest" },

	

}

								-- [[ !!!Stance of the Spirited Crane!!!]]
--[[!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!]]

local inCombatCrane = {

	-- Auto Target
		{ "/target [target=focustarget, harm, nodead]", {"target.range > 40", "!target.exists","toggle.autotarget"} },
		{ "/targetenemy [noexists]", { "toggle.autotarget", "!target.exists" }},
   		{ "/targetenemy [dead]", { "toggle.autotarget", "target.exists", "target.dead" }},

}

local outCombat = {

	-- Keybinds
		{"101546", "modifier.shift"}, -- Spinning Crane Kick
  		{ "115313" , "modifier.control", "tank.ground" },-- Summon Jade Serpent Statue

	-- heals
		{ "115151", { "lowest.buff(119611).duration <= 2", "lowest.health < 100"}, "lowest"}, -- Renewing Mist
		{ "115175", {"lowest.health < 100", "!player.moving"}, "lowest" }, -- Soothing Mist

}
 
for _, Buffs in pairs(Buffs) do
  inCombatSerpente[#inCombatSerpente + 1] = Buffs
  inCombatCrane[#inCombatCrane + 1] = Buffs
  outCombat[#outCombat + 1] = Buffs
end

ProbablyEngine.rotation.register_custom(270, mts_Icon.."|r[|cff9482C9MTS|r][|cff00FF96Monk-WindWalker|r]", {
	{ inCombatSerpente, "player.stance = 1" },
	{ inCombatCrane, "player.stance = 2" },
},  outCombat, exeOnLoad)