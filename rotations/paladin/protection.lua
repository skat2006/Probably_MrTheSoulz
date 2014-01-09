-- //////////////////////-----------------------------------------INFO-----------------------------------//////////////////////////////
--													   	//Paladin Protection//
--													Thank Your For Your My ProFiles
--														I Hope Your Enjoy Them
--																  MTS


local lib = function()

-- /////////////////////////-----------------------------------------TOGGLES-----------------------------------//////////////////////////////
	ProbablyEngine.toggle.create('defcd', 'Interface\\Icons\\Spell_holy_devotionaura.png', 'Defensive Cooldowns', 'Enable or Disable Defensive Cooldowns.')
	ProbablyEngine.toggle.create('buff', 'Interface\\Icons\\spell_magic_greaterblessingofkings.png', 'Buffs', 'Enable for Blessing of Kings. \nDisable for Blessing of Might.')
	ProbablyEngine.toggle.create('aggro', 'Interface\\Icons\\Ability_warrior_stalwartprotector.png', 'Aggro Control', 'Auto Taunts on mouse-over ot target if dosent have aggro.')
	mts:message("\124cff9482C9*MrTheSoulz - \124cffF58CBAPaladin/Protection \124cff9482C9Loaded*")
	
-- //////////////////////-----------------------------------------NOTIFICATIONS-----------------------------------//////////////////////////////
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
		if spellId == 6940 then
			mts:message("*Casted Hand of Sacrifice*")
		end

	end
end)
	
-- ////////////////////////-----------------------------------------COMMANDS-----------------------------------//////////////////////////////
	local mts = {
		con = true,
		seals = true
	}

	function mts.GetCon()
		return mts.con
	end

	function mts.GetSeals()
		return mts.seals
	end
	ProbablyEngine.library.register('mts', mts)
	
	ProbablyEngine.command.register('mts', function(msg, box)
	local command, text = msg:match("^(%S*)%s*(.-)$")
		
		if command == 'ver' then
			GetVer()
		end
	
		if command == 'con' then
		mts.con = not mts.con
			if mts.con then
				mts:message('*Consecration Enabled.*')
			else
				mts:message('*Consecration Disabled*.')
			end
		end
			
		if command == 'seals' then
		mts.seals = not mts.seals
			if mts.seals then
				mts:message('*Seals Enabled.*')
			else
				mts:message('*Seals Disabled.*')
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
		{ "25780", "!player.buff(25780).any" }, -- Fury
	
	-- Seals
		{ "20165", { -- Seal of Insight
			"player.seal != 3",
			"!modifier.multitarget",
			"@mts.GetSeals()"
		}, nil },
		{ "20154", { -- Seal of righteousness
			"player.seal != 2",
			"modifier.multitarget",
			"@mts.GetSeals()"
		}, nil },
		
	-- Hands
		{ "1044", "player.state.root" }, -- Hand of Freedom
	
	-- keybinds
		{ "105593", "modifier.control", "target"}, -- Fist of Justice
		{ "853", "modifier.control", "target"}, -- Hammer of Justice
		{ "114158", "modifier.shift", "ground"}, -- Light´s Hammer
		{ "26573", { -- Consecration glyphed
			"player.glyph(54928)", 
			"modifier.alt" 
		}, "ground"},
		
}
-- ////////////////////////-----------------------------------------END SHARED-----------------------------------//////////////////////////////


local inCombat = {
			
	-- Hands
		{ "6940", { "lowest.health <= 80", "!player.health <= 40" }, "lowest" }, -- Hand of Sacrifice
		
	-- Interrupt
		{ "96231", "modifier.interrupts"}, -- Rebuke

	{{-- Defensive Cooldowns
		{ "20925", "!player.buff(20925)", "player" }, -- Sacred Shield 		
		{ "31850", "player.health < 30" }, --Ardent Defender
		{ "498", "player.health <= 99" }, -- Divine Protection
		{ "86659", "player.health <= 50" }, -- Guardian of Ancient Kings
		{ "#gloves" },
	}, "toggle.defcd" },
	
	-- Cooldowns
		{ "31884", "modifier.cooldowns" }, -- Avenging Wrath
		{ "105809", "modifier.cooldowns" }, --Holy Avenger
		
	-- Self Heal
		{ "#5512", "player.health <= 60" }, --Healthstone
		{ "633", "player.health <= 20", "player"}, -- Lay on Hands
		{ "114163", { -- Eternal Flame
			"!player.buff(114163)",
			"player.buff(114637).count = 5",
			"player.holypower >= 3",
			"player.health <= 85"
		}, "player"},
		{ "85673", {  -- Word of Glory
			"player.buff(114637).count = 5",
			"player.holypower >= 3",
			"player.health <= 40"
		}, "player" },

	-- Rotation

		{ "24275", { -- Hammer of Wrath
			"target.health <= 20",
			"target.spell(24275).range"
		}, "target" },
		{ "31935", { -- Avenger´s Shield Pro
			"player.buff(98057)",
			"target.spell(31935).range"
		}, "target" },
		{ "53600", { -- Shield of the Righteous
			"player.holypower >= 3", 
			"target.spell(53600).range" 
		}, "target" },
		{ "35395", { -- Crusader Strike
			"!modifier.multitarget", 
			"target.spell(35395).range" 
		}, "target" },
		{ "53595", { -- Hammer of the Righteous
			"modifier.multitarget", 
			"target.spell(53595).range" 
		}, "target" },
		{ "20271", "target.spell(20271).range", "target" }, -- Judgment
		{ "114165", "target.spell(114165).range", "target" }, -- Holy Prism
		{ "31935", "target.spell(31935).range", "target" },-- Avenger´s Shield Normal
		{ "26573", { -- Consecration
			"!player.glyph(54928)", 
			"target.range <= 5", 
			"@mts.GetCon()" 
		}, nil },
		{ "114157", "target.spell(114157).range", "target" }, -- Execution Sentense
		{ "119072" }, -- Holy Wrath
  
} -- //////////////////////-----------------------------------------END IN-COMBAT-----------------------------------//////////////////////////////

local outCombat = {

}-- //////////////////////-----------------------------------------END OUT-OF-COMBAT-----------------------------------//////////////////////////////

for _, Shared in pairs(Shared) do
  inCombat[#inCombat + 1] = Shared
  outCombat[#outCombat + 1] = Shared
end

ProbablyEngine.rotation.register_custom(66, "|r[|cff9482C9MTS|r][|cffF58CBAPaladin|r-Protection|r]", inCombat, outCombat, lib)