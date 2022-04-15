require "Items/Distributions"
require "Items/ProceduralDistributions"

local i;

local myDistTable = {
    "NeuroTraits.PillsRitalarr", 20,
}
local function insertTable(gameList, mylist)
    local n = #gameList
    for i = 1, #mylist do
        gameList[n + i] = mylist[i]
    end
end

insertTable(ProceduralDistributions["list"]["ArmyStorageMedical"].items, myDistTable)
insertTable(ProceduralDistributions["list"]["BathroomCabinet"].items, myDistTable)
insertTable(ProceduralDistributions["list"]["BathroomCounter"].items, myDistTable)
insertTable(ProceduralDistributions["list"]["MedicalClinicDrugs"].items, myDistTable)
insertTable(ProceduralDistributions["list"]["MedicalClinicDrugs"].items, myDistTable)
insertTable(ProceduralDistributions["list"]["MedicalClinicTools"].items, myDistTable)
insertTable(ProceduralDistributions["list"]["MedicalStorageDrugs"].items, myDistTable)
insertTable(ProceduralDistributions["list"]["MedicalStorageDrugs"].items, myDistTable)
insertTable(ProceduralDistributions["list"]["SafehouseMedical"].items, myDistTable)
insertTable(ProceduralDistributions["list"]["StoreShelfMedical"].items, myDistTable)

insertTable(ProceduralDistributions["list"]["OfficeDeskHome"].junk.items, myDistTable)
-- insertTable(ProceduralDistributions["list"]["PrisonCellRandom"].junk.items, myDistTable)
