-- server.lua for qb_assignpolicegear

local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('qb-assignpolicegear:server:GivePoliceItems', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player and Player.PlayerData.job.name == 'police' then
        Player.Functions.AddItem("weapon_stungun", 1)
        Player.Functions.AddItem("handcuffs", 1)
        Player.Functions.AddItem("weapon_appistol", 1)
        Player.Functions.AddItem("radio", 1)
    end
end)
