local function EveryOneMinute()
    local sicknessOverTime = SandboxVars.InfectedWounds.sicknessOverTime

    for playerIndex = 0, getNumActivePlayers() - 1 do
        local player = getSpecificPlayer(playerIndex)

        if player then
            local bodyDamage = player:getBodyDamage()
            local bodyParts = bodyDamage:getBodyParts()

            for i = 0, BodyPartType.ToIndex(BodyPartType.MAX) - 1 do
                local bodyPart = bodyParts:get(i)

                if bodyPart:isInfectedWound() then
                    local currentFoodSickness = bodyDamage:getFoodSicknessLevel()
                    local newFoodSickness = currentFoodSickness
                    local progressPercentage = sicknessOverTime

                    if player:HasTrait('Resilient') then
                        progressPercentage = progressPercentage * 1.2
                        newFoodSickness = math.min(newFoodSickness + progressPercentage, 100)
                        bodyDamage:setFoodSicknessLevel(newFoodSickness)
                    elseif player:HasTrait('ProneToIllness') then
                        progressPercentage = progressPercentage * 0.8
                        newFoodSickness = math.min(newFoodSickness + progressPercentage, 100)
                        bodyDamage:setFoodSicknessLevel(newFoodSickness)
                    else
                        newFoodSickness = math.min(newFoodSickness + progressPercentage, 100)
                        bodyDamage:setFoodSicknessLevel(newFoodSickness)
                    end

                    print("Sickness Over Time: " .. tostring(sicknessOverTime))
                    print("Current Sickness: " .. tostring(currentFoodSickness))
                    print("New Sickness: " .. tostring(newFoodSickness))
                    print("Diff: " .. tostring(newFoodSickness - currentFoodSickness))
                    print("Progress Percentage: " .. tostring(math.floor(progressPercentage * 100 + 0.5) / 100))
                    
                    if not SandboxVars.InfectedWounds.multipliesByEachWound then
                        break
                    end
                end
            end
        end
    end
end

Events.EveryOneMinute.Add(EveryOneMinute)
