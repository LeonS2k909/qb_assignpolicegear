local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('qb-assigngear:client:applyPoliceUniform', function(data)
    if data and data.outfitData then
        TriggerEvent('qb-clothing:client:loadOutfit', data)
        print("✅ Police uniform applied")
    else
        print("❌ Outfit data missing or malformed")
    end
end)
