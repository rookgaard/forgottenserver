--[[
<action itemid="12318" script="admin_tp.lua" allowfaruse="1" blockwalls="0" checkfloor="0"/>
]]--

local function spellTP(cid, fromPosition, toPosition)
    local player = Player(cid)
    if not player then
        return
    end

    player:teleportTo(toPosition)
    toPosition:sendMagicEffect(CONST_ME_PURPLEENERGY)
    toPosition:sendMagicEffect(CONST_ME_ENERGYAREA)
    fromPosition:sendMagicEffect(CONST_ME_PURPLEENERGY)
    fromPosition:sendMagicEffect(CONST_ME_ENERGYAREA)
end


function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if player:getAccountType() < ACCOUNT_TYPE_GOD then
        return false
    end

    if toPosition.x == 0 or toPosition.x == 65535 or toPosition.y == 0 or toPosition.y == 65535 then
        return false
    end

    if player:isInGhostMode() then
        player:teleportTo(toPosition)
    else
        toPosition:sendMagicEffect(CONST_ME_THUNDER)
        addEvent(spellTP, 500, player.uid, player:getPosition(), toPosition)
    end
    return true
end