local effects = {
    {position = Position(1006, 999, 7), text = 'Quests', effect = CONST_ME_FIREWORK_RED},
    {position = Position(1006, 1000, 7), text = 'Teleports', effect = CONST_ME_FIREWORK_RED},
	{position = Position(1006, 1001, 7), text = 'Depot', effect = CONST_ME_FIREWORK_RED},
    {position = Position(998, 999, 7), text = 'Shops', effect = CONST_ME_FIREWORK_RED},
	{position = Position(998, 1000, 7), text = 'Trainings', effect = CONST_ME_FIREWORK_RED},
	{position = Position(998, 1001, 7), text = 'City', effect = CONST_ME_FIREWORK_RED},
	{position = Position(1005, 1004, 7), text = 'Vip', effect = CONST_ME_FIREWORK_YELLOW},
}
 
function onThink(creature, interval)
    for i = 1, #effects do
        local settings = effects[i]
        local spectators = Game.getSpectators(settings.position, false, true, 7, 7, 5, 5)
        if #spectators > 0 then
            if settings.text then
                for i = 1, #spectators do
                    spectators[i]:say(settings.text, TALKTYPE_MONSTER_SAY, false, spectators[i], settings.position)
                end
            end
            if settings.effect then
                settings.position:sendMagicEffect(settings.effect)
            end
        end
    end
   return true
end