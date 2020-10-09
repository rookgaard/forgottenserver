function Monster:onDropLoot(corpse)
	if configManager.getNumber(configKeys.RATE_LOOT) == 0 then
		return
	end

	local player = Player(corpse:getCorpseOwner())
	local mType = self:getType()
	if not player or player:getStamina() > 840 then
		local monsterLoot = mType:getLoot()
		for i = 1, #monsterLoot do
			local item = corpse:createLootItem(monsterLoot[i])
			if not item then
				print('[Warning] DropLoot:', 'Could not add loot item to corpse.')
			end
		end

		if player then
			local items = corpse:getItems()
			local autolootContainer = Game.createItem(1987, 1)

			for _, item in ipairs(items) do
				if (player:getAutoLootItem(item.itemid)) then
					item:moveTo(autolootContainer)
				end
			end

			local text = ("Loot of %s: %s"):format(mType:getNameDescription(), corpse:getContentDescription())

			if (autolootContainer:getSize() > 0) then
				text = text .. ' and ' .. autolootContainer:getContentDescription() .. ' that was auto looted'
				local autolootItems = autolootContainer:getItems()

				for _, item in ipairs(autolootItems) do
					item:moveTo(player)
				end
			end

			text = text .. '.'

			local party = player:getParty()
			if party then
				party:broadcastPartyLoot(text)
			else
				player:sendTextMessage(MESSAGE_LOOT, text)
			end
		end
	else
		local text = ("Loot of %s: nothing (due to low stamina)"):format(mType:getNameDescription())
		local party = player:getParty()
		if party then
			party:broadcastPartyLoot(text)
		else
			player:sendTextMessage(MESSAGE_LOOT, text)
		end
	end
end

function Monster:onSpawn(position, startup, artificial)
	return true
end
