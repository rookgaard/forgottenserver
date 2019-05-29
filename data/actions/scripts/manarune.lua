--[[

local mana = 500
local color = TEXTCOLOR_YELLOW

function onUse(player, item, fromPosition, target, toPosition)
    player:addMana(mana)
    player:sendTextMessage(MESSAGE_HEALED, "You have healed ".. mana .. " mana.", player:getPosition(), mana, color)
    return true
end -->



action.xml
<action itemid="2298" script="manarune.lua"/>  -->
]]--


function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local level = player:getLevel()
    local magLevel = player:getMagicLevel()
    local min = (level * 5) + (magLevel * 3) - 50
    local max = (level * 6) + (magLevel * 4)
    player:addMana(math.random(min, max))
    player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
    player:say("mana...", TALKTYPE_MONSTER_SAY)
    return true
end



