local events = {
	'"PlayerDeath"',
	'"DropLoot"',
	'"inquisitionBosses"'
} 

		for i = 1, #events do
		player:registerEvent(events[i])
	end 