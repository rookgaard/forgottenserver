function onSay(player, words, param)
	if not player:getGroup():getAccess() then
		return true
	end

	local steps = tonumber(param)
	if not steps then
		return false
	end

	local position = player:getPosition()
	position:getNextPosition(player:getDirection(), steps)

	

	player:teleportTo(position)
	return false
end
