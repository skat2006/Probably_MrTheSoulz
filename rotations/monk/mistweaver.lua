local fetch = ProbablyEngine.interface.fetchKey
local ignoreDebuffs = {'Mark of Arrogance','Displaced Energy'}

								--[[   !!!Dispell function!!!   ]]
						--[[   Checks is member as debuff and can be dispeled.   ]]
--[[  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ]]
local function Dispell()
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


local function Trans()
	usable, nomana = IsUsableSpell("Transcendence: Transfer");
	if not usable then
		return true
	end
	tFound=false
	for i=1,40 do local B=UnitBuff("player",i); 
		if B=="Transcendence" then tFound=true end 
	end
	
	if not tFound then
		return true
	end
	
	return false
end

local exeOnLoad = function()
mts.Splash("|cff9482C9[MTS]-|cffFFFFFF"..(select(2, GetSpecializationInfo(GetSpecialization())) or "Error").."-|cff9482C9Loaded", 5.0)
	ProbablyEngine.toggle.create(
		'dispel', 
		'Interface\\Icons\\Ability_paladin_sacredcleansing.png', 
		'Dispel Everything', 
		'Dispels everything it finds \nThis does not effect SoO dispels.')
	ProbablyEngine.toggle.create(
		'trans', 
		'Interface\\Icons\\Inv_boots_plate_dungeonplate_c_05.png', 
		'Enable Casting Transcendence Outside of Combat', 
		'Enable/Disable Casting Transcendence Outside of Combat \nIf you forget to cast it and need help -- not a bad idea!.')
end
							-- [[ !!!Stance of the Wise Serpent!!!]]
--[[!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!]]
local inCombatSerpente = {

	{ "/stopcasting", {
		(function() return mts_soothingMist(fetch('mtsconfigMonkMm', 'SM')) end),
		"player.casting(115175)" -- Soothing Mist
	} },

	-- Buffs
  	{ "116781", {-- Legacy of the White Tiger
      	"!player.buff(116781)",
      	"!player.buff(17007)",
      	"!player.buff(1459)",
      	"!player.buff(61316)",
      	"!player.buff(24604)",
      	"!player.buff(90309)",
      	"!player.buff(126373)",
      	"!player.buff(126309)"
    }},
  	{ "117666", {-- Legacy of the Emperor
      	"!player.buff(117666)",
      	"!player.buff(1126)",
      	"!player.buff(20217)",
      	"!player.buff(90363)"
    }},

	-- Keybinds
		--{"101546", "modifier.shift"}, -- Spinning Crane Kick
  		{ "115313" , "modifier.control", "tank.ground" },-- Summon Jade Serpent Statue
  
  	{{-- Interrupts
	  	{ "115078", { -- Paralysis when SHS, and Quaking Palm are all on CD
	     	"!target.debuff(116705)", -- Spear Hand Strike
	     	"player.spell(116705).cooldown > 0", -- Spear Hand Strike
	     	"player.spell(107079).cooldown > 0", -- Quaking Palm
	     	"!modifier.last(116705)", -- Spear Hand Strike
	    }},
	  	{ "116844", { -- Ring of Peace when SHS is on CD
	     	"!target.debuff(116705)", -- Spear Hand Strike
	     	"player.spell(116705).cooldown > 0", -- Spear Hand Strike
	     	"!modifier.last(116705)", -- Spear Hand Strike
	    }},
	  	{ "119381", { -- Leg Sweep when SHS is on CD
	     	"player.spell(116705).cooldown > 0",
	     	"target.range <= 5",
	     	"!modifier.last(116705)",
	    }},
	  	{ "119392", { -- Charging Ox Wave when SHS is on CD
	     	"player.spell(116705).cooldown > 0",
	     	"target.range <= 30",
	     	"!modifier.last(116705)",
	    }},
	  	{ "116705" }, -- Spear Hand Strike
	}, "target.interruptsAt(50)" },
	
	{{ -- Dispell all?
		{ "115450", (function() return Dispell() end) },-- Dispel Everything
	}, "toggle.dispel" },

	-- Cooldowns
  		{ "116849", "lowest.health <= 25" },-- Life Coccon

	-- Give me Mana
		{ "115294", { -- mana tea
			"player.mana < 95", 
			"player.buff(115867).count >= 2" 
		}},

	-- FREEDOOM!
		{ "137562", "player.state.disorient" }, -- Nimble Brew = 137562
		{ "137562", "player.state.fear" },
		{ "137562", "player.state.stun" },
		{ "137562", "player.state.root" },
		{ "137562", "player.state.horror" },
		{ "137562", "player.state.snare" },
		{ "116841", "player.state.disorient" }, -- Tiger's Lust = 116841
		{ "116841", "player.state.stun" },
		{ "116841", "player.state.root" },
		{ "116841", "player.state.snare" },
		{"Escape Artist", "player.state.snare" },
		{"Escape Artist", "player.state.root" },
		{ "115080", "player.buff(121125)" }, -- Touch of Death, Death Note
		{"Transcendence", {
			(function() return Trans() end), 
			"toggle.trans"
		} },

	-- Survival
		{ "115072", { "player.health <= 80", "player.chi < 4" }}, -- Expel Harm
		{ "115098", "player.health <= 75" }, -- Chi Wave
		{ "115203", { -- Forifying Brew at < 30% health and when DM & DH buff is not up
		  "player.health < 30",
		  "!player.buff(122783)", -- Diffuse Magic
		  "!player.buff(122278)"-- Dampen Harm
		}}, 
		{ "#5512", "player.health < 40" }, -- Healthstone
		{"119996", "player.health < 35"}, --Transcendence: Transfer

	-- AoE
		{ "115310", "@coreHealing.needsHealing(50, 9)", nil }, -- Revival
  		{ "116680", { -- Uplift with Thunder Focus Tea Condition
  			"@coreHealing.needsHealing(80, 3)",
  			"player.chi >= 3", 
  			"!player.buff(116680)"
  		}},
	    { "115098", "@coreHealing.needsHealing(90, 2)", "lowest" },
		
	-- Enveloping Mist
		{ "124682", { 
			"focus.chi >= 3",
			"focus.health < 90",
			"player.casting(115175)" -- Soothing Mist
		}, "focus" },
		{ "124682", {
			"player.chi >= 3",
			"tank.health < 90",
			"player.casting(115175)" -- Soothing Mist
		}, "tank" },
		{ "124682", {
			"player.casting(115175)", -- Soothing Mist
			"player.chi >= 3", 
			"lowest.health < 90" 
		}, "lowest" }, 

	-- Surging Mist
		{ "116694", { 
			"player.casting(Soothing Mist)", 
			"focus.health <= 99" 
		}, "focus" },
		{ "116694", {
			"player.casting(Soothing Mist)", 
			"tank.health <= 99" 
		}, "tank" }, 
		{ "116694", {
			"player.casting(Soothing Mist)", 
			"lowest.health <= 95", 
			"!lowest.buff(119611)"
		}, "lowest" }, 

	--Expel Harm
		{"115072", "player.health < 70", "player"},

	-- Renewing Mist
		{ "115151", {
			"lowest.buff(119611).duration <= 2", 
			"lowest.health < 100"
		}, "lowest"}, 

	-- Soothing Mist
	  	{ "115175", {
	  		(function() return mts.dynamicEval("lowest.health < " .. fetch('mtsconfigMonkMm', 'SM')) end), 
	  		"!player.moving"
	  	}, "lowest" },

}

								-- [[ !!!Stance of the Spirited Crane!!!]]
--[[!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!]]

local inCombatCrane = {

	-- Buffs
	  	{ "116781", {-- Legacy of the White Tiger
	      	"!player.buff(116781)",
	      	"!player.buff(17007)",
	      	"!player.buff(1459)",
	      	"!player.buff(61316)",
	      	"!player.buff(24604)",
	      	"!player.buff(90309)",
	      	"!player.buff(126373)",
	      	"!player.buff(126309)"
	    }},
	  	{ "117666", {-- Legacy of the Emperor
	      	"!player.buff(117666)",
	      	"!player.buff(1126)",
	      	"!player.buff(20217)",
	      	"!player.buff(90363)"
	    }},	
		
	-- Cooldowns
  		{ "116849", "lowest.health <= 25" },-- Life Coccon

	-- Give me Mana
		{ "115294", { "player.mana < 95", "player.buff(115867).count >= 2" }}, -- mana tea
		
	-- Survival
		{ "115072", { "player.health <= 80", "player.chi < 4" }}, -- Expel Harm
		{ "115098", "player.health <= 75" }, -- Chi Wave
		{ "115203", { -- Forifying Brew at < 30% health and when DM & DH buff is not up
		  "player.health < 30",
		  "!player.buff(122783)", -- Diffuse Magic
		  "!player.buff(122278)"-- Dampen Harm
		 }}, 
		{ "#5512", "player.health < 40" }, -- Healthstone
		
		
	{{-- Interrupts
	  	{ "115078", { -- Paralysis when SHS, and Quaking Palm are all on CD
	     	"!target.debuff(116705)", -- Spear Hand Strike
	     	"player.spell(116705).cooldown > 0", -- Spear Hand Strike
	     	"player.spell(107079).cooldown > 0", -- Quaking Palm
	     	"!modifier.last(116705)", -- Spear Hand Strike
	    }},
	  	{ "116844", { -- Ring of Peace when SHS is on CD
	     	"!target.debuff(116705)", -- Spear Hand Strike
	     	"player.spell(116705).cooldown > 0", -- Spear Hand Strike
	     	"!modifier.last(116705)", -- Spear Hand Strike
	    }},
	  	{ "119381", { -- Leg Sweep when SHS is on CD
	     	"player.spell(116705).cooldown > 0",
	     	"target.range <= 5",
	     	"!modifier.last(116705)",
	    }},
	  	{ "119392", { -- Charging Ox Wave when SHS is on CD
	     	"player.spell(116705).cooldown > 0",
	     	"target.range <= 30",
	     	"!modifier.last(116705)",
	    }},
	  	{ "116705" }, -- Spear Hand Strike
	}, "target.interruptsAt(50)" },
		
	-- FREEDOOM!
		{ "137562", "player.state.disorient" }, -- Nimble Brew = 137562
		{ "137562", "player.state.fear" },
		{ "137562", "player.state.stun" },
		{ "137562", "player.state.root" },
		{ "137562", "player.state.horror" },
		{ "137562", "player.state.snare" },
		{ "116841", "player.state.disorient" }, -- Tiger's Lust = 116841
		{ "116841", "player.state.stun" },
		{ "116841", "player.state.root" },
		{ "116841", "player.state.snare" },
		{"Escape Artist", "player.state.snare" },
		{"Escape Artist", "player.state.root" },
		
		
		{ "115098", "target.range >= 15" }, -- Chi Wave (40yrd range!)
		{ "115080", "player.buff(121125)" }, -- Touch of Death, Death Note
		{"119996", "player.health < 35"}, --Transcendence: Transfer
		{"Transcendence", {
			(function() return Trans() end), 
			"toggle.trans"
		} },
		{ "115313" , "modifier.control", "tank.ground" }, -- Summon Jade Serpent Statue
}

local outCombat = {

	{ "/stopcasting", {
		(function() return mts_soothingMist(fetch('mtsconfigMonkMm', 'SM')) end),
		"player.casting(115175)" -- Soothing Mist
	} },

	-- Buffs
	  	{ "116781", {-- Legacy of the White Tiger
	      	"!player.buff(116781)",
	      	"!player.buff(17007)",
	      	"!player.buff(1459)",
	      	"!player.buff(61316)",
	      	"!player.buff(24604)",
	      	"!player.buff(90309)",
	      	"!player.buff(126373)",
	      	"!player.buff(126309)"
	    }},
	  	{ "117666", {-- Legacy of the Emperor
	      	"!player.buff(117666)",
	      	"!player.buff(1126)",
	      	"!player.buff(20217)",
	      	"!player.buff(90363)"
	    }},

	-- Keybinds
		--{"101546", "modifier.shift"}, -- Spinning Crane Kick
  		{ "115313" , "modifier.control", "tank.ground" },-- Summon Jade Serpent Statue

	-- heals
		{ "115151", { -- Renewing Mist
			"lowest.buff(119611).duration <= 2", 
			"lowest.health < 100"
		}, "lowest"}, 
	  	{ "115175", {-- Soothing Mist
	  		(function() return mts.dynamicEval("lowest.health < " .. fetch('mtsconfigMonkMm', 'SM')) end), 
	  		"!player.moving"
	  	}, "lowest" },
	
		{"Transcendence", (function() return Trans() end) },
}
 


ProbablyEngine.rotation.register_custom(270, mts.Icon.."|r[|cff9482C9MTS|r][|cff00FF96Monk-Mistweaver|r]", 
		{-- Change CR dyn
			{ inCombatSerpente, "player.stance = 1" },
			{ inCombatCrane, "player.stance = 2" },
		},
  	outCombat, exeOnLoad)