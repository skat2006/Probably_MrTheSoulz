local fetch = ProbablyEngine.interface.fetchKey

local exeOnLoad = function()
	
	mts.Splash("|cff9482C9[MTS]|r-[|cffF58CBAPaladin-Retribution|r]-|cff9482C9Loaded", 5.0)
	ProbablyEngine.toggle.create(
		'smartae', 
		'Interface\\Icons\\spell_holy_sealofrighteousness', 
		'Enable Smart AE', 
		'Enable automatic detection of Area or Single target rotations.')
	ProbablyEngine.toggle.create(
		'burn', 
		'Interface\\Icons\\spell_holy_sealofblood', 
		'Single Target Burn', 
		'Force single target rotation for burn phases.')
end

	---------------------------------------------------------------------------
	-------------------------- Akeon's Imported (cool but messy) --------------
	---------------------------------------------------------------------------

local combat_rotation = {
	-- Rotation Utilities
	{ "pause", "modifier.lalt" },

{{ -- not burn
	-- Mouseovers
	{ "Light's Hammer", "modifier.lcontrol", "mouseover.ground" },
	{ "Cleanse", { 
		"modifier.lshift", 
		"!modifier.last(Cleanse)", 
		"mouseover.exists", 
		"mouseover.alive", 
		"mouseover.friend", 
		"mouseover.range <= 40", 
		"mouseover.dispellable(Cleanse)"
	}, "mouseover" },
	
	-- Self Heals
	{ "Flash of Light", { 
		"player.buff(Selfless Healer).count = 3", 
		(function() return mts.dynamicEval("player.health <= " .. fetch('mtsconfPalaRet', 'flashoflight_spin')) end), 
		(function() return fetch('mtsconfPalaRet', 'flashoflight_check') end) 
	}},
	{ "Word of Glory", { 
		"player.holypower >= 3", 
		(function() return mts.dynamicEval("player.health <= " .. fetch('mtsconfPalaRet', 'wordofglory_spin')) end), 
		(function() return fetch('mtsconfPalaRet', 'wordofglory_check') end) 
	}},
	{ "Lay on Hands", { 
		(function() return mts.dynamicEval("player.health <= " .. fetch('mtsconfPalaRet', 'layonhands_spin')) end), 
		(function() return fetch('mtsconfPalaRet', 'layonhands_check') end) 
	}},
	{ "#5512", { -- Healthstone (5512)
		(function() return mts.dynamicEval("player.health <= " .. fetch('mtsconfPalaRet', 'healthstone_spin')) end), 
		(function() return fetch('mtsconfPalaRet', 'healthstone_check') end) 
	}},
	
	-- Survival
	{ "Eternal Flame", { 
		"player.buff(Eternal Flame).duration < 3", 
		(function() return fetch('mtsconfPalaRet', 'eternalglory') end) 
	}, "player" },
	{ "Sacred Shield", { 
		"player.buff(Sacred Shield).duration < 7", 
		"target.range > 3", 
		(function() return fetch('mtsconfPalaRet', 'sacredshield') end) 
	}, "player" },
	{ "Hand of Freedom", { 
		"!player.buff", 
		"player.state.snare", 
		(function() return fetch('mtsconfPalaRet', 'handoffreedom') end) 
	}, "player" },
	{ "Hand of Freedom", { 
		"!player.buff", 
		"player.state.root", 
		(function() return fetch('mtsconfPalaRet', 'handoffreedom') end) 
	}, "player" },
	{ "Emancipate", { 
		"!modifier.last(Emancipate)", 
		"player.state.root", 
		(function() return fetch('mtsconfPalaRet', 'emancipate') end) 
	}, "player" },
	{ "Cleanse", { 
		"!modifier.last(Cleanse)", 
		"player.dispellable(Cleanse)", 
		(function() return fetch('mtsconfPalaRet', 'cleanse') end) 
	}, "player" },
	{ "Divine Shield", { 
		(function() return mts.dynamicEval("player.health <= " .. fetch('mtsconfPalaRet', 'divineshield_spin')) end), 
		(function() return fetch('mtsconfPalaRet', 'divineshield_check') end) 
	}},
	
	{{	-- Seals (No Twisting)
		{ "Seal of Truth", { 
			"!toggle.smartae", 
			"!modifier.multitarget", 
			"player.seal != 1" 
		}},
		{ "Seal of Righteousness", { 
			"!toggle.smartae", 
			"modifier.multitarget", 
			"player.seal != 2" 
		}},
		-- Seals SmartAE (No Twisting)
		{ "Seal of Truth", { 
			"toggle.smartae", 
			"!modifier.multitarget", 
			"player.seal != 1", 
			"player.area(8).enemies <= 4" 
		}},
		{ "Seal of Righteousness", { 
			"toggle.smartae", 
			"player.seal != 2", 
			"player.area(8).enemies > 4" 
		}},
	}, "!talent(7, 1)" },
	
	{{ --TalentRow 7 Empowered Seals (Twisting)
					
		{ "Seal of Truth", { 
			"player.seal != 1", 
			"!player.buff(Maraad's Truth).duration > 3", 
			"player.spell(Judgment).cooldown <= 1" 
		}},
		{ "Seal of Righteousness", { 
			"player.seal != 2", 
			"!player.buff(Liadrin's Righteousness).duration > 3", 
			"player.buff(Maraad's Truth)", 
			"player.spell(Judgment).cooldown <= 1" 
		}},
		{ "Seal of Justice", { 
			"player.seal != 3", 
			"!player.buff(Turalyon's Justice).duration > 3", 
			"player.buff(Maraad's Truth)", 
			"player.buff(Liadrin's Righteousness)", 
			"player.spell(Judgment).cooldown <= 1", 
			(function() return fetch("mtsconfPalaRet", "twisting") == 'justice' end) 
		}},
		{ "Seal of Insight", { 
			"player.seal != 4", 
			"!player.buff(Uther's Insight).duration > 3", 
			"player.buff(Maraad's Truth)", 
			"player.buff(Liadrin's Righteousness)", 
			"player.spell(Judgment).cooldown <= 1", 
			(function() return fetch("mtsconfPalaRet", "twisting") == 'insight' end) 
		}},
	
		{ "Seal of Righteousness", { -- AE Waiting
			"player.seal != 2", 
			"player.spell(Judgment).cooldown > 1", 
			"modifier.multitarget" 
		}}, 
		{ "Seal of Truth", { -- ST Waiting
			"player.seal != 1", 
			"player.spell(Judgment).cooldown > 1", 
			"!modifier.multitarget", 
			"!toggle.smartae" 
		}},
		{{-- SmartAE Waiting	
			{ "Seal of Righteousness", { 
				"player.seal != 2", 
				"player.area(10).enemies > 4", 
				"player.spell(Judgment).cooldown > 1" 
			}},
			{ "Seal of Truth", { 
				"player.seal != 1", 
				"!modifier.multitarget", 
				"player.area(10).enemies <= 4", 
				"player.spell(Judgment).cooldown > 1" 
			}}
		}, "toggle.smartae" },

		{ "Judgment", { 
			"glyph(Double Jeopardy)", 
			"target.exists", 
			"target.enemy", 
			"target.judgement", 
			"!player.buff(Liadrin's Righteousness).duration < 3" 
		}, "target" },
		{ "Judgment", { 
			"glyph(Double Jeopardy)", 
			"focus.exists", 
			"focus.enemy", 
			"focus.judgement", 
			"!player.buff(Liadrin's Righteousness).duration < 3" 
		}, "focus" },
		{ "Judgment", { 
			"glyph(Double Jeopardy)", 
			"target.exists", 
			"target.enemy", 
			"target.judgement", 
			"!player.buff(Maraad's Truth).duration < 3" 
		}, "target" },
		{ "Judgment", { 
			"glyph(Double Jeopardy)", 
			"focus.exists", 
			"focus.enemy", 
			"focus.judgement", 
			"!player.buff(Maraad's Truth).duration < 3" 
		}, "focus" },
		
		{ "Judgment", "!player.buff(Liadrin's Righteousness).duration < 3" },
		{ "Judgment", "!player.buff(Maraad's Truth).duration < 3" }
	}, "talent(7, 1)" },	

	-- Interrupts
	{ "Rebuke", "target.interruptAt(40)" },
	
	{{  -- Raid Healing and Protection
		{ "Flash of Light", { 
			"lowest.alive", 
			"player.buff(Selfless Healer).count = 3", 
			(function() return mts.dynamicEval("lowest.health <= " .. fetch('mtsconfPalaRet', 'flashoflight_spin')) end), 
			(function() return fetch('mtsconfPalaRet', 'flashoflight_check') end) 
		}, "lowest" },
		{ "Lay on Hands", { 
			"lowest.alive", 
			(function() return mts.dynamicEval("lowest.health <= " .. fetch('mtsconfPalaRet', 'layonhands_spin')) end), 
			(function() return fetch('mtsconfPalaRet', 'layonhands_check') end) 
		}, "lowest" },
		{ "Hand of Protection", { 
			"lowest.alive", 
			"!lowest.role(tank)", 
			"!lowest.immune.melee", 
			(function() return mts.dynamicEval("lowest.health <= " .. fetch('mtsconfPalaRet', 'handoprot_spin')) end), 
			(function() return fetch('mtsconfPalaRet', 'handoprot_check') end) 
		}, "lowest" }
	}, (function() return fetch('mtsconfPalaRet', 'raidprotection') end) },
	
	  --Cooldowns
	{{ -- Seraphim CDs
		{ "Seraphim", "!target.range > 2" }, 
		{ "#trinket1", { 
			"player.buff(Avenging Wrath)",
			"!target.range > 2" 
		}}, 
		{ "#trinket2", { 
			"player.buff(Avenging Wrath)", 
			"!target.range > 2" 
		}},
		{ "Avenging Wrath", { 
			"player.buff(Seraphim).duration >= 10", 
			"modifier.cooldowns", 
			"!target.range > 2" 
		}},
		{ "Holy Avenger", { 
			"player.buff(Seraphim).duration >= 10", 
			"modifier.cooldowns",
			"!target.range > 2" 
		}}
	}, "talent(7, 2)" },

	{{	--Empowered Seals CDs  
		{ "/use 13", "player.buff(Avenging Wrath)" }, 
		{ "/use 14", "player.buff(Avenging Wrath)" }, 
		{ "/use Draenic Strength Potion", { 
			"player.buff(Avenging Wrath)", 
			"player.hashero", 
			"modifier.cooldowns" 
		}},  
		{ "Avenging Wrath" }, 
		{ "Holy Avenger", "player.holypower <= 2" }
	}, { 
		"modifier.cooldowns", 
		"talent(7, 1)", 
		"player.buff(Liadrin's Righteousness)", 
		"player.buff(Maraad's Truth)", 
		"target.distance < 3"
	}},
			
	{{	-- Final Verdict CDs  
		{ "/use 13", "player.buff(Avenging Wrath)" }, 
		{ "/use 14", "player.buff(Avenging Wrath)" }, 
		{ "/use Draenic Strength Potion", { 
			"player.buff(Avenging Wrath)", 
			"player.hashero", 
			"modifier.cooldowns" 
		}}, 
		{ "Avenging Wrath" }, 
		{ "Holy Avenger", "player.holypower <= 2" } 
	}, { 
		"modifier.cooldowns", 
		"talent(7, 3)", 
		"target.distance < 3" 
	}},
	
	{{ -- Out of range 
		{ "Execution Sentence", "target.enemy", "target" },		
		{ "Hammer of Wrath" },
		{ "Light's Hammer", nil, "target.ground" },	
		{ "Judgment" },
		{ "Exorcism", "!glyph(Mass Exorcism)" }
	}, "target.distance > 1" },
		
	{{  -- AE
		{{ --TalentRow 7 Final Verdict
			{ "Final Verdict", "player.buff(Divine Purpose)" }, 
			{ "Final Verdict", "player.holypower >= 5" }	  
		}, {
			"talent(7, 3)", 
			"!player.buff(Final Verdict)"
		}},
		{ "Divine Storm", { --TalentRow 7 Seraphim
			"player.holypower >= 3", 
			"player.buff(Holy Avenger)", 
			"talent(7, 2)", 
			"player.spell(Seraphim).cooldown >= 5" 
		}}, 
		{ "Divine Storm", { 
			"player.holypower >= 3", 
			"player.buff(Holy Avenger)", 
			"!talent(7, 2)" 
		}},
		{ "Divine Storm", "player.buff(Divine Crusader)" },
		{ "Divine Storm", "player.buff(Divine Purpose)" },
		{ "Divine Storm", "player.holypower = 5" },
		{ "Holy Prism", nil, "player" },	
		{ "Light's Hammer", nil, "target.ground" },
		{ "Hammer of Wrath" },
		{ "Hammer of the Righteous" },
		{ "Exorcism", "glyph(Mass Exorcism)" },
		{ "Judgment", { 
			"glyph(Double Jeopardy)", 
			"target.exists", 
			"target.enemy", 
			"target.judgement" 
		}, "target" },
		{ "Judgment", { 
			"glyph(Double Jeopardy)", 
			"focus.exists",
			"focus.enemy", 
			"focus.judgement" 
		}, "focus" },
		{ "Exorcism", { --T174P
			"player.buff(Blazing Contempt)", 
			"player.holypower < 3" 
		}},
		{ "Judgment" },
		{ "Exorcism" },
		{ "Execution Sentence", "target.enemy", "target" },	
		{ "Sacred Shield", { 
			"player.buff(Sacred Shield).duration < 7", 
			(function() return fetch('mtsconfPalaRet', 'sacredshield') end) 
		}, "player" },
		{ "Divine Storm", { --TalentRow 7 Seraphim
			"player.holypower >= 3", 
			"talent(7, 2)", 
			"player.spell(Seraphim).cooldown >= 10" 
		}}, 
		{ "Divine Storm", { 
			"player.holypower >= 3", 
			"!talent(7, 2)" 
		}}
	}, "modifier.multitarget" },
	
	{{  -- SmartAE
		{{ --TalentRow 7 Final Verdict
			{ "Final Verdict", "player.buff(Divine Purpose)" }, 
			{ "Final Verdict", "player.holypower >= 5" } 		  
		}, {
			"talent(7, 3)", 
			"!player.buff(Final Verdict)" 
		}},
		{ "Divine Storm", { --TalentRow 7 Seraphim
			"player.holypower >= 3", 
			"player.buff(Holy Avenger)", 
			"talent(7, 2)", 
			"player.spell(Seraphim).cooldown >= 5" 
		}}, 
		{ "Divine Storm", { 
			"player.holypower >= 3", 
			"player.buff(Holy Avenger)", 
			"!talent(7, 2)" 
		}},
		{ "Divine Storm", "player.buff(Divine Crusader)" },
		{ "Divine Storm", "player.buff(Divine Purpose)" },
		{ "Divine Storm", "player.holypower = 5" },
		{ "Holy Prism", nil, "player" },
		{ "Light's Hammer", nil, "target.ground" },	
		{ "Hammer of Wrath" },
		{ "Hammer of the Righteous", "player.area(8).enemies >= 4" },
		{ "Crusader Strike" },
		{ "Exorcism", "glyph(Mass Exorcism)" },
		{ "Judgment", { 
			"glyph(Double Jeopardy)", 
			"target.exists", 
			"target.enemy", 
			"target.judgement" 
		}, "target" },
		{ "Judgment", { 
			"glyph(Double Jeopardy)", 
			"focus.exists", 
			"focus.enemy", 
			"focus.judgement" 
		}, "focus" },
		{ "Exorcism", { --T174P
			"player.buff(Blazing Contempt)", 
			"player.holypower < 3" 
		}}, 
		{ "Judgment" },
		{ "Exorcism" },	
		{ "Execution Sentence", "target.enemy", "target" },
		{ "Sacred Shield", { 
			"player.buff(Sacred Shield).duration < 7", 
			(function() return fetch('mtsconfPalaRet', 'sacredshield') end) 
		}, "player" },
		{ "Divine Storm", { --TalentRow 7 Seraphim
			"player.holypower >= 3", 
			"talent(7, 2)", 
			"player.spell(Seraphim).cooldown > 10" 
		}}, 
		{ "Divine Storm", { 
			"player.holypower >= 3", 
			"!talent(7, 2)" 
		}}
	},{ 
		"toggle.smartae", 
		"player.area(8).enemies >= 3" 
	}}

}, "!toggle.burn" }, --Force single target rotation
	
	-- ST Rotation
	{ "Execution Sentence", "target.enemy", "target" },
	{ "Light's Hammer", nil, "target.ground" },	
	{{  --TalentRow 7 Final Verdict
		{ "Divine Storm", { 
			"player.buff(Final Verdict)", 
			"player.buff(Divine Crusader)", 
			"player.holypower >= 5" 
		}},
		{ "Final Verdict", { 
			"player.buff(Divine Purpose).duration < 3", 
			"player.buff(Divine Purpose)" 
		}},
		{ "Final Verdict", { 
			"player.buff(Holy Avenger)", 
			"player.holypower >= 3" 
		}}, 
		{ "Divine Storm", { 
			"player.buff(Divine Crusader).duration < 3", 
			"player.buff(Divine Crusader)" 
		}},
		{ "Final Verdict", "player.holypower >= 5" }
	}, "talent(7, 3)" },
	--
	{ "Templar's Verdict", { 
		"player.buff(Divine Purpose).duration < 3", 
		"player.buff(Divine Purpose)" 
	}},
	{ "Divine Storm", { 
		"player.buff(Divine Crusader).duration < 3", 
		"player.buff(Divine Crusader)" 
	}},
	{ "Templar's Verdict", { 
		"player.buff(Holy Avenger)", 
		"player.holypower >= 3" 
	}},
	{ "Templar's Verdict", "player.holypower >= 5" },
		
	{ "Hammer of Wrath" },
	{ "Exorcism", { 
		"player.buff(Blazing Contempt)", 
		"player.holypower < 3" 
	}},
	
	{{ --Execute Range / CDs active (Will cast at 3 HoPo) Final Verdict.
		{ "Divine Storm", { 
			"player.buff(Avenging Wrath)", 
			"player.buff(Final Verdict)", 
			"player.buff(Divine Crusader)" 
		}},
		{ "Divine Storm", { 
			"target.health < 20", 
			"player.buff(Final Verdict)", 
			"player.buff(Divine Crusader)" 
		}},
		{ "Final Verdict", { 
			"player.buff(Avenging Wrath)" 
		}},
		{ "Final Verdict", "player.health < 20" } 
	}, "talent(7, 3)" },
	
	{{ --Execute Range / CDs active (Will cast at 3 HoPo) Seraphim.
		{ "Templar's Verdict", "player.buff(Avenging Wrath)" },
		{ "Templar's Verdict", "player.health < 20" },
		{ "Final Verdict", "player.buff(Avenging Wrath)" },
		{ "Final Verdict", "player.health < 20" }
	}, {
		"talent(7, 2)", 
		"player.spell(Seraphim).cooldown >= 8"
	}},
	
	{{ --Execute Range / CDs active (Will cast at 3 HoPo) Empowered Seals
		{ "Templar's Verdict", "player.buff(Avenging Wrath)" },
		{ "Templar's Verdict", "player.health < 20" }
	}, "talent(7, 1)" },
	
	{ "Crusader Strike" },
	{ "Divine Storm", { 
		"player.buff(Final Verdict)", 
		"player.buff(Divine Crusader)" 
	}},
	{ "Final Verdict", "player.buff(Divine Purpose)" },	
	{ "Judgment", { 
		"glyph(Double Jeopardy)", 
		"target.exists", 
		"target.enemy", 
		"target.judgement" 
	}, "target" },
	{ "Judgment", { 
		"glyph(Double Jeopardy)", 
		"focus.exists", 
		"focus.enemy", 
		"focus.judgement" 
	}, "focus" },
	{ "Judgment" },
	{ "Templar's Verdict", "player.buff(Divine Purpose)" },
	{ "Divine Storm", { 
		"player.buff(Divine Crusader)", 
		"!talent(7, 3)" 
	}},
	{ "Holy Prism", "talent(5, 1)" },
	{ "Sacred Shield", { 
		"player.buff(Sacred Shield).duration < 7", 
		(function() return fetch('mtsconfPalaRet', 'sacredshield') end) 
	}, "player" },
	--LowHoPo GCD available
	{ "Templar's Verdict", { 
		"player.holypower = 4", 
		"talent(7, 2)", 
		"player.spell(Seraphim).cooldown > 10" 
	}},
	{ "Templar's Verdict", { 
		"player.holypower = 4", 
		"!talent(7, 2)"
	}},
	{ "Exorcism" },	
	{ "Templar's Verdict", { 
		"player.holypower = 3", 
		"talent(7, 2)", 
		"player.spell(Seraphim).cooldown > 10" 
	}},
	{ "Templar's Verdict", { 
		"player.holypower = 3", 
		"!talent(7, 2)" 
	}},

}

local oocRotation = {

	-- Pause
	{ "pause", "modifier.lcontrol" },

	{{	-- Spam Checks Wrapper
		{ "Seal of Truth", { 
			"!modifier.multitarget", 
			"player.seal != 1" 
		}},
		{ "Seal of Righteousness", { 
			"modifier.multitarget", 
			"player.seal != 2" 
		}},
	
	}, "player.alive" },

}

ProbablyEngine.rotation.register_custom(70,  mts.Icon.."|r[|cff9482C9MTS|r][|cffF58CBAPaladin-Retribution|r]", 
	combat_rotation, oocRotation, exeOnLoad)

	---------------------------------------------------------------------------
	-------------------------- Testing Area -----------------------------------
	---------------------------------------------------------------------------

local Survival = {

	{ "Eternal Flame", { 
		"player.buff(Eternal Flame).duration < 3", 
		(function() return fetch('mtsconfPalaRet', 'eternalglory') end) 
	}, "player" },
	{ "Sacred Shield", { 
		"player.buff(Sacred Shield).duration < 7", 
		"target.range > 3", 
		(function() return fetch('mtsconfPalaRet', 'sacredshield') end) 
	}, "player" },
	{ "Hand of Freedom", { 
		"!player.buff", 
		"player.state.snare", 
		(function() return fetch('mtsconfPalaRet', 'handoffreedom') end) 
	}, "player" },
	{ "Hand of Freedom", { 
		"!player.buff", 
		"player.state.root", 
		(function() return fetch('mtsconfPalaRet', 'handoffreedom') end) 
	}, "player" },
	{ "Emancipate", { 
		"!modifier.last(Emancipate)", 
		"player.state.root", 
		(function() return fetch('mtsconfPalaRet', 'emancipate') end) 
	}, "player" },
	{ "Cleanse", { 
		"!modifier.last(Cleanse)", 
		"player.dispellable(Cleanse)", 
		(function() return fetch('mtsconfPalaRet', 'cleanse') end) 
	}, "player" },
	{ "Divine Shield", { 
		(function() return mts.dynamicEval("player.health <= " .. fetch('mtsconfPalaRet', 'divineshield_spin')) end), 
		(function() return fetch('mtsconfPalaRet', 'divineshield_check') end) 
	}},

}

local SelfHeals = {

	{ "Flash of Light", { 
		"player.buff(Selfless Healer).count = 3", 
		(function() return mts.dynamicEval("player.health <= " .. fetch('mtsconfPalaRet', 'flashoflight_spin')) end), 
		(function() return fetch('mtsconfPalaRet', 'flashoflight_check') end) 
	}},
	{ "Word of Glory", { 
		"player.holypower >= 3", 
		(function() return mts.dynamicEval("player.health <= " .. fetch('mtsconfPalaRet', 'wordofglory_spin')) end), 
		(function() return fetch('mtsconfPalaRet', 'wordofglory_check') end) 
	}},
	{ "Lay on Hands", { 
		(function() return mts.dynamicEval("player.health <= " .. fetch('mtsconfPalaRet', 'layonhands_spin')) end), 
		(function() return fetch('mtsconfPalaRet', 'layonhands_check') end) 
	}},
	{ "#5512", { -- Healthstone (5512)
		(function() return mts.dynamicEval("player.health <= " .. fetch('mtsconfPalaRet', 'healthstone_spin')) end), 
		(function() return fetch('mtsconfPalaRet', 'healthstone_check') end) 
	}},

}

-- Test these, they came from prot and might not be the same on ret...
local Seals = {

	{{ -- Empowered Seals
		{ "31801", { -- Seal of Truth
			"player.seal != 1", 					-- Seal of Truth
			"!player.buff(156990).duration > 3", 	-- Maraad's Truth
			"player.spell(20271).cooldown <= 1" 	-- Judment  CD less then 1
		}},
		{ "20154", { -- Seal of Righteousness
			"player.seal != 2", 					-- Seal of Righteousness
			"!player.buff(156989).duration > 3", 	-- Liadrin's Righteousness
			"player.buff(156990)", 					-- Maraad's Truth
			"player.spell(20271).cooldown <= 1" 	-- Judment  CD less then 1
		}},
		{ "20165", { -- Seal of Insigh
			"player.seal != 3", 					-- Seal of Insigh
			"!player.buff(156988).duration > 3", 	-- Uther's Insight
			"player.buff(156990)", 					-- Maraad's Truth
			"player.buff(156989)", 					-- Liadrin's Righteousness
			"player.spell(20271).cooldown <= 1" 	-- Judment  CD less then 1
		}},
			
		------------------------------------------------------------------------------ Judgment
		{ "20271", {
			"player.buff(156990).duration < 3", -- Maraad's Truth
			"player.seal = 1"
		}},
		{ "20271", { 
			"player.buff(156989).duration < 3", -- Liadrin's Righteousness
			"player.seal = 2"
		}},
		{ "20271", {
			"player.buff(156988).duration < 3", -- Uther's Insight
			"player.seal = 3"
		}},
	}, "talent(7,1)" },

	{{ -- Normal Seals
		{{ -- AoE
			{ "20165", { -- Seal of Insigh
				"player.seal != 3",
				(function() return fetch("mtsconfPalaProt", "sealAoE") == 'Insight' end),
			}},
			{ "20154", { -- Seal of Righteousness
				"player.seal != 2",
				(function() return fetch("mtsconfPalaProt", "sealAoE") == 'Righteousness' end),
			}},
			{ "31801", { -- Seal of truth
				"player.seal != 1",
				(function() return fetch("mtsconfPalaProt", "sealAoE") == 'Truth' end),
			}},
		}, "modifier.multitarget" },
		{{ -- Single Target
			{ "20165", { -- Seal of Insigh
				"player.seal != 3",
				(function() return fetch("mtsconfPalaProt", "seal") == 'Insight' end),
			}},
			{ "20154", { -- Seal of Righteousness
				"player.seal != 2",
				(function() return fetch("mtsconfPalaProt", "seal") == 'Righteousness' end),
			}},
			{ "31801", { -- Seal of truth
				"player.seal != 1",
				(function() return fetch("mtsconfPalaProt", "seal") == 'Truth' end),
			}},
		}, "!modifier.multitarget" },
	}, "!talent(7,1)" },

}

local inCombat_Testing = {

	-- Cooldowns
	{ "Execution Sentence", "target.enemy", "target" },
	{ "Light's Hammer", nil, "target.ground" },	
	
	{{ -- Talent / Final Verdict
		{ "Divine Storm", { 
			"player.buff(Final Verdict)", 
			"player.buff(Divine Crusader)", 
			"player.holypower >= 5" 
		}},
		{ "Final Verdict", { 
			"player.buff(Divine Purpose).duration < 3", 
			"player.buff(Divine Purpose)" 
		}},
		{ "Final Verdict", { 
			"player.buff(Holy Avenger)", 
			"player.holypower >= 3" 
		}}, 
		{ "Divine Storm", { 
			"player.buff(Divine Crusader).duration < 3", 
			"player.buff(Divine Crusader)" 
		}},
		{ "Final Verdict", "player.holypower >= 5" }
	}, "talent(7, 3)" },
	{{ -- Seraphim.
		{ "Templar's Verdict", "player.buff(Avenging Wrath)" },
		{ "Templar's Verdict", "player.health < 20" },
		{ "Final Verdict", "player.buff(Avenging Wrath)" },
		{ "Final Verdict", "player.health < 20" }
	}, { "talent(7, 2)", "player.spell(Seraphim).cooldown >= 8" }},
	{{ -- Empowered Seals
		{ "Templar's Verdict", "player.buff(Avenging Wrath)" },
		{ "Templar's Verdict", "player.health < 20" }
	}, "talent(7, 1)" },
	
	-- AoE
	{ "Divine Storm", "player.holypower >= 3" },
	{ "Hammer of the Righteous" },
	{ "Judgment" },
	{ "Exorcism" },
	
	-- Solo Target
	{ "Templar's Verdict", "player.holypower >= 5" },
	{ "Hammer of Wrath", "target.health < 35%" },
	{ "Hammer of Wrath", "player.buff(Avenging Wrath)" },
	{ "Crusader Strike" },
	{ "Judgment" },
	{ "Exorcism" },
	{ "Divine Storm", "player.buff(Empowered Divine Storm)" },
	{ "Holy Prism", "talent(5, 1)" },

}

local outCombat_Testing = {

	{ "Seal of Truth", { 
		"!modifier.multitarget", 
		"player.seal != 1" 
	}},
	{ "Seal of Righteousness", { 
		"modifier.multitarget", 
		"player.seal != 2" 
	}},

}

ProbablyEngine.rotation.register_custom(70,  mts.Icon.."|r[|cff9482C9MTS|r][|cffF58CBAPaladin-Retribution|r]-Testing!", 
	{-- In-Combat
		{ Survival },
		{ SelfHeals },
		{ Seals },
		{ inCombat_Testing },
	}, outCombat_Testing, exeOnLoad)