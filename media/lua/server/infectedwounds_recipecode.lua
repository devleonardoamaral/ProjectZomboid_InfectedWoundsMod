Recipe = Recipe or {}
Recipe.OnCreate = Recipe.OnCreate or {}
Recipe.OnCanPerform = Recipe.OnCanPerform or {}

function Recipe.OnCreate.UseAntibiotics(items, result, player)
    -- print('The pill has been taken!')
    local bodyDamage = player:getBodyDamage()

    -- print('Checking if the player is drunk.')
    local playerStats = player:getStats()
    local playerDrunkness = playerStats:getDrunkenness()

    if playerDrunkness <= 5 then
        -- print('The player is not drunk: '..playerDrunkness)

        for i = 0, BodyPartType.ToIndex(BodyPartType.MAX) - 1 do
            local bodyPart = bodyDamage:getBodyParts():get(i)
            
            if bodyPart:isInfectedWound() then
                bodyPart:setInfectedWound(false)
                -- print('The wound is no longer infected!')
            end
        end

    else
        -- print('Player is drunk: '..playerDrunkness)
    end
end

function Recipe.OnCanPerform.UseAntibiotics(recipe, playerObj)
    -- print("Checking if it's necessary to take a pill!")
    local player = playerObj
    local bodyDamage = player:getBodyDamage()
        
    for i = 0, BodyPartType.ToIndex(BodyPartType.MAX) - 1 do
        local bodyPart = bodyDamage:getBodyParts():get(i)
        
        if bodyPart:isInfectedWound() then
            -- print('You need to take it!')
            return true
        end
    end

    -- print('No need to take it!')
    return false
end
