--[[ ///---INFO---////
//Core//
Thank You For Using My ProFiles
I Hope Your Enjoy Them
MTS
]]

													--[[ Global's ]]
--[[------------------------------------------------------------------------------------------------------------]]
--[[------------------------------------------------------------------------------------------------------------]]

mts_Version = "0.13.5"
mts_Icon = "|TInterface\\AddOns\\Probably_MrTheSoulz\\media\\logo.blp:16:16|t"
mts_peRecomemded = "6.0.3r10"

--[[   Pack Commands   ]]
ProbablyEngine.command.register('mts', function(msg, box)
local command, text = msg:match("^(%S*)%s*(.-)$")

    -- Displays General GUI
    if command == 'config' or command == 'c' then
    	mts_ConfigGUI()
    end

   -- Displays LiveGUI
    if command == 'live' or command == 'status' or command == 's' then
    	mts_showLive()
    end

    -- Displays Class GUI
    if command == 'class' or command == 'cl' then
    	mts_ClassGUI()
    end

	-- Displays Help GUI
	if command == 'help' or command == 'info' or command == 'i' or command == '?' then
		mts_InfoGUI()
	end

end)

--[[ Used to compare stuff with GUI's values ]]
function mts_dynamicEval(condition, spell)
	if not condition then return false end
	return ProbablyEngine.dsl.parse(condition, spell or '')
end

--if ProbablyEngine.rotation.currentStringComp == mts_Icon.."|r[|cff9482C9MTS|r][Priest-Shadow|r]"
