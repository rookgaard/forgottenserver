local outfits = {
    ["citizen"] = {136, 128},
    ["hunter"] = {137, 129},
    ["mage"] = {138, 130},
    ["knight"] = {139, 131},
    ["noblewoman"] = {140, 132},
    ["summoner"] = {141, 133},
    ["warrior"] = {142, 134},
    ["barbarian"] = {147, 143},
    ["druid"] = {148, 144},
    ["wizard"] = {149, 145},
    ["oriental"] = {150, 146},
    ["pirate"] = {155, 151},
    ["assassin"] = {156, 152},
    ["beggar"] = {157, 153},
    ["shaman"] = {158, 154},
    ["norsewoman"] = {252, 251},
    ["nightmare"] = {269, 268},
    ["jester"] = {270, 273},
    ["brotherhood"] = {279, 278},
    ["demonhunter"] = {288, 289},
    ["yalaharian"] = {324, 325},
    ["warmaster"] = {336, 335},
    ["wayfarer"] = {366, 367},
}

local addondoll_id = 9693

function onSay(player, words, param)
    if player:getItemCount(addondoll_id) < 0 then
		player:sendCancelMessage("Voce nao tem addon doll!")
		return false
	end

	local split = param:split(",")
	local addonType = split[1]
	if not addonType then
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, "Por favor utilize o comando corretamente. !addon first, mage")
		return false
	end

	addonType = addonType:lower()
	if addonType ~= "first" and addonType ~= "second" then
		player:sendCancelMessage("Por favor use o comando corretamente. Exemplo: !addon first mage")
		return false
	end

	local outfitName = split[2]
	if not outfitName then
		player:sendCancelMessage("Não existe nenhuma Outfit com esse nome.")
		return false
	end

	local outfit = outfits[outfitName:lower()]
	if not outfit then
		player:sendCancelMessage("Não existe nenhuma Outfit com esse nome.")
		return false
	end

	local type = addonType == "first" and 1 or 2
	if player:hasOutfit(outfit[type], type) then 
		player:sendCancelMessage("Voce ja tem este addon")
		return false
	end

	player:removeItem(addondoll_id, 1)
	player:getPosition():sendMagicEffect(CONST_ME_GIFT_WRAPS)
	player:addOutfitAddon(outfit[type], type)
	player:sendTextMessage(MESSAGE_INFO_DESCR, string.format('Você recebeu o %s do Addon %s.', addonType:lower(), outfitName:lower()))
	return false
end