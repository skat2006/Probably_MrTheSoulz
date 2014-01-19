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

-- Table
local mtscommands = {
	con = true,
	seals = true,
	whisper = true, -- "!!!!Change this to true if you want it ON by default!!!"
	chat = true
}

-- Return's	
function mts.GetCon()
	return mtscommands.con
end

function mts.GetSeals()
	return mtscommands.seals
end

function mts.Getwhisper()
	return mtscommands.whisper
end

function mts.Getchat()
	return mtscommands.chat
end

-- Listener	
ProbablyEngine.command.register('mts', function(msg, box)
local command, text = msg:match("^(%S*)%s*(.-)$")
		
	-- Dispaly Version
	if command == 'ver' or command == 'version' then
		GetVer()
	end
		
	-- Disable Rotation Using consecration
	if command == 'con' then
	mtscommands.con = not mtscommands.con
		if mtscommands.con then
			mts:message('*consecration Enabled.*')
		else
			mts:message('*consecration Disabled*.')
		end
	end
		
	-- Disable Rotation Changing seals	
	if command == 'seals' then
	mtscommands.seals = not mtscommands.seals
		if mtscommands.seals then
			mts:message('*seals Enabled.*')
		else
			mts:message('*seals Disabled.*')
		end
	end

	-- Disable Notes
	if command == 'chat' then
	mtscommands.chat = not mtscommands.chat
		if mtscommands.chat then
			mts:message('*Chat Overlay Enabled.*')
		else
			mts:message('*Chat Overlay Disabled.*')
		end
	end

	-- Allow Whispers
	if command == 'ws' or command == 'Whisper' or command == 'whisper' then
	mtscommands.whisper = not mtscommands.whisper
		if mtscommands.whisper then
			mts:message("*Whispers: ON*")
		else
			mts:message("*Whispers: OFF*")
		end
	end

end)
-- //////////////////////-----------------------------------------ITEMS-----------------------------------//////////////////////////////

-- Master Health Potion
function mts.HealthPot()
	if GetItemCount(76097) > 1 
	and GetItemCooldown(76097) == 0 
	and ProbablyEngine.condition["modifier.cooldowns"] then 
		return true
	end

	-- If Dont have it or its in cooldown
	return false
end

-- Kafa Press // Not working right... //
--function mts.KafaPress()
--	if GetItem(86125)
--	and GetItemCooldown(86125) == 0 
--	and ProbablyEngine.condition["modifier.cooldowns"] then 
--		return true
--	end
--
--	-- If Dont have it or its in cooldown
--	return false
--end

-- //////////////////////-----------------------------------------NOTIFICATIONS-----------------------------------//////////////////////////////

	ProbablyEngine.listener.register("COMBAT_LOG_EVENT_UNFILTERED", function(...)
	local event = select(2, ...)
	local source = select(4, ...)
	local spellId = select(12, ...)
	local tname = UnitName("target")
	if source ~= UnitGUID("player") then return false end
	
		if event == "SPELL_CAST_SUCCESS" then

		-- Keybinds
			if spellId == 114158 then
				if mts.Getchat() then
				mts:message("*Casted Light´s Hammer*")
				end
			end

		-- Stuns
			if spellId == 105593 then
				if mts.Getchat() then
					mts:message("*Stunned Target*")
				end
			end

			if spellId == 853 then
				if mts.Getchat() then
					mts:message("*Stunned Target*")
				end
			end
		
		-- Free Yourself
			if spellId == 1044 then
				if mts.Getchat() then
					mts:message("*Casted Hand of Freedom*")
				end
			end
					
		-- Cooldowns
			if spellId == 633 then
				if mts.Getchat() then
					mts:message("*Casted Lay On Hands*")
				end
				if mts.Getwhisper() then
					RunMacroText("/w "..tname.." MSG: Casted Lay On Hands on you.")
				end
			end

			if spellId == 31821 then
				if mts.Getchat() then
					mts:message("*Casted Devotion Aura*")
				end
			end

			if spellId == 31884 then
				if mts.Getchat() then
					mts:message("*Casted Avenging Wrath*")
				end
			end

			if spellId == 86669 then
				if mts.Getchat() then
					mts:message("*Casted Guardian of Ancient Kings*")
				end
			end

			if spellId == 6940 then
				if mts.Getchat() then
					mts:message("*Casted Hand of Sacrifice*")
				end
				if mts.Getwhisper() then
					RunMacroText("/w "..tname.." MSG: Casted Hand of Sacrifice on you.")
				end
			end

			if spellId == 1044 then
				if mts.Getchat() then
					mts:message("*Casted Hand of Sacrifice*")
				end
				if mts.Getwhisper() then
					RunMacroText("/w "..tname.." MSG: Casted Hand of Sacrifice on you.")
				end
			end

		end -- Ends Table
	end)

-- //////////////////////-----------------------------------------Register Lib-----------------------------------//////////////////////////////
ProbablyEngine.library.register('mts', mts)

end

-- //////////////////////-----------------------------------------END LIB-----------------------------------//////////////////////////////


local Buffs = {

	-- Buffs
		{ "19740", { "!player.buff(19740).any", "!player.buff(116956).any", "!player.buff(93435).any", "!player.buff(128997).any", "!toggle.buff" }, nil }, -- Blessing of Might
		{ "20217", { "!player.buff(20217).any", "!player.buff(115921).any", "!player.buff(1126).any", "!player.buff(90363).any", "!player.buff(69378).any", "toggle.buff" }, nil }, -- Blessing of Kings
		{ "25780", "!player.buff(25780).any" }, -- Fury
		
}

-- ////////////////////////-----------------------------------------END BUFFS-----------------------------------//////////////////////////////


local inCombat = {
			
	-- keybinds
		{ "105593", "modifier.control", "target"}, -- Fist of Justice
		{ "853", "modifier.control", "target"}, -- Hammer of Justice
		{ "114158", "modifier.shift", "ground"}, -- Light´s Hammer
		{ "26573", { "player.glyph(54928)", "modifier.alt" }, "ground"}, -- consecration glyphed

	-- Seals
		{ "20165", { "player.seal != 3", "!modifier.multitarget", "@mts.GetSeals()" }, nil }, -- seal of Insight
		{ "20154", { "player.seal != 2", "modifier.multitarget", "@mts.GetSeals()" }, nil }, -- seal of righteousness

	-- Hands
		{ "6940", { "lowest.health <= 80", "!player.health <= 40", "!lowest.player" }, "lowest" }, -- Hand of Sacrifice
		{ "1044", "player.state.root" }, -- Hand of Freedom
		{ "1022", { "!lowest.role(tank)", "!lowest.immune.melee", "lowest.health < 25" }, "lowest" }, -- Hand of Protection
		
	-- Interrupt
		{ "96231", "modifier.interrupts" }, -- Rebuke

	-- Defensive Cooldowns
		{ "20925", { "!player.buff(20925)", "toggle.defcd" }, "player" }, -- Sacred Shield 		
		{ "31850", { "player.health < 30", "toggle.defcd" }, nil }, --Ardent Defender
		{ "498", { "player.health <= 99", "toggle.defcd" }, nil }, -- Divine Protection
		{ "86659", { "player.health <= 50", "toggle.defcd" }, nil }, -- Guardian of Ancient Kings
		{ "#gloves", "toggle.defcd", nil },
	
	-- Cooldowns
		{ "31884", "modifier.cooldowns" }, -- Avenging Wrath
		{ "105809", "modifier.cooldowns" }, --Holy Avenger
	
	-- Items
		{ "#5512", "player.health < 60" }, --Healthstone
		{ "#76097", { "player.health < 30", "@mts.HealthPot" }, nil }, -- Master Health Potion
		--{ "#86125", { "@mts.KafaPress", "modifier.cooldowns" }, nil }, -- Kafa Press // Not working right... //

	-- Self Heal
		{ "633", "player.health < 20", "player"}, -- Lay on Hands
		{ "114163", { "!player.buff(114163)", "player.buff(114637).count = 5", "player.holypower >= 3", "player.health < 60" }, "player"}, -- Eternal Flame
		{ "114163", { "player.holypower >= 1", "player.health < 30" }, "player"}, -- Eternal Flame / Low
		{ "85673", { "player.buff(114637).count = 5", "player.holypower >= 3", "player.health < 60" }, "player" }, -- Word of Glory
		{ "85673", { "player.holypower >= 1", "player.health < 30" }, "player" }, -- Word of Glory / Low
		{ "19750", { "player.health < 70", "player.buff(114250).count > 2", "player.buff(114637" }, "player" }, -- Flash of Light / Selfless Healer / Bastion of glory / Player

	-- Raid Heal
		{ "19750", { "lowest.health < 50", "player.buff(114250).count > 2" }, "lowest" }, -- Flash of Light / Selfless Healer / Lowest
        { "114163", { "player.holypower >= 1", "player.health < 30" }, "Lowest"}, -- Eternal Flame
        { "85673", { "player.holypower >= 1", "player.health < 30" }, "lowest" }, -- Word of Glory 

    -- Auto Target
    	{ "/script TargetNearestEnemy()", { "toggle.autotarget", "!target.exists" }, nil },
        { "/script TargetNearestEnemy()", { "toggle.autotarget", "target.exists", "target.dead" }, nil },

    -- Taunts
		{ "62124", { "toggle.aggro", "@mts.bossTaunt()" }, target }, -- Boss // Reckoning
		--{ "62124", { "toggle.aggro", "target.threat < 100", "@mts.StopIfBoss()" }, target }, -- Aggro Control // Reckoning
		--{ "62124", { "toggle.aggro", "mouseover.threat < 100", "@mts.StopIfBoss()" }, mouseover }, -- Aggro Control // Reckoning

	-- Rotation
		{ "24275", { "target.health <= 20", "target.spell(24275).range" }, "target" }, -- Hammer of Wrath
		{ "31935", { "player.buff(98057)", "target.spell(31935).range" }, "target" }, -- Avenger´s Shield Proc
		{ "53600", { "player.holypower >= 3", "target.spell(53600).range" }, "target" }, -- Shield of the Righteous
		{ "35395", { "!modifier.multitarget", "target.spell(35395).range" }, "target" }, -- Crusader Strike
		{ "53595", { "modifier.multitarget", "target.spell(53595).range" }, "target" }, -- Hammer of the Righteous
		{ "20271", "target.spell(20271).range", "target" }, -- Judgment
		{ "114165", "target.spell(114165).range", "target" }, -- Holy Prism
		{ "31935", "target.spell(31935).range", "target" },-- Avenger´s Shield Normal
		{ "26573", { "!player.glyph(54928)", "target.range <= 5", "@mts.GetCon()" }, nil }, -- consecration
		{ "114157", "target.spell(114157).range", "target" }, -- Execution Sentense
		{ "119072" }, -- Holy Wrath
  
}

-- //////////////////////-----------------------------------------END IN-COMBAT-----------------------------------//////////////////////////////

local outCombat = {

-- keybinds
		{ "105593", "modifier.control", "target"}, -- Fist of Justice
		{ "853", "modifier.control", "target"}, -- Hammer of Justice
		{ "114158", "modifier.shift", "ground"}, -- Light´s Hammer
		{ "26573", { "player.glyph(54928)", "modifier.alt" }, "ground"}, -- consecration glyphed

	-- seals
		{ "20165", { "player.seal != 3", "!modifier.multitarget", "@mts.GetSeals()" }, nil }, -- seal of Insight
		{ "20154", { "player.seal != 2", "modifier.multitarget", "@mts.GetSeals()" }, nil }, -- seal of righteousness

	-- Hands
		{ "1044", "player.state.root" }, -- Hand of Freedom

}

-- //////////////////////-----------------------------------------END OUT-OF-COMBAT-----------------------------------//////////////////////////////

for _, Buffs in pairs(Buffs) do
  inCombat[#inCombat + 1] = Buffs
  outCombat[#outCombat + 1] = Buffs
end

ProbablyEngine.rotation.register_custom(66, "|r[|cff9482C9MTS|r][|cffF58CBAPaladin-Protection|r]", inCombat, outCombat, lib)