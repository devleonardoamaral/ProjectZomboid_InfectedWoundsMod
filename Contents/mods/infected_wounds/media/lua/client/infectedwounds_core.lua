local function EveryOneMinute()
    local sicknessOverTime = SandboxVars.InfectedWounds.sicknessOverTime

    for playerIndex = 0, getNumActivePlayers() - 1 do
        local player = getSpecificPlayer(playerIndex)
        
        if player then
            local modData = player:getModData()
            local bodyDamage = player:getBodyDamage()
            local bodyParts = bodyDamage:getBodyParts()
            local count = 0

            local currentFoodSickness = bodyDamage:getFoodSicknessLevel()

            for i = 0, BodyPartType.ToIndex(BodyPartType.MAX) - 1 do
                local bodyPart = bodyParts:get(i)

                if bodyPart:isInfectedWound() then
                    count = count + 1
                end
            end

            if count > 0 then
                if not modData.playerFoodSickness or modData.playerFoodSickness == 0 then
                    modData.playerFoodSickness = currentFoodSickness
                end

                local progressPercentage = sicknessOverTime
                local newFoodSickness = modData.playerFoodSickness

                if SandboxVars.InfectedWounds.multipliesByEachWound then
                    progressPercentage = sicknessOverTime * (1 + (math.max(count - 1, 0) * SandboxVars.InfectedWounds.multiplierByEachWound))
                end

                if player:HasTrait('Resilient') then
                    progressPercentage = progressPercentage * SandboxVars.InfectedWounds.resilientMultiplier
                elseif player:HasTrait('ProneToIllness') then
                    progressPercentage = progressPercentage * SandboxVars.InfectedWounds.proneToIllnessMultiplier
                end

                -- print("before newFoodSickness: " .. tostring(newFoodSickness))
                -- print("modData.playerFoodSickness: " .. tostring(modData.playerFoodSickness))

                newFoodSickness = math.min(newFoodSickness + progressPercentage, 100)
                newFoodSickness = math.max(newFoodSickness, currentFoodSickness)
                modData.playerFoodSickness = newFoodSickness
                bodyDamage:setFoodSicknessLevel(newFoodSickness)

                -- print("after newFoodSickness: " .. tostring(newFoodSickness))
                -- print("progressPercentage: " .. tostring(progressPercentage))
                -- print("Diff: " .. tostring(newFoodSickness - currentFoodSickness))
            else
                modData.playerFoodSickness = 0
            end
        end
    end
end

Events.EveryOneMinute.Add(EveryOneMinute)
