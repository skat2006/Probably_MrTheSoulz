--[[ ///---INFO---////
//Core//
Thank You For Using My ProFiles
I Hope Your Enjoy Them
MTS
]]

													--[[ Global's ]]
--[[------------------------------------------------------------------------------------------------------------]]
--[[------------------------------------------------------------------------------------------------------------]]

mts_Version = "0.13.3"
mts_Icon = "|TInterface\\AddOns\\Probably_MrTheSoulz\\media\\logo.blp:16:16|t"
mts_peRecomemded = "6.0.3r9-|cffC41F3BDEV|r"

--[[ Used to compare stuff with GUI's values ]]
function mts_dynamicEval(condition, spell)
	if not condition then return false end
	return ProbablyEngine.dsl.parse(condition, spell or '')
end
