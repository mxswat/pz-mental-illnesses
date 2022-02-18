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