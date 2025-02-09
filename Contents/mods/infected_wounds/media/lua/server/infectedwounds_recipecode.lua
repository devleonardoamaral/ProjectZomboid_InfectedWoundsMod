Recipe = Recipe or {}
Recipe.OnCreate = Recipe.OnCreate or {}
Recipe.OnCanPerform = Recipe.OnCanPerform or {}

function Recipe.OnCreate.UseAntibiotics(items, result, player)
    local bodyDamage = player:getBodyDamage()

    local playerStats = player:getStats()
    local playerDrunkness = playerStats:getDrunkenness()

    if playerDrunkness <= 5 then
        for i = 0, BodyPartType.ToIndex(BodyPartType.MAX) - 1 do
            local bodyPart = bodyDamage:getBodyParts():get(i)
            
            if bodyPart:isInfectedWound() then
                bodyPart:setInfectedWound(false)
            end
        end
    end
end

function Recipe.OnCanPerform.UseAntibiotics(recipe, playerObj)
    local player = playerObj
    local bodyDamage = player:getBodyDamage()
        
    for i = 0, BodyPartType.ToIndex(BodyPartType.MAX) - 1 do
        local bodyPart = bodyDamage:getBodyParts():get(i)
        
        if bodyPart:isInfectedWound() then
            return true
        end
    end

    return false
end
