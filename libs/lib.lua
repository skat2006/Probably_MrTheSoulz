--[[ ///---INFO---////
//General Lib//
Thank You For Using My ProFiles
I Hope Your Enjoy Them
MTS
]]

local mtsLib = { wisp = false, alert = true, sound = false, taunt = false, firehack = true }
local _media = "Interface\\AddOns\\Probably_MrTheSoulz\\media\\"
local mts_Dummies = {31146,67127,46647,32546,31144,32667,32542,32666,32545,32541}
mtsLib.queueSpell = nil
mtsLib.queueTime = 0

							
									--[[   !!!Pack Commands!!!   ]]
--[[  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ]]
ProbablyEngine.command.register('mts', function(msg, box)
local command, text = msg:match("^(%S*)%s*(.-)$")
		
	-- Dispaly Version
	if command == 'ver' or command == 'version' then
		mts_AlertSounds()
		mtsAlert:message('MrTheSoulz Version: 0.11.6')
	end
	
	-- Enabled/Disable Whispers
	if command == 'wisp' or command == 'wsp' or command == 'w' then
	mtsLib.wisp = not mtsLib.wisp
		if mtsLib.wisp then
			mtsAlert:message('*Whispers Enabled.*')
		else
			mtsAlert:message('*Whispers Disabled*.')
		end
	end
	
	-- Enable/Disable Alerts
	if command == 'alerts' or command == 'notifications' or command == 'a' then
	mtsLib.alert = not mtsLib.alert
		if mtsLib.alert then
			mtsAlert:message('*Alerts Enabled.*')
		else
			mtsAlert:message('*Alerts Disabled*.')
		end
	end
	
	-- Enabled/Disable Sounds
	if command == 'sounds' or command == 'sound' or command == 's' then
	mtsLib.sound = not mtsLib.sound
		if mtsLib.sound then
			mtsAlert:message('*Sounds Enabled.*')
		else
			mtsAlert:message('*Sounds Disabled*.')
		end
	end

	-- -- Enabled/Disable PE
	if command == 'toggle' then
    	if ProbablyEngine.config.read('button_states', 'MasterToggle', false) then
        	ProbablyEngine.buttons.toggle('MasterToggle')
        	mtsAlert:message("|cFFB30000Rotation off")
    	else
        	ProbablyEngine.buttons.toggle('MasterToggle')
        	mtsAlert:message("|cFF00B34ARotation on")
    	end
  	end

	-- Enabled/Disable Taunts
	if command == 'taunts' or command == 'taunt' or command == 't' then
	mtsLib.taunt = not mtsLib.taunt
		if mtsLib.taunt then
			mtsAlert:message('*Taunts Enabled.*')
		else
			mtsAlert:message('*Taunts Disabled*.')
		end
	end

	-- Enabled/Disable Interrupts
	if command == 'kick' or command == 'interrupt' then
    	if ProbablyEngine.config.read('button_states', 'interrupt', false) then
      		ProbablyEngine.buttons.toggle('interrupt')
      		mtsAlert:message("|cFFB30000Interrupts off")
    	else
      		ProbablyEngine.buttons.toggle('interrupt')
      		mtsAlert:message("|cFF00B34AInterrupts on")
    	end
  	end

  	-- Enabled/Disable cooldowns
  	if command == 'cds' or command == 'cooldowns' then
    	if ProbablyEngine.config.read('button_states', 'cooldowns', false) then
      		ProbablyEngine.buttons.toggle('cooldowns')
      		mtsAlert:message("|cFFB30000Offensive Cooldowns off")
    	else
      		ProbablyEngine.buttons.toggle('cooldowns')
      		mtsAlert:message("|cFF00B34AOffensive Cooldowns on")
    	end
  	end

  	-- Enabled/Disable aoe
	if command == 'aoe' then
    	if ProbablyEngine.config.read('button_states', 'multitarget', false) then
      		ProbablyEngine.buttons.toggle('multitarget')
      		mtsAlert:message("|cFFB30000AoE off")
    	else
      		ProbablyEngine.buttons.toggle('multitarget')
      		mtsAlert:message("|cFF00B34AAoE on")
      	end
    end

    if command == 'logo' then
    	mtsStart:message("\124cff9482C9*Wanted To See Me?!*")
    end

    if command == 'firehack' or command == 'fh' then
    	mtsLib.firehack = not mtsLib.firehack
    	if mtsLib.firehack then
			print("|cFF9482C9[MTS]:|r You have chosen to use FireHack's features.")
		else
			print("|cFF9482C9[MTS]:|r You have chosen to not use FireHack's features.")
		end
    end

	if command == 'help' or command == 'h' then
		print("|cFF9482C9MTS Help:")
 	 	print("|cFFC41F3B/mts ver:|r Displays the version number.")
  		print("|cFFC41F3B/mts wisps:|r Enables/Disables whispers after a cast.")
  		print("|cFFC41F3B/mts alerts:|r Enables/Disables Alerts.")
		print("|cFFC41F3B/mts sounds:|r Enables/Disables sounds.")
		print('|cFFC41F3B/mts taunts:|r Enables/Disables "smart" Taunts.')
		print('|cFFC41F3B/mts toggle:|r Enables/Disables PE.')
		print('|cFFC41F3B/mts aoe:|r Enables/Disables aoe.')
		print('|cFFC41F3B/mts kick:|r Enables/Disables interrupt.')
		print("|cFFC41F3B/mts cds:|r Enables/Disables cooldowns.")
		print("|cFFC41F3B/mts logo:|r Displays MTS Logo.")
		print("|cFFC41F3B/mts logo:|r Enables/Disables the use of FireHack's features if it is detected.")
		print("|cFFC41F3BNeed more help?:|r http://adf.ly/t5PPj")
	end

end)



function mts_ShouldTaunt()
	if UnitIsTappedByPlayer("target") 
	and mtsLib.taunt then
		return true
	else
		return false
	end
end

function mts_ConfigWhisper(txt)
	if mtsLib.wisp then
		return RunMacroText("/w "..txt)
	end
	return false
end

function mts_AlertSounds()
	if mtsLib.sound then
		PlaySoundFile("Interface\\AddOns\\Probably_MrTheSoulz\\media\\beep.mp3", "master")
	end
end

function mts_ConfigAlert(txt)
	if mtsLib.alert then
		return mtsAlert:message(txt)
	end
end

function mtsLib.CanFireHack()
	if FireHack then
	 	if mtsLib.firehack then
			return true
		else return false end
	else return false end
end



							--[[   !!!Check If player to unit distance!!!   ]]
								--[[   TXT = Unit, TXT2 = Distance   ]]
--[[  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ]]
function mtsLib.canUseFeather(txt)
	if Distance(player, txt) >= 35 then
		return true
	else return false end
end


 							--[[   !!!Check IF should dot units around!!!   ]]
										--[[   Thanks biGGER!   ]]
--[[  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ]]

local UnitDebuff = function(target, spell, owner)
    local debuff, count, caster, expires, spellID
    if tonumber(spell) then
    local i = 0; local go = true
    while i <= 40 and go do
        i = i + 1
        debuff,_,_,count,_,_,expires,caster,_,_,spellID,_,_,_,power = _G['UnitDebuff'](target, i)
        if not owner then
        if spellID == tonumber(spell) and caster == "player" then go = false end
        elseif owner == "any" then
        if spellID == tonumber(spell) then go = false end
        end
    end
    else
    debuff,_,_,count,_,_,expires,caster = _G['UnitDebuff'](target, spell)
    end
    return debuff, count, expires, caster, power
end
 

function mtsLib.dots(spellId, debuffId)
  IterateObjects(function(object)
    if not (object == ObjectFromUnitId("target")) then
      if not UnitBuff(object, debuffId, "player") then
    	  CastSpellById("spellId", object)
    	  return true
    	end
    end
  end, ObjectTypes.Unit)
return
end


					--[[   !!!Check Mouseover and target are or not equal!!!   ]]
--[[  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ]]


function mtsLib.mouseNotEqualTarget()
	if (UnitGUID('target')) ~= (UnitGUID('mouseover')) then return true end
 return false
end

function mtsLib.mouseEqualTarget()
	if (UnitGUID('target')) ~= (UnitGUID('mouseover')) then return false end
 return true
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

									--[[   !!!Check can use item!!!   ]]
							-- [[   Check if item is ready and can use it   ]]
--[[  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ]]
function mtsLib.checkItem(key)
	if GetItemCount(key) > 1
	and GetItemCooldown(key) == 0 then 
		return true
	end
	return false
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
			mts_AlertSounds()
			mts_ConfigAlert("*Casted Light´s Hammer*")
		end
		if spellId == 633 then
			mts_AlertSounds()
			mts_ConfigWhisper(tname.." MSG: Casted Lay On Hands on you.")
			mts_ConfigAlert("*Casted Lay on Hands*")
		end
		if spellId == 1044 then
			mts_AlertSounds()
			mts_ConfigWhisper(tname.." MSG: Casted Hand of Freedom on you.")
			mts_ConfigAlert("*Casted Hand of Freedom*")
		end
		if spellId == 6940 then
			mts_AlertSounds()
			mts_ConfigAlert("*Casted Hand of Sacrifice*")
			mts_ConfigWhisper("/w "..tname.." MSG: Casted Hand of Sacrifice on you.")
		end
		if spellId == 105593 then
			mts_AlertSounds()
			mts_ConfigAlert("*Stunned Target*")
		end
		if spellId == 853 then
			mts_AlertSounds()
			mts_ConfigAlert("*Stunned Target*")
		end
		if spellId == 31821 then
			mts_AlertSounds()
			mts_ConfigAlert("*Casted Devotion Aura*")
		end
		if spellId == 31884 then
			mts_AlertSounds()
			mts_ConfigAlert("*Casted Avenging Wrath*")
		end
		if spellId == 105809 then
			mts_AlertSounds()
			mts_ConfigAlert("*Casted Guardian of Ancient Kings*")
		end
		if spellId == 31850 then
			mts_AlertSounds()
			mts_ConfigAlert("*Casted Ardent Defender*")
		end
		if spellId == 86659 then
			mts_AlertSounds()
			mts_ConfigAlert("*Casted Holy Avenger*")
		end
		if spellId == 86669 then
			mts_AlertSounds()
			mts_ConfigAlert("*Casted Guardian of Ancient Kings*")
		end
		if spellId == 31842 then
			mts_AlertSounds()
			mts_ConfigAlert("*Casted Divine Favor*")
		end

    -- DeathKnight

		if spellId == 43265 then
			mts_AlertSounds()
			mts_ConfigAlert("*Casted Death and Decay*")
		end
		if spellId == 48707 then
			mts_AlertSounds()
			mts_ConfigAlert("*Casted Anti-Magic Shell*")
		end
		if spellId == 49028 then
			mts_AlertSounds()
			mts_ConfigAlert("*Casted Dancing Rune Weapon*")
		end
		if spellId == 55233 then
			mts_AlertSounds()
			mts_ConfigAlert("*Casted Vampiric Blood*")
		end
		if spellId == 48792 then
			mts_AlertSounds()
			mts_ConfigAlert("*Casted Icebound Fortitude*")
		end
		if spellId == 42650 then
			mts_AlertSounds()
			mts_ConfigAlert("*Casting Army of the Dead*")
		end

	end
end)