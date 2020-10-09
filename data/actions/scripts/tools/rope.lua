function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if (toPosition.x == CONTAINER_POSITION and not target:isContainer()) then
		local itemType = ItemType(target.itemid)

		if (player:getAutoLootItem(itemType:getId())) then
			player:removeAutoLootItem(itemType:getId())
			return player:sendTextMessage(MESSAGE_INFO_DESCR, "You're not auto looting " .. itemType:getName() .. ' [ID: ' .. itemType:getId() .. '] anymore.')
		else
			player:addAutoLootItem(itemType:getId())
			return player:sendTextMessage(MESSAGE_INFO_DESCR, "You're now auto looting " .. itemType:getName() .. ' [ID: ' .. itemType:getId() .. '].')
		end
	end

	return onUseRope(player, item, fromPosition, target, toPosition, isHotkey)
end
