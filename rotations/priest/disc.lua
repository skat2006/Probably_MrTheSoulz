--[[ ///---INFO---////
//Priest Disc//
Thank You For Using My ProFiles
I Hope Your Enjoy Them
MTS
]]--

local exeOnLoad = function()

	ProbablyEngine.toggle.create('autotarget', 'Interface\\Icons\\Ability_spy.png', 'Auto Target', 'Automatically target the nearest enemy when target dies or does not exist')
	ProbablyEngine.toggle.create( 'painSup', 'Interface\\Icons\\Spell_holy_painsupression.png', 'Pain Suppression', 'Toggle Enables Pain Suppression')
	ProbablyEngine.toggle.create( 'mouseOver', 'Interface\\Icons\\Priest_spell_leapoffaith_a', 'MouseOver Heal', 'Toggle Mouse-Over Healing')
	ProbablyEngine.toggle.create( 'feather', 'Interface\\Icons\\Ability_priest_angelicfeather.png', "Use Feather's", "Toggle Enables The Use Of Feather's")
	ProbablyEngine.toggle.create('dispel', 'Interface\\Icons\\Ability_paladin_sacredcleansing.png', 'Dispel Everything', 'Dispels everything it finds \nThis does not effect SoO dispels.')
	mtsStart:message("\124cff9482C9*MrTheSoulz - \124cF58CBAPriest-Dist - \124cff9482C9Loaded*")


end

local Shared = {

	-- buffs
		{ "21562", {"!player.buff(21562).any","!player.buff(588)"}}, -- Fortitude
		{ "81700", "player.buff(81661).count = 5" },--Archangel
		{ "121536", {"player.moving", "toggle.feather", "!player.buff(121557)", "player.spell(121536).charges >= 1" }, "player.ground" },
		--{ "121536", {"tank.moving", "toggle.feather", "!tank.buff(121557)", "player.spell(121536).charges >= 1" }, "tank.ground" },
	
	--keybinds
		{ "32375", "modifier.rcontrol", "player.ground" }, --Mass Dispel
	 	{ "62618", "modifier.rshift", "tank.ground" }, --Power Word: Barrier
	 	{ "48045", "modifier.ralt", "tank" }, -- Mind Sear
	 	{ "121135", "modifier.lcontrol", "player" },  --Cascade
		{ "120517", "modifier.lcontrol", "player" }, --Halo
		{ "110744", "modifier.lcontrol", "player" }, --Divine Star
		{ "109964", "modifier.lshift" }, --Spirit Shell

	-- Auto Targets
		{ "/target [target=focustarget, harm, nodead]", { "toggle.autotarget", "target.range > 40" }},
		{ "/targetenemy [noexists]", { "toggle.autotarget", "!target.exists" }},
   		{ "/targetenemy [dead]", { "toggle.autotarget", "target.exists", "target.dead" }},

   	-- Mouse Over
	    { "47540", { "toggle.mouseOver", "!player.moving" }, "mouseover" },  --Penance
		{ "2061", { "toggle.mouseOver", "!player.moving" }, "mouseover" },  --Flash Heal


}

local inCombat = {
	
  	-- Mana/Survival
		{ "123040", {"player.mana < 75","target.spell(123040).range"}, "target" }, --Mindbender
		{ "34433", {"player.mana < 75","target.spell(34433).range"}, "target" },	 --Shadowfiend
		{ "19236", {"player.health <= 20" }, "Player" }, --Desperate Prayer
		{ "64901", {"player.mana < 70"}, "player"}, --Hymn of hope

  	-- HEALTHSTONE 
		--{ "#5512", "player.health <= 35" }, -- Its bugged

  	-- Aggro
		{ "586", "target.threat >= 80" }, -- Fade
 
  	-- Dispel's
	    { "!527", {"!modifier.last","player.spell(527).casted < 1","@coreHealing.needsDispelled('Shadow Word: Bane')"}, nil },
	    { "!527", {"!modifier.last","player.debuff(146595)","@coreHealing.needsDispelled('Mark of Arrogance')" }, nil },
	    { "!527", {"!modifier.last","@coreHealing.needsDispelled('Corrosive Blood')"}, nil },
	 	{ "!527", {"!modifier.last","@coreHealing.needsDispelled('Harden Flesh')"}, nil },
	 	{ "!527", {"!modifier.last","@coreHealing.needsDispelled('Torment')"}, nil },
	 	{ "!527", {"!modifier.last","@coreHealing.needsDispelled('Breath of Fire')"}, nil },
	 	{ "527", { "toggle.dispel", "@mtsLib.Dispell('Cleanse')" }, nil },

  	-- CD's
		{ "10060", "modifier.cooldowns" }, --Power Infusion
		{ "33206", { "toggle.painSup","lowest.health <= 25 " }, "lowest" }, --Pain Suppression
	    { "596", { "!player.moving","modifier.lalt" }, "lowest" }, --Prayer of Healing
	
   -- AOE
   		--Shared
   			{ "596", {"player.buff(109964)","player.buff(109964).duration > 2.5"}, "lowest" }, --Prayer of Healing
		-- Party
			{ "596", { "@coreHealing.needsHealing(80, 3)", "modifier.party", "!player.moving" }, "lowest" }, --Prayer of Healing
			--{ "132157", { "@coreHealing.needsHealing(95, 3)", "!modifier.last", "@mtsLib.FHFriendlyCheck('player', 12) >= 2", "modifier.party" }, "lowest" }, -- Holy NOva
		-- RAID
			{ "596", { "@coreHealing.needsHealing(80, 5)", "modifier.party", "!player.moving" }, "lowest" }, --Prayer of Healing
			--{ "132157", { "@coreHealing.needsHealing(95, 5)", "!modifier.last", "@mtsLib.FHFriendlyCheck('player', 12) >= 2", "modifier.party" }, "lowest" }, -- Holy NOva
		-- Raid 25
			{ "596", { "@coreHealing.needsHealing(80, 8)", "modifier.party", "!player.moving" }, "lowest" }, --Prayer of Healing
			--{ "132157", { "@coreHealing.needsHealing(95, 8)", "!modifier.last", "@mtsLib.FHFriendlyCheck('player', 12) >= 2", "modifier.party" }, "lowest" }, -- Holy NOva

   -- MAIN ROTATION

	   	-- Tank
		    { "17", { "!tank.debuff(6788).any","!tank.buff(17).any","tank.spell(17).range"}, "tank" }, --Power Word: Shield
		    { "108968", {"!tank.player","player.health >= 75","tank.health <= 30","tank.spell(108968).range"}, "tank" }, --Void Shift
			{ "32546", {"!tank.player","tank.health <= 40","player.health <= 60","tank.spell(32546).range"}, "tank" }, --Binding Heal
		    { "2061", {"!player.moving","tank.health <= 40","target.spell(2061).range"}, "tank" }, --Flash Heal
			{ "33076", {"tank.health <= 95","tank.spell(33076).range"}, "tank" }, --Prayer of Mending

	  	-- Singe Target
	  		{ "17", { "!lowest.debuff(6788).any","!lowest.buff(17).any","lowest.health <= 30"}, "lowest" }, --Power Word: Shield
			{ "2050", { "lowest.health <= 65","player.mana <= 20", "!player.moving" }, "lowest" }, -- Heal
		    { "2061", { "!player.moving","lowest.health <= 20"}, "lowest" }, --Flash Heal
			{ "2060", { "!player.moving","lowest.health <= 50" }, "lowest" }, --Greater Healing
			{ "47540", { "lowest.health <= 75", "!player.moving" }, "lowest" }, --Penance

	  	--Attonement    
			{ "14914", {"!toggle.mouseOver","player.mana > 20","target.spell(14914).range" }, "target" }, --Holy Fire
			{ "47540", {"player.mana > 20","target.spell(47540).range"}, "target", "!player.moving" }, --Penance
		 	{ "585", {"player.mana > 20","!player.moving","target.spell(585).range"}, "target" }, --Smite

}

local inCombatSolo = {

  	-- Mana
		{ "123040", { "player.mana < 75","target.spell(123040).range" }, "target" }, --Mindbender
		{ "34433", { "player.mana < 75", "target.spell(34433).range" }, "target" }, --Shadowfiend

	-- Heal
		{ "17", { "!player.debuff(6788).any", "!player.buff(17).any", "player.health <= 60" }}, --Power Word Shield
		{ "2061", "player.health <= 35", "Player" }, --Flash Heal

  	--DPS
		{ "589", { "target.debuff(589).duration < 2","target.spell(589).range"}, "target" }, --Shadow Word:Pain
		{ "129250", { "target.spell(129250).range" }, "target" }, -- Power Word: Solace
		{ "14914", { "target.spell(14914).range" }, "target" }, --Holy Fire
		{ "47540", "target.spell(47540).range", "target" }, --Penance 
		{ "585", "target.spell(585).range", "target" },	--Smite
		{ "32379", {"target.health < 20","target.spell(32379).range" }, "target" }, -- Shadow Word: Death

}

local outCombat = {

	--Heal
	    { "21562", { "!player.buff(21562).any","!player.buff(588)" }}, -- Fortitude
		{ "47540", { "lowest.health <= 85", "!player.moving" }, "lowest" }, --Penance
		{ "2061", { "!player.moving", "lowest.health <= 75" }, "lowest" }, --Flash Heal
		{ "596", { "!player.moving", "@coreHealing.needsHealing(90, 4)" }, "lowest" }, --Prayer of Healing

}

for _, Shared in pairs(Shared) do
  inCombat[#inCombat + 1] = Shared
  inCombatSolo[#inCombatSolo + 1] = Shared
  outCombat[#outCombat + 1] = Shared
end

ProbablyEngine.rotation.register_custom(256, "|r[|cff9482C9MTS|r][|cffF58CBAPriest-Dist-Raid/Party|r]", inCombat, outCombat, exeOnLoad)
ProbablyEngine.rotation.register_custom(256, "|r[|cff9482C9MTS|r][|cffF58CBAPriest-Dist-Solo|r]", inCombatSolo, outCombat, exeOnLoad)