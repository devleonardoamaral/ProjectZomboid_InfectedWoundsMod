local function EveryTenMinutes()
    local sicknessOverTime = SandboxVars.InfectedWounds.sicknessOverTime -- Configurado em 3.0 por padrão

    for playerIndex = 0, getNumActivePlayers() - 1 do
        local player = getSpecificPlayer(playerIndex)
        local bodyDamage = player:getBodyDamage()
        local bodyParts = bodyDamage:getBodyParts()

        for i = 0, BodyPartType.ToIndex(BodyPartType.MAX) - 1 do
            local bodyPart = bodyParts:get(i)

            if bodyPart:isInfectedWound() then
                if player:HasTrait('Resilient') then
                    InfWounds_IncreaseFoodSickness(player, sicknessOverTime * 0.8, 100)
                elseif player:HasTrait('ProneToIllness') then
                    InfWounds_IncreaseFoodSickness(player, sicknessOverTime * 1.2, 100)
                else
                    InfWounds_IncreaseFoodSickness(player, sicknessOverTime, 100)
                end
                break
            end
        end

        -- if isDebugEnabled() then
        --    print('### INFECTED WOUNDS ###')
        --    print('Inf. Level: '..tostring(bodyDamage:getFoodSicknessLevel()))
        -- end
    end
end

Events.EveryTenMinutes.Add(EveryTenMinutes)
