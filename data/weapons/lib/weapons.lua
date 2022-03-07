function drill(player, variant, combatType, effect, distanceEffect, weaponChance)
	if (variant.type ~= 1) then
		return true
	end

	local target = Creature(variant.number)
	local playerPosition = player:getPosition()
	local targetPosition = target:getPosition()

	if (playerPosition.x ~= targetPosition.x and playerPosition.y ~= targetPosition.y) then
		return true
	end

	local direction = DIRECTION_NORTH
	local monsterRange = 0

	if (playerPosition.x == targetPosition.x) then
		monsterRange = targetPosition.y - playerPosition.y

		if (monsterRange < 0) then
			direction = DIRECTION_NORTH
		else
			direction = DIRECTION_SOUTH
		end

		monsterRange = math.abs(monsterRange)
	elseif (playerPosition.y == targetPosition.y) then
		monsterRange = targetPosition.x - playerPosition.x

		if (monsterRange < 0) then
			direction = DIRECTION_WEST
		else
			direction = DIRECTION_EAST
		end

		monsterRange = math.abs(monsterRange)
	end

	if (monsterRange == 0) then
		return true
	end

	local weapon = player:getSlotItem(CONST_SLOT_LEFT)

	if (not weapon) then
		weapon = player:getSlotItem(CONST_SLOT_RIGHT)
	end

	if (not weapon) then
		return true
	end

	local itemType = ItemType(weapon.itemid)
	local weaponRange = math.max(weapon:getAttribute(ITEM_ATTRIBUTE_SHOOTRANGE), itemType:getShootRange())

	if (not weaponChance) then
		weaponChance = 33000
	end

	for step = monsterRange + 1, weaponRange do
		local position = playerPosition:clone()
		position:getNextPosition(direction, step)
		local creature = Tile(position):getTopCreature()

		if (creature) then
			local chance = math.random(0, 100000)

			if (chance > weaponChance) then
				return true
			end

			Position(playerPosition):sendDistanceEffect(position, distanceEffect)
			local damage = player:getWeaponDamage()
			doTargetCombat(0, creature, combatType, 0, damage, effect)
		end
	end
end
