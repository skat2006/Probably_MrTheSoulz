--[[ ///---INFO---////
//Priest Disc//
Thank You For Using My ProFiles
I Hope Your Enjoy Them
MTS
]]--

local exeOnLoad = function()

	ProbablyEngine.toggle.create('autotarget', 'Interface\\Icons\\Ability_spy.png', 'Auto Target', 'Automatically target the nearest enemy when target dies or does not exist')
	mtsStart:message("\124cff9482C9*MrTheSoulz - Warlock-Destro - Loaded*")


end

local Shared = {

	--Buffs
		{ "Dark Intent", "!player.buff" },
  		{ "Curse of the Elements", "!target.debuff" },

}

local inCombat = {
	
	-- Keybinds
		{ "Rain of Fire", "modifier.alt", "ground" },

	-- Auto Target
		{ "/target [target=focustarget, harm, nodead]", "target.range > 40" },
		{ "/targetenemy [noexists]", { "toggle.autotarget", "!target.exists" }},
   		{ "/targetenemy [dead]", { "toggle.autotarget", "target.exists", "target.dead" }},

	-- Cooldowns
  		{"Dark Soul: Instability", {"modifier.shift", "modifier.cooldowns"}},
  		{"Summon Terrorguard", {"modifier.control", "modifier.cooldowns"}},
  		{ "Summon Doomguard", {"modifier.control", "modifier.cooldowns"}},

	-- Moving
		{ "Incinerate", {"player.spell(Kil'jaeden's Cunning).exists", "player.moving"} },
  		{ "Fel Flame", {"!player.spell(Kil'jaeden's Cunning).exists", "player.moving"} }, 	

	-- AOE
		{"Fire and Brimstone", {"modifier.multitarget","modifer.enemies > 4"}, "target"}
		{"Havoc", {"modifier.multitarget","modifer.enemies < 4"}, "target"}

  	-- Rotation
	  	{"Shadowburn", "target health <=20", "target"}
	  	{"Immolate", "target.debuff(Immolate).cooldown <=4.", "target"}
	  	{"Conflagrate", "player.spell(Conflagrate).charges >= 2", "target"}
	  	{"Chaos Bolt", "!modifier.last(Chaos Bolt)", "player.embers >= 35"}, "target"},
		{"Chaos Bolt", "player.buff(Dark Soul: Instability)", "target"},
		{"Chaos Bolt", "player.buff(Skull Banner)", "target"},
	  	{"Conflagrate" },
	  	{"Incinerate" }


}

local outCombat = {

	-- Keybinds
		{ "Rain of Fire", "modifier.alt", "ground" },

}

for _, Shared in pairs(Shared) do
  inCombat[#inCombat + 1] = Shared
  inCombatSolo[#inCombatSolo + 1] = Shared
  outCombat[#outCombat + 1] = Shared
end

ProbablyEngine.rotation.register_custom(256, "|r[|cff9482C9MTS|r][|cff9482C9Warlock-Destro|r]", inCombat, outCombat, exeOnLoad)
