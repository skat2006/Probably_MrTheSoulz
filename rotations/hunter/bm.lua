ProbablyEngine.library.register('coreHunter', {
    petInRange = function()
        return (IsSpellInRange('Growl', 'target') == 1)
    end,
})

local lib = function()
	
	ProbablyEngine.toggle.create('autotarget', 'Interface\\Icons\\Ability_spy.png', 'Auto Target', 'Automatically target the nearest enemy when target dies or does not exist')
	ProbablyEngine.toggle.create('resspet', 'Interface\\Icons\\Inv_misc_head_tiger_01.png', 'Auto Ress Pet', 'Automatically ress your pet when it dies.')
	mtsStart:message("\124cff9482C9*MTS-\124cffABD473Hunter/BM-\124cff9482C9Loaded*")
	ProbablyEngine.toggle.create( 'GUI', 'Interface\\AddOns\\Probably_MrTheSoulz\\media\\toggle.blp:36:36"', 'Open/Close GUIs','Toggle GUIs', (function() mts_ClassGUI() mts_ConfigGUI() end) )     mts_showLive()
	
end

local inCombat = {
		
	-- Pause if fake death
		{ "pause","player.buff(5384)" }, -- Pause for Feign Death

	-- keybinds
		{ "60192", "modifier.shift", "mouseover.ground" }, -- Freezing Trap
  		{ "82941", "modifier.shift", "mouseover.ground" }, -- ice Trap
  		{ "60192", "modifier.shift", "mouseover.ground" }, -- Freezing Trap

  	-- aggro
  		{"5384","player.aggro >=100 "}, -- fake death
  		--{"34477", "tank.exists", "target"}, -- misdirection

	-- buffs
		{"77769", "!player.buff(77769)"}, -- trap launcher
	
	-- moving
		{ "172106", {"modifier.cooldowns","player.moving"} },-- Aspect of the fox

	-- Pet
  		{ "!/cast [@pet,dead] Revive Pet; Call Pet 1", {"!pet.alive","toggle.resspet"} },
  		{ "!/cast [@pet,dead] Revive Pet; Call Pet 1", {"!pet.exists","toggle.resspet"} },
  		{ "53271", "player.state.stun" }, -- Mastrer's Call
   		{ "53271", "player.state.root" }, -- Mastrer's Call
   		{ "53271", "player.state.snare" }, -- Mastrer's Call
  		{ "136", { "pet.health <= 75", "pet.exists", "!pet.buff(Mend Pet)" }}, -- mend pet

	-- Interrupts
  		{ "147362", { "modifier.interrupts", "player.spell(147362).cooldown = 0" }}, -- counter Shot

	-- Cooldowns
		{ "121818", "modifier.cooldowns" },--Stampede
		{ "131894", "modifier.cooldowns" },-- A Murder of Crows
		{ "19574", { "player.focus > 60", "modifier.cooldowns" }}, -- Bestial Wrath
		{ "120679", "modifier.cooldowns" }, -- Dire Beast

	-- Survival
  		{ "19263", "player.health < 40" },--Deterrence
  		{ "109304", "player.health < 40" },--Exhilaration

	-- Auto Target
		{ "/target [target=focustarget, harm, nodead]", "target.range > 40" },
		{ "/targetenemy [noexists]", { "toggle.autotarget", "!target.exists" }},
   		{ "/targetenemy [dead]", { "toggle.autotarget", "target.exists", "target.dead" }},

		-- Proc's
			{ "Focus Fire", "player.buff(Frenzy).count = 5" },

		{{-- can use FH

			-- AoE smart
				{"2643","player.area(35).enemies > 4", "target"}, -- Multi-Shot
				{"13813", nil, "target.ground"}, --Explosive Trap

		}, {"player.firehack", "@mtsLib.getConfig('mtsconf_Firehack')"}},


		-- aoe fallback
			{"2643", "modifier.multitarget"}, -- Multi-Shot

		-- Rotation
			{ "53351" },--Kill Shot
			{ "34026" },--Kill Command
			{ "Focusing Shot", "player.focus < 50" },
			{ "77767", { "player.buff(Steady Focus).duration < 5", "player.focus < 50" }},--Cobra Shot
			{ "Glaive Toss" },
			{ "Barrage" },
			{ "Powershot", "player.timetomax > 2.5" },
			{ "3044", { "player.buff(Thrill of the Hunt)", "player.focus > 35" }},--Arcane Shot
			{ "3044", "player.buff(Bestial Wrath)" },--Arcane Shot
			{ "3044", "player.focus >= 64" },--Arcane Shot
			{ "77767" },--Cobra Shot
  
}

local outCombat = {

	-- buffs
		{"77769", "!player.buff(77769)"}, -- trap launcher

	-- keybinds
  		{ "60192", "modifier.shift", "mouseover.ground" }, -- Freezing Trap
  		{ "82941", "modifier.shift", "mouseover.ground" }, -- ice Trap
  		{ "60192", "modifier.shift", "mouseover.ground" }, -- Freezing Trap

}

ProbablyEngine.rotation.register_custom(253, mts_Icon.."|r[|cff9482C9MTS|r][|cffABD473Hunter-BM|r]", inCombat, outCombat, lib)