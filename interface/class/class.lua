local mts_BuildGUI = ProbablyEngine.interface.buildGUI
local fetch = ProbablyEngine.interface.fetchKey
local _CurrentSpec = nil

local ClassWindow
local _OpenClassWindow = false
local _ShowingClassWindow = false

function mts.ClassGUI()
local _SpecID =  GetSpecializationInfo(GetSpecialization())

	-- Check wich spec the player is to return the correct window.	
	if _SpecID == 250 and not _OpenClassWindow then -- DK Blood
		_CurrentSpec = mts_BuildGUI(mts_configDkBlood)
	elseif _SpecID == 252 and not _OpenClassWindow  then -- DK Unholy
		_CurrentSpec = mts_BuildGUI(mts_configDkUnholy)
	elseif _SpecID == 103 and not _OpenClassWindow  then -- Druid Feral
		_CurrentSpec = mts_BuildGUI(mts_configDruidFeral)
	elseif _SpecID == 104 and not _OpenClassWindow  then -- Druid Guardian
		_CurrentSpec = mts_BuildGUI(mts_configDruidGuard)
	elseif _SpecID == 105 and not _OpenClassWindow  then -- Druid Resto
		_CurrentSpec = mts_BuildGUI(mts_configDruidResto)
	elseif _SpecID == 102 and not _OpenClassWindow  then -- Druid Balance
		_CurrentSpec = mts_BuildGUI(mts_configDruidBalance)
	elseif _SpecID == 257 and not _OpenClassWindow  then -- Priest holy
		_CurrentSpec = mts_BuildGUI(mts_configPriestHoly)
	elseif _SpecID == 258 and not _OpenClassWindow  then -- Priest Shadow
		_CurrentSpec = mts_BuildGUI(mts_configPriestShadow)
	elseif _SpecID == 256 and not _OpenClassWindow  then -- Priest Disc
		_CurrentSpec = mts_BuildGUI(mts_configPriestDisc)
	elseif _SpecID == 70 and not _OpenClassWindow  then -- Pala Retribution
		_CurrentSpec = mts_BuildGUI(mts_configPalaRet)
	elseif _SpecID == 66 and not _OpenClassWindow  then -- Pala Protection
		_CurrentSpec = mts_BuildGUI(mts_configPalaProt)
	elseif _SpecID == 65 and not _OpenClassWindow  then -- Pala Holy
		_CurrentSpec = mts_BuildGUI(mts_configPalaHoly)	
	elseif _SpecID == 73 and not _OpenClassWindow  then -- Warrior Protection
		_CurrentSpec = mts_BuildGUI(mts_configWarrProt)
	elseif _SpecID == 72 and not _OpenClassWindow  then -- Warrior Fury
		_CurrentSpec = mts_BuildGUI(mts_configWarrFury)	
	elseif _SpecID == 270 and not _OpenClassWindow  then -- Monk Mistweaver
		_CurrentSpec = mts_BuildGUI(mts_configMonkMm)
	elseif _SpecID == 269 and not _OpenClassWindow  then -- Monk WindWalker
		_CurrentSpec = mts_BuildGUI(mts_configMonkWw)
	elseif _SpecID == 262 and not _OpenClassWindow  then -- Shamman Elemental
		_CurrentSpec = mts_BuildGUI(mts_configShamanEle)
	elseif _SpecID == 264 and not _OpenClassWindow  then -- Shamman Resto
		_CurrentSpec = mts_BuildGUI(mts_configShamanResto)		
	end

	-- If no window been created, create one...
	if not _OpenClassWindow and _CurrentSpec ~= nil then
		_OpenClassWindow = true
		_ShowingClassWindow = true
		_CurrentSpec.parent:SetEventListener('OnClose', function()
			_OpenClassWindow = false
			_ShowingClassWindow = false
		end)

	-- If a windows has been created and its showing then hide it...	
	elseif _OpenClassWindow == true and _ShowingClassWindow == true then
		_CurrentSpec.parent:Hide()
		_ShowingClassWindow = false

	-- If a windows has been created and its hidden then show it...		
	elseif _OpenClassWindow == true and _ShowingClassWindow == false then
		_CurrentSpec.parent:Show()
		_ShowingClassWindow = true
	end

end