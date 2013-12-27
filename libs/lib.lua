local mts = {
  con = true,
  seals = true
}

mts.ConToggle = function()
  return mts.con
end
mts.SealsToggle = function()
  return mts.seals
end

ProbablyEngine.command.register('mts', function(msg, box)
local command, text = msg:match("^(%S*)%s*(.-)$")

	if command == 'con' then
	mts.con = not mts.con
		if mts.con then
			ProbablyEngine.command.print('MrTheSoulz Consecration Enabled.')
		else
			ProbablyEngine.command.print('MrTheSoulz Consecration Disabled.')
		end
	end
	
	if command == 'seals' then
	mts.seals = not mts.seals
	  if mts.seals then
		ProbablyEngine.command.print('MrTheSoulz Rotation seals Enabled.')
	  else
		ProbablyEngine.command.print('MrTheSoulz Rotations seals Disabled.')
	  end
	end
end)

ProbablyEngine.condition.register("talent", function(index)
	return select(5, GetTalentInfo(index)) or false
end)

ProbablyEngine.library.register('mts', mts)
