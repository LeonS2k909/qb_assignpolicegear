local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent("qb-assignpolicegear:server:GivePoliceItems", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    -- Define police gear
    local items = {
        { name = "weapon_stungun", amount = 1 },
        { name = "handcuffs", amount = 1 },
        { name = "weapon_appistol", amount = 1 },
        { name = "radio", amount = 1 },
    }

    for _, item in pairs(items) do
        if not Player.Functions.GetItemByName(item.name) then
            Player.Functions.AddItem(item.name, item.amount)
        end
    end
end)
