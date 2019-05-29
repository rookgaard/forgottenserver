local teleports = {
	[2150] = {text = 'Entering Ushuriel\'s ward.', newPos = Position(951, 1446, 10), storage = 0, alwaysSetStorage = true}, -- to ushuriel ward
	[2151] = {text = 'Entering the Crystal Caves.', bossStorage = 200, newPos = Position(817, 1682, 11), storage = 1}, -- from ushuriel ward
	[2152] = {text = 'Escaping back to the Retreat.', newPos = Position(913, 1481, 11)}, -- from crystal caves
	[2153] = {text = 'Entering the Crystal Caves.', newPos = Position(817, 1682, 11), storage = 1}, -- to crystal caves (from teleports main)
	[2154] = {text = 'Entering the Sunken Caves.', newPos = Position(909, 1660, 11)}, -- to sunken caves --
	[2155] = {text = 'Entering the Mirror Maze of Madness.', newPos = Position(813, 1672, 8)}, -- from sunken caves
	[2156] = {text = 'Entering Zugurosh\'s ward.', newPos = Position(951, 1416, 10)}, -- to zugurosh ward
	[2157] = {text = 'Entering the Blood Halls.', bossStorage = 201, newPos = Position(821, 1440, 10), storage = 2}, -- from zugurosh ward
	[2158] = {text = 'Escaping back to the Retreat.', newPos = Position(913, 1481, 11)}, -- from blood halls
	[2159] = {text = 'Entering the Blood Halls.', newPos = Position(821, 1440, 10), storage = 2}, -- to blood halls(from teleports main)
	[2160] = {text = 'Entering the Foundry.', newPos = Position(813, 1363, 10)}, -- to foundry
	[2161] = {text = 'Entering Madareth\'s ward.', newPos = Position(991, 1423, 10)}, -- to madareth ward
	[2162] = {text = 'Entering the Vats.', bossStorage = 202, newPos = Position(744, 1503, 10), storage = 3}, -- from madareth ward
	[2163] = {text = 'Escaping back to the Retreat.', newPos = Position(913, 1481, 11)}, -- from vats
	[2164] = {text = 'Entering the Vats.', newPos = Position(744, 1503, 10), storage = 3}, -- to vats -- (from teleport main)
	[2165] = {text = 'Entering the Battlefield.', newPos = Position(758, 1541, 10)}, -- to battlefield
	[2166] = {text = 'Entering the Vats.', newPos = Position(824, 1479, 10)}, -- from battlefield
	[2167] = {text = 'Entering the Demon Forge.', newPos = Position(988, 1450, 10)}, -- to brothers ward
	[2168] = {text = 'Entering the Arcanum.', bossStorage = 203, newPos = Position(799, 1569, 10), storage = 4}, -- from demon forge
	[2169] = {text = 'Escaping back to the Retreat.', newPos = Position(913, 1481, 11)}, -- from arcanum
	[2170] = {text = 'Entering the Arcanum.', newPos = Position(799, 1569, 10), storage = 4}, -- to arcanum -- (from teleport main)
	[2171] = {text = 'Entering the Soul Wells.', newPos = Position(738, 1354, 10)}, -- to soul wells
	[2172] = {text = 'Entering the Arcanum.', newPos = Position(942, 1577, 10)}, -- from soul wells
	[2173] = {text = 'Entering the Annihilon\'s ward.', newPos = Position(1019, 1424, 10)}, -- to annihilon ward
	[2174] = {text = 'Entering the Hive.', bossStorage = 204, newPos = Position(981, 1610, 12), storage = 5}, -- from annihilon ward
	[2175] = {text = 'Escaping back to the Retreat.', newPos = Position(913, 1481, 11)}, -- from hive
	[2176] = {text = 'Entering the Hive.', newPos = Position(981, 1610, 12), storage = 5}, -- to hive -- (from teleport main)
	[2177] = {text = 'Entering the Hellgorak\'s ward.', newPos = Position(1022, 1452, 10)}, -- to hellgorak ward
	[2178] = {text = 'Entering the Shadow Nexus. Abandon all Hope.', bossStorage = 205, newPos = Position(867, 1493, 10), storage = 6}, -- from hellgorak ward
	[2179] = {text = 'Escaping back to the Retreat.', newPos = Position(913, 1481, 11)}, -- from shadow nexus
	[2180] = {text = 'Entering the Blood Halls.', newPos = Position(809, 1419, 8)} -- from foundry to blood halls
}

function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local teleport = teleports[item.uid]
	if teleport.alwaysSetStorage and player:getStorageValue(Storage.TheInquisition.EnterTeleport) < teleport.storage then
		player:setStorageValue(Storage.TheInquisition.EnterTeleport, teleport.storage)
	end

	if teleport.bossStorage then
		if Game.getStorageValue(teleport.bossStorage) == 2 then
			if player:getStorageValue(Storage.TheInquisition.EnterTeleport) < teleport.storage then
				player:setStorageValue(Storage.TheInquisition.EnterTeleport, teleport.storage)
			end
		else
			player:teleportTo(Position(913, 1481, 11))
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			player:say('Escaping back to the Retreat.', TALKTYPE_MONSTER_SAY)
			return true
		end
	elseif teleport.storage and player:getStorageValue(Storage.TheInquisition.EnterTeleport) < teleport.storage then
		player:teleportTo(fromPosition)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		player:say('You don\'t have enough energy to enter this portal', TALKTYPE_MONSTER_SAY)
		return true
	end

	player:teleportTo(teleport.newPos)
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	player:say(teleport.text, TALKTYPE_MONSTER_SAY)
	return true
end