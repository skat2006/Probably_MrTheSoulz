local fetch = ProbablyEngine.interface.fetchKey
local _PeConfig = ProbablyEngine.config

--[[ UNTESTED
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
  }

-- Move to unit if distance.
local function mts_MoveTo(unit, name)
	local _SpecID =  GetSpecializationInfo(GetSpecialization())
  	if fetch('mtsconf', 'AutoMove') then
  		if UnitExists(unit) and UnitIsVisible(unit) then
		  	for i=1,#ranged do
			    if FireHack then
			    	local aX, aY, aZ = ObjectPosition(unit)
				        -- If Player is ranged
				        if _SpecID == ranged[i] then
				        	if mts.Distance("player", unit) >= 30 + (UnitCombatReach('player') + UnitCombatReach(unit)) then
				        		mtsAlert:message('Moving to: '..name) 
				            	MoveTo(aX, aY, aZ)
				            end
				        -- If player is melee
				        else
				            if mts.Distance("player", unit) >= 6 + (UnitCombatReach('player') + UnitCombatReach(unit)) then
				            	mtsAlert:message('Moving to: '..name) 
				            	MoveTo(aX, aY, aZ)
				            end
				        end
			    end
			end
	  	end
	end
end]]

-- Move to unit if distance.
local function mts_MoveTo(unit, name)
	local _SpecID =  GetSpecializationInfo(GetSpecialization())
  	if fetch('mtsconf', 'AutoMove') then
  		if UnitExists(unit) and UnitIsVisible(unit) then
			if FireHack then
			   	local aX, aY, aZ = ObjectPosition(unit)
				    if mts.Distance("player", unit) >= 6 + (UnitCombatReach('player') + UnitCombatReach(unit)) then
				        mtsAlert:message('Moving to: '..name) 
				        MoveTo(aX, aY, aZ)
				    end
			end
	  	end
	end
end

-- Face unit.
local function mts_FaceTo(unit, name)
	if fetch('mtsconf', 'AutoFace') then
	  	if UnitExists(unit) and UnitIsVisible(unit) then
	    	if not mts.Infront(unit) then
	      		if FireHack then
	      			mtsAlert:message('Facing: '..name) 
	        		FaceUnit(unit)
	      		elseif oexecute then
	      			mtsAlert:message('Facing: '..name) 
	        		FaceToUnit(unit)
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
	    	mtsAlert:message('Targeting: '..name) 
	        return Macro("/target "..unit)
	    end
	end
end

--[[-----------------------------------------------
** Ticker **
DESC: MoveTo & Face.

Build By: MTS
 ---------------------------------------------------]]
C_Timer.NewTicker(0.1, (function()
  	if mts.CurrentCR then
	    if _PeConfig.read('button_states', 'MasterToggle', false) and ProbablyEngine.module.player.combat then
	    	for i=1,#mts.unitCache do
	    		if mts.unitCache[i].name ~= UnitName("player") then
			        mts_MoveTo(mts.unitCache[i].key, mts.unitCache[i].name)
			        mts_FaceTo(mts.unitCache[i].key, mts.unitCache[i].name)
			        mts_autoTarget(mts.unitCache[i].key, mts.unitCache[i].name)
			    end
		    end
	    end
  	end
end), nil)