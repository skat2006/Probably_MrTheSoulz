local logo = "|TInterface\\AddOns\\Probably_MrTheSoulz\\media\\logo.blp:15:15|t"
local fetch = ProbablyEngine.interface.fetchKey

local InfoWindow
local mts_OpenInfoWindow = false
local mts_ShowingInfoWindow = false
local mts_InfoUpdating = false

local _Header = { 
	type = "texture",texture = "Interface\\AddOns\\Probably_MrTheSoulz\\media\\splash.blp",
	width = 200, 
	height = 100, 
	offset = 90, 
	y = 42, 
	center = true 
}

local mts_info = {
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

		{ type = 'spacer' },{ type = 'spacer' },{ type = 'spacer' },{ type = 'spacer' },{ type = 'spacer' },
		
		-- Advanced Status
		{ type = 'rule' },
		{ type = 'header', text = "|cff9482C9MrTheSoulz Advanced Status:", align = "center"},
		{ type = 'spacer' },

			{ type = "text", text = "Unit Cache Status: ", size = 11, offset = -11 },
			{ key = 'current_cacheStatus', type = "text", text = "Random", size = 11, align = "right", offset = 0 },

			{ type = "text", text = "Smart AoE Status: ", size = 11, offset = -11 },
			{ key = 'current_smartAoEStatus', type = "text", text = "Random", size = 11, align = "right", offset = 0 },

			{ type = "text", text = "Movement Status: ", size = 11, offset = -11 },
			{ key = 'current_movementStatus', type = "text", text = "Random", size = 11, align = "right", offset = 0 },

		{ type = 'spacer' },{ type = 'spacer' },{ type = 'spacer' },{ type = 'spacer' },{ type = 'spacer' },

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
				text = "Close", 
				width = 480, 
				height = 20,
				callback = function()
					mts_InfoGUI()
				end
			},

		
	}
}

-- Check if possivel to smart AoE
local function SmartAoEInfo()
	if FireHack or oexecute then
		if fetch('mtsconf', 'Firehack') then
			return "|cff00FF96Able"
		else 
			return "|cffC41F3BDisabled in Settings"
		end
	else 
		return "|cffC41F3BUnable"
	end
end

-- Check if possivel to smart cache
local function CacheInfo()
	if FireHack then
		return "|cff00FF96Using Unlocker object manager "
	else 
		return "|cffC41F3BUsing Raid/Party Targets (FALLBACK)"
	end
end

-- Check if possivel to move
local function MovementInfo()
	if FireHack then
		if fetch('mtsconf', 'AutoMove') then
			return "|cff00FF96Able"
		else
			return "|cffC41F3BDisabled in Settings"
		end
	else 
		return "|cffC41F3BUnable"
	end
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

-- Check if user is unclocked and how
local function UnlockerInfo()
	if ProbablyEngine.pmethod == nil
	and ProbablyEngine.protected.method == nil then
		return "|cffC41F3BYou're not Unlocked, please use an unlocker."
	else 
		return "|cff00FF96You're Unlocked, Using: ".. (ProbablyEngine.pmethod or ProbablyEngine.protected.method)
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
	
	-- Advanced Status
	InfoWindow.elements.current_movementStatus:SetText(MovementInfo())
	InfoWindow.elements.current_cacheStatus:SetText(CacheInfo())
	InfoWindow.elements.current_smartAoEStatus:SetText(SmartAoEInfo())

	-- Spec info
	InfoWindow.elements.current_spec:SetText(select(2, GetSpecializationInfo(GetSpecialization())) or "None")
	InfoWindow.elements.current_keybinds:SetText(mts_ClassInfo())
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