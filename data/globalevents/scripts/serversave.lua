local shutdownAtServerSave = false
local cleanMapAtServerSave = true

local function serverSave()
	if shutdownAtServerSave then
		Game.setGameState(GAME_STATE_SHUTDOWN)
	else
		if cleanMapAtServerSave then
			cleanMap()
			saveData()
			broadcastMessage("The server has been saved, and cleaned...", MESSAGE_STATUS_WARNING)
		end
		saveServer()
	end
end

local function secondServerSaveWarning()
	broadcastMessage("Server is saving game in one minute. Go to a safe place.", MESSAGE_STATUS_WARNING)
	addEvent(serverSave, 60000)
end

local function firstServerSaveWarning()
	broadcastMessage("Server is saving game in 3 minutes. Go to a safe place.", MESSAGE_STATUS_WARNING)
	addEvent(secondServerSaveWarning, 120000)
end

function onThink(interval)
	broadcastMessage("Server is saving game in 5 minutes. Go to a safe place.", MESSAGE_STATUS_WARNING)
	Game.setGameState(GAME_STATE_NORMAL)
	addEvent(firstServerSaveWarning, 120000)
	return not shutdownAtServerSave
end
