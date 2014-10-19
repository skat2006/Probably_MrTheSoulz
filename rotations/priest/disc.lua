--[[ ///---INFO---////
//Priest Disc//
Thank You For Using My ProFiles
I Hope Your Enjoy Them
MTS
]]--

local exeOnLoad = function()

	ProbablyEngine.toggle.create( 'painSup', 'Interface\\Icons\\Spell_holy_painsupression.png', 'Pain Suppression', 'Toggle Enables Pain Suppression')
	ProbablyEngine.toggle.create( 'mouseOver', 'Interface\\Icons\\Priest_spell_leapoffaith_a', 'MouseOver Heal', 'Toggle Mouse-Over Healing')

end

local inCombat = {
	
	
  -- Maintain these buffs
    { "21562", {"!player.buff(21562).any","!player.buff(588)"}}, -- Fortitude
    { "588", "!player.buff(588)" }, -- Inner Fire
    { "89485" }, -- Inner Focus
	{ "81700", "player.buff(81661).count = 5" },--Archangel
	{ "109964", "modifier.lshift" }, --Spirit Shell
	{ "596", {"player.buff(109964)","player.buff(109964).duration > 2.5"}, "lowest" }, --Prayer of Healing
	
  -- Mana/Survival
  
	{ "123040", {"player.mana < 75","target.spell(123040).range"}, "target" }, --Mindbender
	{ "34433", {"player.mana < 75","target.spell(34433).range"}, "target" },	 --Shadowfiend
	{ "129250", { "!toggle.mouseOver","target.spell(129250).range" }, "target" },-- Power Word: Solace
	{ "19236", {"player.health <= 20" }, "Player" }, --Desperate Prayer
	{ "64901", {"player.mana < 70"}, "player"}, --Hymn of hope

  --HEALTHSTONE 
	{ "#5512", "player.health <= 35" },

  --Agro
	{ "586", "target.threat >= 80" }, -- Fade
	
  --Immerseus mouseover healing
    { "!47540", { "@mtsLib.mouseover","mouseover.spell(47540).range"}, "mouseover" },  
	{ "!2061", {"@mtsLib.mouseover","mouseover.spell(2061).range"}, "mouseover" }, --Flash Heal
	
  --Mouse Over Healing
    { "47540", {"toggle.mouseOver","mouseover.spell(47540).range"}, "mouseover" },  -- Penance 
	{ "2061", {"toggle.mouseOver","mouseover.spell(2061).range"}, "mouseover" }, --Flash Heal
 
  --Dispel SoO 
    {"!527", {"!modifier.last","player.spell(527).casted < 1","@coreHealing.needsDispelled('Shadow Word: Bane')"}, nil },
    { "!527", {"!modifier.last","player.debuff(146595)","@coreHealing.needsDispelled('Mark of Arrogance')" }, nil },
    { "!527", {"!modifier.last","@coreHealing.needsDispelled('Corrosive Blood')"}, nil },
 	{ "!527", {"!modifier.last","@coreHealing.needsDispelled('Harden Flesh')"}, nil },
 	{ "!527", {"!modifier.last","@coreHealing.needsDispelled('Torment')"}, nil },
 	{ "!527", {"!modifier.last","@coreHealing.needsDispelled('Breath of Fire')"}, nil },
	
  --Tier6 CD's - CD's
	{ "121135", "modifier.lcontrol", "player" },  --Cascade
	{ "120517", "modifier.lcontrol", "player" }, --Halo
	{ "110744", "modifier.lcontrol", "player" }, --Divine Star
	{ "!62618", "modifier.rshift", "ground" }, --Power Word: Barrier
	{ "10060", "modifier.cooldowns" }, --Power Infusion
	{ "!32375", "modifier.rcontrol", "ground" }, --Mass Dispel
	{ "!48045", "modifier.ralt", "target" }, -- Mind Sear
	{ "33206", { "toggle.painSup","lowest.health <= 25 ","lowest.spell(33206).range"}, "lowest" }, --Pain Suppression
    { "596", { "!player.moving","modifier.lalt","lowest.spell(596).range" }, "lowest" }, --Prayer of Healing

	 -- stop casting Thok Deafening Screech
    	{ "/stopcasting", "@mtsLib.stopCast(boss1)" },
	
	-- MALKOROK ROTATION
    {{

	    -- Tank
		    { "17", {"@mtsLib.checkRapture","!tank.debuff(6788).any","!tank.buff(17).any","tank.spell(17).range"}, "tank" }, --Power Word: Shield
			{ "33076", { "tank.health <= 95","tank.spell(33076).range"}, "tank" },--Prayer of Mending
		  
		-- Raid Healing
			{ "596", {"!player.moving","player.buff(137323)","lowest.spell(596).range"}, "lowest" }, --Prayer of Healing /Lucidity proc
			{ "47540", {"lowest.spell(47540).range"}, "lowest" }, --Penance
			{ "596", {"!player.moving","lowest.spell(596).range"}, "lowest" }, --Prayer of Healing
		  
		--Attonement   
			{ "14914", {"!toggle.mouseOver","player.mana > 20","player.buff(81661).count < 5","target.spell(14914).range" }, "target" }, --Holy Fire
			{ "47540", {"player.mana > 20","player.buff(81661).count < 5","target.spell(47540).range"}, "target"}, --Penance
		 	{ "585", {"player.mana > 20","!player.moving","player.buff(81661).count < 5","target.spell(585).range"}, "target" },   --Smite

			{ "/targetenemy [noexists]", "!target.exists" },
			{ "/focus [@targettarget]" },
			{ "/target [target=focustarget, harm, nodead]", "target.range > 40" },
	  
	}, "@mtsLib.bossCheck()" },
	
   -- MAIN ROTATION
	
	   -- Tank
	    { "17", {"@mtsLib.checkRapture","!tank.debuff(6788).any","!tank.buff(17).any","tank.spell(17).range"}, "tank" }, --Power Word: Shield
	    { "108968", {"!tank.player","player.health >= 75","tank.health <= 30","tank.spell(108968).range"}, "tank" }, --Void Shift
		{ "32546", {"!tank.player","tank.health <= 40","player.health <= 60","tank.spell(32546).range"}, "tank" }, --Binding Heal
	    { "2061", {"!player.moving","tank.health <= 40","target.spell(2061).range"}, "tank" }, --Flash Heal
		{ "139", {"!tank.buff(139)","tank.debuff(6788).any","!player.spell(33076).cooldown","tank.health < 100","tank.spell(139).range"}, "tank" }, --Renew
		{ "33076", {"tank.health <= 95","tank.spell(33076).range"}, "tank" }, --Prayer of Mending
		
	    
	  -- Raid Healing
	    { "!596", {"!modifier.last","!player.moving","player.buff(137323)","lowest.spell(596).range"}, "lowest" },--Prayer of Healing /Lucidity proc
		{ "2050", {"lowest.health <= 65","player.mana <= 20","lowest.spell(2050).range"}, "lowest" }, -- Heal
	    { "2061", {"!player.moving","lowest.health <= 20","lowest.spell(2061).range"}, "lowest" }, --Flash Heal
		{ "17", {"!lowest.debuff(6788).any","!lowest.buff(17).any","lowest.health <= 30","lowest.spell(17).range"}, "lowest" }, --Power Word: Shield
		{ "2060", {"!player.moving","lowest.health <= 50","lowest.spell(2060).range"}, "lowest" }, --Greater Healing
		{ "47540", {"lowest.health <= 75","lowest.spell(47540).range"}, "lowest" }, --Penance

	  --Attonement    
		{ "14914", {"!toggle.mouseOver","player.mana > 20","target.spell(14914).range" }, "target" }, --Holy Fire
		{ "47540", {"player.mana > 20","target.spell(47540).range"}, "target"}, --Penance
	 	{ "585", {"player.mana > 20","!player.moving","target.spell(585).range"}, "target" }, --Smite
		

		{ "/targetenemy [noexists]", "!target.exists" },
		{ "/focus [@targettarget]" },
		{ "/target [target=focustarget, harm, nodead]", "target.range > 40" },

}
	
local outCombat = {

    { "47540", {"toggle.mouseOver","mouseover.spell(47540).range"}, "mouseover" },  --Penance
	{ "2061", {"toggle.mouseOver","mouseover.spell(2061).range"}, "mouseover" },  --Flash Heal
    { "21562", {"!player.buff(21562).any","!player.buff(588)"}}, -- Fortitude
    { "588", "!player.buff(588)" }, --Inner Fire
	{ "47540", {"lowest.health <= 85","lowest.spell(47540).range"}, "lowest" }, --Penance
	{ "2061", {"!player.moving","lowest.health <= 75","lowest.spell(2061).range"}, "lowest" }, --Flash Heal
	{ "596", {"!player.moving","@coreHealing.needsHealing(90, 4)","lowest.spell(596).range"}, "lowest" }, --Prayer of Healing

}

local inCombatSolo = {	

  --Buffs
	{ "21562", "!player.buff(21562).any" }, --Fortitude
    { "588", "!player.buff(588)" }, --Inner Fire
	{ "81700", "player.buff(81661).count = 5" },  --Archangel 
	
	--Tier6 CD's
	{ "121135", "modifier.lcontrol", "player" }, --Cascade
	{ "120517", "modifier.lcontrol", "player" }, --Halo
	{ "110744", "modifier.lcontrol", "player" }, --Divine Star
	{ "10060", "modifier.cooldowns" },
	
  --Dispel
    { "527", "player.dispellable(527)", "player" }, --Purify
	{ "527", "@coreHealing.needsDispelled('Aqua Bomb')" },
	
  -- Mana
	{ "123040", {"player.mana < 75","target.spell(123040).range"}, "target" }, --Mindbender
	{ "34433", {"player.mana < 75", "target.spell(34433).range" }, "target" }, --Shadowfiend
	
  --DPS
    { "17", {"!player.debuff(6788).any","!player.buff(17).any","player.health <= 60"}}, --Power Word Shield
	{ "2061", "player.health <= 35", "Player" }, --Flash Heal
	{ "589", {"target.debuff(589).duration < 2","target.spell(589).range"}, "target" }, --Shadow Word:Pain
	{ "129250", {"target.spell(129250).range"}, "target" }, -- Power Word: Solace
	{ "14914", {"target.spell(14914).range"}, "target" }, --Holy Fire
	{ "47540", "target.spell(47540).range", "target" }, --Penance 
	{ "585", "target.spell(585).range", "target" },	--Smite
	{ "32379", {"target.health < 20","target.spell(32379).range" }, "target" }, -- Shadow Word: Death

}
	
local outCombatSolo = {

    { "21562", "!player.buff(21562).any" }, --Fortitude
    { "588", "!player.buff(588)" }, --Inner Focus
	{ "47540", "player.health < 100" }, --Penance   
	
}

ProbablyEngine.rotation.register_custom(256, "|r[|cff9482C9MTS|r][|cffF58CBAPriest-Dist-Raid/Party|r]", inCombat, outCombat, exeOnLoad)
ProbablyEngine.rotation.register_custom(256, "|r[|cff9482C9MTS|r][|cffF58CBAPriest-Dist-Solo|r]", inCombatSolo, outCombatSolo, exeOnLoad)