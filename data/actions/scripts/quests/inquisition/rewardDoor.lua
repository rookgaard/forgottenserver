function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if(item.uid == 9021) then
		if player:getStorageValue(Storage.TheInquisition.Reward) == 1 then
			if(item.itemid == 9175) then
				player:teleportTo(toPosition, true)
				item:transform(item.itemid + 1)
			end
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Necesitas terminar Inquisition y coger la recompensa, para poder usar esta puerta.")
		end
	end
	return true
end