local area = createCombatArea({
	{1, 1, 1},
	{1, 3, 1},
	{1, 1, 1}
})

local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_EXPLOSIONAREA)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_BURSTARROW)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, true)
combat:setFormula(COMBAT_FORMULA_SKILL, 0, 0, 1, 0)
combat:setArea(area)

function onUseWeapon(player, variant)
	if player:getSkull() == SKULL_BLACK then
		return false
	end

	drill(player, variant, COMBAT_PHYSICALDAMAGE, CONST_ME_EXPLOSIONAREA, CONST_ANI_BURSTARROW, 15000)

	return combat:execute(player, variant)
end
