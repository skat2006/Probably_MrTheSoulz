ProbablyEngine.library.register('coreHunter', {
    petInRange = function()
        return (IsSpellInRange('Growl', 'target') == 1)
    end,
})

local lib = function()
	
	ProbablyEngine.toggle.create('autotarget', 'Interface\\Icons\\Ability_spy.png', 'Auto Target', 'Automatically target the nearest enemy when target dies or does not exist')
	ProbablyEngine.toggle.create('resspet', 'Interface\\Icons\\Inv_misc_head_tiger_01.png', 'Auto Ress Pet', 'Automatically ress your pet when it dies.')
	mtsStart:message("\124cff9482C9*MrTheSoulz - \124cffABD473Hunter/BM \124cff9482C9Loaded*")

end

local Shared = {

	-- Buffs
		{"77769", "!player.buff(77769)"}, -- trap launcher

}

local inCombat = {
		
	-- Cancel ceetah
		{"/cancelaura Aspect of the cheetah", "player.buff(5118)"},

	-- keybinds
  		{ "60192", "modifier.shift", "ground" }, -- Freezing Trap
  		{ "82941", "modifier.shift", "ground" }, -- ice Trap

  	-- aggro
  		{"5384","player.aggro >=100 "}, -- fake death
  		--{"34477", "tank.exists", "target"}, -- misdirection

	-- moving
		{ "172106", {"modifier.cooldowns","player.moving"} },-- Aspect of the fox

	-- Pet
  		{ "!/cast [@pet,dead] Revive Pet; Call Pet 1", {"!pet.alive","toggle.resspet"} },
  		{ "!/cast [@pet,dead] Revive Pet; Call Pet 1", {"!pet.exists","toggle.resspet"} },
  		{"53271", "pet.root"},

	-- Interrupts
  		{ "147362", { "modifier.interrupts", "player.spell(147362).cooldown = 0" }}, -- counter Shot

	-- Cooldowns
		{ "121818", "modifier.cooldowns" },--Stampede
  		{ "131894", "modifier.cooldowns" }, -- A Murder of Crows
  		{ "120679", "modifier.cooldowns" },--Dire Beast

	-- Survival
  		{ "19263", "player.health < 40" },--Deterrence
  		{ "109304", "player.health < 40" },--Exhilaration
  		{ "136", { "pet.health <= 75", "pet.exists", "!pet.buff(Mend Pet)" }}, -- mend pet

	-- Auto Target
		{ "/target [target=focustarget, harm, nodead]", "target.range > 40" },
		{ "/targetenemy [noexists]", { "toggle.autotarget", "!target.exists" }},
   		{ "/targetenemy [dead]", { "toggle.autotarget", "target.exists", "target.dead" }},

	-- Proc's
		{"Focus Fire", "player.buff(Frenzy)", "target"},

	-- aoe
		{"2643", "modifier.multitarget", "target" }, -- Multi-Shot
		{"13813", nil, "target.ground"}, --Explosive Trap

	-- Rotation
		{"34023"},--Kill Command
		{"53351", "target.health <= 20", "target"},--Kill Shot
		{"3044", {"player.focus > 60", "!modifer.multitarget"}, "target"},--Arcane Shot
		{"77767", "player.focus < 60", "target"},--Cobra Shot
  
} 

local outCombat = {

	-- keybinds
  		{ "60192", "modifier.shift", "ground" }, -- Freezing Trap
  		{ "82941", "modifier.shift", "ground" }, -- ice Trap

  	-- move faster
  		{ "5118", {"player.moving", "!player.buff(5118)"} },-- Aspect of the cheetah

}

for _, Shared in pairs(Shared) do
  inCombat[#inCombat + 1] = Shared
  outCombat[#outCombat + 1] = Shared
end


ProbablyEngine.rotation.register_custom(253, "|r[|cff9482C9MTS|r][|cffABD473Hunter-BM|r]", inCombat, outCombat, lib)