local fetch = ProbablyEngine.interface.fetchKey
local _PeConfig = ProbablyEngine.config

--[[-----------------------------------------------
** Automated moving/facing. **
DESC: This code will try to move or face a unit if said unit 
meets the requirements (LoS, mts_Distance etc...)

Build by: MTS
---------------------------------------------------]]

-- Move to unit if distance.
local function mts_MoveTo(unit)
  if unit and unit ~= "player"  and UnitID(unit) ~= 76585 and UnitExists(unit) and UnitIsVisible(unit) and LineOfSight then
    if mts_Distance("player", unit) >= 6 then
      --if not LineOfSight('player', unit) then
        if FireHack then
          local aX, aY, aZ = ObjectPosition(unit)
            MoveTo(aX, aY, aZ)
        elseif oexecute then -- Offspring dosent have MoveTo :(
        end
      --end
    end
  end
end

-- Face unit.
local function mts_FaceTo(unit)
  if unit and unit ~= "player"  and UnitID(unit) ~= 76585 and UnitExists(unit) and UnitIsVisible(unit) and LineOfSight then
    if LineOfSight('player', unit) and mts_Distance("player", unit) <= 6 and not mts_infront(unit) then
      if FireHack then
        FaceUnit(unit)
      elseif oexecute then
        oface(unit)
      end
    end
  end
end

--[[-----------------------------------------------
** Ticker **
DESC: MoveTo & Face.

Build By: MTS
 ---------------------------------------------------]]
C_Timer.NewTicker(0.1, (function()
  --No Point in Trying any of these if not using an advanced unlocker
  if FireHack or oexecute then
    
    if _PeConfig.read('button_states', 'MasterToggle', false)
    and ProbablyEngine.module.player.combat then

      -- Can we move?
      if fetch('mtsconf', 'AutoMove') then
        mts_MoveTo('target')
      end
      -- Can we face?
      if fetch('mtsconf', 'AutoFace') then
        mts_FaceTo('target')
      end
    
    end

  end
end), nil)