local vocations = {3, 7, 1, 5}
local dir = 2 --1 = north/south door....2 = east/west door
function onUse(cid, item, fromPos, item2, toPos)
    if not isInArray(vocations getPlayerVocation(cid)) then
        return doPlayerSendTextMessage(cid, 22, "You must be a paladin or sorcerer to pass here.")
	end
 
    local pPos = getPlayerPosition(cid)
 
    if dir == 1 then
        if pPos.y < toPos.y then
            pos = {x = toPos.x, y = toPos.y + 1, z = toPos.z}
        elseif pPos.y > toPos.y then
            pos = {x = toPos.x, y = toPos.y - 1, z = toPos.z}
        end
    else
        if pPos.x < toPos.x then
            pos = {x = toPos.x + 1, y = toPos.y, z = toPos.z}
        elseif pPos.x > toPos.x then
            pos = {x = toPos.x - 1, y = toPos.y, z = toPos.z}
        end
    end
if pos then
    player:teleportTo(pos)
    doSendMagicEffect(toPos, 12)
end
return true
end