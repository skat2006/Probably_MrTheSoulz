local fetch = ProbablyEngine.interface.fetchKey

local function mts_MoveTo(unit, ds)
  if FireHack then
  local aX, aY, aZ = ObjectPosition(unit)
  local bX, bY, bZ = ObjectPosition('player')
  local playerReach = UnitCombatReach('player')
  local unitReach = UnitCombatReach(unit)
  
	--(Over sensitive...)if TraceLine(bX, bY, bZ, aX, aY, aZ, 0xFFFFFFFF) then 
	  if not (Distance(unit, "player") <= (playerReach+unitReach) + ds) then
		MoveTo(aX, aY, aZ)
	  end
    --end
  elseif oexecute then -- Offspring dosent have MoveTo :(
	local aX, aY, aZ = opos(unit)
	local bX, bY, bZ = opos('player')
	  if not (Distance(unit, "player") <= (playerReach+unitReach) + ds) then
		--MoveTo(aX, aY, aZ)
	  end
  end
end

local function mts_FaceTo(unit)
  if FireHack then
  local playerReach = UnitCombatReach('player')
  local unitReach = UnitCombatReach(unit)
    if not UnitInfront(unit) then
	  if (Distance(unit, "player") <= playerReach+unitReach) then 
	    FaceUnit(unit)
	  end
	end
  elseif oexecute then
	if not UnitInfront(unit) then
	  if (Distance(unit, "player") <= 6) then 
		FaceUnit(unit)
	  end
	end
  end
end

local function mts_rangeNeeded()
  local _SpecID =  GetSpecializationInfo(GetSpecialization())
  local ranged = {256, 257}
  for i=1,#ranged do
	if _SpecID == ranged[i] then
	  --print("ranged")
	  return 30
	else 
	  --print("melee")
	  return 6 
	end
  end
end
		

C_Timer.NewTicker(0.5, (function()
	if FireHack then
	  if ProbablyEngine.config.read('button_states', 'MasterToggle', false)
	  and ProbablyEngine.module.player.combat
	  and fetch('mtsconf', 'AutoMove') then
		if UnitExists("target")
		and not UnitIsFriend("player", "target") then
		  mts_MoveTo('target', mts_rangeNeeded())
		  mts_FaceTo('target')
		end
	  end
	end
	if oexecute then
	  if ProbablyEngine.config.read('button_states', 'MasterToggle', false)
	  and ProbablyEngine.module.player.combat 
	  and fetch('mtsconf', 'AutoMove') then
		if UnitExists("target") 
		and not UnitIsFriend("player", "target") then
		  mts_FaceTo('target')
		end
	  end
	end
end), nil)