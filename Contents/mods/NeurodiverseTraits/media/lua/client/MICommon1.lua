function ApplyPositiveOrNegativeTraitsGivenACondition(isPositives, positives, negatives)
    local player = getSpecificPlayer(0)

    -- Init by removing all traits both positives and negatives
    for _, value in pairs(positives) do
        player:getTraits():remove(value);
    end
    for _, value in pairs(negatives) do
        player:getTraits():remove(value);
    end

    if isPositives then
        -- Enable positives
        for _, value in pairs(positives) do
            player:getTraits():add(value);
            print("Added Trait: "..value)
        end 
    else
        -- Enable negatives
        for _, value in pairs(negatives) do
            player:getTraits():add(value);
            print("Added Trait: "..value)
        end 
    end
end

function RemoveTraits(traits)
    local player = getSpecificPlayer(0)
    for _, value in pairs(traits) do
        player:getTraits():remove(value);
    end
end

-- WIP
function TickBasedUpdate(tickId)
    local player = getPlayer()
    local playerdata = player:getModData();

    if playerdata[tickId] == nil then
        playerdata[tickId] = 0;
    end

    local tick = playerdata[tickId];
    if tick <= 0 then
        print(tickId..' has beed triggered')
        -- stats:setEndurance(endurance + enduranceChange);
        playerdata[tickId] = 1000;
    else
        if player:isSprinting() then
            playerdata[tickId] = tick - 4;
        elseif player:IsRunning() then
            playerdata[tickId] = tick - 10;
        elseif player:getCurrentState() == FitnessState.instance() then
            playerdata[tickId] = tick - 10;
        else
            playerdata[tickId] = tick - 5;
        end
    end
end