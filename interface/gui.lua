														--[[   Local Var's   ]]
--[[----------------------------------------------------------------------------------------------------------------------------]]
--[[----------------------------------------------------------------------------------------------------------------------------]]

local logo = "|TInterface\\AddOns\\Probably_MrTheSoulz\\media\\logo.blp:15:15|t"
local _Header = { 
	type = "texture",texture = "Interface\\AddOns\\Probably_MrTheSoulz\\media\\splash.blp",
	width = 200, 
	height = 100, 
	offset = 90, 
	y = 42, 
	center = true 
}
local fetch = ProbablyEngine.interface.fetchKey

local mts_BuildGUI = ProbablyEngine.interface.buildGUI
local _CurrentSpec = nil

local ConfigWindow
local mts_OpenConfigWindow = false
local mts_ShowingConfigWindow = false

local ClassWindow
local _OpenClassWindow = false
local _ShowingClassWindow = false

local InfoWindow
local mts_OpenInfoWindow = false
local mts_ShowingInfoWindow = false
local mts_InfoUpdating = false

local LiveWindow
local mts_OpenLive = false
local mts_LiveUpdating = false

														--[[   Local Functions  ]]
--[[----------------------------------------------------------------------------------------------------------------------------]]
--[[----------------------------------------------------------------------------------------------------------------------------]]

-- Check if user is unclocked and how
local function UnlockerInfo()
	if ProbablyEngine.pmethod == 'Locked' then
		return "|cffC41F3BYou're not Unlocked, please use an unlocker."
	else 
		return "|cff00FF96You're Unlocked, Using: ".. ProbablyEngine.pmethod
	end
end

-- Check if using recommended PE
local function PEVersionInfo()
	if ProbablyEngine.version ~= mts_peRecomemded then
		return "|cffC41F3BYou're not using the recommeded PE version."
	else 
		return "|cff00FF96You're using the recommeded PE version."
	end
end

-- current status
local function mtsInfoStatus()
	if ProbablyEngine.version == mts_peRecomemded
	and ProbablyEngine.pmethod ~= 'Locked' then
		return "|cff00FF96Okay!"
	else 
		return "|cffC41F3BOuch, something is not right..."
	end
end

-- return Spell in queue
local function mts_QueueState()
	if ProbablyEngine.current_spell == false then
		return ("\124cff0070DEWaiting...")
	else return ProbablyEngine.current_spell end
end

-- return last used spell
local function mts_LastCastState()
	return ProbablyEngine.parser.lastCast == "" and "\124cff0070DENone" or ProbablyEngine.parser.lastCast
end

-- return Currect AoE state
local function mts_AoEState()
	if FireHack and fetch('mtsconf','Firehack') then
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

-- return Currect interrumpts state
local function mts_KickState()
	if ProbablyEngine.config.read('button_states', 'interrupt', false) then
		return ("\124cff0070DEON")
	else return ("\124cffC41F3BOFF") end
end

-- return Currect Cooldown state
local function mts_CdState()
	if ProbablyEngine.config.read('button_states', 'cooldowns', false) then
		return ("\124cff0070DEON")
	else return ("\124cffC41F3BOFF") end
end

-- Return the currect keybinds for the currect spec
local function mts_ClassInfo()
	local _SpecID =  GetSpecializationInfo(GetSpecialization())

	-- Check wich spec the player is to return the currect info.	
	if _SpecID == 66 then -- Pala Prot
		return ("Control: Fist of Justice or Hammer of Justice\nShift: Light´s Hammer")
	
	elseif _SpecID == 65 then -- Pala holy
			return ("Shift: Light´s Hammer\nAlt: Mouseover Focus")
	
	else 
		return ("This Current Class is either not suported or wasnt documented yet...")
	end

end

-- Update Text for Status GUI
local function mts_updateLiveGUI()
	LiveWindow.elements.current_Queue:SetText(mts_QueueState())
	LiveWindow.elements.current_spell:SetText(mts_LastCastState())
	LiveWindow.elements.current_AoE:SetText(mts_AoEState())
	LiveWindow.elements.current_Interrupts:SetText(mts_KickState())
	LiveWindow.elements.current_Cooldowns:SetText(mts_CdState())
end

-- Update Text for Info GUI
local function mts_updateLiveInfo()
	InfoWindow.elements.current_Unlocker:SetText(UnlockerInfo())
	InfoWindow.elements.current_PEStatus:SetText(PEVersionInfo())
	InfoWindow.elements.current_Status:SetText(mtsInfoStatus())
end

														--[[   Live window   ]]
--[[----------------------------------------------------------------------------------------------------------------------------]]
--[[----------------------------------------------------------------------------------------------------------------------------]]
local mts_live = {
	key = "mtslive",
	title = logo.."MrTheSoulz GUI \124cffC41F3Bv:"..mts_Version,
	color = "9482C9",
	width = 200,
	height = 84,
	resize = false,
	config = {

		-- Current Spell
		{ type = "text", text = "Queued: ", size = 11, offset = -11 },
		{ key = 'current_Queue', type = "text", text = "Random", size = 11, align = "right", offset = 0 },

		-- Current Spell
		{ type = "text", text = "Last Used: ", size = 11, offset = -11 },
		{ key = 'current_spell', type = "text", text = "Random", size = 11, align = "right", offset = 0 },

		-- AoE
		{ type = "text", text = "AoE: ", size = 11, offset = -11 },
		{ key = 'current_AoE', type = "text", text = "Random", size = 11, align = "right", offset = 0 },

		-- Interrupts
		{ type = "text", text = "Interrupts: ", size = 11, offset = -11 },
		{ key = 'current_Interrupts', type = "text", text = "Random", size = 11, align = "right", offset = 0 },

		-- Cooldowns
		{ type = "text", text = "Cooldowns: ", size = 11, offset = -11 },
		{ key = 'current_Cooldowns', type = "text", text = "Random", size = 11, align = "right", offset = 0 },

		{ type = "spacer" },

		-- Class GUI
		{ type = "button", text = "Class Settings", width = 180, height = 20,
			callback = function()
				mts_ClassGUI()
			end},

		-- General GUI
		{ type = "button", text = "General Settings", width = 180, height = 20,
			callback = function()
				mts_ConfigGUI()
			end},

		-- Info GUI
		{ type = "button", text = "Information", width = 180, height = 20,
			callback = function()
				mts_InfoGUI()
			end},

	}
}

														--[[   Info window   ]]
--[[----------------------------------------------------------------------------------------------------------------------------]]
--[[----------------------------------------------------------------------------------------------------------------------------]]
mts_info = {
	key = "mtsinfo",
	title = logo.."MrTheSoulz Config",
	subtitle = "General Settings",
	color = "9482C9",
	width = 500,
	height = 350,
	config = {
		{ type = 'header',text = 'MrTheSoulz Pack', size = 15},
		{ type = 'rule' },
		{ type = "texture",texture = "Interface\\AddOns\\Probably_MrTheSoulz\\media\\splash.blp",
			width = 400, 
			height = 200, 
			offset = 190, 
			y = 94, 
			center = true 
		},

		-- General Status
		{ type = 'rule' },
		{ type = 'header', text = "MrTheSoulz General Status:", align = "center"},
		{ type = 'spacer' },

			{ type = "text", text = "Unlocker Status: ", size = 11, offset = -11 },
			{ key = 'current_Unlocker', type = "text", text = "Random", size = 11, align = "right", offset = 0 },

			{ type = "text", text = "PE Version Status: ", size = 11, offset = -11 },
			{ key = 'current_PEStatus', type = "text", text = "Random", size = 11, align = "right", offset = 0 },

			{ type = "text", text = "Overall Status: ", size = 11, offset = -11 },
			{ key = 'current_Status', type = "text", text = "Random", size = 11, align = "right", offset = 0 },

		{ type = 'spacer' },

		-- Spec Info
		{ type = 'rule' },
		{ type = 'header', text = "MrTheSoulz Spec Info:", align = "center"},
		{ type = 'spacer' },

			{ type = "text", text = "Spec:", size = 11, offset = -11 },
			{ type = "text", text = (select(2, GetSpecializationInfo(GetSpecialization())) or "None"), size = 11, align = "right", offset = 0 },

			{ type = "text", text = "Keykinds:", size = 11, offset = -11 },
			{ type = "text", text = mts_ClassInfo(), size = 11, align = "right", offset = 0 },

		{ type = 'spacer' },
		{ type = 'spacer' },
		{ type = 'spacer' },
		{ type = 'spacer' },
		{ type = 'spacer' },

		{ type = 'rule' },
		{ type = 'header', text = "MrTheSoulz Pack Information:", align = "center"},
		{ type = 'spacer' },

			{ type = 'text', text = "This pack been created for personal use and shared to help others with the same needs." },
			{ type = 'text', text = "If you have any issues while using it and the Status say they are okay, please visit: |cffC41F3Bhttp://www.ownedcore.com/forums/world-of-warcraft/world-of-warcraft-bots-programs/probably-engine/combat-routines/498642-pe-mrthesoulzpack.html|r for futher help."},
			{ type = 'text', text = "Created By: MrTheSoulz" },

			{ type = "button", text = "Close", width = 480, height = 20,
				callback = function()
					mts_InfoGUI()
				end},

		
	}
}

														--[[   General window   ]]
--[[----------------------------------------------------------------------------------------------------------------------------]]
--[[----------------------------------------------------------------------------------------------------------------------------]]
mts_config = {
	key = "mtsconf",
	profiles = true,
	title = logo.."MrTheSoulz Config",
	subtitle = "General Settings",
	color = "9482C9",
	width = 250,
	height = 500,
	config = {
		{ type = 'header',text = 'MrTheSoulz Pack'},
		{ type = 'rule' },
		_Header,
		
		{ type = 'rule' },
		{ type = 'header', text = "MrTheSoulzs Pack General settings:"},

		-- Splash
		{ type = "checkbox", text = "Splash", key = "Splash", default = true, desc = 
		"This checkbox enables or disables MrTheSoulz splash when you choose the profile."},

		-- Taunts
		{ type = "checkbox", text = "Taunts", key = "Taunts", default = false, desc =
		"This checkbox enables or disables MrTheSoulz Pack using smarth auto taunts."},

		-- Whispers
		{ type = "checkbox", text = "Whispers", key = "Whispers", default = false, desc =
		"This checkbox enables or disables MrTheSoulz Pack using Whispers when a special event occurs."},

		-- Alerts
		{ type = "checkbox", text = "Alerts", key = "Alerts", default = true, desc =
		"This checkbox enables or disables MrTheSoulz Pack using Alerts when a special event occurs."},

		-- Sounds
		{ type = "checkbox", text = "Sounds", key = "Sounds", default = true, desc =
		"This checkbox enables or disables MrTheSoulz Pack using sounds."},

		-- Firehack
		{ type = "checkbox", text = "Firehack", key = "Firehack", default = true, desc =
		"This checkbox enables or disables MrTheSoulz Pack using Firehacks features like smart aoe and other fancy stuff."},

		-- LiveGUI
		{ type = "checkbox", text = "LiveGUI", key = "LiveGUI", default = true, desc =
		"This checkbox enables or disables MrTheSoulz Pack Displaying LiveGUI at Start."},

		-- AutoMove
		{ type = "checkbox", text = "Auto Moving", key = "AutoMove", default = false, desc =
		"Follows your current target if its an enemie.\nChecks for LoS and range."},

	}
}

													--[[   Global Functions   ]]
--[[----------------------------------------------------------------------------------------------------------------------------]]
--[[----------------------------------------------------------------------------------------------------------------------------]]

-- Control Info GUI
function mts_InfoGUI()
	if not mts_OpenInfoWindow then
		InfoWindow = ProbablyEngine.interface.buildGUI(mts_info)
		-- This is so the window isn't opened twice :D
		mts_OpenInfoWindow = true
		mts_ShowingInfoWindow = true
		InfoWindow.parent:SetEventListener('OnClose', function()
			mts_OpenInfoWindow = false
			mts_ShowingInfoWindow = false
		end)
	
	elseif mts_OpenInfoWindow == true and mts_ShowingInfoWindow == true then
		InfoWindow.parent:Hide()
		mts_ShowingInfoWindow = false
	
	elseif mts_OpenInfoWindow == true and mts_ShowingInfoWindow == false then
		InfoWindow.parent:Show()
		mts_ShowingInfoWindow = true
	
	end

	if not mts_InfoUpdating then
			mts_InfoUpdating = true
			C_Timer.NewTicker(1.00, mts_updateLiveInfo, nil)
		end
end

-- Control Status GUI
function mts_showLive()

	-- If a window is not created, then create one...
	if not mts_OpenLive and fetch('mtsconf','LiveGUI') then
		LiveWindow = ProbablyEngine.interface.buildGUI(mts_live)
		-- This is so the window isn't opened twice :D
		mts_OpenLive = true
		LiveWindow.parent:SetEventListener('OnClose', function()
			mts_OpenLive = false
		end)
	end

	if not mts_LiveUpdating then
			mts_LiveUpdating = true
			C_Timer.NewTicker(0.01, mts_updateLiveGUI, nil)
		end
end

-- Control Config
function mts_ConfigGUI()
	
	-- If a frame has not been created, create one...
	if not mts_OpenConfigWindow then
		ConfigWindow = ProbablyEngine.interface.buildGUI(mts_config)
		-- This is so the window isn't opened twice :D
		mts_OpenConfigWindow = true
		mts_ShowingConfigWindow = true
		ConfigWindow.parent:SetEventListener('OnClose', function()
			mts_OpenConfigWindow = false
			mts_ShowingConfigWindow = false
		end)
	
	-- If a frame has been created and its showing, hide it.
	elseif mts_OpenConfigWindow == true and mts_ShowingConfigWindow == true then
		ConfigWindow.parent:Hide()
		mts_ShowingConfigWindow = false
	
	-- If a frame has been created and its hiding, show it.
	elseif mts_OpenConfigWindow == true and mts_ShowingConfigWindow == false then
		ConfigWindow.parent:Show()
		mts_ShowingConfigWindow = true
	
	end
end

-- Control Class GUI
function mts_ClassGUI()
local _SpecID =  GetSpecializationInfo(GetSpecialization())

	-- Check wich spec the player is to return the currect window.	
	if _SpecID == 250 and not _OpenClassWindow then -- DK Blood
		_CurrentSpec = mts_BuildGUI(mts_configDkBlood)

	elseif _SpecID == 103 and not _OpenClassWindow  then -- Druid Feral
		_CurrentSpec = mts_BuildGUI(mts_configDruidFeral)

	elseif _SpecID == 104 and not _OpenClassWindow  then -- Druid Guardian
		_CurrentSpec = mts_BuildGUI(mts_configDruidGuard)

	elseif _SpecID == 105 and not _OpenClassWindow  then -- Druid Resto
		_CurrentSpec = mts_BuildGUI(mts_configDruidResto)

	elseif _SpecID == 257 and not _OpenClassWindow  then -- Priest holy
		_CurrentSpec = mts_BuildGUI(mts_configPriestHoly)

	elseif _SpecID == 256 and not _OpenClassWindow  then -- Priest Disc
		_CurrentSpec = mts_BuildGUI(mts_configPriestDisc)

	elseif _SpecID == 66 and not _OpenClassWindow  then -- Pala Prot
		_CurrentSpec = mts_BuildGUI(mts_configPalaProt)

	elseif _SpecID == 65 and not _OpenClassWindow  then -- Pala Holy
		_CurrentSpec = mts_BuildGUI(mts_configPalaHoly)	
	end

	-- If no window been created, create one...
	if not _OpenClassWindow and _CurrentSpec ~= nil then
		_OpenClassWindow = true
		_ShowingClassWindow = true
		_CurrentSpec.parent:SetEventListener('OnClose', function()
			_OpenClassWindow = false
			_ShowingClassWindow = false
		end)

	-- If a windows has been created and its showing then hide it...	
	elseif _OpenClassWindow == true and _ShowingClassWindow == true then
		_CurrentSpec.parent:Hide()
		_ShowingClassWindow = false

	-- If a windows has been created and its hidden then show it...		
	elseif _OpenClassWindow == true and _ShowingClassWindow == false then
		_CurrentSpec.parent:Show()
		_ShowingClassWindow = true
	end

end