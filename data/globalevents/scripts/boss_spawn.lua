local spawns = {
	-- Vampires
	[1]  = {position = Position(0, 0, 7), monster = 'Arachir The Ancient One'},
	[2]  = {position = Position(0, 0, 7), monster = 'Diblis The Fair'},
	[3]  = {position = Position(0, 0, 7), monster = 'Sir Valorcrest'},
	[4]  = {position = Position(0, 0, 7), monster = 'Zevelon Duskbringer'},

	-- Bosses
	[5]  = {position = Position(0, 0, 7), monster = 'Demodras'},
	[6]  = {position = Position(0, 0, 7), monster = 'Dharalion'},
	[7]  = {position = Position(0, 0, 7), monster = 'Fernfang'},
	[8]  = {position = Position(0, 0, 7), monster = 'Man in the Cave'},
	[9]  = {position = Position(1027, 1108, 7), monster = 'Necropharus'}, --ready
	[10] = {position = Position(0, 0, 7), monster = 'The Horned Fox'},
	[11] = {position = Position(0, 0, 7), monster = 'Yeti'},

	-- PoI bosses
	[12] = {position = Position(959, 684, 11), monster = 'Countess Sorrow'},
	[13] = {position = Position(1052, 662, 12), monster = 'Dracola'},
	[14] = {position = Position(1093, 722, 12), monster = 'Massacre'},
	[15] = {position = Position(1037, 720, 12), monster = 'Mr. Punish'},
	[16] = {position = Position(1003, 659, 12), monster = 'The Handmaiden'},
	[17] = {position = Position(918, 714, 12), monster = 'The Plasmother'},
	[18] = {position = Position(1000, 725, 12), monster = 'The Imperor'}
}

function onThink(interval, lastExecution, thinkInterval)
	if math.random(1000) > 50 then
		return true
	end

	local spawn = spawns[math.random(#spawns)]
	Game.createMonster(spawn.monster, spawn.position, false, true)
	return true
end