--[[ ///---INFO---////
// Druid Guard //
Thank You For Using My ProFiles
I Hope Your Enjoy Them
MTS

Updated for level 100 WoD by mac_attack @ ownedcore
]]

local fetch = ProbablyEngine.interface.fetchKey

local exeOnLoad = function()

	
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
		{ "/cleartarget", {
			(function() return fetch('mtsconfDruidGuard','AutoTarget') end), 
			(function() return UnitIsFriend("player","target") end)
			}},

		{ "/target [target=focustarget, harm, nodead]", { -- Use Tank Target
			(function() return fetch('mtsconfDruidGuard','AutoTarget') end),
			"target.range > 40"
			 }}, 
		{ "/targetenemy [noexists]", { -- target enemire if no target
			(function() return fetch('mtsconfDruidGuard','AutoTarget') end),
			"!target.exists" 
			}},
		{ "/targetenemy [dead]", { -- target enemire if current is dead.
			(function() return fetch('mtsconfDruidGuard','AutoTarget') end), 
			"target.exists", 
			"target.dead" 
			}},

	-- Interrupts
		{ "106839", "modifier.interrupt", "target"},	-- Skull Bash
		{ "5211", "modifier.interrupt", "target" }, -- Mighty Bash
	
	-- Items
		{ "#5512", (function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfDruidGuard', 'Healthstone')) end) }, -- Healthstone
		{ "#109223", (function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfDruidGuard', 'HealingTonic')) end) }, --  Healing Tonic
		{ "#117415", (function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfDruidGuard', 'SmuggledTonic')) end) }, --  Smuggled Tonic
	
	-- Cooldowns
		{ "50334", "modifier.cooldowns" }, -- Berserk
		{ "124974", "modifier.cooldowns" }, -- Nature's Vigil
		{ "106731", "modifier.cooldowns" }, -- Incarnation
 
	--Defensive
		{ "62606", { -- Savage Defense
			"!player.buff", 
			(function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfDruidGuard', 'SavageDefense')) end) 
			} },
		{ "22842", { -- Frenzied Regeneration
			"!player.buff",
			(function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfDruidGuard', 'FrenziedRegeneration')) end),
			"player.rage >= 20"
			} },
		{ "22812",  (function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfDruidGuard', 'Barkskin')) end) }, -- Barkskin
		{ "102351",  (function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfDruidGuard', 'CenarionWard')) end), "player" }, -- Cenarion Ward
		{ "61336",  (function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfDruidGuard', 'SurvivalInstincts')) end) }, -- Survival Instincts
		{ "108238", (function() return mts_dynamicEval("player.health <= " .. fetch('mtsconfDruidGuard', 'Renewal')) end) }, -- Renewal		

	-- Dream of Cenarious
		-- Needs a Rebirth here
		{ "5185", { "lowest.health < 90", "!player.health < 90", "player.buff(145162)" }, "lowest" }, -- Healing touch /  RAID/PARTY
		{ "5185", { "player.health < 90", "player.buff(145162)" }, "player" }, -- Healing touch / PLAYER

	-- Procs
		{ "6807", "player.buff(Tooth and Claw)" }, -- Maul

	-- Rotation
		{ "770", {"!target.debuff(770)", "target.boss"} }, -- Faerie Fire
		{ "158792", {"target.debuff(Lacerate).count >= 3", "player.buff(Pulverize).duration <= 3"} }, -- Pulverize
		{ "33917" }, -- Mangle
		
		-- AoE
			{ "77758", "modifier.multitarget" }, -- Thrash

		{{-- can use FH

			-- AoE smart
				{ "77758", "player.area(8).enemies >= 3", "target" }, -- Thrash  // FH SMARTH AoE

		}, {"player.firehack", (function() return fetch('mtsconf','Firehack') end) }},

			
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

ProbablyEngine.rotation.register_custom(104, mts_Icon.."|r[|cff9482C9MTS|r][|cffFF7D0ADruid-Guardian|r]", inCombat, outCombat, exeOnLoad)