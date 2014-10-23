--[[ ///---INFO---////
//General Lib//
Thank You For Using My ProFiles
I Hope Your Enjoy Them
MTS
]]

local mtsLib = { wisp = false, alert = true, sound = true, taunt = false, firehack = true }
local _media = "Interface\\AddOns\\Probably_MrTheSoulz\\media\\"
local mts_Dummies = {31146,67127,46647,32546,31144,32667,32542,32666,32545,32541}
local ignoreDebuffs = {'Mark of Arrogance','Displaced Energy'}
mtsLib.queueSpell = nil
mtsLib.queueTime = 0
mtsLib.sefUnits = {}
mtsLib.lastSEFCount = 0
mtsLib.lastSEFTarget = nil


function mtsLib.SEF()
  if (UnitGUID('target') ~= nil) then
	  local count = DSL('buff.count')('player', '137639')
	  if count > mtsLib.lastSEFCount and mtsLib.lastSEFTarget then
		mtsLib.sefUnits[mtsLib.lastSEFTarget], mtsLib.lastSEFCount, mtsLib.lastSEFTarget = true, count, nil
	  end
	  if count < 2 and DSL('enemy')('mouseover') then
		local mouseover, target = UnitGUID('mouseover'), UnitGUID('target')
		if mouseover and target ~= mouseover and not mtsLib.sefUnits[mouseover] then
		  mtsLib.lastSEFTarget = mouseover
		  return true
		end
	  end
	  if (count == 0) then
		mtsLib.sefUnits, mtsLib.lastSEFCount, mtsLib.lastSEFTarget = {}, 0, nil
	  end
  end
  return false
end



function mtsLib.cancelSEF()
  if DSL('buff')('player', '137639') then
     --and DSL('modifier.enemies')() < 2 then
    mtsLib.sefUnits, mtsLib.lastSEFCount, mtsLib.lastSEFTarget = {}, 0, nil
    return true
  end
  return
end

--[[   !!!Pack Commands!!!   ]]
ProbablyEngine.command.register('mts', function(msg, box)
local command, text = msg:match("^(%S*)%s*(.-)$")
		
	-- Dispaly Version
	if command == 'ver' or command == 'version' then
		mtsLib.ConfigAlertSound()
		mtsAlert:message('MrTheSoulz Version: 0.5.11')
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

--[[   !!!Check If can FireHack!!!   ]]
function mtsLib.CanFireHack()
	if FireHack then
	 	if mtsLib.firehack then
			return true
		else return false end
	else  return false end
end

--[[   !!!Check If can feathers!!!   ]]
function mtsLib.canUseFeather(txt)
	if Distance(player, txt) >= 30 then
		return true
	else 
		return false
	end
end

--[[   !!!Dispell function!!!   ]]
function mtsLib.Dispell(text)
local prefix = (IsInRaid() and 'raid') or 'party'
	for i = -1, GetNumGroupMembers() - 1 do
	local unit = (i == -1 and 'target') or (i == 0 and 'player') or prefix .. i
		if IsSpellInRange(text, unit) then
			for j = 1, 40 do
			local debuffName, _, _, _, dispelType, duration, expires, _, _, _, spellID, _, isBossDebuff, _, _, _ = UnitDebuff(unit, j)
				if dispelType and dispelType == 'Magic' or dispelType == 'Poison' or dispelType == 'Disease' then
				local ignore = false
				for k = 1, #ignoreDebuffs do
					if debuffName == ignoreDebuffs[k] then
						ignore = true
						break
					end
				end
					if not ignore then
						ProbablyEngine.dsl.parsedTarget = unit
						return true
					end
				end
				if not debuffName then
					break
				end
			end
		end
	end
		return false
end 

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

--[[   !!!Check if should taunt!!!   ]]
function mtsLib.ShouldTaunt()
	if UnitIsTappedByPlayer("target") 
	and mtsLib.taunt
	and mtsLib.dummy() then
		return true
	else
		return false
	end
end

--[[   !!!Check if can whisper!!!   ]]
function mtsLib.ConfigWhisper(txt)
	if mtsLib.GetWisp() then
		return RunMacroText("/w "..txt)
	end
	return false
end

--[[   !!!Check if can use sounds!!!   ]]
function mtsLib.ConfigAlertSound()
	if mtsLib.wisp then
		PlaySoundFile(_media .. "beep.mp3", "master")
	end
end

--[[   !!!Check if can use Alerts!!!   ]]
function mtsLib.ConfigAlert(txt)
	if mtsLib.alert then
		return mtsAlert:message(txt)
	end
end

--[[   !!!Check should stop when a boss...!!!   ]]
function mtsLib.StopIfBoss()
if UnitExists("boss1") then
local npcId = tonumber(UnitGUID("target"):sub(6,10), 16)
	if npcId == 71543 -- Immersus
	or npcId == 72276 -- Norushen
	or npcId == 71734 -- Sha of Pride
	or npcId == 72249 -- Galakras
	or npcId == 71466 -- Iron Juggernaut
	or npcId == 71859 -- Kor'kron Dark Shaman
	or npcId == 71515 -- General Nazgrim
	or npcId == 71454 -- Malkorok
	or npcId == 71529 -- Thok the Bloodsthirsty
	or npcId == 71504 -- Siegecrafter Blackfuse
	or npcId == 71865 -- Garrosh Hellscream
	then return false end
end
	return true 
end

--[[   !!!Check should stop when a boss...!!!   ]]
function mtsLib.shouldStop(unit)
	if not UnitAffectingCombat(unit) then return false end
	if mtsLib.hasDebuffTable(unit, _cc) then return false end
	if UnitAura(unit,GetSpellInfo(116994))
		or UnitAura(unit,GetSpellInfo(122540))
		or UnitAura(unit,GetSpellInfo(123250))
		or UnitAura(unit,GetSpellInfo(106062))
		or UnitAura(unit,GetSpellInfo(110945))
		or UnitAura(unit,GetSpellInfo(143593)) -- General Nazgrim: Defensive Stance
		or UnitAura(unit,GetSpellInfo(143574)) -- Heroic Immerseus: Swelling Corruption
		then return false 
	end
		return true
end

--[[   !!!Check can use item!!!   ]]
function mtsLib.checkItem(key)
	if GetItemCount(key) > 1
	and GetItemCooldown(key) == 0 then 
		return true
	end
	return false
end

--[[   !!!Check if it is a dummy!!!   ]]
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
ProbablyEngine.listener.register("COMBAT_LOG_EVENT_UNFILTERED", function(...)
local event = select(2, ...)
local source = select(4, ...)
local spellId = select(12, ...)
local tname = UnitName("target")
if source ~= UnitGUID("player") then return false end

	if event == "SPELL_CAST_SUCCESS" then	

    -- Paladin

		if spellId == 114158 then
			mtsLib.ConfigAlertSound()
			mtsLib.ConfigAlert("*Casted Light´s Hammer*")
		end
		if spellId == 633 then
			mtsLib.ConfigAlertSound()
			mtsLib.ConfigWhisper(tname.." MSG: Casted Lay On Hands on you.")
			mtsLib.ConfigAlert("*Casted Lay on Hands*")
		end
		if spellId == 1044 then
			mtsLib.ConfigAlertSound()
			mtsLib.ConfigWhisper(tname.." MSG: Casted Hand of Freedom on you.")
			mtsLib.ConfigAlert("*Casted Hand of Freedom*")
		end
		if spellId == 6940 then
			mtsLib.ConfigAlertSound()
			mtsLib.ConfigAlert("*Casted Hand of Sacrifice*")
			mtsLib.ConfigWhisper("/w "..tname.." MSG: Casted Hand of Sacrifice on you.")
		end
		if spellId == 105593 then
			mtsLib.ConfigAlertSound()
			mtsLib.ConfigAlert("*Stunned Target*")
		end
		if spellId == 853 then
			mtsLib.ConfigAlertSound()
			mtsLib.ConfigAlert("*Stunned Target*")
		end
		if spellId == 31821 then
			mtsLib.ConfigAlertSound()
			mtsLib.ConfigAlert("*Casted Devotion Aura*")
		end
		if spellId == 31884 then
			mtsLib.ConfigAlertSound()
			mtsLib.ConfigAlert("*Casted Avenging Wrath*")
		end
		if spellId == 105809 then
			mtsLib.ConfigAlertSound()
			mtsLib.ConfigAlert("*Casted Guardian of Ancient Kings*")
		end
		if spellId == 31850 then
			mtsLib.ConfigAlertSound()
			mtsLib.ConfigAlert("*Casted Ardent Defender*")
		end
		if spellId == 86659 then
			mtsLib.ConfigAlertSound()
			mtsLib.ConfigAlert("*Casted Holy Avenger*")
		end
		if spellId == 86669 then
			mtsLib.ConfigAlertSound()
			mtsLib.ConfigAlert("*Casted Guardian of Ancient Kings*")
		end
		if spellId == 31842 then
			mtsLib.ConfigAlertSound()
			mtsLib.ConfigAlert("*Casted Divine Favor*")
		end

    -- DeathKnight

		if spellId == 43265 then
			mtsLib.ConfigAlertSound()
			mtsLib.ConfigAlert("*Casted Death and Decay*")
		end
		if spellId == 48707 then
			mtsLib.ConfigAlertSound()
			mtsLib.ConfigAlert("*Casted Anti-Magic Shell*")
		end
		if spellId == 49028 then
			mtsLib.ConfigAlertSound()
			mtsLib.ConfigAlert("*Casted Dancing Rune Weapon*")
		end
		if spellId == 55233 then
			mtsLib.ConfigAlertSound()
			mtsLib.ConfigAlert("*Casted Vampiric Blood*")
		end
		if spellId == 48792 then
			mtsLib.ConfigAlertSound()
			mtsLib.ConfigAlert("*Casted Icebound Fortitude*")
		end
		if spellId == 42650 then
			mtsLib.ConfigAlertSound()
			mtsLib.ConfigAlert("*Casting Army of the Dead*")
		end

	end
end)