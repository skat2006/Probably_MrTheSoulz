local function mts_hasDebuffTable(target, spells)
  for i = 1, 40 do
    local _,_,_,_,_,_,_,_,_,_,spellId = _G['UnitDebuff'](target, i)
    for k,v in pairs(spells) do
      if spellId == v then return true end
    end
  end
end

local function mts_immuneEvents(unit)
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
  if not UnitAffectingCombat(unit) then 
	return false 
  end
  -- Crowd Control
  if mts_hasDebuffTable(unit, cc) then 
	return false 
  end
  if UnitAura(unit,GetSpellInfo(116994))
  or UnitAura(unit,GetSpellInfo(122540))
  or UnitAura(unit,GetSpellInfo(123250))
  or UnitAura(unit,GetSpellInfo(106062))
  or UnitAura(unit,GetSpellInfo(110945))
  or UnitAura(unit,GetSpellInfo(143593)) -- General Nazgrim: Defensive Stance
  or UnitAura(unit,GetSpellInfo(143574)) -- Heroic Immerseus: Swelling Corruption
	then 
	  return false 
	end
  return true
end

local function mts_infront(unit)
	local aX, aY, aZ = ObjectPosition(unit)
	local bX, bY, bZ = ObjectPosition('player')
	local playerFacing = GetPlayerFacing()
	local facing = math.atan2(bY - aY, bX - aX) % 6.2831853071796
	return math.abs(math.deg(math.abs(playerFacing - (facing)))-180) < 90
end

-- Multidotting Function
-- Created by Mirakuru
function mts_Dot(spell, health, distance)
	local totalObjects = ObjectCount()
	local can_cast = ProbablyEngine.parser.can_cast
	local _,_,_,_,_,_,spellID = GetSpellInfo(spell) 
	
	-- Parse Object Manager
	for i=1, totalObjects do
		local object = ObjectWithIndex(i)
		if ObjectIsType(object, ObjectTypes.Unit)
		and mts_infront(object)
		and mts_immuneEvents(object)
		and not UnitIsPlayer(object)
		and LineOfSight(object, "player")
		and UnitCanAttack("player", object)
		and can_cast(spellID, object, false)
		and not UnitIsUnit("target", object)
		and Distance(object, "player") <= distance
		and not UnitDebuff(object, GetSpellInfo(spellID), nil, "player") then
			local objectHealth = math.floor((UnitHealth(object) / UnitHealthMax(object)) * 100)
			if objectHealth <= health then
				ProbablyEngine.dsl.parsedTarget = object
				return true
			end
		end
	end
	return false
end
