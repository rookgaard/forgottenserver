-- Credits to OT Land for all their shared ressources and community help.
-- To Danat, me, that made this script
-- To knekarn, which shared a nice npc guard script that I adapted to this one. (I adapted the check radius around player, and added multiple floors)

local config = {
        radiusx = 10, -- radiusx
        radiusy = 10, -- radiusy
        radiusz = 15, -- radiusy, set to 15 or higher to search all floors, set to 0 to search current floor, 1 will search floors above and below.
        find_monsters = TRUE, -- set to TRUE to find monsters
        find_npcs = TRUE, -- set to TRUE to find NPCs
        effectfail = CONST_ME_POFF, -- effect no creatures found
        effectuse = CONST_ME_ENERGYHIT, -- effect creatures found
        effectremoved = CONST_ME_MAGIC_GREEN, -- effect on player when creature removed
        effectremove = CONST_ME_TELEPORT, -- effect on creature when creature removed
        ani = CONST_ANI_ENERGY -- ani from player to creature
}


function onSay(player, words, param)
    if not player:getGroup():getAccess() then
        return true
    end

    if player:getAccountType() < ACCOUNT_TYPE_GOD then
        return false
    end
   
local monsters = { } 
local pos = player:getPosition()
local starting = {x = (pos.x - config.radiusx), y = (pos.y - config.radiusy), z = (pos.z + config.radiusz), stackpos = stack}  
local ending = {x = (pos.x + config.radiusx), y = (pos.y + config.radiusy), z = (pos.z - config.radiusz), stackpos = stack}  
local checking = {x = starting.x, y = starting.y, z = starting.z, stackpos = starting.stackpos}

if starting.z > 15 then
    starting.z = 15
end 
if ending.z < 0 then
    ending.z = 0
end

local creature
    repeat
        creature = getTopCreature(checking)
        -- print(creature, getCreatureName(creature.uid))
            if creature.itemid > 0 then
                if isCreature(creature.uid) == TRUE then 
                    if config.find_npcs == TRUE then
                        if isNpc(creature.uid) == TRUE then
                            table.insert (monsters, creature.uid)
                        end
                    end
                    if config.find_monsters == TRUE then
                        if isMonster(creature.uid) == TRUE then
                            table.insert (monsters, creature.uid)
                        end
                    end
                end
            end
-- this checks to skip player pos, else add +1 to x       
        if checking.x == pos.x-1 and checking.y == pos.y then  
            checking.x = checking.x+2  
        else   
            checking.x = checking.x+1
        end  
-- this checks to see if x reached end, if it did, restart x, and add +1 to y
        if checking.x > ending.x then  
            checking.x = starting.x  
            checking.y = checking.y+1  
        end  
-- this will check if y reached ending, restart x and y and add +1 to z
        if checking.y > ending.y then  
            checking.x = starting.x
            checking.y = starting.y
            checking.z = checking.z-1
        end
    until checking.z < ending.z


    if #monsters >= 1 then
    doSendMagicEffect(pos, config.effectuse)
    player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "You have found the following creatures:")
        for i = 1, #monsters do 
            local monstername = getCreatureName(monsters[i])
            local monsterpos = getThingPos(monsters[i])
            player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Found a creature called " .. monstername .. " at x: "  .. monsterpos.x .. ", y: "  .. monsterpos.y .. ", z: "  .. monsterpos.z .. ".")
            player:sendCancelMessage("Found Creatures.")
            if(monstername == param) then
                local npcpos = {x =getThingPos(monsters[i]).x, y = getThingPos(monsters[i]).y, z = getThingPos(monsters[i]).z, stackpos = getThingPos(monsters[i]).stackpos}
                local stackmob = getThingPos(monsters[i]).stackpos   
                doSendDistanceShoot(player, getThingPos(monsters[i]), config.ani)
                doSendMagicEffect(getThingPos(monsters[i]), config.effectremove)
                doRemoveCreature(monsters[i])
                doSendMagicEffect(pos, config.effectremoved)
                player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "The Creature nearby called " .. monstername .. " has been removed.")
            end
        end
    elseif table.getn(monsters) < 1 then  
                    doSendMagicEffect(pos, config.effectfail)
                    player:sendCancelMessage("There are no Creatures nearby.")
    end
    return false
end