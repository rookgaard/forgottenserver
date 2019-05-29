function changeOutfit(cid)
    local npc = Creature(cid)
    if npc then
        local outfit = npc:getOutfit()
        outfit.lookHead = math.random(0, 132)
        outfit.lookBody = math.random(0, 132)
        outfit.lookLegs = math.random(0, 132)
        outfit.lookFeet = math.random(0, 132)
        npc:setOutfit(outfit)
    end
end

local interval = 100
function onThink()
    local cid = getNpcCid()
    for i = 9, 1000/interval do
        addEvent(changeOutfit, (i-1)*interval, cid)
    end
    npcHandler:onThink()
	return
end