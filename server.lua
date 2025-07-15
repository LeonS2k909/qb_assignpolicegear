local QBCore = exports['qb-core']:GetCoreObject()

-- Give gear when QBCore updates a player's job (server-side)
RegisterNetEvent('QBCore:Server:OnJobUpdate', function(source, job)
    if not job or job.name ~= 'police' then return end
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return end

    -- Weapon names must match your qb-inventory keys
    local items = {
        "weapon_stungun",
        "weapon_appistol",
        "radio",
        "handcuffs",
    }

    for _, item in ipairs(items) do
        Player.Functions.AddItem(item, 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[item], 'add')
    end

    -- You can still log or notify the player here if you want
    print(("[qb-assignpolicegear] Gave gear to %s"):format(Player.PlayerData.name))
end)
