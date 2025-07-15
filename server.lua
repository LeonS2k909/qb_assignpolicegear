local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('qb-policejob:server:OnJobUpdate', function(job)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player and job.name == "police" then
        Player.Functions.AddItem("weapon_stungun", 1)
        Player.Functions.AddItem("weapon_appistol", 1)
        Player.Functions.AddItem("radio", 1)
        Player.Functions.AddItem("handcuffs", 1)

        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["weapon_stungun"], "add")
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["weapon_appistol"], "add")
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["radio"], "add")
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["handcuffs"], "add")
    end
end)
