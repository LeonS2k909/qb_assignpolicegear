-- server.lua for qb_assignpolicegear

local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent("qb-assignpolicegear:server:GivePoliceItems", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    -- Define police gear items
    local items = {
        { name = "weapon_stungun", amount = 1 },
        { name = "handcuffs", amount = 1 },
        { name = "weapon_appistol", amount = 1 },
        { name = "radio", amount = 1 },
    }

    for _, item in pairs(items) do
        if not Player.Functions.GetItemByName(item.name) then
            local added = Player.Functions.AddItem(item.name, item.amount)
            if added then
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item.name], "add")
            else
                print("[DEBUG] Failed to add item: " .. item.name)
            end
        else
            print("[DEBUG] Player already has: " .. item.name)
        end
    end
end)
