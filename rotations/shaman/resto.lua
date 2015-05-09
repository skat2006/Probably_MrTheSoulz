local fetch = ProbablyEngine.interface.fetchKey

local _unitDebuff = function(unit)
	for z = 1, 40 do
		local debuffName, _, _, _, dispelType, duration, expires, _, _, _, spellID, _, isBossDebuff, _, _, _ = UnitDebuff(unit, z)
		if dispelType and dispelType == 'Magic' or dispelType == 'Curse' then
			return unit
		end
		if not debuffName then
			break
		end				
	end
	return nil
end

local function Dispell()
	local x = GetNumGroupMembers()
	if x == 0 then
		local rez = _unitDebuff('player')
		if rez then 
			ProbablyEngine.dsl.parsedTarget = rez
			return true 
		end				
	elseif x > 0 then
		for i = 0, x do
			local grp = (IsInRaid() and 'raid') or 'party'	
			local rez = _unitDebuff((i == 0 and 'player') or (grp .. i))
			if rez then 
				ProbablyEngine.dsl.parsedTarget = rez
				return true 
			end
		end
	end
	return false
end

local exeOnLoad = function()
	mts.Splash()
  	ProbablyEngine.toggle.create(
  		'dps', 
  		'Interface\\Icons\\Spell_shaman_stormearthfire.png‎', 
  		'Some DPS', 
  		'Do some dmg while healing.')
end	



local inCombat = {

  	-- Keybinds
  		{ "73920", {"modifier.shift", "!player.buff(114052)"}, "ground"}, -- Healing Rain + Ascendance
  		{ "/focus [target=mouseover]", "modifier.ralt" }, -- Mouseover Focus

	-- Dispel
		{{
			{ "77130", (function() return Dispell() end) }, -- Dispel Everything
		}, (function() return fetch('mtsconfShamanResto','Dispels') end) }, 	
  	  	  	
  	-- Interrupt
  		{ "57994", "modifier.interrupt" }, -- Wind Shear

	-- Survival
		{ "108271", (function() return mts.dynamicEval("player.health <= " .. fetch('mtsconfShamanResto', 'AstralShift')) end), nil }, -- Astral Shift
  		{ "108273", "player.state.root", "player" }, -- Windwalk Totem
  		{ "108273", "player.state.snare", "player" }, -- Windwalk Totem 		

	-- Items
		{ "#5512", (function() return mts.dynamicEval("player.health <= " .. fetch('mtsconfShamanResto', 'Healthstone')) end), nil }, -- Healthstone
		{ "#trinket1", (function() return mts.dynamicEval("player.mana <= " .. fetch('mtsconfShamanResto', 'Trinket1')) end), nil }, -- Trinket 1
		{ "#trinket2", (function() return mts.dynamicEval("player.mana <= " .. fetch('mtsconfShamanResto', 'Trinket2')) end), nil }, -- Trinket 2		
  		  		  		
  	-- Buffs
    	{ "52127", {"!player.buff(52127)", "!player.buff(974)"}}, -- Water Shield

  	-- Heal Fast (Cooldowns)
   		{ "114052", { 
			"@coreHealing.needsHealing(45,10)", 
			"!player.buff(114052)", --Ascendance
			"modifier.cooldowns"
		}}, -- Ascendance
    	{ "98008", {  
			"player.buff(114052)", --Ascendance
			"modifier.cooldowns"
		}}, -- Spirit Link Totem

	-- Tank
		{ "974", {
			(function() return fetch("mtsconfShamanResto", "ESo") == '1' end),
			"!tank.buff(974)", 
			"tank.range <= 40" 
		}, "tank" }, -- Earth Shield
			
	    { "61295", {
	    	(function() return fetch("mtsconfShamanResto", "ESo") == '1' end),
	    	"tank.buff(61295).duration <= 3", 
	    	"tank.range <= 40" 
	    }, "tank" }, -- Riptide						
      
    -- Focus
    	{ "974", {
    		(function() return fetch("mtsconfShamanResto", "ESo") == '2' end), 
    		"!focus.buff(974)", 
    		"focus.range <= 40" 
    	}, "focus" }, --Earth Shield
  	    
	    { "61295", {
	    	(function() return fetch("mtsconfShamanResto", "ESo") == '2' end), 
	    	"focus.exists",
	    	"focus.buff(61295).duration <= 3",
	    	"focus.range <= 40" 
	    }, "focus" }, -- Riptide

  	-- AoE
  		{ "1064", { 
			"!player.buff(53390)", --Tidal Waves
			"@coreHealing.needsHealing(60, 3)" 
		}, "lowest" }, --Chain Heal
	    { "1064", "@coreHealing.needsHealing(40, 3)", "lowest" }, --Chain Heal

  	-- regular healing
	    { "5394", "@coreHealing.needsHealing(99, 1)" }, --Healing Stream Totem
	    { "61295", { --Riptide
			"!player.buff(53390)", --Tidal Waves
			"lowest.buff(61295).duration <= 3",
			"lowest.range <= 40"
		}, "lowest" },
	    { "73685", { "!player.buff(73685)", "player.spell(73685).exists" }}, --Unleash Life
	    { "16188", { -- Ancestral Swiftness
			"lowest.health <= 20", 
			"lowest.range <= 40" 
		}, "player" },
	    { "8004", { --Healing Surge for low level characters
		"!player.spell(77472).exists",
		"lowest.health <= 85",
		"lowest.range <= 40"
	    }, "lowest" },		
	    { "77472", { --Healing Wave
			"player.buff(16188)",
			"lowest.range <= 40"
		}, "lowest" },   
	    { "8004", { --Healing Surge
			"lowest.health <= 20", 
			"lowest.range <= 40"
		}, "lowest" },
	    { "77472", { --Healing Wave
			"lowest.health <= 85",
			"lowest.range <= 40"
		}, "lowest" },

	-- Some DPS			
	{{
		{ "2894", { "!talent(6, 2)", "modifier.cooldowns" }}, --Fire Elemental Totem
		{ "3599", { "!player.totem(3599)", "!player.totem(2894)" }}, --Searing Totem // Fire Elemental Totem
		{ "117014", "talent(6, 3)" },
		{ "8050", "!target.debuff(8050)" },
		{ "51505" },
		{ "421", { "modifier.multitarget", "target.area(10).enemies > 2" } },
		{ "403" }, --Lightning Bolt
	}, "toggle.dps" },			
  
}

local outCombat = {

   	-- Keybinds
   		{ "73920", { "modifier.shift", "!player.buff(114052)"}, "ground"}, -- Healing Rain + Ascendance
  
  	-- Buffs
    	{ "52127", "!player.buff(52127)" }, -- Water Shield

  	-- Healing
  		--  Focus
  			{ "974", { 
  				(function() return fetch("mtsconfShamanResto", "ESo") == '2' end),
  				"!focus.buff(974)", 
  				"focus.range <= 40" 
  			}, "focus" }, -- Earth Shield
    	
    	-- Noobs
    		{ "1064", { "@coreHealing.needsHealing(75, 4)", "lowest.range <= 40" }, "lowest" }, -- Chain Heal
    		{ "8004", { -- Healing Surge for low level characters
    			"!player.spell(77472).exists", 
    			"lowest.health <= 70", 
    			"lowest.range <= 40" 
    		}, "lowest" }, 
	    	{ "8004", { "lowest.health <= 50", "lowest.range <= 40" }, "lowest" }, -- Healing Surge
	    	{ "61295", { "lowest.health <= 85", "!lowest.buff(61295)", "lowest.range <= 40" }, "lowest" }, -- Riptide
    		{ "77472", { "lowest.health <= 70", "lowest.range <= 40" }, "lowest" } -- Healing Wave
}

ProbablyEngine.rotation.register_custom(
	264, 
	mts.Icon.."|r[|cff9482C9MTS|r][|cff0070DEShaman-Resto|r]", 
	inCombat, outCombat, exeOnLoad)
