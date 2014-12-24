
local ignoreDebuffs = {'Mark of Arrogance','Displaced Energy'}

								--[[   !!!Dispell function!!!   ]]
						--[[   Checks is member as debuff and can be dispeled.   ]]
--[[  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ]]
local function Dispell()
local prefix = (IsInRaid() and 'raid') or 'party'
	for i = -1, GetNumGroupMembers() - 1 do
	local unit = (i == -1 and 'target') or (i == 0 and 'player') or prefix .. i
		if IsSpellInRange('Purify Spirit', unit) then
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

local lib = function()
mts_Splash("|cff9482C9[MTS]-|cffFFFFFF"..(select(2, GetSpecializationInfo(GetSpecialization())) or "Error").."-|cff9482C9Loaded", 5.0)

  	ProbablyEngine.toggle.create('dispel', 'Interface\\Icons\\Ability_paladin_sacredcleansing.png', 'Dispel Everything', 'Dispels everything it finds \nThis does not effect SoO dispels.')
  	
end

local inCombat = {
  
  	-- Keybinds
  		{ "Healing Rain", { "modifier.shift", "!player.buff(Ascendance)"}, "ground"},

  	-- Interrupt
  		{ "Wind Shear", "modifier.interrupt" },

  	-- Survival
  		{ "Windwalk Totem", { "toggle.survival", "!player.buff", "player.state.root" }, "player" }, 
  		{ "Windwalk Totem", { "toggle.survival", "!player.buff", "player.state.snare" }, "player" }, 

  	-- Buffs
    	{ "Water Shield", "!player.buff(Water Shield)" },

  	-- Dispel's
	    { "77130", {"player.debuff(146595)","@coreHealing.needsDispelled('Mark of Arrogance')"}, nil },
	    { "77130", "@coreHealing.needsDispelled('Corrosive Blood')", nil },
	 	{ "77130", "@coreHealing.needsDispelled('Harden Flesh')", nil },
	 	{ "77130", "@coreHealing.needsDispelled('Torment')", nil },
	 	{ "77130", "@coreHealing.needsDispelled('Breath of Fire')", nil },
		{{ -- Dispell all?
			{ "77130", (function() return Dispell() end) },-- Dispel Everything
		}, "toggle.dispel" },

  	-- Heal Fast Bitch
   		{ "Ascendance", { 
			"@coreHealing.needsHealing(45,10)", 
			"!player.buff(Ascendance)", 
			"modifier.cooldowns"
			}},
    	{ "Spirit Link Totem", {  
			"player.buff(Ascendance)", 
			"modifier.cooldowns"
			}},
   
    -- Focus
    	{ "Earth Shield", { 
			"!focus.buff(Earth Shield)", 
			"focus.range <= 40" 
			}, "focus" },
	    { "Riptide", { 
			"focus.buff(Riptide).duration <= 3", 
			"focus.range <= 40" 
			}, "focus" },

	-- Tank
		{ "Earth Shield", { 
			"!tank.buff(Earth Shield)", 
			"tank.range <= 40" 
			}, "tank" },
	    { "Riptide", { 
			"tank.buff(Riptide).duration <= 3", 
			"tank.range <= 40" 
			}, "tank" },

  	-- AoE
  		{ "Chain Heal", { 
			"!player.buff(Tidal Waves)", 
			"@coreHealing.needsHealing(60, 3)" 
			}, "lowest" },
	    { "Chain Heal", "@coreHealing.needsHealing(40, 3)", "lowest" },

  	-- regular healing
	    { "Healing Stream Totem", "@coreHealing.needsHealing(99, 1)" },
	    { "Riptide", {
			"!player.buff(Tidal Waves)",
			"lowest.buff(Riptide).duration <= 3",
			"lowest.range <= 40"
			}, "lowest" },
	    { "Unleash Life", "!player.buff(Unleash Life)" },
	    { "Ancestral Swiftness", { 
			"lowest.health <= 20", 
			"lowest.range <= 40" 
			}, "player" },
	    { "Healing Wave", {
			"player.buff(Ancestral Swiftness)",
			"lowest.range <= 40"
			}, "lowest" },   
	    { "Healing Surge", { 
			"lowest.health <= 20", 
			"lowest.range <= 40"
			}, "lowest" },
	    { "Healing Wave", { 
			"lowest.health <= 85",
			"lowest.range <= 40"
			}, "lowest" },
  
}

local outCombat = {

   	-- Keybinds
   		{ "Healing Rain", { "modifier.shift", "!player.buff(Ascendance)"}, "ground"},
  
  	-- Buffs
    	{ "Water Shield", "!player.buff(Water Shield)" },

  	-- Healing
  		--  Focus
  			{ "Earth Shield", { "focus.health <= 100", "!focus.buff(Earth Shield)", "focus.range <= 40" }, "focus" },
    	
    	-- Noobs
    		{ "Chain Heal", { "@coreHealing.needsHealing(75, 4)", "lowest.range <= 40" }, "lowest" },
	    	{ "Healing Surge", { "lowest.health <= 50", "lowest.range <= 40" }, "lowest" },
	    	{ "Riptide", { "lowest.health <= 85", "!lowest.buff(Riptide)", "lowest.range <= 40" }, "lowest" },
    		{ "Healing Wave", { "lowest.health <= 70", "lowest.range <= 40" }, "lowest" }

}


ProbablyEngine.rotation.register_custom(264, mts.Icon.."|r[|cff9482C9MTS|r][|cff0070DETesting Shaman-Resto|r]", inCombat, outCombat, lib)