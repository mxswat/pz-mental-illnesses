local function Bipolar_Init()
    local player = getSpecificPlayer(0)

    local positives = {
        "BipolarMania",
        "NeedsLessSleep",
    }

    local negatives = {
        "BipolarDepression",
        "NeedsMoreSleep",
    }

    local isInDepression = player:HasTrait("BipolarDepression")
    print('isInDepression: '..tostring(isInDepression))
    -- if depressed switch to positive
    ApplyPositiveOrNegativeTraitsGivenACondition(isInDepression, positives, negatives)

    player:Say(not player:HasTrait("BipolarDepression") and "I feel unstoppable" or "I feel terrible")
end

ProfessionFramework.addTrait('Bipolar', {
    name = "UI_trait_Bipolar",
    description = "UI_trait_Bipolardesc",
    icon = "trait_Bipolar",
    cost = -7,
    exclude = {
        "NeedsLessSleep",
        "NeedsMoreSleep",
    },
    OnNewGame = function(player, square, profession)
        Bipolar_Init()
    end,
    OnGameStart = function(trait)
        -- add a new event to trigger every ten minutes
        Events.EveryDays.Add(function()
            Bipolar_Init()
        end)
    end
})

ProfessionFramework.addTrait('BipolarMania', {
    name = "UI_trait_BipolarMania",
    description = "UI_trait_BipolarManiadesc",
    icon = "trait_BipolarMania",
    cost = 0,
    profession = true,
    exclude = {
        
    },
})

ProfessionFramework.addTrait('BipolarDepression', {
    name = "UI_trait_BipolarDepression",
    description = "UI_trait_BipolarDepressiondesc",
    icon = "trait_BipolarDepression",
    cost = 0,
    profession = true,
    exclude = {

    },
})

local function initBipolarTrait(player)
    local playerdata = player:getModData();
    playerdata.bipolarEnduranceTicks = 10;
end

local function onPlayerUpdate(player)
    if not player:HasTrait("Bipolar") then
        return
    end

    -- Bipolar Sadness
    local stats = player:getStats();
    local playerdata = player:getModData();
    local isInDepression = player:HasTrait("BipolarDepression")
    local unhappyness = player:getBodyDamage():getUnhappynessLevel()
    local unhappynessChange = isInDepression and 0.002 or -0.004
    local hasUnhappynessToChange = (isInDepression and unhappyness <= 60) or (not isInDepression and unhappyness >= 20) 
    if hasUnhappynessToChange then
        player:getBodyDamage():setUnhappynessLevel(unhappyness + unhappynessChange);
    end
    
    -- Bipolar Stress
    local stress = stats:getStress() or 0
    local stressChange = isInDepression and 0.001 or -0.001
    local hasStressToChange = (isInDepression and stress <= 0.26) or (not isInDepression and stress >= 0.5) 
    if hasStressToChange then
        stats:setStress(stress + stressChange);
    end

    -- Bipolar Endurance 
    local endurance = stats:getEndurance();
    local enduranceChange = isInDepression and -0.001 or 0.0016;

    if playerdata.bipolarEnduranceTicks == nil then
        playerdata.bipolarEnduranceTicks = 0;
    end

    local tick = playerdata.bipolarEnduranceTicks;
    if tick <= 0 then
        -- print(isInDepression and 'Bipolar Endurance Losss' or 'Bipolar Endurance Regen')
        stats:setEndurance(endurance + enduranceChange);
        playerdata.bipolarEnduranceTicks = 1000;
    else
        if player:isSprinting() then
            playerdata.bipolarEnduranceTicks = tick - 4;
        elseif player:IsRunning() then
            playerdata.bipolarEnduranceTicks = tick - 10;
        elseif player:getCurrentState() == FitnessState.instance() then
            playerdata.bipolarEnduranceTicks = tick - 10;
        else
            playerdata.bipolarEnduranceTicks = tick - 5;
        end
    end
end

Events.OnPlayerUpdate.Add(onPlayerUpdate);
Events.OnNewGame.Add(initBipolarTrait);
