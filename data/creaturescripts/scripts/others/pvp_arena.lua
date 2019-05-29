local arena = {
    frompos = {x = 963, y = 1061, z = 9},
    topos = {x = 977, y = 1071, z = 9},
    exitpos = {x = 959, y = 1066, z = 8}
}
 
function onPrepareDeath(player, lastHitKiller, mostDamageKiller)
    if player:isPlayer() then
        local ppos = player:getPosition()
        if isInRange(ppos, arena.frompos, arena.topos) then
            local maxhp = player:getMaxHealth()
            player:addHealth(maxhp)
            addEvent(doCreatureAddHealth, 100, player:getId(), maxhp)
            player:sendTextMessage(MESSAGE_STATUS_WARNING,"[Arena]: You lost the duel.")
        end
        if isInRange(ppos, arena.frompos, arena.topos) then
            player:teleportTo(arena.exitpos)
            return true
        end
    end
    return true
end
 
function onLogin(player)
    player:registerEvent("pvparena")
    return true
end
