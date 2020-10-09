function Container.isContainer(self)
	return true
end

function Container.createLootItem(self, item)
	if self:getEmptySlots() == 0 then
		return true
	end

	local itemCount = 0
	local randvalue = getLootRandom()
	if randvalue < item.chance then
		if ItemType(item.itemId):isStackable() then
			itemCount = randvalue % item.maxCount + 1
		else
			itemCount = 1
		end
	end

	if itemCount > 0 then
		local tmpItem = self:addItem(item.itemId, math.min(itemCount, 100))
		if not tmpItem then
			return false
		end

		if tmpItem:isContainer() then
			for i = 1, #item.childLoot do
				if not tmpItem:createLootItem(item.childLoot[i]) then
					tmpItem:remove()
					return false
				end
			end
		end

		if item.subType ~= -1 then
			tmpItem:setAttribute(ITEM_ATTRIBUTE_CHARGES, item.subType)
		end

		if item.actionId ~= -1 then
			tmpItem:setActionId(item.actionId)
		end

		if item.text and item.text ~= "" then
			tmpItem:setText(item.text)
		end
	end
	return true
end

function Container.getItems(self)
	local items = {}

	for index = 0, self:getSize() - 1 do
		local item = self:getItem(index)

		if (item) then
			if (item:isContainer()) then
				local containerItems = item:getItems()

				for _, item in ipairs(containerItems) do
					table.insert(items, item)
				end
			else
				table.insert(items, item)
			end
		end
	end

	return items
end
