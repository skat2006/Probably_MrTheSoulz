local fetch = ProbablyEngine.interface.fetchKey

local function mts_InFront(unit)
  local aX, aY, aZ = ObjectPosition(unit)
  local bX, bY, bZ = ObjectPosition('player')
  local playerFacing = GetPlayerFacing()
  local facing = math.atan2(bY - aY, bX - aX) % 6.2831853071796
    return math.abs(math.deg(math.abs(playerFacing - (facing)))-180) < 90
end

local function mts_MoveTo(unit)
  local aX, aY, aZ = ObjectPosition(unit)
  if (mts_InFront('target') == false) 
    or (ProbablyEngine.condition["distance"]('target') <= 5 == false) then
      MoveTo(aX, aY, aZ)
  end
end

C_Timer.NewTicker(0.05, (function()
    if FireHack
      and UnitExists("target")
      and fetch('mtsconf', 'AutoMove')
      and (UnitIsFriend("player","target") == false) then
        mts_MoveTo('target')
    end
end), nil)