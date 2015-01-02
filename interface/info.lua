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
	width = 350,
	height = 400,
	config = {
		{ type = "texture",texture = "Interface\\AddOns\\Probably_MrTheSoulz\\media\\splash.blp",
			width = 400, 
			height = 200, 
			offset = 190, 
			y = 94, 
			center = true 
		},

		-- General Status
		{ type = 'rule' },
		{ 
			type = 'header', 
			text = "|cff9482C9MrTheSoulz General Status:", 
			align = "center"
		},
		{ type = 'spacer' },

			{ 
				type = "text", 
				text = "Unlocker Status: ", 
				size = 11, 
				offset = -11 
			},
			{ 
				key = 'current_Unlocker', 
				type = "text", 
				text = "Loading...", 
				size = 11, 
				align = "right", 
				offset = 0 
			},
			{ 
				type = "text", 
				text = "PE Version Status: ", 
				size = 11, 
				offset = -11 
			},
			{ 
				key = 'current_PEStatus', 
				type = "text", 
				text = "Loading...", 
				size = 11, 
				align = "right", 
				offset = 0 
			},
			{ 
				type = "text", 
				text = "Using MTS Profiles: ", 
				size = 11, 
				offset = -11 
			},
			{ 
				key = 'current_MTSProfiles', 
				type = "text", 
				text = "Loading...", 
				size = 11, 
				align = "right", 
				offset = 0 
			},
			{ 
				type = "button", 
				text = "Test Unlocker (If you jump, it works)", 
				width = 325, 
				height = 20,
				callback = function()
					JumpOrAscendStart();
				end
			},
		
		-- Advanced Status
		{ type = 'rule' },
		{ type = 'header', text = "|cff9482C9MrTheSoulz Advanced Status:", align = "center"},
		{ type = 'spacer' },

			{ type = "text", text = "Smart AoE Status: ", size = 11, offset = -11 },
			{ key = 'current_smartAoEStatus', type = "text", text = "Loading...", size = 11, align = "right", offset = 0 },

			{ type = "text", text = "Automated Movement: ", size = 11, offset = -11 },
			{ key = 'current_movementStatus', type = "text", text = "Loading...", size = 11, align = "right", offset = 0 },

			{ type = "text", text = "Automated Facing: ", size = 11, offset = -11 },
			{ key = 'current_facingStatus', type = "text", text = "Loading...", size = 11, align = "right", offset = 0 },

		{ type = 'rule' },
		{ type = 'header', text = "|cff9482C9MrTheSoulz Pack Information:", align = "center"},
		{ type = 'spacer' },

			{ type = 'text', text = "This pack been created for personal use and shared to help others with the same needs." },
			{ type = 'text', text = "If you have any issues while using it and the Status say they are okay, please visit: |cffC41F3Bhttp://www.ownedcore.com/forums/world-of-warcraft/world-of-warcraft-bots-programs/probably-engine/combat-routines/498642-pe-mrthesoulzpack.html|r for futher help."},
			{ type = 'text', text = "Created By: MrTheSoulz" },

			{ type = 'spacer' },
			{ 
				type = "button", 
				text = "Donate", 
				width = 325, 
				height = 20,
				callback = function()
					if FireHack then
						OpenURL("http://goo.gl/yrctPO");
					else
						message("|cff00FF96Please Visit:|cffFFFFFF\nhttp://goo.gl/yrctPO");
					end
				end
			},
			{ 
				type = "button", 
				text = "Forums", 
				width = 325, 
				height = 20,
				callback = function()
					if FireHack then
						OpenURL("http://www.ownedcore.com/forums/world-of-warcraft/world-of-warcraft-bots-programs/probably-engine/combat-routines/498642-pe-mrthesoulzpack.html");
					else
						message("|cff00FF96Please Visit:|cffFFFFFF\nhttp://www.ownedcore.com/forums/world-of-warcraft/world-of-warcraft-bots-programs/probably-engine/combat-routines/498642-pe-mrthesoulzpack.html");
					end
				end
			},
			{ 
				type = "button", 
				text = "Close", 
				width = 325, 
				height = 20,
				callback = function()
					mts.InfoGUI()
				end
			},

		
	}
}

-- Update Text for Info GUI
local function mts_updateLiveInfo()
	-- General Status
	InfoWindow.elements.current_Unlocker:SetText(ProbablyEngine.pmethod == nil and ProbablyEngine.protected.method == nil and "|cffC41F3BYou're not Unlocked, please use an unlocker." or "|cff00FF96You're Unlocked, Using: ".. (ProbablyEngine.pmethod or ProbablyEngine.protected.method))
	InfoWindow.elements.current_PEStatus:SetText(ProbablyEngine.version == mts.peRecomemded and "|cff00FF96You're using the recommeded PE version." or "|cffC41F3BYou're not using the recommeded PE version.")
	InfoWindow.elements.current_MTSProfiles:SetText(mts.CurrentCR and "|cff00FF96Currently using MTS Profiles" or "|cffC41F3BNot using MTS Profiles")
	-- Advanced Status
	InfoWindow.elements.current_movementStatus:SetText(FireHack and fetch('mtsconf', 'AutoMove') and "|cff00FF96Able" or "|cffC41F3BUnable")
	InfoWindow.elements.current_smartAoEStatus:SetText((FireHack or oexecute) and fetch('mtsconf', 'Firehack') and "|cff00FF96Able" or "|cffC41F3BUnable")
	InfoWindow.elements.current_facingStatus:SetText((FireHack or oexecute) and fetch('mtsconf', 'AutoFace') and "|cff00FF96Able" or "|cffC41F3BUnable")
end

function mts.InfoGUI()
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