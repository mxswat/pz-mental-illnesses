ADHDCore = {}
ADHDCore.init = function ()
    local player = getSpecificPlayer(0)
    local days_survived = player:getHoursSurvived() / 24
    local starting_chance = player:HasTrait("Lucky") and 40 or 35
    local chance_of_focus = math.min((days_survived * 0.5) + starting_chance, 70)
    local roll = ZombRand(100) + 1
    local is_in_hyperfocus = roll <= chance_of_focus

    ADHDCore.applyEffect(is_in_hyperfocus)

    -- Maybe TODO: IN hyperfoucs makes action faster, BUT disable the ability to interrupt them, EG: Reading a book, cutting down tree etc
    player:Say(is_in_hyperfocus and "I feel focused" or "I don't feel focused")
end

local positives = {
    "FastLearner",
    "FastReader",
    "Organized",
    "Dextrous"
}

local negatives = {
    "SlowLearner",
    "SlowReader",
    "Disorganized",
    "AllThumbs"
}

local traits = MxAppendTables(positives, negatives)

ADHDCore.applyEffect = function (is_in_hyperfocus)
    ApplyPositiveOrNegativeTraitsGivenACondition(is_in_hyperfocus, positives, negatives)
end

ADHDCore.applyMedication = function ()
    local player = getSpecificPlayer(0)
    if player:HasTrait("ADHD") then
        RemoveTraits(positives)
        RemoveTraits(negatives)
        player:Say("I feel quite balanced")
    end
end

ProfessionFramework.addTrait('ADHD', {
    name = "UI_trait_ADHD",
    description = "UI_trait_ADHDdesc",
    icon = "trait_ADHD",
    cost = -7,
    exclude = traits,
    OnNewGame = function (player, square, profession)
        ADHDCore.init()
        player:getInventory():AddItem("NeuroTraits.PillsAdderal");
    end,
    OnGameStart = function(trait)
        -- add a new event to trigger every ten minutes
        Events.EveryDays.Add(function()
            ADHDCore.init()
        end)
    end
})