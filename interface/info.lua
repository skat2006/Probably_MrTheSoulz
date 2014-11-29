local logo = "|TInterface\\AddOns\\Probably_MrTheSoulz\\media\\logo.blp:15:15|t"

local InfoWindow
local mts_OpenInfoWindow = false
local mts_ShowingInfoWindow = false
local mts_InfoUpdating = false

local ThanksWindow
local mts_OpenThanksWindow = false
local mts_ShowingThanksWindow = false

local _Header = { 
	type = "texture",texture = "Interface\\AddOns\\Probably_MrTheSoulz\\media\\splash.blp",
	width = 200, 
	height = 100, 
	offset = 90, 
	y = 42, 
	center = true 
}

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
		{ type = 'header', text = "|cff9482C9MrTheSoulz General Status:", align = "center"},
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
		{ type = 'header', text = "|cff9482C9MrTheSoulz Spec Info:", align = "center"},
		{ type = 'spacer' },

			{ type = "text", text = "Spec:", size = 11, offset = -11 },
			{ key = 'current_spec', type = "text", text = "Random", size = 11, align = "right", offset = 0 },

			{ type = "text", text = "Keykinds:", size = 11, offset = -11 },
			{ key = 'current_keybinds', type = "text", text = "Random", size = 11, align = "right", offset = 0 },

		{ type = 'spacer' },{ type = 'spacer' },{ type = 'spacer' },{ type = 'spacer' },{ type = 'spacer' },

		{ type = 'rule' },
		{ type = 'header', text = "|cff9482C9MrTheSoulz Pack Information:", align = "center"},
		{ type = 'spacer' },

			{ type = 'text', text = "This pack been created for personal use and shared to help others with the same needs." },
			{ type = 'text', text = "If you have any issues while using it and the Status say they are okay, please visit: |cffC41F3Bhttp://www.ownedcore.com/forums/world-of-warcraft/world-of-warcraft-bots-programs/probably-engine/combat-routines/498642-pe-mrthesoulzpack.html|r for futher help."},
			{ type = 'text', text = "Created By: MrTheSoulz" },

			{ type = 'spacer' },{ type = 'spacer' },
			{ 
				type = "button", 
				text = "Show Thanks", 
				width = 480, 
				height = 20,
				callback = function()
					mts_ThanksGUI()
				end
			},
			{ 
				type = "button", 
				text = "Close", 
				width = 480, 
				height = 20,
				callback = function()
					mts_InfoGUI()
				end
			},

		
	}
}

mts_Thanks = {
	key = "mtsThanks",
	title = logo.."MrTheSoulz Config",
	subtitle = "Thanks GUI",
	color = "9482C9",
	width = 250,
	height = 350,
	config = {

		{ type = 'rule' },
		{ type = 'header', text = "|cff9482C9MrTheSoulz Special Thanks to:", align = "center"},
		{ type = 'spacer' },

			{ type = 'text', text = "Conscious Shell who donated: 100.00 USD" },
			{ type = 'text', text = "Nicholas D Perdue who donated: 20.00 EUR" },
			{ type = 'text', text = "saga3180 who donated: GameTime" },
			{ type = 'text', text = "Phelps who answersed all my noob questions, payed my FH and helped alot." },
			{ type = 'text', text = "People in the PE IRC who are always willing to help." },
			{ type = 'text', text = "People who submited bug report's." },
			{ type = "button", text = "Close", width = 230, height = 20, callback = function() mts_ThanksGUI() end}

		
	}
}


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

-- Check if user is unclocked and how
local function UnlockerInfo()
	if ProbablyEngine.pmethod == nil then
		return "|cffC41F3BYou're not Unlocked, please use an unlocker."
	else 
		return "|cff00FF96You're Unlocked, Using: ".. ProbablyEngine.pmethod
	end
end

-- Check if using recommended PE
local function PEVersionInfo()
	if ProbablyEngine.version == mts_peRecomemded then
		return "|cff00FF96You're using the recommeded PE version."
	else 
		return "|cffC41F3BYou're not using the recommeded PE version."
	end
end

-- current status
local function mtsInfoStatus()
	if ProbablyEngine.version == mts_peRecomemded
	and ProbablyEngine.pmethod ~= nil then
		return "|cff00FF96Okay!"
	else 
		return "|cffC41F3BOuch, something is not right..."
	end
end

-- Update Text for Info GUI
local function mts_updateLiveInfo()
	-- General Status
	InfoWindow.elements.current_Unlocker:SetText(UnlockerInfo())
	InfoWindow.elements.current_PEStatus:SetText(PEVersionInfo())
	InfoWindow.elements.current_Status:SetText(mtsInfoStatus())

	-- Spec info
	InfoWindow.elements.current_spec:SetText(select(2, GetSpecializationInfo(GetSpecialization())) or "None")
	InfoWindow.elements.current_keybinds:SetText(mts_ClassInfo())
end

function mts_ThanksGUI()
	if not mts_OpenThanksWindow then
		ThanksWindow = ProbablyEngine.interface.buildGUI(mts_Thanks)
		mts_OpenThanksWindow = true
		mts_ShowingThanksWindow = true
		ThanksWindow.parent:SetEventListener('OnClose', function()
			mts_OpenThanksWindow = false
			mts_ShowingThanksWindow = false
		end)
	
	elseif mts_OpenThanksWindow == true and mts_ShowingThanksWindow == true then
		ThanksWindow.parent:Hide()
		mts_ShowingThanksWindow = false
	
	elseif mts_OpenThanksWindow == true and mts_ShowingThanksWindow == false then
		ThanksWindow.parent:Show()
		mts_ShowingThanksWindow = true
	end

end

function mts_InfoGUI()
	if not mts_OpenInfoWindow then
		InfoWindow = ProbablyEngine.interface.buildGUI(mts_info)
		mts_InfoUpdating = true
		mts_OpenInfoWindow = true
		mts_ShowingInfoWindow = true
		InfoWindow.parent:SetEventListener('OnClose', function()
			mts_OpenInfoWindow = false
			mts_ShowingInfoWindow = false
		end)
	
	elseif mts_OpenInfoWindow == true and mts_ShowingInfoWindow == true then
		mts_InfoUpdating = false
		InfoWindow.parent:Hide()
		mts_ShowingInfoWindow = false
	
	elseif mts_OpenInfoWindow == true and mts_ShowingInfoWindow == false then
		mts_InfoUpdating = true
		InfoWindow.parent:Show()
		mts_ShowingInfoWindow = true
	end

	if mts_InfoUpdating then
		C_Timer.NewTicker(1.00, mts_updateLiveInfo, nil)
	end

end