local config = {
    level = 50, -- level mínimo
    maxTimes = 1, -- quantas vezes poderá usar
    timeToWait = {1, 'day'}, -- tempo para usar novamente após atingir o max_times
    maxPlayers = 3, -- máximo de players dentro da área
    room = {fromPos = Position(32312, 32507, 8), toPos = Position(32312, 32507, 8)}, -- posição do canto superior esquerdo, posição do canto inferior direito da sala
    newPos = Position(32327, 32528, 8), -- posição para onde o player será teleportado ao entrar
    stone = {id = 1304, pos = Position(32320, 32516, 8)}, -- id da pedra, posição
    timeToKick = {2, 'min'}, -- tempo para ser kikado da sala
    kickPos = Position(32331, 32526, 7), -- quando kikados da área, o player vai para essa posição
}
function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if player:hasExhaustion(84309) then
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, "You can use again at " .. os.date("%d %B %Y %X", player:getStorageValue(84309))..".")
        return true
    end
    if player:getStorageValue(84310) == config.maxTimes then
        player:setStorageValue(84310, -1)
    end
    if #getPlayersInArea(config.room.fromPos, config.room.toPos) >= config.maxPlayers then
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, 'Wait for the team to leave the room.')
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return true
    end
    if player:getLevel() < config.level then
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, "You need at least level " .. config.level .. " to go.")
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return true
    end
    local max_times = player:getStorageValue(84310) > 0 and player:getStorageValue(84310) or 0
    if (max_times + 1) == config.maxTimes then
        player:setStorageValue(84309, mathtime(config.timeToWait) + os.time())
    end
    local stone = Tile(config.stone.pos):getItemById(config.stone.id)
    if stone then
        stone:getPosition():sendMagicEffect(CONST_ME_POFF)
        stone:remove()
    end
    player:teleportTo(config.newPos)
    player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
    player:setStorageValue(84310, math.max(0, max_times) + 1)
    addEvent(kickFromArea, mathtime(config.timeToKick) * 1000, player.uid)
    return true
end

function getPlayersInArea(fromPos, toPos)
    local players, playerss = {}, Game.getPlayers()
    for i = 1, #playerss do
        local player = playerss[i]
        if isInRange(player:getPosition(), fromPos, toPos) then
            table.insert(players, player)
        end
    end
    return players
end

function mathtime(table) -- by dwarfer
    local unit = {"sec", "min", "hour", "day"}
    for i, v in pairs(unit) do
        if v == table[2] then
            return table[1]*(60^(v == unit[4] and 2 or i-1))*(v == unit[4] and 24 or 1)
        end
    end
    return error("Bad declaration in mathtime function.")
end

function kickFromArea(cid)
    local stone = Tile(config.stone.pos):getItemById(config.stone.id)
    if not stone then
        Game.createItem(config.stone.id, 1, config.stone.pos)
    end
    local player = Player(cid)
    if player and isInRange(player:getPosition(), config.room.fromPos, config.room.toPos) then
        player:teleportTo(config.kickPos)
        player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
    end
end