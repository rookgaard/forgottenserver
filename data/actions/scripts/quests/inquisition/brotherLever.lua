local config = {
	[9017] = {
		wallPositions = {
			Position(994, 1438, 10),
			Position(993, 1438, 10),
			Position(992, 1438, 10),
			Position(991, 1438, 10),
			Position(990, 1438, 10),
			Position(989, 1438, 10),
			Position(988, 1438, 10),
			Position(987, 1438, 10),
			Position(986, 1438, 10),
			Position(985, 1438, 10),
			Position(984, 1438, 10),
			Position(983, 1438, 10),
			Position(982, 1438, 10)
		},
		wallDown = 1524,
		wallUp = 1050
	},
	[9018] = {
		wallPositions = {
			Position(979, 1441, 10),
			Position(979, 1442, 10),
			Position(979, 1443, 10),
			Position(979, 1444, 10),
			Position(979, 1445, 10),
			Position(979, 1446, 10),
			Position(979, 1447, 10),
			Position(979, 1448, 10),
			Position(979, 1449, 10)
		},
		wallDown = 1526,
		wallUp = 1049
	},
	[9019] = {
		wallPositions = {
			Position(982, 1452, 10),
			Position(983, 1452, 10),
			Position(984, 1452, 10),
			Position(985, 1452, 10),
			Position(986, 1452, 10),
			Position(987, 1452, 10),
			Position(988, 1452, 10),
			Position(989, 1452, 10),
			Position(990, 1452, 10),
			Position(991, 1452, 10),
			Position(992, 1452, 10),
			Position(993, 1452, 10),
			Position(994, 1452, 10)
		},
		wallDown = 1524,
		wallUp = 1050
	},
	[9020] = {
		wallPositions = {
			Position(997, 1449, 10),
			Position(997, 1448, 10),
			Position(997, 1447, 10),
			Position(997, 1446, 10),
			Position(997, 1445, 10),
			Position(997, 1444, 10),
			Position(997, 1443, 10),
			Position(997, 1442, 10),
			Position(997, 1441, 10)
		},
		wallDown = 1526,
		wallUp = 1049
	}
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local targetLever = config[item.uid]
	if not targetLever then
		return true
	end

	local tile, thing
	for i = 1, #targetLever.wallPositions do
		tile = Tile(targetLever.wallPositions[i])
		if tile then
			thing = tile:getItemById(item.itemid == 1945 and targetLever.wallDown or targetLever.wallUp)
			if thing then
				thing:transform(item.itemid == 1945 and targetLever.wallUp or targetLever.wallDown)
			end
		end
	end

	item:transform(item.itemid == 1945 and 1946 or 1945)
	return true
end