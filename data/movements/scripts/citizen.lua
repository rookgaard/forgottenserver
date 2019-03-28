function onStepIn(creature, item, position, fromPosition)
	if item.actionid > 30020 and item.actionid < 30050 then
		local player = creature:getPlayer()
		if player == nil then
			return false
		end

		local town = Town(item.actionid - 30020)
		player:setTown(town)
		player:teleportTo(town:getTemplePosition())
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		player:setDirection(DIRECTION_SOUTH)
		player:sendTextMessage(MESSAGE_INFO_DESCR, 'You are now a citizen of ' .. town:getName() .. '.')
	end
	return true
end