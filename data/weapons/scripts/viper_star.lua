local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_GREENSTAR)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, true)
combat:setFormula(COMBAT_FORMULA_SKILL, 0, 0, 1, 0)

function onUseWeapon(player, variant)
	if not combat:execute(player, variant) then
		return false
	end

	if math.random(1, 100) <= 90 then
		return false
	end

	player:addDamageCondition(Creature(variant:getNumber()), CONDITION_POISON, DAMAGELIST_LOGARITHMIC_DAMAGE, 2)

	drill(player, variant, COMBAT_PHYSICALDAMAGE, CONST_ME_DRAWBLOOD, CONST_ANI_GREENSTAR, 10000)

	return true
end
