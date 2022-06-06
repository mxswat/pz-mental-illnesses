local skipFirst = true

local function Tourette_Init()
    local player = getSpecificPlayer(0)
    if not player or not player:HasTrait("Tourette") then
        return
    end

    if skipFirst then
        skipFirst = false
        return
    end

    local roll = ZombRand(100) + 1
    local vehicle = player:getVehicle()
    local weapon = player:getPrimaryHandItem()
    local stats = player:getStats();
    local panic = stats:getPanic();
    local days_survived = player:getHoursSurvived() / 24
    local breakPoint = (15 * (1 + panic)) - math.max(days_survived * 0.18, 5)

    if roll < breakPoint then
        if vehicle and vehicle:isDriver(player) then
            ISVehicleMenu.onHorn(player)
            return
		end
        if (ZombRand(100) + 1) > 50 then
            player:Callout()
            return
        end
        if not (player:isDoShove() or player:isSprinting() or player:IsRunning()) then
            if weapon then
                if weapon:isRanged() then
                    if ISReloadWeaponAction.canRack(weapon) then
                        -- Rack the gun
                        triggerEvent("OnPressRackButton", player, weapon)  
                    else
                        -- Reload the gun
                        triggerEvent("OnPressReloadButton", player, weapon)  
                    end
                else
                    -- Swing melee
                    player:AttemptAttack()
                end
            else
                -- do shove
                player:DoAttack(0, true, "")
            end
        end
    end
end

ProfessionFramework.addTrait('Tourette', {
    name = "UI_trait_Tourette",
    description = "UI_trait_Tourettedesc",
    icon = "trait_Tourette",
    cost = -10,
    exclude = {

    },
    OnNewGame = function (player, square, profession)
        -- Tourette_Init()
        -- not required
    end,
    OnGameStart = function(trait)
        -- add a new event to trigger every hour
        Events.EveryTenMinutes.Add(function()
            Tourette_Init()
        end)
    end
})