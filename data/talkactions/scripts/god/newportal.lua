--[[
Use it by typing !portal x, y, z

!portal 1000, 1000, 7

It will create the portal in the direction you are looking. It will not create the portal on top of an item or a player.
]]--

function onSay(player, words, param)
    if not player:getGroup():getAccess() then
        return true
    end

    if player:getAccountType() < ACCOUNT_TYPE_GOD then
        return false
    end

    local split = param:split(",")
    if split[3] == nil then
        player:sendCancelMessage("Insufficient parameters.")
        return false
    end

    x = split[1]
    y = split[2]
    z = split[3]
 
    x = tonumber(x)
    y = tonumber(y)
    z = tonumber(z)
 
    local DIR = player:getDirection()
 
    if DIR == DIRECTION_NORTH then
        portal_pos = {x = player:getPosition().x, y = player:getPosition().y - 1, z = player:getPosition().z}
    elseif DIR == DIRECTION_EAST then
        portal_pos = {x = player:getPosition().x + 1, y = player:getPosition().y, z = player:getPosition().z}
    elseif DIR == DIRECTION_SOUTH then
        portal_pos = {x = player:getPosition().x, y = player:getPosition().y + 1, z = player:getPosition().z}
    elseif DIR == DIRECTION_WEST then
        portal_pos = {x = player:getPosition().x - 1, y = player:getPosition().y, z = player:getPosition().z}
    end
 
    if isCreature(Tile(portal_pos):getTopCreature()) then
        return player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, "You cannot create a teleport on top of a player.")
    end
 
    if Tile(portal_pos):getTopDownItem() then
        return player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, "You cannot create a teleport on top of an item.")
    end
 
    doCreateTeleport(1387, {x = x, y = y, z = z}, portal_pos)
    player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, "Teleport created to cordinates: {X: "..x.." Y: "..y.." Z: "..z.."}.")
    return false
end



--[[ Acortado(shortened)

function onSay(player, words, param)
    if player:getAccountType() < ACCOUNT_TYPE_GOD then
        return true
    end

    local split = param:split(",")
    if tonumber(split[3]) == nil then
        player:sendCancelMessage("Insufficient parameters.")
        return false
    end
   
    local msg = nil

    for i = 1, #split do
        split[i] = tonumber(split[i])
    end

    local direction = {
        [0] = function(ps) ps.y = ps.y - 1 return ps end,
        [1] = function(ps) ps.x = ps.x + 1 return ps end,
        [2] = function(ps) ps.y = ps.y + 1 return ps end,
        [3] = function(ps) ps.x = ps.x - 1 return ps end
    }

    local teleporter = direction[player:getDirection()](player:getPosition())

    if isCreature(Tile(teleporter):getTopCreature()) then
        msg = "You cannot create a teleport on top of a player."
    end
 
    if Tile(teleporter):getTopDownItem() then
        msg = "You cannot create a teleport on top of an item."
    end
   
    if not msg then
        msg = "Teleport created to cordinates: {X: "..split[1].." Y: "..split[2].." Z: "..split[3].."}."
        doCreateTeleport(1387, {x = split[1], y = split[2], z = split[3]}, teleporter)
    end
   
    player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, msg)
    return false
end

]]--