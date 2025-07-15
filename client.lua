local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('qb-assigngear:client:applyPoliceUniform', function(outfit)
    if outfit and outfit.outfitData then
        TriggerEvent('qb-clothing:client:loadOutfit', outfit)
        print("✅ Police uniform applied")
    else
        print("❌ Outfit data missing or malformed")
    end
end)
