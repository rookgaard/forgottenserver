local config = {
        rate = 2.0, -- 4x More Experience
        time = 3, -- Hours of Exp Time
        storage = 200011
    }
    local function endExpRate(player, cid)
        player:setExperienceRate(cid, SKILL__LEVEL, 3.0)
        player:setStorageValue(cid, config.storage, -1)
        player:sendTextMessage(cid, MESSAGE_INFO_DESCR, "Your extra experience time has ended.")
    end
 
    function onUse(cid, item, fromPosition, itemEx, toPosition)
	local player = Player(cid)
	if player:getStorageValue(80000) <= os.time() then
       player:setStorageValue(80000, os.time() + 2 * 60 * 60)
       Item(item.uid):remove(1)
       player:say("You have just activated 2 hours of Double Experience!", TALKTYPE_MONSTER_SAY)
	else
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You still have extra experience time left.")
	end
	return true
end



