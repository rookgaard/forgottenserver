local pos = {
	[2025] = {x = 969, y = 848, z = 12},
	[2026] = {x = 969, y = 846, z = 12},
	[2027] = {x = 969, y = 844, z = 12},
	[2028] = {x = 969, y = 842, z = 12}
}

local function doRemoveFirewalls(fwPos)
	local tile = Position(fwPos):getTile()
	if tile then
		local thing = tile:getItemById(6290)
		if thing then
			thing:remove()
		end
	end
end

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if(item.itemid == 1945) then
		doRemoveFirewalls(pos[item.uid])
		Position(pos[item.uid]):sendMagicEffect(CONST_ME_FIREAREA)
	else
		Game.createItem(6290, 1, pos[item.uid])
		Position(pos[item.uid]):sendMagicEffect(CONST_ME_FIREAREA)
	end
	item:transform(item.itemid == 1945 and 1946 or 1945)
	return true
end