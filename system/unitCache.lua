mts.unitCache = {}
mts.unitFriendlyCache = {}

local fetch = ProbablyEngine.interface.fetchKey
local emptyMsg = "Empty...\n|--> |cff9482C9----------|r\n|--> |cff9482C9----------|r\n|--> |cff9482C9----------|r\n|--> |cff9482C9----------|r\n|--> |cff9482C9----------|r"
local _PeConfig = ProbablyEngine.config
local unitCacheTotal = 0
local unitCacheFriendlyTotal = 0

local function mts_unitCacheFun()
  -- Wipe Chace before refresh otherwise it just adds to the cache...
  wipe(mts.unitCache)
  wipe(mts.unitFriendlyCache)
  unitCacheTotal = 0
  unitCacheFriendlyTotal = 0
  
	-- If we're using FireHack...  
		if FireHack and fetch("cacheInfo", "AC") then
			local totalObjects = ObjectCount()
				for i=1, totalObjects do
					local object = ObjectWithIndex(i)
						if ObjectExists(object) then
							if ObjectIsType(object, ObjectTypes.Unit) and ProbablyEngine.condition["alive"](object) then
								local distance = mts.Distance('player', object)
									 if distance <= (fetch("cacheInfo", "CD") or 40) then
                                        local health = math.floor((UnitHealth(object) / UnitHealthMax(object)) * 100)
                                        local maxHealth = UnitHealthMax(object)
                                        local actualHealth = UnitHealth(object)
                                        local name = GetUnitName(object, false)
                                            -- Friendly Cache
                                            if UnitIsFriend("player", object) then
                                                -- Enabled on GUI
                                                if fetch("cacheInfo", "FU") then
                                                    -- Cache only Players
                                                    if fetch("cacheInfo", "FU2") == 'Players' then
                                                        if UnitIsPlayer(object) then
                                                            unitCacheFriendlyTotal = unitCacheFriendlyTotal + 1
                                                            table.insert(mts.unitFriendlyCache, {key=object, distance=distance, health=health, maxHealth=maxHealth, actualHealth=actualHealth, name=name})
                                                            table.sort(mts.unitFriendlyCache, function(a,b) return a.distance < b.distance end)
                                                        end
                                                    -- Cache Only Party/Raid
                                                    elseif fetch("cacheInfo", "FU2") == 'PR' then
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
                                                if fetch("cacheInfo", "EU") then
                                                    if not mts.immuneEvents(object) then
                                                        if fetch("cacheInfo", "EU2") == 'Combat' then 
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
        elseif oexecute and fetch("cacheInfo", "AC") then
            local count = ObjectsCount('player', (fetch("cacheInfo", "CD") or 40))
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
                                if fetch("cacheInfo", "FU") then
                                    -- Cache only Players
                                    if fetch("cacheInfo", "FU2") == 'Players' then
                                        if UnitIsPlayer(object) then
                                            unitCacheFriendlyTotal = unitCacheFriendlyTotal + 1
                                            table.insert(mts.unitFriendlyCache, {key=object, distance=distance, health=health, maxHealth=maxHealth, actualHealth=actualHealth, name=name})
                                            table.sort(mts.unitFriendlyCache, function(a,b) return a.distance < b.distance end)
                                        end
                                        -- Cache Only Party/Raid
                                        elseif fetch("cacheInfo", "FU2") == 'PR' then
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
                                if fetch("cacheInfo", "EU") then
                                    if not mts.immuneEvents(object) then
                                        if fetch("cacheInfo", "EU2") == 'Combat' then 
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
                        if fetch("cacheInfo", "EU") then
                            if UnitExists(target) and not UnitIsFriend("player", target) then
                                local distance = mts.Distance('player', target)
                					if distance <= (fetch("cacheInfo", "CD") or 40) and ProbablyEngine.condition["alive"](target) then
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
						if fetch("cacheInfo", "FU") then
                            local distance = mts.Distance('player', friendly)
    							if distance <= (fetch("cacheInfo", "CD") or 40) and ProbablyEngine.condition["alive"](friendly) then
                                    unitCacheFriendlyTotal = unitCacheFriendlyTotal + 1
                                    table.insert(mts.unitFriendlyCache, {key=friendly, distance=distance, health=math.floor((UnitHealth(friendly) / UnitHealthMax(friendly)) * 100), maxHealth=UnitHealthMax(friendly), actualHealth=UnitHealth(friendly), name=GetUnitName(friendly, false)})
                                    table.sort(mts.unitFriendlyCache, function(a,b) return a.distance < b.distance end)
                                end
                        end
                end
		end
end

--[[
    This shit is completly broken -.-
    The plan: to Display the cache on a GUI
    so we can keep track of all units LIVE.
    Error atm: Only displays the last unit in the cache...
]]
--
local mts_cacheInfo = {
    key = "cacheInfo",
    title = "MrTheSoulz cache",
    subtitle = "mts cache",
    color = "9482C9",
    width = 210,
    height = 350,
    config = {
	
				{ 
					type = 'text', 
					text = "|cff9482C9Cache Options:", 
					size = 15, 
					offset = 0 
				},
					{ 
						type = "checkbox", 
						text = "Use Advanced Object Manager", 
						key = "AC", 
						default = true, 
					},
					{ 
						type = "checkbox", 
						text = "Cache Friendly Units", 
						key = "FU", 
						default = true, 
					},
                    { 
                        type = "checkbox", 
                        text = "Cache Enemie Units", 
                        key = "EU", 
                        default = true, 
                    },
					{ 
						type = "dropdown",
						text = "Friendly Units", 
						key = "FU2", 
						list = {
							{
							  text = "All",
							  key = "All"
							},
							{
							  text = "Players",
							  key = "Players"
							},
                            {
                              text = "Party/Raid",
                              key = "PR"
                            },
						}, 
						default = "PR" 
					},
                    { 
                        type = "dropdown",
                        text = "Enemie Units", 
                        key = "EU2", 
                        list = {
                            {
                              text = "All",
                              key = "All"
                            },
                            {
                              text = "Combat",
                              key = "Combat"
                            },
                        }, 
                        default = "Combat" 
                    },
					{
						type = "spinner",
						text = "Cache distance",
						key = "CD",
						width = 50,
						min = 10,
						max = 80,
						default = 40,
						step = 5
					},
                { type = 'rule' },{ type = 'spacer' },
                { 
                    type = 'text', 
                    text = "|cff9482C9Unit Cache Status:", 
                    size = 15, 
                    offset = 0 
                },
                    { 
                        key = 'current_CacheStatus', 
                        type = "text", 
                        text = "Empty...", 
                        size = 11, 
                        offset = 11 
                    },
				{ type = 'rule' },{ type = 'spacer' },
				{ 
					type = 'text', 
					text = "|cff9482C9Unit Cache:", 
					size = 15, 
					offset = 0 
				},
					{ 
						key = 'current_Cache1Total', 
						type = "text", 
						text = "Empty...", 
						size = 14, 
						offset = 5
					},
					{ 
						key = 'current_Cache1_1', 
						type = "text", 
						text = emptyMsg, 
						size = 11, 
						offset = 60 
					},
					{ 
						key = 'current_Cache1_2', 
						type = "text", 
						text = emptyMsg, 
						size = 11, 
						offset = 60 
					},
					{ 
						key = 'current_Cache1_3', 
						type = "text", 
						text = emptyMsg, 
						size = 11, 
						offset = 60 
					},
					{ 
						key = 'current_Cache1_4', 
						type = "text", 
						text = emptyMsg, 
						size = 11, 
						offset = 60 
					},
					{ 
						key = 'current_Cache1_5', 
						type = "text", 
						text = emptyMsg, 
						size = 11, 
						offset = 60 
					},
					{ 
						key = 'current_Cache1_6', 
						type = "text", 
						text = emptyMsg, 
						size = 11, 
						offset = 60 
					},
					{ 
						key = 'current_Cache1_7', 
						type = "text", 
						text = emptyMsg, 
						size = 11, 
						offset = 60 
					},
					{ 
						key = 'current_Cache1_8', 
						type = "text", 
						text = emptyMsg, 
						size = 11, 
						offset = 60 
					},
					{ 
						key = 'current_Cache1_9', 
						type = "text", 
						text = emptyMsg, 
						size = 11, 
						offset = 60 
					},
					{ 
						key = 'current_Cache1_10', 
						type = "text", 
						text = emptyMsg, 
						size = 11, 
						offset = 60 
					},
				{ type = 'rule' },{ type = 'spacer' },
				{ 
					type = 'text', 
					text = "|cff9482C9Friendly Unit Cache:", 
					size = 15, 
					offset = 0 
				},
					{ 
						key = 'current_Cache2Total', 
						type = "text", 
						text = "Empty...", 
						size = 14, 
						offset = 5
					},
					{ 
						key = 'current_Cache2_1', 
						type = "text", 
						text = emptyMsg, 
						size = 11, 
						offset = 60 
					},
					{ 
						key = 'current_Cache2_2', 
						type = "text", 
						text = emptyMsg, 
						size = 11, 
						offset = 60 
					},
					{ 
						key = 'current_Cache2_3', 
						type = "text", 
						text = emptyMsg, 
						size = 11, 
						offset = 60 
					},
					{ 
						key = 'current_Cache2_4', 
						type = "text", 
						text = emptyMsg, 
						size = 11, 
						offset = 60 
					},
					{ 
						key = 'current_Cache2_5', 
						type = "text", 
						text = emptyMsg, 
						size = 11, 
						offset = 60 
					},
					{ 
						key = 'current_Cache2_6', 
						type = "text", 
						text = emptyMsg, 
						size = 11, 
						offset = 60 
					},
					{ 
						key = 'current_Cache2_7', 
						type = "text", 
						text = emptyMsg, 
						size = 11, 
						offset = 60 
					},
					{ 
						key = 'current_Cache2_8', 
						type = "text", 
						text = emptyMsg, 
						size = 11, 
						offset = 60 
					},
					{ 
						key = 'current_Cache2_9', 
						type = "text", 
						text = emptyMsg, 
						size = 11, 
						offset = 60 
					},
					{ 
						key = 'current_Cache2_10', 
						type = "text", 
						text = emptyMsg, 
						size = 11, 
						offset = 60 
					},

        
    }
}
local mts_cacheWindow
local mts_OpenCacheWindow = false
local mts_ShowingCacheWindow = false
local mts_cacheWindowUpdating = false

-- Check if possivel to smart cache
local function CacheInfo()
    if mts.CurrentCR then
        if fetch("cacheInfo", "AC") then
            if FireHack or oexecute then
                return "|cff00FF96Using Unlocker object manager."
            else
                return "|cffC41F3BUsing Raid/Party Targets.\nUnlocker Dosent have Object manager"
            end
        else 
            return "|cffC41F3BUsing Raid/Party Targets."
        end
    else
        return "|cffC41F3Disabled, Not using MTS Profiles."
    end
end

local function mts_updateCacheInfo()
    -- Enemies
		mts_cacheWindow.elements.current_Cache1Total:SetText("|cff0070DETotal:|r "..unitCacheTotal)
		
		if mts.unitCache[1] then
			mts_cacheWindow.elements.current_Cache1_1:SetText("|cff9482C91 |r "..mts.unitCache[1].name.."\n |--> |cff0070DEGUID:|r "..mts.unitCache[1].key.."\n |--> |cff0070DEDistance:|r "..mts.unitCache[1].distance.."\n |--> |cff0070DEHealth:|r "..mts.unitCache[1].health.."%".."\n |--> |cff0070DEMaxHealth:|r "..mts.unitCache[1].maxHealth.."\n |--> |cff0070DEactualHealth:|r "..mts.unitCache[1].actualHealth)
		else
			mts_cacheWindow.elements.current_Cache1_1:SetText(emptyMsg)
		end
		if mts.unitCache[2] then
			mts_cacheWindow.elements.current_Cache1_2:SetText("|cff9482C92 |r "..mts.unitCache[2].name.."\n |--> |cff0070DEGUID:|r "..mts.unitCache[2].key.."\n |--> |cff0070DEDistance:|r "..mts.unitCache[2].distance.."\n |--> |cff0070DEHealth:|r "..mts.unitCache[2].health.."%".."\n |--> |cff0070DEMaxHealth:|r "..mts.unitCache[2].maxHealth.."\n |--> |cff0070DEactualHealth:|r "..mts.unitCache[2].actualHealth)
		else
			mts_cacheWindow.elements.current_Cache1_2:SetText(emptyMsg)
		end
		if mts.unitCache[3] then
			mts_cacheWindow.elements.current_Cache1_3:SetText("|cff9482C93 |r "..mts.unitCache[3].name.."\n |--> |cff0070DEGUID:|r "..mts.unitCache[3].key.."\n |--> |cff0070DEDistance:|r "..mts.unitCache[3].distance.."\n |--> |cff0070DEHealth:|r "..mts.unitCache[3].health.."%".."\n |--> |cff0070DEMaxHealth:|r "..mts.unitCache[3].maxHealth.."\n |--> |cff0070DEactualHealth:|r "..mts.unitCache[3].actualHealth)
		else
			mts_cacheWindow.elements.current_Cache1_3:SetText(emptyMsg)
		end
		if mts.unitCache[4] then
			mts_cacheWindow.elements.current_Cache1_4:SetText("|cff9482C94 |r "..mts.unitCache[4].name.."\n |--> |cff0070DEGUID:|r "..mts.unitCache[4].key.."\n |--> |cff0070DEDistance:|r "..mts.unitCache[4].distance.."\n |--> |cff0070DEHealth:|r "..mts.unitCache[4].health.."%".."\n |--> |cff0070DEMaxHealth:|r "..mts.unitCache[4].maxHealth.."\n |--> |cff0070DEactualHealth:|r "..mts.unitCache[4].actualHealth)
		else
			mts_cacheWindow.elements.current_Cache1_4:SetText(emptyMsg)
		end
		if mts.unitCache[5] then
			mts_cacheWindow.elements.current_Cache1_5:SetText("|cff9482C95 |r "..mts.unitCache[5].name.."\n |--> |cff0070DEGUID:|r "..mts.unitCache[5].key.."\n |--> |cff0070DEDistance:|r "..mts.unitCache[5].distance.."\n |--> |cff0070DEHealth:|r "..mts.unitCache[5].health.."%".."\n |--> |cff0070DEMaxHealth:|r "..mts.unitCache[5].maxHealth.."\n |--> |cff0070DEactualHealth:|r "..mts.unitCache[5].actualHealth)
		else
			mts_cacheWindow.elements.current_Cache1_5:SetText(emptyMsg)
		end
		if mts.unitCache[6] then
			mts_cacheWindow.elements.current_Cache1_6:SetText("|cff9482C96 |r "..mts.unitCache[6].name.."\n |--> |cff0070DEGUID:|r "..mts.unitCache[6].key.."\n |--> |cff0070DEDistance:|r "..mts.unitCache[6].distance.."\n |--> |cff0070DEHealth:|r "..mts.unitCache[6].health.."%".."\n |--> |cff0070DEMaxHealth:|r "..mts.unitCache[6].maxHealth.."\n |--> |cff0070DEactualHealth:|r "..mts.unitCache[6].actualHealth)
		else
			mts_cacheWindow.elements.current_Cache1_6:SetText(emptyMsg)
		end
		if mts.unitCache[7] then
			mts_cacheWindow.elements.current_Cache1_7:SetText("|cff9482C97 |r "..mts.unitCache[7].name.."\n |--> |cff0070DEGUID:|r "..mts.unitCache[7].key.."\n |--> |cff0070DEDistance:|r "..mts.unitCache[7].distance.."\n |--> |cff0070DEHealth:|r "..mts.unitCache[7].health.."%".."\n |--> |cff0070DEMaxHealth:|r "..mts.unitCache[7].maxHealth.."\n |--> |cff0070DEactualHealth:|r "..mts.unitCache[7].actualHealth)
		else
			mts_cacheWindow.elements.current_Cache1_7:SetText(emptyMsg)
		end
		if mts.unitCache[8] then
			mts_cacheWindow.elements.current_Cache1_8:SetText("|cff9482C98 |r "..mts.unitCache[8].name.."\n |--> |cff0070DEGUID:|r "..mts.unitCache[8].key.."\n |--> |cff0070DEDistance:|r "..mts.unitCache[8].distance.."\n |--> |cff0070DEHealth:|r "..mts.unitCache[8].health.."%".."\n |--> |cff0070DEMaxHealth:|r "..mts.unitCache[8].maxHealth.."\n |--> |cff0070DEactualHealth:|r "..mts.unitCache[8].actualHealth)
		else
			mts_cacheWindow.elements.current_Cache1_8:SetText(emptyMsg)
		end
		if mts.unitCache[9] then
			mts_cacheWindow.elements.current_Cache1_9:SetText("|cff9482C99 |r "..mts.unitCache[9].name.."\n |--> |cff0070DEGUID:|r "..mts.unitCache[9].key.."\n |--> |cff0070DEDistance:|r "..mts.unitCache[9].distance.."\n |--> |cff0070DEHealth:|r "..mts.unitCache[9].health.."%".."\n |--> |cff0070DEMaxHealth:|r "..mts.unitCache[9].maxHealth.."\n |--> |cff0070DEactualHealth:|r "..mts.unitCache[9].actualHealth)
		else
			mts_cacheWindow.elements.current_Cache1_9:SetText(emptyMsg)
		end
		if mts.unitCache[10] then
			mts_cacheWindow.elements.current_Cache1_10:SetText("|cff9482C910 |r "..mts.unitCache[10].name.."\n |--> |cff0070DEGUID:|r "..mts.unitCache[10].key.."\n |--> |cff0070DEDistance:|r "..mts.unitCache[10].distance.."\n |--> |cff0070DEHealth:|r "..mts.unitCache[10].health.."%".."\n |--> |cff0070DEMaxHealth:|r "..mts.unitCache[10].maxHealth.."\n |--> |cff0070DEactualHealth:|r "..mts.unitCache[10].actualHealth)
		else
			mts_cacheWindow.elements.current_Cache1_10:SetText(emptyMsg)
		end

	-- Friendly
		mts_cacheWindow.elements.current_Cache2Total:SetText("|cff0070DETotal:|r "..unitCacheFriendlyTotal)

		if mts.unitFriendlyCache[1] then
			mts_cacheWindow.elements.current_Cache2_1:SetText("|cff9482C91: |r "..mts.unitFriendlyCache[1].name.."\n |--> |cff0070DEGUID:|r "..mts.unitFriendlyCache[1].key.."\n |--> |cff0070DEDistance:|r "..mts.unitFriendlyCache[1].distance.."\n |--> |cff0070DEHealth:|r "..mts.unitFriendlyCache[1].health.."%".."\n |--> |cff0070DEMaxHealth:|r "..mts.unitFriendlyCache[1].maxHealth.."\n |--> |cff0070DEactualHealth:|r "..mts.unitFriendlyCache[1].actualHealth)
		else
			mts_cacheWindow.elements.current_Cache2_1:SetText(emptyMsg)
		end
		if mts.unitFriendlyCache[2] then
			mts_cacheWindow.elements.current_Cache2_2:SetText("|cff9482C92: |r "..mts.unitFriendlyCache[2].name.."\n |--> |cff0070DEGUID:|r "..mts.unitFriendlyCache[2].key.."\n |--> |cff0070DEDistance:|r "..mts.unitFriendlyCache[2].distance.."\n |--> |cff0070DEHealth:|r "..mts.unitFriendlyCache[2].health.."%".."\n |--> |cff0070DEMaxHealth:|r "..mts.unitFriendlyCache[2].maxHealth.."\n |--> |cff0070DEactualHealth:|r "..mts.unitFriendlyCache[2].actualHealth)
		else
			mts_cacheWindow.elements.current_Cache2_2:SetText(emptyMsg)
		end
		if mts.unitFriendlyCache[3] then
			mts_cacheWindow.elements.current_Cache2_3:SetText("|cff9482C93: |r "..mts.unitFriendlyCache[3].name.."\n |--> |cff0070DEGUID:|r "..mts.unitFriendlyCache[3].key.."\n |--> |cff0070DEDistance:|r "..mts.unitFriendlyCache[3].distance.."\n |--> |cff0070DEHealth:|r "..mts.unitFriendlyCache[3].health.."%".."\n |--> |cff0070DEMaxHealth:|r "..mts.unitFriendlyCache[3].maxHealth.."\n |--> |cff0070DEactualHealth:|r "..mts.unitFriendlyCache[3].actualHealth)
		else
			mts_cacheWindow.elements.current_Cache2_3:SetText(emptyMsg)
		end
		if mts.unitFriendlyCache[4] then
			mts_cacheWindow.elements.current_Cache2_4:SetText("|cff9482C94: |r "..mts.unitFriendlyCache[4].name.."\n |--> |cff0070DEGUID:|r "..mts.unitFriendlyCache[4].key.."\n |--> |cff0070DEDistance:|r "..mts.unitFriendlyCache[4].distance.."\n |--> |cff0070DEHealth:|r "..mts.unitFriendlyCache[4].health.."%".."\n |--> |cff0070DEMaxHealth:|r "..mts.unitFriendlyCache[4].maxHealth.."\n |--> |cff0070DEactualHealth:|r "..mts.unitFriendlyCache[4].actualHealth)
		else
			mts_cacheWindow.elements.current_Cache2_4:SetText(emptyMsg)
		end
		if mts.unitFriendlyCache[5] then
			mts_cacheWindow.elements.current_Cache2_5:SetText("|cff9482C95: |r "..mts.unitFriendlyCache[5].name.."\n |--> |cff0070DEGUID:|r "..mts.unitFriendlyCache[5].key.."\n |--> |cff0070DEDistance:|r "..mts.unitFriendlyCache[5].distance.."\n |--> |cff0070DEHealth:|r "..mts.unitFriendlyCache[5].health.."%".."\n |--> |cff0070DEMaxHealth:|r "..mts.unitFriendlyCache[5].maxHealth.."\n |--> |cff0070DEactualHealth:|r "..mts.unitFriendlyCache[5].actualHealth)
		else
			mts_cacheWindow.elements.current_Cache2_5:SetText(emptyMsg)
		end
		if mts.unitFriendlyCache[6] then
			mts_cacheWindow.elements.current_Cache2_6:SetText("|cff9482C96: |r "..mts.unitFriendlyCache[6].name.."\n |--> |cff0070DEGUID:|r "..mts.unitFriendlyCache[6].key.."\n |--> |cff0070DEDistance:|r "..mts.unitFriendlyCache[6].distance.."\n |--> |cff0070DEHealth:|r "..mts.unitFriendlyCache[6].health.."%".."\n |--> |cff0070DEMaxHealth:|r "..mts.unitFriendlyCache[6].maxHealth.."\n |--> |cff0070DEactualHealth:|r "..mts.unitFriendlyCache[6].actualHealth)
		else
			mts_cacheWindow.elements.current_Cache2_6:SetText(emptyMsg)
		end
		if mts.unitFriendlyCache[7] then
			mts_cacheWindow.elements.current_Cache2_7:SetText("|cff9482C97: |r "..mts.unitFriendlyCache[7].name.."\n |--> |cff0070DEGUID:|r "..mts.unitFriendlyCache[7].key.."\n |--> |cff0070DEDistance:|r "..mts.unitFriendlyCache[7].distance.."\n |--> |cff0070DEHealth:|r "..mts.unitFriendlyCache[7].health.."%".."\n |--> |cff0070DEMaxHealth:|r "..mts.unitFriendlyCache[7].maxHealth.."\n |--> |cff0070DEactualHealth:|r "..mts.unitFriendlyCache[7].actualHealth)
		else
			mts_cacheWindow.elements.current_Cache2_7:SetText(emptyMsg)
		end
		if mts.unitFriendlyCache[8] then
			mts_cacheWindow.elements.current_Cache2_8:SetText("|cff9482C98: |r "..mts.unitFriendlyCache[8].name.."\n |--> |cff0070DEGUID:|r "..mts.unitFriendlyCache[8].key.."\n |--> |cff0070DEDistance:|r "..mts.unitFriendlyCache[8].distance.."\n |--> |cff0070DEHealth:|r "..mts.unitFriendlyCache[8].health.."%".."\n |--> |cff0070DEMaxHealth:|r "..mts.unitFriendlyCache[8].maxHealth.."\n |--> |cff0070DEactualHealth:|r "..mts.unitFriendlyCache[8].actualHealth)
		else
			mts_cacheWindow.elements.current_Cache2_8:SetText(emptyMsg)
		end
		if mts.unitFriendlyCache[9] then
			mts_cacheWindow.elements.current_Cache2_9:SetText("|cff9482C99: |r "..mts.unitFriendlyCache[9].name.."\n |--> |cff0070DEGUID:|r "..mts.unitFriendlyCache[9].key.."\n |--> |cff0070DEDistance:|r "..mts.unitFriendlyCache[9].distance.."\n |--> |cff0070DEHealth:|r "..mts.unitFriendlyCache[9].health.."%".."\n |--> |cff0070DEMaxHealth:|r "..mts.unitFriendlyCache[9].maxHealth.."\n |--> |cff0070DEactualHealth:|r "..mts.unitFriendlyCache[9].actualHealth)
		else
			mts_cacheWindow.elements.current_Cache2_9:SetText(emptyMsg)
		end
		if mts.unitFriendlyCache[10] then
			mts_cacheWindow.elements.current_Cache2_10:SetText("|cff9482C910: |r "..mts.unitFriendlyCache[10].name.."\n |--> |cff0070DEGUID:|r "..mts.unitFriendlyCache[10].key.."\n |--> |cff0070DEDistance:|r "..mts.unitFriendlyCache[10].distance.."\n |--> |cff0070DEHealth:|r "..mts.unitFriendlyCache[10].health.."%".."\n |--> |cff0070DEMaxHealth:|r "..mts.unitFriendlyCache[10].maxHealth.."\n |--> |cff0070DEactualHealth:|r "..mts.unitFriendlyCache[10].actualHealth)
		else
			mts_cacheWindow.elements.current_Cache2_10:SetText(emptyMsg)
		end

	mts_cacheWindow.elements.current_CacheStatus:SetText(CacheInfo())
end

function mts.CacheGUI()
    if not mts_OpenCacheWindow then
        mts_cacheWindow = ProbablyEngine.interface.buildGUI(mts_cacheInfo)
        mts_cacheWindowUpdating = true
        mts_OpenCacheWindow = true
        mts_ShowingCacheWindow = true
        mts_cacheWindow.parent:SetEventListener('OnClose', function()
            mts_OpenCacheWindow = false
            mts_ShowingCacheWindow = false
        end)
    
    elseif mts_OpenCacheWindow == true and mts_ShowingCacheWindow == true then
        mts_cacheWindowUpdating = false
        mts_cacheWindow.parent:Hide()
        mts_ShowingCacheWindow = false
    
    elseif mts_OpenCacheWindow == true and mts_ShowingCacheWindow == false then
        mts_cacheWindowUpdating = true
        mts_cacheWindow.parent:Show()
        mts_ShowingCacheWindow = true
    end

    if mts_cacheWindowUpdating then
        C_Timer.NewTicker(1.00, mts_updateCacheInfo, nil)
    end

end

C_Timer.NewTicker(0.2, (function()
    if mts.CurrentCR then
		if _PeConfig.read('button_states', 'MasterToggle', false) then
			mts_unitCacheFun()
		end
    end
end), nil)