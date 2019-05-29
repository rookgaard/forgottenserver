local dirs = {
    [0] = {x = 0,  y = -1, nx = 7},  -- North
    [1] = {x = 1,  y = 0,  nx = 5},   -- East
    [2] = {x = 0,  y = 1,  nx = 4},   -- South
    [3] = {x = -1, y = 0,  nx = 6},  -- West
    [4] = {x = -1, y = 1,  nx = 3},  -- Southwest
    [5] = {x = 1,  y = 1,  nx = 2},   -- Southeast
    [6] = {x = -1, y = -1, nx = 0}, -- Northwest
    [7] = {x = 1,  y = -1, nx = 1}   -- Northeast
}

local function executeShit(name, areaEffect, distEffect, percent, delay, currDir, totalHealth, n)
    -- currDir, totalHealth, n args are for internal usage
    local player = Player(name)
    if not player then
        return
    end
    if (n == nil or n <= 7) then
        local pos = player:getPosition()
        local off = dirs[currDir or 0]
        local position = Position(pos.x+off.x, pos.y+off.y, pos.z)
        local health = player:addPercentHealth(percent)
        local add = totalHealth and totalHealth + health or health
        position:sendMagicEffect(areaEffect)
        position:sendDistanceEffect(pos, distEffect)
        pos:sendMagicEffect(CONST_ME_HOLYAREA)
        player:sendTextMessage(MESSAGE_STATUS_SMALL, string.format('Total health added: %d', add))
        addEvent(executeShit, delay, name, areaEffect, distEffect, percent, delay, off.nx, add, not n and 1 or n+1)
    end
end

-------------------------------------------------------------------------------------------------------------------

local wait = {}

local cfg = {
    percent = 10, -- percent of health to be added back to the player each tick
    time = 60, -- seconds to use tile again
    delay = 650, -- milliseconds (tick delay)
    areaEffect = CONST_ME_HOLYDAMAGE,
    distanceEffect = CONST_ANI_HOLY
}

function onStepIn(creature, item, position, fromPosition)
    local p = creature:getPlayer()
    if p then
        local getwait = wait[p:getName()]
        if getwait and getwait - os.time() > 0 then
            return p:sendTextMessage(MESSAGE_STATUS_SMALL, string.format('You must wait %d seconds to use this again.', getwait - os.time())), creature:teleportTo(fromPosition, true)
        end
        executeShit(p:getName(), cfg.areaEffect, cfg.distanceEffect, cfg.percent/100, cfg.delay)
        wait[p:getName()] = os.time() + cfg.time
        return
    end
    return creature:teleportTo(fromPosition, true)
end