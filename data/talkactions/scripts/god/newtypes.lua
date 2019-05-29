local outfitsRefuse = {135, {161, 191}}

local function isInAltArray(array, value)
    for i = 1, #array do
        if type(array[i]) == 'table' then
            return (value < array[i][1] and value > array[i][2])
        elseif array[i] == value then
            return true
        end
    end
end

local function outfitSearch()
    local outfit = math.random(2, 367)
    if not isInAltArray(outfitsRefuse, outfit) then
      return outfit
    end
    return outfitSearch()
end

function onSay(player, words, param)
    if not player:getGroup():getAccess() then
        return true
    end
    player:setOutfit({lookType = outfitSearch()})
    player:getPosition():sendMagicEffect(CONST_ME_GROUNDSHAKER)
    return false
end