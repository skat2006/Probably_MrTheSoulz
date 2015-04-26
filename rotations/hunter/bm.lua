local fetch = ProbablyEngine.interface.fetchKey

local lib = function()
	mts.Splash()

	ProbablyEngine.toggle.create(
		'resspet', 
		'Interface\\Icons\\Inv_misc_head_tiger_01.png', 
		'Auto Ress Pet', 
		'Automatically ress your pet when it dies.')
	ProbablyEngine.toggle.create(
		'mts_SAoE', 
		'Interface\\AddOns\\Probably_MrTheSoulz\\media\\toggle.blp', 
		'Smart AoE', 
		'Smart AoE\nTo Force AoE enable multitarget toggle.')
	
end

local inCombat = {
		
	-- Pause if fake death
		{ "pause","player.buff(5384)" }, -- Pause for Feign Death

	-- keybinds
		{ "60192", "modifier.shift", "target.ground" }, -- Freezing Trap
  		{ "82941", "modifier.shift", "target.ground" }, -- ice Trap

  	-- aggro
  		{"5384", "player.aggro >= 100" }, -- fake death

	-- buffs
		{"77769", "!player.buff(77769)"}, -- trap launcher
	
	-- moving
		{ "172106", {-- Aspect of the fox
			"modifier.cooldowns",
			"player.moving"
		} },

	-- Pet
  		{ "!/cast [@pet,dead] Revive Pet; Call Pet 1", {
			"!pet.alive",
			"toggle.resspet"
		} },
  		{ "53271", "player.state.stun" }, -- Mastrer's Call
   		{ "53271", "player.state.root" }, -- Mastrer's Call
   		{ "53271", "player.state.snare" }, -- Mastrer's Call
  		{ "136", { -- mend pet
			"pet.health <= 75", 
			"pet.exists", 
			"!pet.buff(Mend Pet)" 
		}}, 

	-- Interrupts
  		{ "147362", "target.interruptAt(50)" }, -- Counter Shot at 70% cast time left

	-- Cooldowns
		{ "121818", "modifier.cooldowns" },--Stampede
		{ "131894", "modifier.cooldowns" },-- A Murder of Crows
		{ "19574", { -- Bestial Wrath
			"player.focus > 60", 
			"modifier.cooldowns" 
		}},
		{ "120679", "modifier.cooldowns" }, -- Dire Beast
		
	-- Survival
		{ "109304", "player.health < 50" }, -- Exhiliration
		{ "19263", "player.health < 10" }, -- Deterrence as a last resort
		{ "#5512", "player.health < 40" }, -- Healthstone
		{ "136", { -- Mend Pet
			"pet.health <= 75", 
			"pet.exists", 
			"!pet.dead", 
			"!pet.buff(136)" 
		}},

	-- Missdirect
		{ "34477", { 
			"focus.exists", 
			"!player.buff(35079)", 
			"target.threat > 60" 
		}, "focus" },
		{ "34477", { 
			"pet.exists", 
			"!pet.dead", 
			"!player.buff(35079)", 
			"!focus.exists", 
			"target.threat > 85" 
		}, "pet" },

		-- Proc's
			{ "Focus Fire", "player.buff(Frenzy).count = 5" },

		-- aoe fallback
			{"2643", "modifier.multitarget"}, -- Multi-Shot
		
		{{-- can use FH

			-- AoE smart
				{"2643","player.area(35).enemies > 4", "target"}, -- Multi-Shot
				{"13813", nil, "target.ground"}, --Explosive Trap

		}, "toggle.mts_SAoE" },

		-- Rotation
			{ "53351" },--Kill Shot
			{ "34026" },--Kill Command
			{ "Focusing Shot", "player.focus < 50" },
			{ "77767", { --Cobra Shot
				"player.buff(Steady Focus).duration < 5", 
				"player.focus < 50" 
			}},
			{ "Glaive Toss" },
			{ "Barrage" },
			{ "Powershot", "player.timetomax > 2.5" },
			{ "3044", { --Arcane Shot
				"player.buff(Thrill of the Hunt)", 
				"player.focus > 35"
			}},
			{ "3044", "player.buff(Bestial Wrath)" },--Arcane Shot
			{ "3044", "player.focus >= 64" },--Arcane Shot
			{ "77767" },--Cobra Shot
  
}

local outCombat = {

	-- buffs
		{"77769", "!player.buff(77769)"}, -- trap launcher

	-- keybinds
  		{ "60192", "modifier.shift", "target.ground" }, -- Freezing Trap
  		{ "82941", "modifier.shift", "target.ground" }, -- ice Trap

}

ProbablyEngine.rotation.register_custom(253, mts.Icon.."|r[|cff9482C9MTS|r][|cffABD473Hunter-BM|r]", inCombat, outCombat, lib)