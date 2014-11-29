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


--[[ Originaly build by: Mirakuru ]]
-- Manager cache
local unitCache = {}
local function cache()
	local totalObjects = ObjectCount()
	local specID = GetSpecializationInfo(GetSpecialization())
	wipe(unitCache)
	
	if FireHack then
		for i=1, totalObjects do
			local object = ObjectWithIndex(i)
			if ObjectExists(object) then
				if ObjectIsType(object, ObjectTypes.Unit)
				and ProbablyEngine.condition["distance"](object) <= 40
				and ProbablyEngine.condition["alive"](object) then
					table.insert(unitCache, object)
				end
			end
		end
	end
end
 
-- Call cache manager and throttle
C_Timer.NewTicker(0.1, (function()
	if ProbablyEngine.config.read('button_states', 'MasterToggle', false) then
		if ProbablyEngine.module.player.combat then cache() end
	end
end), nil)

function mts_holyNova()
local minHeal = GetSpellBonusDamage(2) * 1.125
local inRange = 0
local prefix = (IsInRaid() and 'raid') or 'party'
	
	if FireHack then
		for i=1,#unitCache do
			if UnitIsFriend("player", unitCache[i]) then
				if ProbablyEngine.condition["distance"](unitCache[i]) <= 10
				and UnitHealth(unitCache[i]) <= minHeal 
				and UnitIsUnit("target", unitCache[i]) then
					inRange = inRange + 1
				end
			end
		end
	else
		for i = -1, GetNumGroupMembers() - 1 do
		  local unit = (i == -1 and 'target') or (i == 0 and 'player') or prefix .. i
		  if IsItemInRange(33278, unit) or unit == 'player' then
			local diff = UnitHealth(unit)
			if diff > minHeal then
			  inRange = inRange + 1
			end
		  end
		end
	end
	return inRange > 3
end

-- Priest - Shadow Word: Pain
function mts_SWP()
	for i=1,#unitCache do
	local _,_,_,_,_,_,debuff = UnitDebuff(unitCache[i], GetSpellInfo(589), nil, "PLAYER")

		if not debuff or debuff - GetTime() < 5.5 then
			print("pass debuff")
		
			-- Checks 1
			if mts_immuneEvents(unitCache[i])
			and not UnitIsUnit("target", unitCache[i])
			and UnitAffectingCombat(unitCache[i])
			and UnitCanAttack("player", unitCache[i])
			and not UnitIsPlayer(unitCache[i]) then
				print("hit1")
							
				--Checks 2
				if ProbablyEngine.parser.can_cast(589, unitCache[i], false) then
				print("hit2")
						
					--Checks 3
					if mts_infront(unitCache[i])
					and LineOfSight(unitCache[i], "player") then
						print("hit3")
						ProbablyEngine.dsl.parsedTarget = unitCache[i]
						return true
					end
						
				end
			end	
		end
	end
	return false
end

function mts_SWD()
	for i=1,#unitCache do
		local _,_,_,_,_,_,debuff = UnitDebuff(unitCache[i], GetSpellInfo(589), nil, "PLAYER")
		
		if not debuff or debuff - GetTime() < 5.5 then
		
			-- Checks 1
			if mts_immuneEvents(unitCache[i])
			and not UnitIsUnit("target", unitCache[i])
			and ProbablyEngine.condition["health"](unitCache[i]) <= 20
			and UnitAffectingCombat(unitCache[i])
			and UnitCanAttack("player", unitCache[i])
			and not UnitIsPlayer(unitCache[i]) then
						
				--Checks 2
				if ProbablyEngine.parser.can_cast(589, unitCache[i], false) then
					
					--Checks 3
					if mts_infront(unitCache[i])
					and LineOfSight(unitCache[i], "player") then
						ProbablyEngine.dsl.parsedTarget = unitCache[i]
						return true
					end
					
				end
			end	
		end
	end
	return false
end

function mts_MoonFire()
	for i=1,#unitCache do
		local _,_,_,_,_,_,debuff = UnitDebuff(unitCache[i], GetSpellInfo(164812), nil, "PLAYER")
		
		if not debuff or debuff - GetTime() < 5.5 then
			
			-- Checks 1
			if mts_immuneEvents(unitCache[i])
			and not UnitIsUnit("target", unitCache[i])
			and ProbablyEngine.condition["health"](unitCache[i]) <= 20
			and UnitAffectingCombat(unitCache[i])
			and UnitCanAttack("player", unitCache[i])
			and not UnitIsPlayer(unitCache[i]) then
						
				--Checks 2
				if ProbablyEngine.parser.can_cast(164812, unitCache[i], false) then
					
					--Checks 3
					if mts_infront(unitCache[i])
					and LineOfSight(unitCache[i], "player") then
						ProbablyEngine.dsl.parsedTarget = unitCache[i]
						return true
					end
					
				end
			end	
		end
	end
	return false
end