--[[ ///---INFO---////
//General Lib//
Thank You For Using My ProFiles
I Hope Your Enjoy Them
MTS
]]

local mtsLib = {}
local _media = "Interface\\AddOns\\Probably_MrTheSoulz\\media\\"
local mts_Dummies = {31146,67127,46647,32546,31144,32667,32542,32666,32545,32541}

local mts_BuildGUI = ProbablyEngine.interface.buildGUI
local _CurrentSpec = nil

local ConfigWindow
local mts_OpenConfigWindow = false
local mts_ShowingConfigWindow = false

local _OpenClassWindow = false
local _ShowingClassWindow = false

local InfoWindow
local mts_OpenInfoWindow = false
local mts_ShowingInfoWindow = false

local _mtsKeyError = false
local __mtsKeyError2 = false



mts_Version = "0.11.28"
mts_Icon = "|TInterface\\AddOns\\Probably_MrTheSoulz\\media\\logo.blp:16:16|t"
mtsLib.queueSpell = nil
mtsLib.queueTime = 0

-- To Implement // FH Keybinds
-- if GetKeyState(90) then print("Z HAS BEEN PRESSED!") end

							
									--[[   !!!Pack Commands!!!   ]]
--[[  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ]]
ProbablyEngine.command.register('mts', function(msg, box)
local command, text = msg:match("^(%S*)%s*(.-)$")
		
	-- Dispaly Version
	if command == 'ver' or command == 'version' then
		mtsLib.canUse('sound')
		mtsAlert:message('MrTheSoulz Version: '..mts_Version)
	end

    -- Displays MTS splash
    if command == 'logo' then
    	mtsStart:message("\124cff9482C9*Wanted To See Me?!*")
    end

    -- Displays General GUI
    if command == 'config' then
    	mts_ConfigGUI()
    end

   -- Displays LiveGUI
    if command == 'gui' then
    	mts_showLive()
    end

    -- Displays Class GUI
    if command == 'class' then
    	mts_ClassGUI()
    end

	-- Displays Help GUI
	if command == 'help' or command == 'info' or command == '?' then
		mts_InfoGUI()
	end

end)

-- Check Keys
function mtsLib.getConfig(key, key2)
	local _Config = ProbablyEngine.interface
 	if _Config.fetchKey(key, key2) == nil and not _mtsKeyError then
		mts_ClassGUI()
		mts_ConfigGUI()
		_mtsKeyError = true
	elseif _Config.fetchKey(key, key2) == nil and _mtsKeyError and not __mtsKeyError2 then
		print('|cffB30000[MTS]|r Error in key: |cff0070DE'..key.."_"..key2)
		__mtsKeyError2 = true
	else return _Config.fetchKey(key, key2) end
end

-- Check Keys Global...
function mts_getConfig(key,  key2)
	local _Config = ProbablyEngine.interface
 	if _Config.fetchKey(key, key2) == nil and not _mtsKeyError then
		mts_ClassGUI()
		mts_ConfigGUI()
		_mtsKeyError = true
	elseif _Config.fetchKey(key, key2) == nil and _mtsKeyError and not __mtsKeyError2 then
		print('|cffB30000[MTS]|r Error in key: |cff0070DE'..key.."_"..key2)
		__mtsKeyError2 = true
	else return _Config.fetchKey(key, key2) end
end

function mtsLib.Dropdown(txt)
local _Config = ProbablyEngine.interface
local _seal =_Config.fetchKey("mtsconfPalaProt", "seal")
local _palabuff = _Config.fetchKey("mtsconfPalaProt", "Buff")
	if _seal == 'Insight' and txt == 'Insight' 
	or _seal == 'Righteousness'and txt == 'Righteousness'
	or _seal == 'Truth' and txt == 'Truth'
	or _palabuff == 'Kings'and txt == 'Kings'
	or _palabuff == 'Might' and txt == 'Might' then
		return true
	else return false end
end

-- Compare stuff with GUIs
function mtsLib.Compare(txt, key, key2, unit)
 	if UnitExists(unit) then
        return math.floor((UnitHealth(unit) / UnitHealthMax(unit)) * 100) <= mtsLib.getConfig(key, key2)
    end
end

function mts_ConfigGUI()
	if not mts_OpenConfigWindow then
		ConfigWindow = ProbablyEngine.interface.buildGUI(mts_config)
		-- This is so the window isn't opened twice :D
		mts_OpenConfigWindow = true
		mts_ShowingConfigWindow = true
		ConfigWindow.parent:SetEventListener('OnClose', function()
			mts_OpenConfigWindow = false
			mts_ShowingConfigWindow = false
		end)
	
	elseif mts_OpenConfigWindow == true and mts_ShowingConfigWindow == true then
		ConfigWindow.parent:Hide()
		mts_ShowingConfigWindow = false
	
	elseif mts_OpenConfigWindow == true and mts_ShowingConfigWindow == false then
		ConfigWindow.parent:Show()
		mts_ShowingConfigWindow = true
	
	end
end

function mts_ClassGUI()
local _SpecID =  GetSpecializationInfo(GetSpecialization())

	-- Check wich spec the player is to return the currect window.	
	if _SpecID == 250 and not _OpenClassWindow then -- DK Blood
		_CurrentSpec = mts_BuildGUI(mts_configDkBlood)

	elseif _SpecID == 103 and not _OpenClassWindow  then -- Druid Feral
		_CurrentSpec = mts_BuildGUI(mts_configDruidFeral)

	elseif _SpecID == 105 and not _OpenClassWindow  then -- Druid Resto
		_CurrentSpec = mts_BuildGUI(mts_configDruidResto)

	elseif _SpecID == 257 and not _OpenClassWindow  then -- Priest holy
		_CurrentSpec = mts_BuildGUI(mts_configPriestHoly)

	elseif _SpecID == 256 and not _OpenClassWindow  then -- Priest Disc
		_CurrentSpec = mts_BuildGUI(mts_configPriestDisc)

	elseif _SpecID == 66 and not _OpenClassWindow  then -- Pala Prot
		_CurrentSpec = mts_BuildGUI(mts_configPalaProt)
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
end

-- !Testing! to cancel targets
-- Usefull for autotargets
function mtsLib.cancelTarget()
	if UnitIsEnemy("player", "target") == 1 then
		print("enemie")
		return false 
	else 
		print("friend")
		return true 
	end
end

-- Generic Check Function
function mtsLib.canUse(txt, txt2, txt3)

	-- Check it can Taunt
	if txt == 'taunt' 
		and UnitIsTappedByPlayer("target") 
		and mtsLib.getConfig('mtsconf','Taunts') then
			return true

	-- Check if can whisper
	elseif txt == 'whisper' 
		and mtsLib.getConfig('mtsconf','Whispers') then
			return RunMacroText("/w "..txt2)
	
	-- Check if can use sounds
	elseif txt == 'sound' 
		and mtsLib.getConfig('mtsconf','Sounds') then
			PlaySoundFile("Interface\\AddOns\\Probably_MrTheSoulz\\media\\beep.mp3", "master")

	-- Check if can use alerts
	elseif txt == 'alert' 
		and mtsLib.getConfig('mtsconf','Alerts') then
			return mtsAlert:message(txt2)

	-- Checks if Can use Priest Feathers
	elseif txt == 'feather' 
		and Distance(txt2, txt3) >= 35 then
			return true
	
	-- Check if monk can SEF on mouseover
	elseif txt == 'sef' 
		and (UnitGUID('target')) ~= (UnitGUID('mouseover')) then
 			return true

	-- check if can use item
	elseif txt == 'item'
	 	and mtsLib.getConfig('mtsconf','Items') 
	 	and GetItemCount(key) > 1 
	 	and GetItemCooldown(key) == 0 then 
			return true

	else return false end

end

									--[[   !!!Check Queue!!!   ]]
				--[[   !!!I Dont Remember who originaly build this, but thanks!!!!   ]]
--[[  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ]]
mtsLib.checkQueue = function (spellId)
    if (GetTime() - mtsLib.queueTime) > 10 then
        mtsLib.queueTime = 0
        mtsLib.queueSpell = nil
    return false
    else
    if mtsLib.queueSpell then
        if mtsLib.queueSpell == spellId then
            if ProbablyEngine.parser.lastCast == GetSpellName(spellId) then
                mtsLib.queueSpell = nil
                mtsLib.queueTime = 0
            end
        return true
        end
    end
    end
    return false
end

							--[[   !!!Check If Should Stop Dps!!!   ]]
			--[[   !!!I Dont Remember who originaly build this, but thanks!!!!   ]]
			-- [[   Used to Not break CC's or when it should not attack on special events.]]
--[[  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ]]
function mtsLib.immuneEvents(unit)
  if not UnitAffectingCombat(unit) then return false end
  -- Crowd Control
  local cc = {
    49203, -- Hungering Cold
     6770, -- Sap
     1776, -- Gouge
    51514, -- Hex
     9484, -- Shackle Undead
      118, -- Polymorph
    28272, -- Polymorph (pig)
    28271, -- Polymorph (turtle)
    61305, -- Polymorph (black cat)
    61025, -- Polymorph (serpent) -- FIXME: gone ?
    61721, -- Polymorph (rabbit)
    61780, -- Polymorph (turkey)
     3355, -- Freezing Trap
    19386, -- Wyvern Sting
    20066, -- Repentance
    90337, -- Bad Manner (Monkey) -- FIXME: to check
     2637, -- Hibernate
    82676, -- Ring of Frost
   115078, -- Paralysis
    76780, -- Bind Elemental
     9484, -- Shackle Undead
     1513, -- Scare Beast
   115268, -- Mesmerize
  }
  if mtsLib.hasDebuffTable(unit, cc) then return false end
  if UnitAura(unit,GetSpellInfo(116994))
		or UnitAura(unit,GetSpellInfo(122540))
		or UnitAura(unit,GetSpellInfo(123250))
		or UnitAura(unit,GetSpellInfo(106062))
		or UnitAura(unit,GetSpellInfo(110945))
		or UnitAura(unit,GetSpellInfo(143593)) -- General Nazgrim: Defensive Stance
    	or UnitAura(unit,GetSpellInfo(143574)) -- Heroic Immerseus: Swelling Corruption
		then return false end
  return true
end

function mtsLib.hasDebuffTable(target, spells)
  for i = 1, 40 do
    local _,_,_,_,_,_,_,_,_,_,spellId = _G['UnitDebuff'](target, i)
    for k,v in pairs(spells) do
      if spellId == v then return true end
    end
  end
end

							--[[   !!!Check if it is a dummy!!!   ]]
					--[[   Used to not Taunt Dummy's like a noob, and other situations.   ]]
--[[  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ]]
function mtsLib.dummy()	
	for i=1, #mts_Dummies do
		if UnitExists("target") then
			mts_Dummies_ID = tonumber(UnitGUID("target"):sub(-13, -9), 16)
		else
			mts_Dummies_ID = 0
		end
		if mts_Dummies_ID == mts_Dummies[i] then
			return false
		else
			return true
		end	
	end
end


ProbablyEngine.library.register('mtsLib', mtsLib)



								--[[   !!!Combat Alert Tracker!!!   ]]
						     --[[   Used For Spiting Alerts & sounds   ]]
--[[  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ]]
ProbablyEngine.listener.register("COMBAT_LOG_EVENT_UNFILTERED", function(...)
local event = select(2, ...)
local source = select(4, ...)
local spellId = select(12, ...)
local tname = UnitName("target")
if source ~= UnitGUID("player") then return false end

	if event == "SPELL_CAST_SUCCESS" then	

    -- Paladin

		if spellId == 114158 then
			mtsLib.canUse('sound')
			mtsLib.canUse('alert', "*Casted Light´s Hammer*")
		end
		if spellId == 633 then
			mtsLib.canUse('sound')
			mtsLib.canUse('whisper', tname.." MSG: Casted Lay On Hands on you.")
			mtsLib.canUse('alert', "*Casted Lay on Hands*")
		end
		if spellId == 1044 then
			mtsLib.canUse('sound')
			mtsLib.canUse('whisper', tname.." MSG: Casted Hand of Freedom on you.")
			mtsLib.canUse('alert', "*Casted Hand of Freedom*")
		end
		if spellId == 6940 then
			mtsLib.canUse('sound')
			mtsLib.canUse('alert', "*Casted Hand of Sacrifice*")
			mtsLib.canUse('whisper', "/w "..tname.." MSG: Casted Hand of Sacrifice on you.")
		end
		if spellId == 105593 then
			mtsLib.canUse('sound')
			mtsLib.canUse('alert', "*Stunned Target*")
		end
		if spellId == 853 then
			mtsLib.canUse('sound')
			mtsLib.canUse('alert', "*Stunned Target*")
		end
		if spellId == 31821 then
			mtsLib.canUse('sound')
			mtsLib.canUse('alert', "*Casted Devotion Aura*")
		end
		if spellId == 31884 then
			mtsLib.canUse('sound')
			mtsLib.canUse('alert', "*Casted Avenging Wrath*")
		end
		if spellId == 105809 then
			mtsLib.canUse('sound')
			mtsLib.canUse('alert', "*Casted Guardian of Ancient Kings*")
		end
		if spellId == 31850 then
			mtsLib.canUse('sound')
			mtsLib.canUse('alert', "*Casted Ardent Defender*")
		end
		if spellId == 86659 then
			mtsLib.canUse('sound')
			mtsLib.canUse('alert', "*Casted Holy Avenger*")
		end
		if spellId == 86669 then
			mtsLib.canUse('sound')
			mtsLib.canUse('alert', "*Casted Guardian of Ancient Kings*")
		end
		if spellId == 31842 then
			mtsLib.canUse('sound')
			mtsLib.canUse('alert', "*Casted Divine Favor*")
		end

    -- DeathKnight

		if spellId == 43265 then
			mtsLib.canUse('sound')
			mtsLib.canUse('alert', "*Casted Death and Decay*")
		end
		if spellId == 48707 then
			mtsLib.canUse('sound')
			mtsLib.canUse('alert', "*Casted Anti-Magic Shell*")
		end
		if spellId == 49028 then
			mtsLib.canUse('sound')
			mtsLib.canUse('alert', "*Casted Dancing Rune Weapon*")
		end
		if spellId == 55233 then
			mtsLib.canUse('sound')
			mtsLib.canUse('alert', "*Casted Vampiric Blood*")
		end
		if spellId == 48792 then
			mtsLib.canUse('sound')
			mtsLib.canUse('alert', "*Casted Icebound Fortitude*")
		end
		if spellId == 42650 then
			mtsLib.canUse('sound')
			mtsLib.canUse('alert', "*Casting Army of the Dead*")
		end

	end
end)