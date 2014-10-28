--[[ ///---INFO---////
// Druid Guard //
Thank You For Using My ProFiles
I Hope Your Enjoy Them
MTS
]]

local exeOnLoad = function()

	ProbablyEngine.toggle.create('autotarget', 'Interface\\Icons\\Ability_spy.png', 'Auto Target', 'Automatically target the nearest enemy when target dies or does not exist')
	mtsStart:message("\124cff9482C9*MTS-\124cffFF7D0ADruid/Guardian\124cff9482C9-Loaded*")

end

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
	
	--	keybinds
		{ "77761", "modifier.rshift" }, -- Stampeding Roar
		{ "5211", "modifier.lcontrol" }, -- Mighty Bash
		{ "!/focus [target=mouseover]", "modifier.ralt" }, -- Focus
		-- Rebirth
			{ "!/cancelform", { "player.form > 0", "player.spell(20484).cooldown < .001", "modifier.lshift" }, nil }, -- remove bear form
			{ "20484", { "modifier.lshift", "!target.alive" }, "target" }, -- Rebirth
			{ "!/cast Bear Form", { "!player.casting", "!player.form = 1", "modifier.last(20484)", "modifier.lshift" }, nil }, -- bear form
		
	--	Buffs
		{ "/cancelaura Bear Form", { -- Cancel player form
  			"player.form > 0",  -- Is in any fom
  			"!player.buff(20217).any", -- kings
			"!player.buff(115921).any", -- Legacy of the Emperor
			"!player.buff(1126).any",   -- Mark of the Wild
			"!player.buff(90363).any",  -- embrace of the Shale Spider
			"!player.buff(69378).any",  -- Blessing of Forgotten Kings
  			"!player.buff(5215)" }},-- Not in Stealth
		{ "1126", {  -- Mark of the Wild
			"!player.buff(20217).any", -- kings
			"!player.buff(115921).any", -- Legacy of the Emperor
			"!player.buff(1126).any",   -- Mark of the Wild
			"!player.buff(90363).any",  -- embrace of the Shale Spider
			"!player.buff(69378).any",  -- Blessing of Forgotten Kings
			"!player.buff(5215)",-- Not in Stealth
			"player.form = 0" }}, -- Player not in form
  		{ "5487", { -- bearform
  			"player.form != 1", -- Stop if bear
  			"!modifier.lalt", -- Stop if pressing left alt
  			"!player.buff(5215)"}}, -- Not in Stealth

	-- Auto Target
		{ "/target [target=focustarget, harm, nodead]", {"target.range > 40", "!target.exists","toggle.autotarget"} },
		{ "/targetenemy [noexists]", { "toggle.autotarget", "!target.exists" }},
   		{ "/targetenemy [dead]", { "toggle.autotarget", "target.exists", "target.dead" }},

	-- Interrupts
		{ "80964", "target.interruptsAt(50)" }, -- skull bash
		{ "132469", "target.interruptsAt(50)" }, -- typhoon
	
	-- Items
		{ "#5512", "player.health < 50" }, --Healthstone
		--{ "#76097", "player.health < 30" }, -- Master Health Potion
		--{ "#86125"}, -- Kafa Press
	
	-- Cooldowns
		{ "50334", "modifier.cooldowns" }, -- Berserk
		{ "124974", "modifier.cooldowns" }, -- Nature's Vigil
		{ "5229", "modifier.cooldowns" }, -- Enrage
		{ "106731", "modifier.cooldowns" }, -- Incarnation
 
	--Defensive
		{ "62606", { "!player.buff", "player.health <= 95" } }, -- Savage Defense
		{ "22842", { "!player.buff", "player.health <= 70", "player.rage >= 20" } }, -- Frenzied Regeneration
		{ "22812",  "player.health <= 70" }, -- Barkskin
		{ "102351",  "player.health <= 60", "player" }, -- Cenarion Ward
		{ "61336",  "player.health <= 40" }, -- Survival Instincts
		{ "106922", "player.health < 30", nil }, -- Might of Ursoc
		{ "108238", "player.health <= 40" }, -- Renewal		

	-- Dream of Cenarious
		-- Needs a Rebirth here
		{ "5185", { "lowest.health < 90", "!player.health < 90", "player.buff(145162)" }, "lowest" }, -- Healing touch /  RAID/PARTY
		{ "5185", { "player.health < 90", "player.buff(145162)" }, "player" }, -- Healing touch / PLAYER

	-- Procs
		{ "6807", "player.buff(Tooth and Claw)" }, -- Maul

	-- Rotation
		{ "770", {"!target.debuff(770)", "target.boss"} }, -- Faerie Fire
		{ "33917", "player.rage < 80" }, -- Mangle
		
		-- AoE
			{ "77758", "player.area(8).enemies >= 3", "@mtsLib.CanFireHack()" }, -- Thrash  // FH SMARTH AoE
			{ "77758", "modifier.multitarget" }, -- Thrash
			
		{ "77758", "target.debuff(77758).duration <= 4" }, -- Thrash
		{ "33745" }, -- Lacerate
  
}

local outCombat = {

	--	keybinds
		{ "77761", "modifier.rshift" }, -- Stampeding Roar
		{ "5211", "modifier.lcontrol" }, -- Mighty Bash
		{ "!/focus [target=mouseover]", "modifier.ralt" }, -- Focus
		-- Rebirth
			{ "!/cancelform", { "player.form > 0", "player.spell(20484).cooldown < .001", "modifier.lshift" }, nil }, -- remove bear form
			{ "20484", { "modifier.lshift", "!target.alive" }, "target" }, -- Rebirth
			{ "!/cast Bear Form", { "!player.casting", "!player.form = 1", "modifier.last(20484)", "modifier.lshift" }, nil }, -- bear form
		
	-- Buffs
  		{ "/cancelaura Bear Form", { -- Cancel player form
  			"player.form > 0",  -- Is in any fom
  			"!player.buff(20217).any", -- kings
			"!player.buff(115921).any", -- Legacy of the Emperor
			"!player.buff(1126).any",   -- Mark of the Wild
			"!player.buff(90363).any",  -- embrace of the Shale Spider
			"!player.buff(69378).any",  -- Blessing of Forgotten Kings
  			"!player.buff(5215)" }},-- Not in Stealth
		{ "1126", {  -- Mark of the Wild
			"!player.buff(20217).any", -- kings
			"!player.buff(115921).any", -- Legacy of the Emperor
			"!player.buff(1126).any",   -- Mark of the Wild
			"!player.buff(90363).any",  -- embrace of the Shale Spider
			"!player.buff(69378).any",  -- Blessing of Forgotten Kings
			"!player.buff(5215)",-- Not in Stealth
			"player.form = 0" }}, -- Player not in form

}

ProbablyEngine.rotation.register_custom(104, "|r[|cff9482C9MTS|r][|cffFF7D0ADruid-Guardian|r]", inCombat, outCombat, exeOnLoad)


