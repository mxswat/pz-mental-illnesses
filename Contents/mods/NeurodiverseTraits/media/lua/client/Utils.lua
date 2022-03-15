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