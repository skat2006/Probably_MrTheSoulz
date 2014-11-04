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
mts_Version = "0.11.21"
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

	-- -- Enabled/Disable PE
	if command == 'toggle' then
    	if mts_getConfig('button_states', 'MasterToggle', false) then
        	ProbablyEngine.buttons.toggle('MasterToggle')
        	mtsAlert:message("|cFFB30000Rotation off")
    	else
        	ProbablyEngine.buttons.toggle('MasterToggle')
        	mtsAlert:message("|cFF00B34ARotation on")
    	end
  	end

	-- Enabled/Disable Interrupts
	if command == 'kick' or command == 'interrupt' then
    	if mts_getConfig('button_states', 'interrupt', false) then
      		ProbablyEngine.buttons.toggle('interrupt')
      		mtsAlert:message("|cFFB30000Interrupts off")
    	else
      		ProbablyEngine.buttons.toggle('interrupt')
      		mtsAlert:message("|cFF00B34AInterrupts on")
    	end
  	end

  	-- Enabled/Disable cooldowns
  	if command == 'cds' or command == 'cooldowns' then
    	if mts_getConfig('button_states', 'cooldowns', false) then
      		ProbablyEngine.buttons.toggle('cooldowns')
      		mtsAlert:message("|cFFB30000Offensive Cooldowns off")
    	else
      		ProbablyEngine.buttons.toggle('cooldowns')
      		mtsAlert:message("|cFF00B34AOffensive Cooldowns on")
    	end
  	end

  	-- Enabled/Disable aoe
	if command == 'aoe' then
    	if mts_getConfig('button_states', 'multitarget', false) then
      		ProbablyEngine.buttons.toggle('multitarget')
      		mtsAlert:message("|cFFB30000AoE off")
    	else
      		ProbablyEngine.buttons.toggle('multitarget')
      		mtsAlert:message("|cFF00B34AAoE on")
      	end
    end

    -- Displays MTS splash
    if command == 'logo' then
    	mtsStart:message("\124cff9482C9*Wanted To See Me?!*")
    end

    -- Displays General GUI
    if command == 'config' then
    	mts_BuildGUI(mts_config)
    end

   -- Displays LiveGUI
    if command == 'gui' then
    	mts_BuildGUI(mts_live)
    end

    -- Displays Class GUI
    if command == 'class' then
    	mts_ClassGUI()
    end

	-- Displays Help GUI
	if command == 'help' or command == 'info' or command == '?' then
		mts_BuildGUI(mts_info)
	end

end)

-- Check Keys
function mts_getConfig(key)
local _config = ProbablyEngine.config
 	if _config.read(key) == nil then
		mts_ClassGUI()
		ProbablyEngine.interface.buildGUI(mts_config)
	else return _config.read(key) end
end

-- Checks what GUI to call for what class
function mts_ClassGUI()
local _SpecID =  GetSpecializationInfo(GetSpecialization())
	
	if _SpecID == 250 then -- DK Blood
		return mts_BuildGUI(mts_configDkBlood)
	end

	if _SpecID == 103 then -- Druid Feral
		return mts_BuildGUI(mts_configDruidFeral)
	end

	if _SpecID == 105 then -- Druid Resto
		return mts_BuildGUI(mts_configDruidResto)
	end

	if _SpecID == 257 then -- Priest holy
		return mts_BuildGUI(mts_configPriestHoly)
	end

	if _SpecID == 256 then -- Priest Disc
		return mts_BuildGUI(mts_configPriestDisc)
	end

	if _SpecID == 66 then -- Pala Prot
		return mts_BuildGUI(mts_configPalaProt)
	end
end

function mtsLib.Dropdown(txt)
local _seal = mts_getConfig("mtsconfPalaProt_seal")
local _palabuff = mts_getConfig("mtsconfPalaProt_Buff")
	if _seal == 'Insight' and txt == 'Insight' 
	or _seal == 'Righteousness'and txt == 'Righteousness'
	or _seal == 'Truth' and txt == 'Truth'
	or _palabuff == 'Kings'and txt == 'Kings'
	or _palabuff == 'Might' and txt == 'Might' then
		return true
	else return false end
end

-- Compare keybinds with names
function mtsLib.CompareKeybind(txt, key)
	if txt == 'alt'	then
		return IsAltKeyDown() and not GetCurrentKeyBoardFocus() and mts_getConfig("altKeyAction") == key
	end

	if txt == 'shift' then
		return IsShiftKeyDown() and not GetCurrentKeyBoardFocus() and mts_getConfig("shiftKeyAction") == key
	end

	if txt == 'control' then
		return IsControlKeyDown() and not GetCurrentKeyBoardFocus() and mts_getConfig("controlKeyAction") == key
	end
end

-- Compare stuff with GUIs
function mtsLib.Compare(txt, key, unit)
	return ProbablyEngine.condition[txt](unit) <= mts_getConfig(key)
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
		and mts_getConfig('mtsconf_Taunts') then
			return true

	-- Check if can whisper
	elseif txt == 'whisper' 
		and mts_getConfig('mtsconf_Whispers') then
			return RunMacroText("/w "..txt2)
	
	-- Check if can use sounds
	elseif txt == 'sound' 
		and mts_getConfig('mtsconf_Sounds') then
			PlaySoundFile("Interface\\AddOns\\Probably_MrTheSoulz\\media\\beep.mp3", "master")

	-- Check if can use alerts
	elseif txt == 'alert' 
		and mts_getConfig('mtsconf_Alerts') then
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
	 	and mts_getConfig('mtsconf_Items') 
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