Cooking = {
	storage = 12345,
	getData = function(player)
		local tries = player:getStorageValue(Cooking.storage)

		if (tries < 0) then
			tries = 0
			player:setStorageValue(Cooking.storage, tries)
		end

		local skill = 0
		local needed = 0

		while true do
			needed = (skill + 1) * 100

			if (tries >= needed) then
				skill = skill + 1
				tries = tries - needed
			else
				break
			end
		end

		local percent = tries * 100 / needed

		local data = {
			skill = skill,
			tries = tries,
			needed = needed,
			percent = percent,
		}

		return data
	end,
	sendData = function(player)
		player:sendExtendedOpcode(206, Cooking.getData(player), true)

		return true
	end,
	add = function(player, value)
		local data = Cooking.getData(player)

		if (data.tries + value >= data.needed) then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You advanced in cooking.")
		end

		player:setStorageValue(Cooking.storage, player:getStorageValue(Cooking.storage) + value)
		Cooking.sendData(player)
	end,
}
