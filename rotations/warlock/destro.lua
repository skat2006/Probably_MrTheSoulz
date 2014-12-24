--[[ ///---INFO---////
//Priest Disc//
Thank You For Using My ProFiles
I Hope Your Enjoy Them
MTS
]]--

local fetch = ProbablyEngine.interface.fetchKey

local exeOnLoad = function()
mts_Splash("|cff9482C9[MTS]-|cffFFFFFF"..(select(2, GetSpecializationInfo(GetSpecialization())) or "Error").."-|cff9482C9Loaded", 5.0)

	ProbablyEngine.toggle.create('autotarget', 'Interface\\Icons\\Ability_spy.png', 'Auto Target', 'Automatically target the nearest enemy when target dies or does not exist')

end

local inCombat = {
	
	-- Keybinds
		{ "Rain of Fire", "modifier.alt", "ground" },

	-- Auto Target
		{ "/cleartarget", {
	      "toggle.autotarget",
	      (function() return UnitIsFriend("player","target") end)
	      }},
		{ "/target [target=focustarget, harm, nodead]", "target.range > 40" },
		{ "/targetenemy [noexists]", { "toggle.autotarget", "!target.exists" }},
   		{ "/targetenemy [dead]", { "toggle.autotarget", "target.exists", "target.dead" }},

	--Buffs
		{ "Dark Intent", "!player.buff" },
  		{ "Curse of the Elements", "!target.debuff" },

	-- Cooldowns
  		{"Dark Soul: Instability", {"modifier.shift", "modifier.cooldowns"}},
  		{"Summon Terrorguard", {"modifier.control", "modifier.cooldowns"}},
  		{"Summon Doomguard", {"modifier.control", "modifier.cooldowns"}},

	-- Moving
		{ "Incinerate", {"player.spell(Kil'jaeden's Cunning).exists", "player.moving"} },
  		{ "Fel Flame", {"!player.spell(Kil'jaeden's Cunning).exists", "player.moving"} }, 	

	{{-- can use FH

   	 	{"Fire and Brimstone","player.area(10).enemies >= 3", "target"}, -- smarth

  	}, (function() return fetch('mtsconf','Firehack') end) },
		
	-- AoE
		{"Fire and Brimstone", "modifier.multitarget", "target"},

  	-- Rotation
	  	{"Shadowburn", "target.health <=20", "target"},
	  	{"Immolate", "target.debuff(Immolate).duration <= 4", "target"},
	  	{"Conflagrate", "player.spell(Conflagrate).charges >= 2", "target"},
	  	{"Chaos Bolt", {"!modifier.last(Chaos Bolt)", "player.embers >= 35"}, "target"},
		{"Chaos Bolt", "player.buff(Dark Soul: Instability)", "target"},
		{"Chaos Bolt", "player.buff(Skull Banner)", "target"},
	  	{"Conflagrate" },
	  	{"Incinerate" },


}

local outCombat = {

	--Buffs
		{ "Dark Intent", "!player.buff" },
  		{ "Curse of the Elements", "!target.debuff" },

	-- Keybinds
		{ "Rain of Fire", "modifier.alt", "ground" },

}

ProbablyEngine.rotation.register_custom(267, mts.Icon.."|r[|cff9482C9MTS|r][|cff9482C9Warlock-Destro|r]", inCombat, outCombat, exeOnLoad)
