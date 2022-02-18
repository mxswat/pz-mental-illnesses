-- count_hyperfocus = 0
-- count_hypofocus = 0

local function ADHD_Init()
    local player = getSpecificPlayer(0)
    local days_survived = player:getHoursSurvived() / 24
    -- TODO: Add lucky/unlucky effect to chance?
    local starting_chance = 35
    local chance_of_focus = math.min((days_survived * 0.5) + starting_chance, 70)
    local roll = ZombRand(100) + 1
    local is_in_hyperfocus = roll <= chance_of_focus

    -- Init by removing all traits that you gain with ADHD
    local positives = {
        "FastLearner",
        "FastReader",
        "NeedsLessSleep",
        "Dextrous"
    }

    local negatives = {
        "SlowLearner",
        "SlowReader",
        "NeedsMoreSleep",
        "AllThumbs"
    }

    ApplyPositiveOrNegativeTraitsGivenACondition(is_in_hyperfocus, positives, negatives)

    print('chance_of_focus: '..tostring(chance_of_focus)..' Rolled: '..tostring(roll))
    print('is_in_hyperfocus: '..tostring(is_in_hyperfocus))
    print('days_survived'..days_survived)
    -- print('count_hypofocus: '..count_hypofocus..' count_hyperfocus: '..count_hyperfocus)
    player:Say(is_in_hyperfocus and "I feel focused" or "I don't feel focused")
end

ProfessionFramework.addTrait('ADHD', {
    name = "UI_trait_ADHD",
    description = "UI_trait_ADHDdesc",
    icon = "trait_ADHD",
    cost = -7,
    exclude = {
        "FastLearner",
        "FastReader",
        "NeedsLessSleep",
        "SlowLearner",
        "SlowReader",
        "NeedsMoreSleep",
        "Dextrous",
        "AllThumbs",
    },
    OnNewGame = function (player, square, profession)
        ADHD_Init()
    end,
    OnGameStart = function(trait)
        -- add a new event to trigger every ten minutes
        Events.EveryDays.Add(function()
            ADHD_Init()
        end)
    end
})
