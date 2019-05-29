function onSay(player, words, param)
    local party = player:getParty()
    if not party then
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "You are not in a party.")
        return false
    end
    if not (party:getLeader() == player) then
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "You are not the leader of the party.")
        return false
    end
    local outfit = player:getOutfit()
    local members = party:getMembers()
    for i = 1, #members do
        local newOutfit = members[i]:getOutfit()
        newOutfit.lookHead = outfit.lookHead
        newOutfit.lookBody = outfit.lookBody
        newOutfit.lookLegs = outfit.lookLegs
        newOutfit.lookFeet = outfit.lookFeet
        members[i]:setOutfit(newOutfit)
        members[i]:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
    end
    return false
end