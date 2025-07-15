-- server.lua for qb_assignpolicegear

local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('qb-assignpolicegear:server:GivePoliceItems', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player and Player.PlayerData.job.name == "police" then
        local items = {
            { name = "weapon_appistol", amount = 1 },
            { name = "weapon_stungun", amount = 1 },
            { name = "handcuffs", amount = 1 },
            { name = "radio", amount = 1 }
        }

        for _, item in pairs(items) do
            if not Player.Functions.GetItemByName(item.name) then
                Player.Functions.AddItem(item.name, item.amount)
            end
        end
    else
        print(("[qb-assignpolicegear] WARNING: Player %s tried to request police items without being police."):format(src))
    end
end)
