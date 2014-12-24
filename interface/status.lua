local logo = "|TInterface\\AddOns\\Probably_MrTheSoulz\\media\\logo.blp:15:15|t"
local fetch = ProbablyEngine.interface.fetchKey

local LiveWindow
local mts_OpenLive = false
local mts_ShowingLiveWindow = false
local mts_LiveUpdating = false

local mts_live = {
	key = "mtslive",
	title = logo.."MrTheSoulz GUI \124cffC41F3Bv:"..mts.Version,
	color = "9482C9",
	width = 200,
	height = 84,
	resize = false,
	config = {

		-- Current Spell
		{ type = "text", text = "Queued: ", size = 11, offset = -11 },
		{ key = 'current_Queue', type = "text", text = "Loading...", size = 11, align = "right", offset = 0 },

		-- Current Spell
		{ type = "text", text = "Last Used: ", size = 11, offset = -11 },
		{ key = 'current_spell', type = "text", text = "Loading...", size = 11, align = "right", offset = 0 },

		-- AoE
		{ type = "text", text = "AoE: ", size = 11, offset = -11 },
		{ key = 'current_AoE', type = "text", text = "Loading...", size = 11, align = "right", offset = 0 },

		-- Interrupts
		{ type = "text", text = "Interrupts: ", size = 11, offset = -11 },
		{ key = 'current_Interrupts', type = "text", text = "Loading...", size = 11, align = "right", offset = 0 },

		-- Cooldowns
		{ type = "text", text = "Cooldowns: ", size = 11, offset = -11 },
		{ key = 'current_Cooldowns', type = "text", text = "Loading...", size = 11, align = "right", offset = 0 },

		{ type = "spacer" },
		{ 
			type = "button", 
			text = "Class Settings", 
			width = 180, 
			height = 20,
			callback = function()
				mts_ClassGUI()
			end
		},
		{ 
			type = "button", 
			text = "General Settings", 
			width = 180, 
			height = 20,
			callback = function()
				mts_ConfigGUI()
			end
		},
		{ 
			type = "button", 
			text = "Information", 
			width = 180, 
			height = 20,
			callback = function()
				mts_InfoGUI()
			end
		},
		{ 
			type = "button", 
			text = "Unit Cache", 
			width = 180, 
			height = 20,
			callback = function()
				mts_cacheGUI()
			end
		},

	}
}

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

function mts_showLive()
	if not mts_OpenLive and fetch('mtsconf','LiveGUI') then
		LiveWindow = ProbablyEngine.interface.buildGUI(mts_live)
		mts_LiveUpdating = true
		mts_OpenLive = true
		mts_ShowingLiveWindow = true
		LiveWindow.parent:SetEventListener('OnClose', function()
			mts_OpenLive = false
			mts_ShowingLiveWindow = false
		end)
	
	elseif mts_OpenLive == true and mts_ShowingLiveWindow == true then
		mts_LiveUpdating = false
		LiveWindow.parent:Hide()
		mts_ShowingLiveWindow = false
	
	elseif mts_OpenLive == true and mts_ShowingLiveWindow == false then
		mts_LiveUpdating = true
		LiveWindow.parent:Show()
		mts_ShowingLiveWindow = true
	end

	if mts_LiveUpdating then
		C_Timer.NewTicker(1.00, mts_updateLiveGUI, nil)
	end

end