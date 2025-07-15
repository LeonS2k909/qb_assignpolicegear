local QBCore = exports['qb-core']:GetCoreObject()

-- Define police uniform
local policeUniform = {
    outfitData = {
        ["pants"] = { item = 24, texture = 0 },
        ["arms"] = { item = 19, texture = 0 },
        ["t-shirt"] = { item = 58, texture = 0 },
        ["vest"] = { item = 0, texture = 0 },
        ["torso2"] = { item = 55, texture = 0 },
        ["shoes"] = { item = 51, texture = 0 },
        ["accessory"] = { item = 0, texture = 0 },
        ["bag"] = { item = 0, texture = 0 },
        ["hat"] = { item = -1, texture = -1 },
        ["glass"] = { item = 0, texture = 0 },
        ["mask"] = { item = 0, texture = 0 }
    }
}

RegisterNetEvent('QBCore:Server:OnJobUpdate', function(source, job)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player or job.name ~= "police" then return end

    -- Give items
    Player.Functions.AddItem("WEAPON_STUNGUN", 1)
    Player.Functions.AddItem("WEAPON_APPISTOL", 1)
    Player.Functions.AddItem("radio", 1)
    Player.Functions.AddItem("handcuffs", 1)

    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["WEAPON_STUNGUN"], "add")
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["WEAPON_APPISTOL"], "add")
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["radio"], "add")
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["handcuffs"], "add")

    -- Send uniform to client
    TriggerClientEvent('qb-assigngear:client:applyPoliceUniform', source, policeUniform)
end)
