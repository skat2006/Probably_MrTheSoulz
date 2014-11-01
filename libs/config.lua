								--[[   !!!Live window!!!   ]]
--[[!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!]]
local mts_live = {
	key = "mtslive",
	title = "MrTheSoulz Live GUI",
	color = "9482C9",
	width = 200,
	height = 100,
	resize = false,
	config = {

		-- Current Spell
		{ type = "text", text = "Queded: ", size = 10, offset = -10 },
		{ key = 'current_Queue', type = "text", text = "Random", size = 10, align = "right", offset = 5 },

		-- Current Spell
		{ type = "text", text = "Last Used: ", size = 10, offset = -10 },
		{ key = 'current_spell', type = "text", text = "Random", size = 10, align = "right", offset = 5 },

		-- AoE
		{ type = "text", text = "AoE: ", size = 10, offset = -10 },
		{ key = 'current_AoE', type = "text", text = "Random", size = 10, align = "right", offset = 5 },

		-- Interrupts
		{ type = "text", text = "Interrupts: ", size = 10, offset = -10 },
		{ key = 'current_Interrupts', type = "text", text = "Random", size = 10, align = "right", offset = 5 },

		-- Cooldowns
		{ type = "text", text = "Cooldowns: ", size = 10, offset = -10 },
		{ key = 'current_Cooldowns', type = "text", text = "Random", size = 10, align = "right", offset = 5 },

	}
}
 


local windowRef = ProbablyEngine.interface.buildGUI(mts_live)

function mts_QueueState()
	if ProbablyEngine.current_spell == false then
		return ("\124cff0070DEWaiting...")
	else return ProbablyEngine.current_spell end
end

function mts_LastCastState()
	if ProbablyEngine.parser.lastCast == nil then
		return ("\124cff0070DENone...")
	else return ProbablyEngine.parser.lastCast end
end

function mts_AoEState()
	if FireHack and mts_getConfig('mtsconf_Firehack') then
		if ProbablyEngine.config.read('button_states', 'multitarget', false) then
			return ("\124cff0070DEForced")
		end
	  return ("\124cff0070DESmart AoE")
	elseif ProbablyEngine.config.read('button_states', 'multitarget', false) then
			return ("\124cff0070DEON")
	else
		return ("\124cffC41F3BOFF") 
	end
end

function mts_KickState()
	if ProbablyEngine.config.read('button_states', 'interrupt', false) then
		return ("\124cff0070DEON")
	else return ("\124cffC41F3BOFF") end
end

function mts_CdState()
	if ProbablyEngine.config.read('button_states', 'cooldowns', false) then
		return ("\124cff0070DEON")
	else return ("\124cffC41F3BOFF") end
end

function updateLiveGUI()
		windowRef.elements.current_Queue:SetText(mts_QueueState())
		windowRef.elements.current_spell:SetText(mts_LastCastState())
		windowRef.elements.current_AoE:SetText(mts_AoEState())
		windowRef.elements.current_Interrupts:SetText(mts_KickState())
		windowRef.elements.current_Cooldowns:SetText(mts_CdState())
end

C_Timer.NewTicker(0.01, updateLiveGUI, nil)


								--[[   !!!INfo!!!   ]]
--[[!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!]]
mts_info = {
	key = "mtsinfo",
	title = "MrTheSoulz Config",
	subtitle = "General Settings",
	color = "9482C9",
	width = 500,
	height = 500,
	config = {
		{ type = 'header',text = 'MrTheSoulz Pack'},
		{ type = 'rule' },
		{ type = "texture",texture = "Interface\\AddOns\\Probably_MrTheSoulz\\media\\splash.blp",width = 200, height = 100, offset = 110, y = 50, center = true },
		{ type = 'rule' },
		{ type = 'header', text = "MrTheSoulzs Pack information:"},


		{ type = 'rule' },
		{ type = 'text', text = "To be filled..."},

		
}}

								--[[   !!!General Config!!!   ]]
--[[!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!]]
mts_config = {
	key = "mtsconf",
	title = "MrTheSoulz Config",
	subtitle = "General Settings",
	color = "9482C9",
	width = 250,
	height = 500,
	config = {
		{ type = 'header',text = 'MrTheSoulz Pack'},
		{ type = 'rule' },
		{ type = "texture",texture = "Interface\\AddOns\\Probably_MrTheSoulz\\media\\splash.blp",width = 200, height = 100, offset = 110, y = 50, center = true },
		{ type = 'rule' },
		{ type = 'header', text = "MrTheSoulzs Pack General settings:"},

		-- Splash
		{ type = "checkbox", text = "Splash", key = "Splash", default = true },
		{ type = 'text', text = "This checkbox enables or disables MrTheSoulz splash when you choose the profile."},

		-- Taunts
		{ type = "checkbox", text = "Taunts", key = "Taunts", default = false },
		{ type = 'text', text = "This checkbox enables or disables MrTheSoulz Pack using smarth auto taunts."},

		-- Whispers
		{ type = "checkbox", text = "Whispers", key = "Whispers", default = false },
		{ type = 'text', text = "This checkbox enables or disables MrTheSoulz Pack using Whispers when a special event occurs."},

		-- Alerts
		{ type = "checkbox", text = "Alerts", key = "Alerts", default = true },
		{ type = 'text', text = "This checkbox enables or disables MrTheSoulz Pack using Alerts when a special event occurs."},

		-- Sounds
		{ type = "checkbox", text = "Sounds", key = "Sounds", default = true },
		{ type = 'text', text = "This checkbox enables or disables MrTheSoulz Pack using sounds."},

		-- Firehack
		{ type = "checkbox", text = "Firehack", key = "Firehack", default = true },
		{ type = 'text', text = "This checkbox enables or disables MrTheSoulz Pack using Firehacks features like smarth aoe and other fancy stuff."},

}}


								--[[   !!!Priest Holy Config!!!   ]]
--[[!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!]]

mts_configPriestHoly = {
	key = "mtsconfPriestHoly",
	title = "MrTheSoulz Config",
	subtitle = "Priest Holy Settings",
	color = "9482C9",
	width = 250,
	height = 500,
	config = {
		{ type = 'header',text = 'MrTheSoulz Pack'},
		{ type = 'rule' },
		{ type = "texture",texture = "Interface\\AddOns\\Probably_MrTheSoulz\\media\\splash.blp",width = 200, height = 100, offset = 110, y = 50, center = true },
		
		-- General
		{ type = 'rule' },
		{ type = 'header', text = "General settings:"},

			-- AutoTargets
			{ type = "checkbox", text = "AutoTargets", key = "AutoTargets", default = true },
			{ type = 'text', text = "This checkbox enables or disables the use of automatic targets."},

			-- Dispels
			{ type = "checkbox", text = "Dispels", key = "Dispels", default = true },
			{ type = 'text', text = "This checkbox enables or disables the use of automatic dispels of everything it can dispel."},
			
			-- Feathers
			{ type = "checkbox", text = "Feathers", key = "Feathers", default = true },
			{ type = 'text', text = "This checkbox enables or disables the use of automatic feathers to move faster."},

		-- Focus
		{ type = 'rule' },
		{ type = 'header', text = 'Focus settings:'},

			-- Flash Heal
			{ type = "spinner", text = "Flash Heal", key = "FlashHealTank", default = 40},

			-- Holy Word Serenity
			{ type = "spinner", text = "Holy Word Serenity", key = "HolyWordSerenityTank", default = 90},

			-- Power Word: Shield
			{ type = "spinner", text = "Power Word: Shield", key = "ShieldTank", default = 100},

			-- Heal
			{ type = "spinner", text = "Heal", key = "HealTank", default = 95},

			-- Binding Heal
			{ type = "spinner", text = "Binding Heal", key = "BindingHealTank", default = 100},

			-- Prayer of Mending
			{ type = "spinner", text = "Prayer of Mending", key = "PrayerofMendingTank", default = 100},


		-- Player
		{ type = 'rule' },
		{ type = 'header', text = 'Player settings:'},

			-- Flash Heal
			{ type = "spinner", text = "Flash Heal", key = "FlashHealPlayer", default = 40},

			-- Holy Word Serenity
			{ type = "spinner", text = "Holy Word Serenity", key = "HolyWordSerenityPlayer", default = 90},

			-- Renew
			{ type = "spinner", text = "Renew", key = "RenewPlayer", default = 85},

			-- Power Word: Shield
			{ type = "spinner", text = "Power Word: Shield", key = "ShieldPlayer", default = 70},

			-- Desperate Prayer
			{ type = "spinner", text = "Desperate Prayer", key = "DesperatePrayer", default = 25},

			-- Heal
			{ type = "spinner", text = "Heal", key = "Heal", default = 95},


}}

								--[[   !!!Priest Discipline Config!!!   ]]
--[[!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!]]

mts_configPriestDisc = {
	key = "mtsconfPriestDisc",
	title = "MrTheSoulz Config",
	subtitle = "Priest Discipline Settings",
	color = "9482C9",
	width = 250,
	height = 500,
	config = {
		{ type = 'header',text = 'MrTheSoulz Pack'},
		{ type = 'rule' },
		{ type = "texture",texture = "Interface\\AddOns\\Probably_MrTheSoulz\\media\\splash.blp",width = 200, height = 100, offset = 110, y = 50, center = true },
		
		-- General
		{ type = 'rule' },
		{ type = 'header', text = "General settings:"},

			-- AutoTargets
			{ type = "checkbox", text = "AutoTargets", key = "AutoTargets", default = true },
			{ type = 'text', text = "This checkbox enables or disables the use of automatic targets."},

			-- Dispels
			{ type = "checkbox", text = "Dispels", key = "Dispels", default = true },
			{ type = 'text', text = "This checkbox enables or disables the use of automatic dispels of everything it can dispel."},
			
			-- Feathers
			{ type = "checkbox", text = "Feathers", key = "Feathers", default = true },
			{ type = 'text', text = "This checkbox enables or disables the use of automatic feathers to move faster."},

		-- Focus
		{ type = 'rule' },
		{ type = 'header', text = 'Focus settings:'},

			-- Flash Heal
			{ type = "spinner", text = "Flash Heal", key = "FlashHealTank", default = 40},

			-- Power Word: Shield
			{ type = "spinner", text = "Power Word: Shield", key = "ShieldTank", default = 100},

			-- Heal
			{ type = "spinner", text = "Heal", key = "HealTank", default = 90},

			-- Prayer of Mending
			{ type = "spinner", text = "Prayer of Mending", key = "PrayerofMendingTank", default = 100},


		-- Player
		{ type = 'rule' },
		{ type = 'header', text = 'Player settings:'},

			-- Flash Heal
			{ type = "spinner", text = "Flash Heal", key = "FlashHealPlayer", default = 40},

			-- Power Word: Shield
			{ type = "spinner", text = "Power Word: Shield", key = "ShieldPlayer", default = 70},

			-- Heal
			{ type = "spinner", text = "Heal", key = "Heal", default = 90},

}}