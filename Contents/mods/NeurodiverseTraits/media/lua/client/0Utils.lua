-- File renamed to 0Utils.lua so it loads before all the other files, 
-- and this allows me to use MxAppendTables otherwise it would not be defined

function GetRandomPerkExceptPassivAndAgility()
    local perk = nil
    repeat
        local rand = ZombRand(Perks.getMaxIndex())
        local _perk = PerkFactory.getPerk(Perks.fromIndex(rand));
        local parent = _perk:getParent()
        if _perk and parent ~= Perks.None and parent ~= Perks.Passiv and parent ~= Perks.Agility then
            perk = _perk
        end
    until (perk ~= nil)
    return perk
end

function MxAppendTables(t1, t2)
    local t = {unpack(t1)}

    for _,v in ipairs(t2) do 
        table.insert(t, v)
    end

    return t
end


-- Cooking (Crafting)
-- Fitness (Passive)
-- Strength (Passive)
-- Long Blunt (Combat)
-- Axe (Combat)
-- Sprinting (Agility)
-- Lightfooted (Agility)
-- Nimble (Agility)
-- Sneaking (Agility)
-- Carpentry (Crafting)
-- Aiming (Firearm)
-- Reloading (Firearm)
-- Farming (Crafting)
-- Fishing (Survivalist)
-- Trapping (Survivalist)
-- Foraging (Survivalist)
-- First Aid (Crafting)
-- Electrical (Crafting)
-- Metalworking (Crafting)
-- Mechanics (Crafting)
-- Spear (Combat)
-- Maintenance (Combat)
-- Short Blade (Combat)
-- Long Blade (Combat)
-- Short Blunt (Combat)
-- Tailoring (Crafting)