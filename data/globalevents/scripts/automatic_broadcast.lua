function onThink(interval, lastExecution)
    local MESSAGE = {
        "[COMMAND] Use !addondoll to buy addons to your outfit.",
        "[FORUM] Report bugs on the forum! We have admins checking there every day!",
        "[Fixing] We are working on to fix POI, INQ. News on updates made on them can be found on Odisea.com",
        "[INFO] You can buy your blessings from command !bless.",
    }
    Game.broadcastMessage(MESSAGE[math.random(1, #MESSAGE)], MESSAGE_STATUS_WARNING)
    return true
end