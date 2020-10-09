function onSay(player, words, param)
	if (param == '') then
		local list = player:getAutoLootList()

		if (not list) then
			return player:sendCancelMessage("Your auto loot list is empty, usage: /autoloot [add/remove], [itemID/name]")
		end

		local text = "You're auto looting: "

		for _, itemID in ipairs(list) do
			local itemType = ItemType(itemID)
			text = text .. itemType:getName() .. ' [ID: ' .. itemID .. '], '
		end

		return player:sendTextMessage(MESSAGE_INFO_DESCR, text:sub(1, -3) .. '.')
	end

	local params = param:split(",")

	if (not params[2]) then
		return player:sendCancelMessage("Missing itemID or name, usage: /autoloot [add/remove], [itemID/name]")
	end

	if (params[1] == 'add' or params[1] == 'remove') then
		local itemType = ItemType(params[2]:trim())

		if (itemType:getId() == 0) then
			itemType = ItemType(tonumber(params[2]:trim()))
		end

		if (itemType:getName() == '') then
			return player:sendCancelMessage("There is no item with that ID or name.")
		end

		if (params[1] == 'add') then
			if (player:addAutoLootItem(itemType:getId())) then
				return player:sendTextMessage(MESSAGE_INFO_DESCR, "You're now auto looting " .. itemType:getName() .. ' [ID: ' .. itemType:getId() .. '].')
			end

			return not player:sendCancelMessage("You're already auto looting this item.")
		elseif (params[1] == 'remove') then
			if (player:removeAutoLootItem(itemType:getId())) then
				return player:sendTextMessage(MESSAGE_INFO_DESCR, "You're not auto looting " .. itemType:getName() .. ' [ID: ' .. itemType:getId() .. '] anymore.')
			end

			return player:sendCancelMessage("You're not auto looting this item.")
		end
	end

    return player:sendCancelMessage("Unknown parameter, usage: /autoloot [add/remove], [itemID/name]")
end
