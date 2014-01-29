--[[ ///---INFO---////
// DeathKnight's Lib //
Thank Your For Your My ProFiles
I Hope Your Enjoy Them
MTS
]]

local mtsLibDK = {}

mtsLibDK.darkSimSpells = {
-- siege of orgrimmar
"Froststorm Bolt","Arcane Shock","Rage of the Empress","Chain Lightning",
-- pvp
"Hex","Mind Control","Cyclone","Polymorph","Pyroblast","Tranquility","Divine Hymn","Hymn of Hope","Ring of Frost","Entangling Roots"
}

function mtsLibDK.shoulDarkSimUnit(unit)
	for index,spellName in pairs(mtsLibDK.darkSimSpells) do
		if ProbablyEngine.condition["casting"](unit, spellName) then return true end
	end
		return false
end

function mtsLibDK.canCastPlagueLeech(timeLeft)
local frostFeverApplied, _, ffExpires, ffCaster = UnitDebuff("target","Frost Fever","player")
local bloodPlagueApplied, _, bpExpires, bpCaster = UnitDebuff("target","Blood Plague","player")
local durationFF = 0
local durationBP = 0
	if ffExpires and ffCaster == "player" then
		durationFF = (ffExpires - (GetTime()-(ProbablyEngine.lag/1000)))
	end
	if bpExpires and bpCaster == "player" then
		durationBP = (bpExpires - (GetTime()-(ProbablyEngine.lag/1000)))
	end
		
	if not frostFeverApplied or not bloodPlagueApplied then return false end
	if durationFF <= timeLeft then
		return true
	end
	if durationBP <= timeLeft then
		return true
	end
		return false
end

function mtsLibDK.shouldBloodTap()
	local _, _, _, count, _, _, _, _, _ = UnitBuff("player","Blood Charge")
	if count == nil then count = 0 end	
	if count >= 5 then return true end
	return false
end

function mtsLibDK.gotBloodRunes()
	if GetRuneType(1) ~= 4 and GetRuneType(2) ~= 4 then
		return true
	end 
	return false
end

function mtsLibDK.hasGhoul()
	if ProbablyEngine.module.player.specName == "Unholy" then
		if UnitExists("pet") == nil then return false end
	else
		if select(1,GetTotemInfo(1)) == false then return false end
	end
		return true
end

ProbablyEngine.library.register('mtsLibDK', mtsLibDK)
