local lib = function()

  	ProbablyEngine.toggle.create('autotarget', 'Interface\\Icons\\Ability_spy.png', 'Auto Target', 'Automatically target the nearest enemy when target dies or does not exist')
  	ProbablyEngine.toggle.create('cleave', 'Interface\\Icons\\spell_frost_frostbolt', 'Disable Cleaves', 'Disable casting of Cone of Cold and Ice Nova for Procs.')
  	mtsStart:message("\124cff9482C9*MTS-\124cff69CCF0Mage/Frost-\124cff9482C9Loaded*")
  	mts_showLive()
  	
end


local inCombat = {

 	 -- Rotation Utilities
		{ "pause", "modifier.lalt" },
		{ "/script TargetNearestEnemy()", { "toggle.autotarget", "!target.exists" } },
		{ "/script TargetNearestEnemy()", { "toggle.autotarget", "target.exists", "target.dead" } },
	
	-- Interrupt
		{ "2139", "modifier.interrupt" },--Counterspell
		{ "Rune of Power", "modifier.lcontrol", "mouseover.ground" },

 	--Survival Abilities
 		{ "1953", "player.state.root" }, -- Blink
		{ "475", { -- Remove Curse
			"!modifier.last(475)", 
			"player.dispellable(475)" }, "player" }, 
	
	-- Cooldowns
		{ "Rune of Power", { "!player.buff(Rune of Power)", "!player.moving" }, "player.ground" }, 
		{ "12472", "modifier.cooldowns" },--Icy Veins
		{ "Mirror Image", "modifier.cooldowns" },
	
	-- Moving
		{ "Ice Floes", "player.moving" },

	-- Procs
		{ "44614", "player.buff(Brain Freeze)", "target" },-- Frostfire Bolt
		{ "30455", "player.buff(Fingers of Frost)", "target" },-- Ice Lance

	-- Frost Bomb
		{ "Frost Bomb", {  "target.debuff(Frost Bomb).duration <= 3", "talent(5, 1)" } },

	{{-- can use FH

		-- AoE smart
			{ "84714", "target.area(10).enemies >= 5" },--Frozen Orb
			{ "Ice Nova", {"target.area(10).enemies >= 5", "talent(5, 3)" } },
			{ "120", "target.area(10).enemies >= 5" },--Cone of Cold
			{ "10", "target.area(10).enemies >= 5", "target.ground" },--Blizzard

	}, {"player.firehack", "@mts_getConfig('mtsconf_Firehack')"}},

	
	-- AoE // FallBack
		{ "84714", "modifier.multitarget" },--Frozen Orb
		{ "Ice Nova", { "modifier.multitarget", "talent(5, 3)" } },
		{ "120", "modifier.multitarget" },--Cone of Cold
		{ "10", "modifier.multitarget", "target.ground" },--Blizzard

	-- Main Rotation
		{ "84714", "!toggle.cleave" }, -- Frozen Orb
		{ "Ice Nova", { "!toggle.cleave", "talent(5, 3)" } },
		{ "120", { "!toggle.cleave" } },--Cone of Cold
		{ "116" },--Frostbolt
	
}

local outCombat = {

  -- Pause
		{ "pause", "modifier.lalt" },

	-- Buffs
		{ "Arcane Brilliance", "!player.buff(Arcane Brilliance)" },
		{ "Summon Water Elemental", "!pet.exists"}


}

ProbablyEngine.rotation.register_custom(64, mts_Icon.."|r[|cff69CCF0MTS|r][|cff69CCF0Mage-Frost|r]", inCombat, outCombat, lib)