local fetch = ProbablyEngine.interface.fetchKey

local function mts_MoveTo(unit)
  local aX, aY, aZ = ObjectPosition(unit)
  local bX, bY, bZ = ObjectPosition('player')
  local playerFacing = GetPlayerFacing()
  local facing = math.atan2(bY - aY, bX - aX) % 6.2831853071796
  local playerReach = UnitCombatReach('player')
  local unitReach = UnitCombatReach(unit)
  
	--(Over sensitive...)if TraceLine(bX, bY, bZ, aX, aY, aZ, 0xFFFFFFFF) then 
	  if (math.abs(math.deg(math.abs(playerFacing - (facing)))-180) < 90) == false
	  or (ProbablyEngine.condition["distance"]('target') <= playerReach+unitReach) == false then
		MoveTo(aX, aY, aZ)
	  end
    --end
end

C_Timer.NewTicker(0.05, (function()
  if ProbablyEngine.config.read('button_states', 'MasterToggle', false)
  and FireHack then
	if UnitExists("target") 
	and fetch('mtsconf', 'AutoMove') 
	and UnitIsFriend("player","target") == false then
	  mts_MoveTo('target')
	end
  end
end), nil)