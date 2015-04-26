--[[ ///---INFO---////
//Priest Disc//
Thank You For Using My ProFiles
I Hope Your Enjoy Them
MTS
]]--

local fetch = ProbablyEngine.interface.fetchKey

local exeOnLoad = function()
	mts.Splash()
	ProbablyEngine.toggle.create(
		'mts_SAoE', 
		'Interface\\AddOns\\Probably_MrTheSoulz\\media\\toggle.blp', 
		'Smart AoE', 
		'Smart AoE\nTo Force AoE enable multitarget toggle.')
end

local inCombat = {
	
	-- Keybinds
		{ "Rain of Fire", "modifier.alt", "ground" },

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

  	}, "toggle.mts_SAoE" },
		
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
