local QBCore = exports['qb-core']:GetCoreObject()
local inv    = exports['qb-inventory']

-- Reads the player’s actual inventory table
local function PlayerHasItem(player, itemName)
    for _, item in ipairs(player.PlayerData.items or {}) do
        if item.name == itemName and item.amount > 0 then
            return true
        end
    end
    return false
end

-- Checks if player already has a weapon (inventory or loadout)
local function HasWeapon(player, weaponName)
    if PlayerHasItem(player, weaponName) then return true end
    for _, w in pairs(player.PlayerData.loadout or {}) do
        if w.name == weaponName then return true end
    end
    return false
end

-- Give police gear (only missing items/weapons)
RegisterNetEvent('qb-assignpolicegear:server:GivePoliceItems', function()
    local src    = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player or Player.PlayerData.job.name ~= 'police' then return end

    -- ITEMS
    for _, name in ipairs({
        "handcuffs", "radio", "armor", "firstaidkit", "binoculars"
    }) do
        if not PlayerHasItem(Player, name) then
            inv:AddItem(src, name, 1)
        end
    end

    -- WEAPONS
    for _, w in ipairs({
        {name = "weapon_stungun",   ammo = 50},
        {name = "weapon_appistol",  ammo = 50},
        {name = "weapon_nightstick"},
        {name = "weapon_flashlight"}
    }) do
        if not HasWeapon(Player, w.name) then
            if w.ammo then
                inv:AddItem(src, w.name, 1, false, { ammo = w.ammo })
            else
                inv:AddItem(src, w.name, 1)
            end
        end
    end
end)

-- Remove police gear when leaving police job
RegisterNetEvent('qb-assignpolicegear:server:RemovePoliceItems', function()
    local src    = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    -- ITEMS
    for _, name in ipairs({
        "handcuffs", "radio", "armor", "firstaidkit", "binoculars"
    }) do
        if PlayerHasItem(Player, name) then
            inv:RemoveItem(src, name, 1)
        end
    end

    -- WEAPONS: remove all entries regardless of inventory check
    for _, weaponName in ipairs({
        "weapon_stungun",
        "weapon_appistol",
        "weapon_nightstick",
        "weapon_flashlight"
    }) do
        inv:RemoveItem(src, weaponName, 1)
    end

    -- also unequip all police weapons client-side
    TriggerClientEvent('qb-assignpolicegear:client:RemovePoliceWeapons', src)
end)