local config = {
    rewards = {[2195] = 1, [2472] = 1, [2493] = 1}
}
 
function onTime(interval)
    if Game.getPlayerCount() == 0 then
        return true
    end
 
    local players = Game.getPlayers()
    local winner  = players[math.random(1, #players)]
 
    local items = {}
    for itemid, count in pairs(config.rewards) do
        items[#items + 1] = itemid
    end
	
    if winner:getGroup():getAccess() then
		return true
	end
	
    local itemid = items[math.random(1, #items)]
    local amount = config.rewards[itemid]
    winner:addItem(itemid, amount)
 
    local it   = ItemType(itemid)
    local name = ""
    if amount == 1 then
        name = it:getArticle() .. " " .. it:getName()
    else
        name = amount .. " " .. it:getPluralName()
    end
 
    Game.broadcastMessage("" .. winner:getName() .. " won " .. name .. "! Congratulations.", MESSAGE_STATUS_WARNING)
    return true
end



--[[~second option~∞
<globalevent name="Lotto" time="01:00:00" script="Events/lottery.lua" />


local rewards = {
    {2160, 15},
    {2160, 25},
    {2195, 1},

}

function onTime(interval)
    local players = Game.getPlayers()

    if #players > 0 and #rewards > 0 then
        local uid, n = math.random(1, #players), math.random(1, #rewards)
        local lucky = players[uid]
        local reward, count = rewards[n][1], rewards[n][2]
    
        if lucky and reward and count then
            lucky:addItem(reward, count)
            Game.broadcastMessage('[LOTTERY] - '.. lucky:getName()..' recieved '.. count .. ' '..ItemType(reward):getName()..' Congratulations.', MESSAGE_STATUS_WARNING)
        end
    end

    return true
end]]--