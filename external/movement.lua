local fetch = ProbablyEngine.interface.fetchKey

-- Experimental // Move to
local function mts_MoveTo(unit)
  local aX, aY, aZ = ObjectPosition(unit)
  local bX, bY, bZ = ObjectPosition('player')
    if TraceLine(bX, bY, bZ, aX, aY, aZ, 0xFFFFFFFF)
        then MoveTo(aX, aY, aZ)
    end
end

function mts_InFront(unit)
  local aX, aY, aZ = ObjectPosition(unit)
  local bX, bY, bZ = ObjectPosition('player')
  local playerFacing = GetPlayerFacing()
  local facing = math.atan2(bY - aY, bX - aX) % 6.2831853071796
    return math.abs(math.deg(math.abs(playerFacing - (facing)))-180) < 90
end

function mts_NeedMoving()
    if ProbablyEngine.condition["distance"]('target') <= 5 == false
    or mts_InFront('target') == false
      then return true end
    return false
end

C_Timer.NewTicker(0.05, (function() 
    if FireHack and fetch('mtsconf', 'AutoMove') and UnitExists("target") and mts_NeedMoving() and UnitIsTappedByPlayer("target")
        then mts_MoveTo("target") 
    end 
end), nil)