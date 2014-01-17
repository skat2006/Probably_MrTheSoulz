-- //////////////////////-----------------------------------------INFO-----------------------------------//////////////////////////////
--													   	//Paladin Protection//
--													Thank Your For Your My ProFiles
--														I Hope Your Enjoy Them
--																  MTS


local lib = function()

-- /////////////////////////-----------------------------------------TOGGLES-----------------------------------//////////////////////////////
	ProbablyEngine.toggle.create('defcd', 'Interface\\Icons\\Spell_holy_devotionaura.png', 'Defensive Cooldowns', 'Enable or Disable Defensive Cooldowns.')
	ProbablyEngine.toggle.create('buff', 'Interface\\Icons\\Spell_magic_greaterblessingofkings.png', 'Buffs', 'Enable for Blessing of Kings. \nDisable for Blessing of Might.')
	ProbablyEngine.toggle.create('aggro', 'Interface\\Icons\\Ability_warrior_stalwartprotector.png', 'Aggro control', 'Auto Taunts on mouse-over ot target if dosent have aggro.')
	mts:message("\124cff9482C9*MrTheSoulz - \124cffF58CBAPaladin/Protection \124cff9482C9Loaded*")
	
-- ////////////////////////-----------------------------------------COMMANDS-----------------------------------//////////////////////////////

	local mtsPalaProt = {
		con = true,
		seal = true,
		Whisper = true, -- "!!!!Change this to true if you want it ON by default!!!"
		ChatOverlay = true
	}
	
	function mtsPalaProt.GetCon()
		return mtsPalaProt.con
	end

	function mtsPalaProt.Getseal()
		return mtsPalaProt.seal
	end

	function mtsPalaProt.GetWhisper()
		return mtsPalaProt.Whisper
	end

	function mtsPalaProt.GetChatOverlay()
		return mtsPalaProt.ChatOverlay
	end
	
	ProbablyEngine.command.register('mts', function(msg, box)
	local command, text = msg:match("^(%S*)%s*(.-)$")
		
		if command == 'ver' or command == 'version' then
			GetVer()
		end
		
		-- Disable Rotation Using consecration
			if command == 'con' then
			mtsPalaProt.con = not mtsPalaProt.con
				if mtsPalaProt.con then
					mts:message('*consecration Enabled.*')
				else
					mts:message('*consecration Disabled*.')
				end
			end
		
		-- Disable Rotation Changing seals	
			if command == 'seals' then
			mtsPalaProt.seal = not mtsPalaProt.seal
				if mtsPalaProt.seal then
					mts:message('*seals Enabled.*')
				else
					mts:message('*seals Disabled.*')
				end
			end

		-- Disable Notes
			if command == 'chat' then
			mtsPalaProt.ChatOverlay = not mtsPalaProt.ChatOverlay
				if mtsPalaProt.ChatOverlay then
					mts:message('*Chat Overlay Enabled.*')
				else
					mts:message('*Chat Overlay Disabled.*')
				end
			end

		-- Allow Whispers
			if command == 'ws' or command == 'Whisper' or command == 'whisper' then
				mtsPalaProt.Whisper = not mtsPalaProt.Whisper
				if mtsPalaProt.Whisper then
					mts:message("*Whispers: ON*")
				else
					mts:message("*Whispers: OFF*")
				end
			end

	end)


-- //////////////////////-----------------------------------------NOTIFICATIONS-----------------------------------//////////////////////////////

	ProbablyEngine.listener.register("COMBAT_LOG_EVENT_UNFILTERED", function(...)
	local event = select(2, ...)
	local source = select(4, ...)
	local spellId = select(12, ...)
	local tname = UnitName("target")
	if source ~= UnitGUID("player") then return false end

		if mtsPalaProt.GetChatOverlay() then
	
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
						if mtsPalaProt.GetWhisper() then
							RunMacroText("/w "..tname.." MSG: Casted Lay On Hands on you.")
						end
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
						if mtsPalaProt.GetWhisper() then
							RunMacroText("/w "..tname.." MSG: Casted Hand of Sacrifice on you.")
						end
					end
					if spellId == 1044 then
						mts:message("*Casted Hand of Sacrifice*")
						if mtsPalaProt.GetWhisper() then
							RunMacroText("/w "..tname.." MSG: Casted Hand of Sacrifice on you.")
						end
					end

			end
		end
	end)

ProbablyEngine.library.register('mtsPalaProt', mtsPalaProt)

end

-- //////////////////////-----------------------------------------END LIB-----------------------------------//////////////////////////////


local Buffs = {

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
		
}
-- ////////////////////////-----------------------------------------END BUFFS-----------------------------------//////////////////////////////


local inCombat = {
			
	-- keybinds
		{ "105593", "modifier.control", "target"}, -- Fist of Justice
		{ "853", "modifier.control", "target"}, -- Hammer of Justice
		{ "114158", "modifier.shift", "ground"}, -- Light´s Hammer
		{ "26573", { -- consecration glyphed
			"player.glyph(54928)", 
			"modifier.alt" 
		}, "ground"},

	-- seals
		{ "20165", { -- seal of Insight
			"player.seal != 3",
			"!modifier.multitarget",
			"@mtsPalaProt.Getseal()"
		}, nil },
		{ "20154", { -- seal of righteousness
			"player.seal != 2",
			"modifier.multitarget",
			"@mtsPalaProt.Getseal()"
		}, nil },

	-- Hands
		{ "6940", { "lowest.health <= 80", "!player.health <= 40" }, "lowest" }, -- Hand of Sacrifice
		{ "1044", "player.state.root" }, -- Hand of Freedom
		
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
		{ "26573", { -- consecration
			"!player.glyph(54928)", 
			"target.range <= 5", 
			"@mtsPalaProt.GetCon()" 
		}, nil },
		{ "114157", "target.spell(114157).range", "target" }, -- Execution Sentense
		{ "119072" }, -- Holy Wrath
  
} -- //////////////////////-----------------------------------------END IN-COMBAT-----------------------------------//////////////////////////////

local outCombat = {

-- keybinds
		{ "105593", "modifier.control", "target"}, -- Fist of Justice
		{ "853", "modifier.control", "target"}, -- Hammer of Justice
		{ "114158", "modifier.shift", "ground"}, -- Light´s Hammer
		{ "26573", { -- consecration glyphed
			"player.glyph(54928)", 
			"modifier.alt" 
		}, "ground"},

	-- seals
		{ "20165", { -- seal of Insight
			"player.seal != 3",
			"!modifier.multitarget",
			"@mtsPalaProt.Getseal()"
		}, nil },
		{ "20154", { -- seal of righteousness
			"player.seal != 2",
			"modifier.multitarget",
			"@mtsPalaProt.Getseal()"
		}, nil },

	-- Hands
		{ "1044", "player.state.root" }, -- Hand of Freedom

}-- //////////////////////-----------------------------------------END OUT-OF-COMBAT-----------------------------------//////////////////////////////

for _, Buffs in pairs(Buffs) do
  inCombat[#inCombat + 1] = Buffs
  outCombat[#outCombat + 1] = Buffs
end

ProbablyEngine.rotation.register_custom(66, "|r[|cff9482C9MTS|r][|cffF58CBAPaladin-Protection|r]", inCombat, outCombat, lib)