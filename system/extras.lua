mts.unitCache = {}
mts.unitFriendlyCache = {}

local fetch = ProbablyEngine.interface.fetchKey
local PeConfig = ProbablyEngine.config
local dummyStartedTime = 0
local lastDummyPrint = 0
local unitCacheTotal = 0
local unitCacheFriendlyTotal = 0

--[[-----------------------------------------------
** Unit Cache **
DESC: This checks all defined units around you and caches them.
ToDo: Review Offspring's cache.

Build By: MTS
---------------------------------------------------]]
local function mts_unitCacheFun()
	-- Wipe Chace before refresh otherwise it just adds to the cache...
	wipe(mts.unitCache)
	wipe(mts.unitFriendlyCache)
	-- These are globals beacuse we use it on GUI and might be usefull for other stuff asswell.
	unitCacheTotal = 0
	unitCacheFriendlyTotal = 0
  
	-- If we're using FireHack...  
	if FireHack and fetch("mtsconf", "AC") then
		local totalObjects = ObjectCount()
		for i=1, totalObjects do
			local object = ObjectWithIndex(i)
			if ObjectExists(object) then
				if ObjectIsType(object, ObjectTypes.Unit) and ProbablyEngine.condition["alive"](object) then
					local distance = mts.Distance('player', object)
					if distance <= (fetch("mtsconf", "CD") or 40) then
						local health = math.floor((UnitHealth(object) / UnitHealthMax(object)) * 100)
						local maxHealth = UnitHealthMax(object)
						local actualHealth = UnitHealth(object)
						local name = GetUnitName(object, false)
						-- Friendly Cache
						if UnitIsFriend("player", object) then
							-- Enabled on GUI
							if fetch("mtsconf", "FU") then
								-- Cache only Players
								if fetch("mtsconf", "FU2") == 'Players' then
									if UnitIsPlayer(object) then
										unitCacheFriendlyTotal = unitCacheFriendlyTotal + 1
										table.insert(mts.unitFriendlyCache, {key=object, distance=distance, health=health, maxHealth=maxHealth, actualHealth=actualHealth, name=name})
										table.sort(mts.unitFriendlyCache, function(a,b) return a.distance < b.distance end)
									end
								-- Cache Only Party/Raid
								elseif fetch("mtsconf", "FU2") == 'PR' then
									if UnitIsPlayer(object) and (UnitInParty(object) or UnitInRaid(object)) then
										unitCacheFriendlyTotal = unitCacheFriendlyTotal + 1
										table.insert(mts.unitFriendlyCache, {key=object, distance=distance, health=health, maxHealth=maxHealth, actualHealth=actualHealth, name=name})
										table.sort(mts.unitFriendlyCache, function(a,b) return a.distance < b.distance end)
									end
								-- Cache All
								else
									unitCacheFriendlyTotal = unitCacheFriendlyTotal + 1
									table.insert(mts.unitFriendlyCache, {key=object, distance=distance, health=health, maxHealth=maxHealth, actualHealth=actualHealth, name=name})
									table.sort(mts.unitFriendlyCache, function(a,b) return a.distance < b.distance end)
								end
							end
						-- All Other units cache
						else
							-- Enabled on GUI and unit affecting combat
							if fetch("mtsconf", "EU") then
								if not mts.immuneEvents(object) then
									if fetch("mtsconf", "EU2") == 'Combat' then 
										if UnitAffectingCombat(object) then
											unitCacheTotal = unitCacheTotal + 1
											table.insert(mts.unitCache, {key=object, distance=distance, health=health, maxHealth=maxHealth, actualHealth=actualHealth, name=name})
											table.sort(mts.unitCache, function(a,b) return a.distance < b.distance end)
										end
									else
										unitCacheTotal = unitCacheTotal + 1
										table.insert(mts.unitCache, {key=object, distance=distance, health=health, maxHealth=maxHealth, actualHealth=actualHealth, name=name})
										table.sort(mts.unitCache, function(a,b) return a.distance < b.distance end)
									end
								end
							end
						end
					 end
				end
			end
		end
        -- OffSpring
        elseif oexecute and fetch("mtsconf", "AC") then
		local count = ObjectsCount('player', (fetch("mtsconf", "CD") or 40))
		for i=1, count do
			local object, id, name = ObjectByIndex(i)
			if object then
				if ProbablyEngine.condition["alive"](object) then
					local distance = mts.Distance('player', object)
					local health = math.floor((UnitHealth(object) / UnitHealthMax(object)) * 100)
					local maxHealth = UnitHealthMax(object)
					local actualHealth = UnitHealth(object)
					local name = GetUnitName(object, false)
                            		-- Friendly Cache
					if UnitIsFriend("player", object) then
						-- Enabled on GUI
						if fetch("mtsconf", "FU") then
							-- Cache only Players
							if fetch("mtsconf", "FU2") == 'Players' then
								if UnitIsPlayer(object) then
									unitCacheFriendlyTotal = unitCacheFriendlyTotal + 1
									table.insert(mts.unitFriendlyCache, {key=object, distance=distance, health=health, maxHealth=maxHealth, actualHealth=actualHealth, name=name})
									table.sort(mts.unitFriendlyCache, function(a,b) return a.distance < b.distance end)
								end
                                        		-- Cache Only Party/Raid
							elseif fetch("mtsconf", "FU2") == 'PR' then
								if UnitIsPlayer(object) and (UnitInParty(object) or UnitInRaid(object)) then
									unitCacheFriendlyTotal = unitCacheFriendlyTotal + 1
									table.insert(mts.unitFriendlyCache, {key=object, distance=distance, health=health, maxHealth=maxHealth, actualHealth=actualHealth, name=name})
									table.sort(mts.unitFriendlyCache, function(a,b) return a.distance < b.distance end)
								end
							-- Cache All
							else
								unitCacheFriendlyTotal = unitCacheFriendlyTotal + 1
								table.insert(mts.unitFriendlyCache, {key=object, distance=distance, health=health, maxHealth=maxHealth, actualHealth=actualHealth, name=name})
								table.sort(mts.unitFriendlyCache, function(a,b) return a.distance < b.distance end)
							end
						end
					-- All Other units cache
					else
						-- Enabled on GUI and unit affecting combat
						if fetch("mtsconf", "EU") then
							if not mts.immuneEvents(object) then
								if fetch("mtsconf", "EU2") == 'Combat' then 
									if UnitAffectingCombat(object) then
										unitCacheTotal = unitCacheTotal + 1
										table.insert(mts.unitCache, {key=object, distance=distance, health=health, maxHealth=maxHealth, actualHealth=actualHealth, name=name})
										table.sort(mts.unitCache, function(a,b) return a.distance < b.distance end)
									end
								else
									unitCacheTotal = unitCacheTotal + 1
									table.insert(mts.unitCache, {key=object, distance=distance, health=health, maxHealth=maxHealth, actualHealth=actualHealth, name=name})
									table.sort(mts.unitCache, function(a,b) return a.distance < b.distance end)
								end
							end
						end
					end
				end
			end
		end
	-- Cache Raid/Party Targets
	else
		local prefix = (IsInRaid() and 'raid') or 'party'
		for i = 1, GetNumGroupMembers() do
			local target = prefix..i.."target"
			if fetch("mtsconf", "EU") then
				if UnitExists(target) and not UnitIsFriend("player", target) then
					local distance = mts.Distance('player', target)
					if distance <= (fetch("mtsconf", "CD") or 40) and ProbablyEngine.condition["alive"](target) then
						if not mts.immuneEvents(target) then
							unitCacheTotal = unitCacheTotal + 1
							table.insert(mts.unitCache, {key=target, distance=distance, health=math.floor((UnitHealth(target) / UnitHealthMax(target)) * 100), maxHealth=UnitHealthMax(target), actualHealth=UnitHealth(target), name=GetUnitName(target, false)})
							table.sort(mts.unitCache, function(a,b) return a.distance < b.distance end)
						end
					end
				end
			end
		end
		for i = -1, GetNumGroupMembers() - 1 do
			local friendly = (i == 0 and 'player') or prefix .. i
			if fetch("mtsconf", "FU") then
				local distance = mts.Distance('player', friendly)
				if distance <= (fetch("mtsconf", "CD") or 40) and ProbablyEngine.condition["alive"](friendly) then
					unitCacheFriendlyTotal = unitCacheFriendlyTotal + 1
					table.insert(mts.unitFriendlyCache, {key=friendly, distance=distance, health=math.floor((UnitHealth(friendly) / UnitHealthMax(friendly)) * 100), maxHealth=UnitHealthMax(friendly), actualHealth=UnitHealth(friendly), name=GetUnitName(friendly, false)})
					table.sort(mts.unitFriendlyCache, function(a,b) return a.distance < b.distance end)
				end
			end
		end
	end
end

--[[-----------------------------------------------
** Automated Movements **
DESC: Moves to a unit.

Build By: MTS
---------------------------------------------------]]
local function mts_MoveTo()
	--[[ UNTESTED, this is to be used with MoveTo.
	local ranged = {
	    62,         -- arcane mage
	    63,         -- fire mage
	    64,         -- frost mage
	    65,         -- holy paladin
	    102,        -- balance druid
	    105,        -- restoration druid
	    253,        -- beast mastery hunter
	    254,        -- marksmanship hunter
	    255,        -- survival hunter
	    256,        -- discipline priest
	    257,        -- holy priest
	    258,        -- shadow priest
	    262,        -- elemental shaman
	    263,        -- enhancement shaman
	    264,        -- restoration shaman
	    265,        -- affliction warlock
	    266,        -- demonology warlock
	    267,        -- destruction warlock
	    270,        -- mistweaver monk
	  }]]
  	if fetch('mtsconf', 'AutoMove') then
  		if UnitExists('target') and UnitIsVisible('target') then
			local name = GetUnitName('target', false)
			if FireHack then
				local aX, aY, aZ = ObjectPosition('target')
				if mts.Distance("player", 'target') >= 6 + (UnitCombatReach('player') + UnitCombatReach('target')) then
					mtsAlert:message('Moving to: '..name) 
					MoveTo(aX, aY, aZ)
				end
			end
	  	end
	end
end

--[[-----------------------------------------------
** Automated Facing **
DESC: Checks if unit can/should be faced.

Build By: MTS
---------------------------------------------------]]
local function mts_FaceTo()
	if fetch('mtsconf', 'AutoFace') then
	local unitSpeed, _ = GetUnitSpeed('player')
	  	if UnitExists('target') and UnitIsVisible('target') and unitSpeed == 0 and not UnitChannelInfo("player") then
			local name = GetUnitName('target', false)
			if not mts.Infront('target') then
				if FireHack then
					mtsAlert:message('Facing: '..name) 
					FaceUnit('target')
				elseif oexecute then
					mtsAlert:message('Facing: '..name) 
					FaceToUnit('target')
				end
			end
		end
	end
end

--[[-----------------------------------------------
** Automated Targets **
DESC: Checks if unit can/should be targeted.

Build By: MTS & StinkyTwitch
---------------------------------------------------]]
local function mts_autoTarget(unit, name)
	if fetch('mtsconf', 'AutoTarget') then
		if UnitExists("target") and not UnitIsFriend("player", "target") and not UnitIsDeadOrGhost("target") then
			-- Do nothing
		else
			for i=1,#mts.unitCache do
				if mts.unitCache[i].name ~= UnitName("player") then
					mtsAlert:message('Targeting: '..mts.unitCache[i].name) 
					return Macro("/target "..mts.unitCache[i].key)
				end
			end
		end
	end
end

--[[----------------------------------------------- 
    ** Utility - Milling ** 
    DESC: Automatic Draenor herbs milling 
    ToDo: Test it & add some kind of button to start instease of using a
    checkbox on the GUI.
    Oh and possivly add more stuff...

    Build By: MTS
    ---------------------------------------------------]] 
local function autoMilling()
	local Milling_Herbs = {
		-- Draenor
		109124, -- Frostweed
		109125, -- Fireweed
		109126, -- Gorgrond Flytrap
		109127, -- Starflower
		109128, -- Nagrand Arrowbloom
		109129 -- Talador Orchid
	}
	if mts.AutoMilling then
		if IsSpellKnown(51005) then
			for i=1,#Milling_Herbs do
				if GetItemCount(Milling_Herbs[i],false,false) >= 5 then 
					Cast(51005) 
					UseItem(Milling_Herbs[i])
					mts.Print('Milling '..Milling_Herbs[i])
				else	
					mts.AutoMilling = false
					mts.Print('Stoped milling, you dont have enough mats.')
				end
			end
		else
			mts.AutoMilling = false
			mts.Print('Failed, you are not a miller.')
		end
	end
end

--[[----------------------------------------------- 
    ** Savage ** 
    DESC: Savge Items

    Build By: SVS
    ---------------------------------------------------]]
local function OpenSalvage()
	if mts.AutoSavage then
		-- Bag of Salvaged Goods
		if GetItemCount(114116, false, false) > 0 then
			UseItem(114116)
		-- Crate of Salvage
		elseif GetItemCount(114119, false, false) > 0 then
			UseItem(114119)
		-- Big Crate of Salvage
		elseif GetItemCount(114120, false, false) > 0 then
			UseItem(114120)
		else
			mts.AutoSavage = false
			mts.Print('Failed, you do not have enough mats.')
		end
	end
end

local function AutoBait()
	if mts.AutoBait then
		-- Jawless Skulker Bait
		if fetch('mtsconf', 'bait') == "jsb" and not UnitBuff("player", GetSpellInfo(158031)) and GetItemCount(110274, false, false) > 0 then
			UseItem(110274)
		-- Fat Sleeper Bait
		elseif fetch('mtsconf', 'bait') == "fsb" and not UnitBuff("player", GetSpellInfo(158034)) and GetItemCount(110289, false, false) > 0 then
			UseItem(110289)
		-- Blind Lake Sturgeon Bait
		elseif fetch('mtsconf', 'bait') == "blsb" and not UnitBuff("player", GetSpellInfo(158035)) and GetItemCount(110290, false, false) > 0 then
			UseItem(110290)
		-- Fire Ammonite Bait
		elseif fetch('mtsconf', 'bait') == "fab" and not UnitBuff("player", GetSpellInfo(158036)) and GetItemCount(110291, false, false) > 0 then
			UseItem(110291)
		-- Sea Scorpion Bait
		elseif fetch('mtsconf', 'bait') == "ssb" and not UnitBuff("player", GetSpellInfo(158037)) and GetItemCount(110292, false, false) > 0 then
			UseItem(110292)
		-- Abyssal Gulper Eel Bait
		elseif fetch('mtsconf', 'bait') == "ageb" and not UnitBuff("player", GetSpellInfo(158038)) and GetItemCount(110293, false, false) > 0 then
			UseItem(110293)
		-- Blackwater Whiptail Bait
		elseif fetch('mtsconf', 'bait') == "bwb" and not UnitBuff("player", GetSpellInfo(158039)) and GetItemCount(110294, false, false) > 0 then
			UseItem(110294)
		end
	end
end
 
local function CarpDestruction()
	if fetch('mtsconf', 'LunarfallCarp') and GetItemCount(116158, false, false) > 0 then
		for bag = 0, NUM_BAG_SLOTS do
			for slot = 1, GetContainerNumSlots(bag) do
				currentItemID = GetContainerItemID(bag, slot)
				if currentItemID == 116158 then
					PickupContainerItem(bag, slot)
						if CursorHasItem() then
							DeleteCursorItem();
						end
					return true
				end
			end
		end
	end
end

--[[----------------------------------------------- 
    ** Dummy Testing ** 
    DESC: Automatic timer for dummy testing
    ToDo: rename/cleanup 

    Build By: MTS
    ---------------------------------------------------]]
function mts.dummyTest(key)
	local hours, minutes = GetGameTime()
	local TimeRemaning = fetch('mtsconf', 'testDummy') - (minutes-dummyStartedTime)
	
	-- If Disabled PE while runing a test, abort.
	if dummyStartedTime ~= 0 and not ProbablyEngine.config.read('button_states', 'MasterToggle', false) then
		dummyStartedTime = 0
		message('|r[|cff9482C9MTS|r] You have Disabled PE while running a dummy test. \n[|cffC41F3BStoped dummy test timer|r].')
		StopAttack()
	end
	-- If not Calling for refresh, then start it.
	if key ~= 'Refresh' then
		dummyStartedTime = minutes
		message('|r[|cff9482C9MTS|r] Dummy test started! \n[|cffC41F3BWill end in: '..fetch('mtsconf', 'testDummy').."m|r]")
		-- If PE not enabled, then enable it.
		if not ProbablyEngine.config.read('button_states', 'MasterToggle', false) then
			ProbablyEngine.buttons.toggle('MasterToggle')
		end
		StartAttack("target")
	end
	-- Check If time is up.
	if dummyStartedTime ~= 0 and key == 'Refresh' then
		-- Tell the user how many minutes left.
		if lastDummyPrint ~= TimeRemaning then
			lastDummyPrint = TimeRemaning
			mts.Print('Dummy Test minutes remaning: '..TimeRemaning)
		end
		if minutes >= dummyStartedTime + fetch('mtsconf', 'testDummy') then
			dummyStartedTime = 0
			message('|r[|cff9482C9MTS|r] Dummy test ended!')
			-- If PE enabled, then Disable it.
			if ProbablyEngine.config.read('button_states', 'MasterToggle', false) then
				ProbablyEngine.buttons.toggle('MasterToggle')
			end
			StopAttack()
		end
	end
end

--[[-----------------------------------------------
** Ticker **
DESC: SMASH ALL BUTTONS :)
This calls stuff in a define time (used for refreshing stuff).

Build By: MTS
---------------------------------------------------]]
C_Timer.NewTicker(0.5, (function()
	-- If using MTS profies
	if mts.CurrentCR then
		-- Refresh Dummy Testing
		mts.dummyTest('Refresh')
		-- If PE is enabled
		if PeConfig.read('button_states', 'MasterToggle', false) then
			-- Unit Cache
			mts_unitCacheFun()
			-- If in Combat
			if ProbablyEngine.module.player.combat then
				mts_MoveTo()
				mts_FaceTo()
				mts_autoTarget()
			end
			-- If not in combat
			if not ProbablyEngine.module.player.combat then
				-- If not Casting
				if not UnitChannelInfo("player") then
					CarpDestruction()
					-- If There Bag Space
					if mts.BagSpace() > 2 then
						autoMilling()
						OpenSalvage()
						AutoBait()
					end
				end
			end
		end
	end
end), nil)
