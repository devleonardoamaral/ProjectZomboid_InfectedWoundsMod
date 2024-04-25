function InfWounds_IncreaseFoodSickness(player, value, chance)
    local rand = ZombRand(100) + 1

    if rand <= chance then
        local bodyDamage = player:getBodyDamage()
        bodyDamage:setFoodSicknessLevel(bodyDamage:getFoodSicknessLevel() + value)

        if bodyDamage:getFoodSicknessLevel() > 100 then
            bodyDamage:setFoodSicknessLevel(100)
        end

        if isDebugEnabled() then
            print('### INFECTED WOUNDS ###')
            print('Increased Food Sickness: ')
            print(' - Increased: '..tostring(value))
            print(' - Current Value: '..tostring(bodyDamage:getFoodSicknessLevel()))
        end
    end
end