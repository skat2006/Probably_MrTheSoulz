ProbablyEngine.library.register('coreHunter', {
    petInRange = function()
        return (IsSpellInRange('Growl', 'target') == 1)
    end,
})

local lib = function()
	
	ProbablyEngine.toggle.create('autotarget', 'Interface\\Icons\\Ability_spy.png', 'Auto Target', 'Automatically target the nearest enemy when target dies or does not exist')
	ProbablyEngine.toggle.create('resspet', 'Interface\\Icons\\Ability_spy.png', 'Auto Ress Pet', 'Automatically ress your pet when it dies.')
	mtsStart:message("\124cff9482C9*MrTheSoulz - \124cffC41F3BDeathKnight/Blood \124cff9482C9Loaded*")

end

local Shared = {



}

local inCombat = {
	
	-- keybinds
  		{ "Freezing Trap" , "modifier.shift", "ground" },

	-- Pet
  		{ "!/cast [@pet,dead] Revive Pet; Call Pet 1", {"!pet.alive","toggle.resspet"} },
  		{ "!/cast [@pet,dead] Revive Pet; Call Pet 1", {"!pet.exists","toggle.resspet"} },

	-- Interrupts
  		{ "Silencing Shot", { "modifier.interrupts", "player.spell(Silencing Shot).cooldown = 0" }},

	-- Cooldowns
		{ "Stampede", "modifier.cooldowns" },
  		{ "A Murder of Crows", "modifier.cooldowns" },
  		{ "Dire Beast", "modifier.cooldowns" },
  		{ "Rapid Fire", "modifier.cooldowns" },

	-- Survival
  		{ "Deterrence", "player.health < 40" },
  		{ "Exhilaration", "player.health < 40" },
  		{ "Mend Pet", { "pet.health <= 75", "pet.exists", "!pet.buff(Mend Pet)" }},

	-- Auto Target
		{ "/target [target=focustarget, harm, nodead]", "target.range > 40" },
		{ "/targetenemy [noexists]", { "toggle.autotarget", "!target.exists" }},
   		{ "/targetenemy [dead]", { "toggle.autotarget", "target.exists", "target.dead" }},

	-- aoe
		{"Multi-Shot", "modifer.multitarget", "target" },
		{"Explosive Trap", "modifer.multitarget", "target.ground"},

	-- Rotation
		{"Kill Command"},
		{"Kill Shot", "target.health <= 20", "target"},
		{"Focus Fire", "player.buff(Frenzy)", "target"},
		{"Arcane Shot", "player.focus > 60", "target"},
		{"Cobra Shot", "player.focus < 60", "target"},
  
} 

local outCombat = {



}

for _, Shared in pairs(Shared) do
  inCombat[#inCombat + 1] = Shared
  outCombat[#outCombat + 1] = Shared
end


ProbablyEngine.rotation.register_custom(253, "|r[|cff9482C9MTS|r][|cffF58CBAHunter-BM|r]", inCombat, outCombat, lib)