local function Alzheimer_Init()
    local player = getSpecificPlayer(0)

    local perks = {}

    for i=0, Perks.getMaxIndex() - 1 do
        local perk = PerkFactory.getPerk(Perks.fromIndex(i));
        local parent = perk:getParent()
        local isNotPassiveOrAgility = parent ~= Perks.None and parent ~= Perks.Passiv and parent ~= Perks.Agility
        local currentXp = player:getXp():getXP(perk)
        local info = player:getPerkInfo(perk)
        local level = info and info:getLevel() or 0
        -- local isPotentialLevelLoss = currentXp < PerkFactory.getPerk(perk):getTotalXpForLevel(level)
        local xpToLose = perk:getXpForLevel(level + 1) * 0.025
        if ZombRand(2) == 0 and perk and isNotPassiveOrAgility and currentXp > 0 and level > 0 then
            player:getXp():AddXP(perk, -math.max(xpToLose, 0));
            xpUpdate.checkForLosingLevel(player, perk)
            table.insert(perks, perk:getName())
        end
    end

    if #perks == 0 then
        return
    end

    player:Say("I don't remember...");
end

ProfessionFramework.addTrait('Alzheimer', {
    name = "UI_trait_Alzheimer",
    description = "UI_trait_Alzheimerdesc",
    icon = "trait_Alzheimer",
    cost = -18,
    exclude = {

    },
    OnNewGame = function (player, square, profession)
        Alzheimer_Init()
    end,
    OnGameStart = function(trait)
        -- add a new event to trigger every ten minutes
        Events.EveryDays.Add(function()
            Alzheimer_Init()
        end)
    end
})
