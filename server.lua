-- server.lua for qb_assignpolicegear

local QBCore = exports['qb-core']:GetCoreObject()
local inv    = exports['qb-inventory']

-- Check true inventory table for items
local function PlayerHasItem(player, itemName)
    for _, item in ipairs(player.PlayerData.items or {}) do
        if item.name == itemName and item.amount > 0 then
            return true
        end
    end
    return false
end

-- Check inventory + loadout for weapons
local function HasWeapon(player, weaponName)
    if PlayerHasItem(player, weaponName) then
        return true
    end
    for _, w in pairs(player.PlayerData.loadout or {}) do
        if w.name == weaponName then
            return true
        end
    end
    return false
end

RegisterNetEvent('qb-assignpolicegear:server:GivePoliceItems', function()
    local src    = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player or Player.PlayerData.job.name ~= 'police' then
        return
    end

    -- 1) Regular ITEMS
    for _, name in ipairs({
        "handcuffs",
        "radio",
        "armor",        -- body armor vest
        "firstaidkit",  -- health kit
        "binoculars"    -- observation
    }) do
        if not PlayerHasItem(Player, name) then
            inv:AddItem(src, name, 1)
        end
    end

    -- 2) WEAPONS
    for _, w in ipairs({
        {name = "weapon_stungun",   ammo = 50},
        {name = "weapon_appistol",  ammo = 50},
        {name = "weapon_nightstick"},
        {name = "weapon_flashlight"}
    }) do
        if not HasWeapon(Player, w.name) then
            -- if w.ammo is nil, metadata table is omitted
            if w.ammo then
                inv:AddItem(src, w.name, 1, false, { ammo = w.ammo })
            else
                inv:AddItem(src, w.name, 1)
            end
        end
    end
end)
