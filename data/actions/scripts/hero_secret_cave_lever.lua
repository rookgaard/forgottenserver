local wallPosition = Position(994, 1253, 9) --wall position
local wall = 9127 --wall ID
local revertTime = 1 * 60 * 1000 --time: 1=1min

local function revertWall()
    Game.createItem(wall, 1, wallPosition)
    wallPosition:sendMagicEffect(CONST_ME_POFF)
end

local function revertLever(position)
    local leverItem = Tile(position):getItemById(1946)
    if leverItem then
        leverItem:transform(1945)
    end
end

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if item.itemid == 1945 then
        local removeWall = Tile(wallPosition):getItemById(wall)
        if removeWall then
            removeWall:remove()
            wallPosition:sendMagicEffect(CONST_ME_POFF)
            addEvent(revertWall, revertTime)
        end

        item:transform(1946)
        addEvent(revertLever, revertTime, toPosition)
    end
    return true
end