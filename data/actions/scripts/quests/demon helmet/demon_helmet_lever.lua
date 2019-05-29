local t = {
	Position(523, 1274, 10), -- stone position
	Position(521, 1271, 10), -- teleport creation position
	Position(548, 1308, 10) -- where the teleport takes you
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.itemid == 1945 then
		local tile = t[1]:getTile()
		if tile then
			local stone = tile:getItemById(1355)
			if stone then
				stone:remove()
			end
		end

		local teleport = Game.createItem(1387, 1, t[2])
		if teleport then
			teleport:setDestination(t[3])
			t[2]:sendMagicEffect(CONST_ME_TELEPORT)
		end
	elseif item.itemid == 1946 then
		local tile = t[2]:getTile()
		if tile then
			local teleport = tile:getItemById(1387)
			if teleport and teleport:isTeleport() then
				teleport:remove()
			end
		end
		t[2]:sendMagicEffect(CONST_ME_POFF)
		Game.createItem(1355, 1, t[1])
	end
	return item:transform(item.itemid == 1945 and 1946 or 1945)
end