--[[ ///---INFO---////
// Shaman Elemental //
// Originaly made by Akeon //
Thank You For Using My ProFiles
I Hope Your Enjoy Them
MTS
]]

local fetch = ProbablyEngine.interface.fetchKey
local ignoreDebuffs = {'Mark of Arrogance','Displaced Energy'}

								--[[   !!!Dispell function!!!   ]]
						--[[   Checks is member as debuff and can be dispeled.   ]]
--[[  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ]]
local function Dispell()
local prefix = (IsInRaid() and 'raid') or 'party'
	for i = -1, GetNumGroupMembers() - 1 do
	local unit = (i == -1 and 'target') or (i == 0 and 'player') or prefix .. i
		if IsSpellInRange('Cleanse Spirit', unit) then
			for j = 1, 40 do
			local debuffName, _, _, _, dispelType, duration, expires, _, _, _, spellID, _, isBossDebuff, _, _, _ = UnitDebuff(unit, j)
				if dispelType and dispelType == 'curse' then
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

function exeOnLoad()
mts.Splash("|cff9482C9[MTS]-|r[|cff0070DEShaman-Elemental|r]-|cff9482C9Loaded", 5.0)

	ProbablyEngine.toggle.create('cleavemode', 'Interface\\Icons\\spell_nature_chainlightning', 'Disable Cleaves', 'Disables automatic casting of earthquake and chain lightning for cleaves.')
	ProbablyEngine.toggle.create('mouseovers', 'Interface\\Icons\\spell_fire_flameshock', 'Enable Mouseovers', 'Enable flameshock on mousover targets.')

	
end

local inCombat = {

	-- Rotation Utilities
		{ "pause", "modifier.lalt" },
	
	-- Interrupt
		{ "Wind Shear", "modifier.interrupt" },

	-- Self Heals
		{ "Healing Surge", "player.health < 20" },
		{ "Healing Stream Totem", { "!player.totem(Healing Stream Totem)", "player.health < 30" } },
 
 	--Survival Abilities
		{ "Windwalk Totem", { "!player.buff", "player.state.root" }, "player" }, 
		{ "Windwalk Totem", { "!player.buff", "player.state.snare" }, "player" }, 
		{ "Tremor Totem", { "!player.buff", "player.state.fear" }, "player" }, 
 
	-- Dispell
		{{ -- Dispell all?
			{ "77130", (function() return Dispell() end) },-- Dispel Everything
		}, "toggle.dispel" },
	
	-- Control Toggles
		{ "Flame Shock", { "!modifier.multitarget", "mouseover.enemy", "mouseover.alive", "mouseover.debuff(Flame Shock).duration <= 3", "toggle.mouseovers" }, "mouseover" },

	-- Pull
		{ "Elemental Blast", "player.buff(Ancestral Swiftness)" },
		{ "Unleash Flame", "talent(6, 1)" },
		{ "Flame Shock", "target.debuff(Flame Shock).duration <= 3" },
	
	-- Movement Rotation
		{ "Spiritwalker's Grace", { "player.moving", "player.buff(Ascendance)" } },
		{ "Ancestral Swiftness", "player.moving" },
		{ "Flame Shock", { "player.moving", "target.debuff(Flame Shock).duration <= 3", "!player.buff(Spiritwalker's Grace)" } },
		{ "Lava Burst", { "player.moving", "player.buff(Lava Surge)", "!player.buff(Spiritwalker's Grace)" } },
		{ "Earth Shock", { "player.moving", "player.buff(Lightning Shield)", "player.buff(Lightning Shield).count >= 15", "!player.buff(Spiritwalker's Grace)" } },
		{ "Chain Lightning", { "player.moving", "!toggle.cleavemode", "player.buff(Ancestral Swiftness)", "!player.buff(Spiritwalker's Grace)" } },
		{ "Chain Lightning", { "player.moving", "modifier.multitarget", "!player.buff(Ascendance)", "player.buff(Ancestral Swiftness)", "!player.buff(Spiritwalker's Grace)" } },	
		{ "Elemental Blast", { "player.moving", "player.buff(Ancestral Swiftness)", "!player.buff(Spiritwalker's Grace)" } },
		{ "Lightning Bolt", { "player.moving", "player.buff(Ancestral Swiftness)", "!player.buff(Spiritwalker's Grace)" } },
		{ "Earth Shock", { 
			"player.moving", 
			"player.buff(Lightning Shield)", 
			"player.buff(Lightning Shield).count >= 15", 
			"!player.buff(Spiritwalker's Grace)", 
			"!target.debuff(Flame Shock).duration <= 3" } },
		
	-- Cooldowns
		{ "Ancestral Swiftness", "modifier.cooldowns" },
		{ "Fire Elemental Totem", "modifier.cooldowns" },
		{ "Elemental Mastery", "modifier.cooldowns" },
		{ "Berserking", "modifier.cooldowns" }, -- EXISTS??? // TO CHECK
		{ "165339", { "modifier.cooldowns", "!player.buff(Ascendance)" } }, -- Ascendance
	
	{{-- can use FH

   	 	{ "Lava Beam", { -- Does it even still exist? // To Review.
			"player.buff(Ascendance)", 
			"player.area(12).enemies > 3" } },
		{ "61882", "player.area(12).enemies > 3", "target.ground" }, -- Earthquake
		{ "8042", { --Earth Shock
			"player.buff(Lightning Shield)", 
			"player.buff(Lightning Shield).count >= 12", 
			"player.area(12).enemies > 3",} },
		{ "3599", { -- Searing Totem
			"!player.totem(Fire Elemental Totem)", 
			"!player.totem(Searing Totem)", 
			"player.area(12).enemies > 3" } },
		{ "403", "player.area(12).enemies > 3" },--Chain Lightning

  }, (function() return fetch('mtsconf','SAoE') end) },

	-- AoE Fallback
		{ "Lava Beam", { -- Does it even still exist? // To Review.
			"modifier.multitarget", 
			"player.buff(Ascendance)" } },
		{ "61882", "modifier.multitarget", "target.ground" },--Earthquake
		{ "8042", { -- Earth Shock
			"modifier.multitarget", 
			"player.buff(Lightning Shield)", 
			"player.buff(Lightning Shield).count >= 12" } },
		{ "3599", { -- Searing Totem
			"modifier.multitarget", 
			"!player.totem(Fire Elemental Totem)", 
			"!player.totem(Searing Totem)"} },
		{ "403", "modifier.multitarget" },--Chain Lightning
	
	-- Main Rotation
		{ "51505" }, -- Lava Burst
		{ "8042", { "player.buff(Lightning Shield)", "player.buff(Lightning Shield).count >= 12" } },
		{ "117014" }, -- Elemental Blast
		{ "61882", { "!toggle.cleavemode", "player.ilevel >= 560" }, "target.ground" }, -- Earthquake
		
		{{-- can use FH

   	 		{ "403", {"player.area(8).enemies > 1", "!toggle.cleavemode" } }, -- Chain Lightning

  		}, (function() return fetch('mtsconf','SAoE') end) },

		{ "3599", { "!player.totem(Fire Elemental Totem)", "!player.totem(Searing Totem)" } }, -- Searing Totem
		{ "403" }, -- Lightning Bolt

}
		
local outCombat = {

	-- Pause
		{ "pause", "modifier.lalt" },

	-- Buffs
		{ "Lightning Shield", "!player.buff(Lightning Shield)" },

}

ProbablyEngine.rotation.register_custom(262, mts.Icon.."|r[|cff9482C9MTS|r][|cff0070DEShaman-Elemental|r]", inCombat, outCombat, exeOnLoad)


