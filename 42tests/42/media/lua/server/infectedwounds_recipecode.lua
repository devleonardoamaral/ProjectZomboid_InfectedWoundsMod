Recipe = Recipe or {}
Recipe.OnCreate = Recipe.OnCreate or {}
Recipe.OnCanPerform = Recipe.OnCanPerform or {}

function Recipe.OnCreate.UseAntibiotics(craftRecipeData, character)
    local bodyDamage = character:getBodyDamage()

    local characterStats = character:getStats()
    local characterDrunkness = characterStats:getDrunkenness()

    if characterDrunkness < 5 then
        for i = 0, BodyPartType.ToIndex(BodyPartType.MAX) - 1 do
            local bodyPart = bodyDamage:getBodyParts():get(i)
            
            if bodyPart:isInfectedWound() then
                bodyPart:setInfectedWound(false)
            end
        end
    end
end

-- local p = getPlayer(); local b = p:getBodyDamage(); local bp = b:getBodyParts(); for i=0, BodyPartType.ToIndex(BodyPartType.MAX) - 1 do print(bp:get(i):isInfectedWound()) end

-- local p = getPlayer(); local s = p:getStats(); print(s:getDrunkenness())