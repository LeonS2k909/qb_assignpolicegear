local QBCore = exports['qb-core']:GetCoreObject()

local cachedClothing = nil
local currentJob     = nil

-- Save civilian outfit to restore when off-duty
local function CacheCurrentOutfit()
    local ped = PlayerPedId()
    cachedClothing = {
        outfitData = {
            ['pants']     = {item = GetPedDrawableVariation(ped, 4), texture = GetPedTextureVariation(ped, 4)},
            ['arms']      = {item = GetPedDrawableVariation(ped, 3), texture = GetPedTextureVariation(ped, 3)},
            ['t-shirt']   = {item = GetPedDrawableVariation(ped, 8), texture = GetPedTextureVariation(ped, 8)},
            ['vest']      = {item = GetPedDrawableVariation(ped, 9), texture = GetPedTextureVariation(ped, 9)},
            ['torso2']    = {item = GetPedDrawableVariation(ped,11), texture = GetPedTextureVariation(ped,11)},
            ['shoes']     = {item = GetPedDrawableVariation(ped, 6), texture = GetPedTextureVariation(ped, 6)},
            ['accessory'] = {item = GetPedDrawableVariation(ped, 7), texture = GetPedTextureVariation(ped, 7)},
            ['bag']       = {item = GetPedDrawableVariation(ped, 5), texture = GetPedTextureVariation(ped, 5)},
            ['hat']       = {item = GetPedPropIndex(ped, 0), texture = GetPedPropTextureIndex(ped, 0)},
            ['glass']     = {item = GetPedPropIndex(ped, 1), texture = GetPedPropTextureIndex(ped, 1)},
            ['mask']      = {item = GetPedDrawableVariation(ped, 1), texture = GetPedTextureVariation(ped, 1)},
        }
    }
end

-- Restore player's civilian outfit
local function RestoreCivilianOutfit()
    if cachedClothing and cachedClothing.outfitData then
        TriggerEvent('qb-clothing:client:loadOutfit', cachedClothing)
    end
end

-- Apply police uniform
local function ApplyPoliceUniform()
    local outfit = {
        outfitData = {
            ['pants']     = {item = 24, texture = 0},
            ['arms']      = {item = 19, texture = 0},
            ['t-shirt']   = {item = 58, texture = 0},
            ['vest']      = {item = 0,  texture = 0},
            ['torso2']    = {item = 55, texture = 0},
            ['shoes']     = {item = 51, texture = 0},
            ['accessory'] = {item = 0,  texture = 0},
            ['bag']       = {item = 0,  texture = 0},
            ['hat']       = {item = -1, texture = -1},
            ['glass']     = {item = 0,  texture = 0},
            ['mask']      = {item = 0,  texture = 0},
        }
    }
    TriggerEvent('qb-clothing:client:loadOutfit', outfit)
end

-- Trigger server give/remove events
local function GivePoliceItems()
    TriggerServerEvent('qb-assignpolicegear:server:GivePoliceItems')
end
local function RemovePoliceItems()
    TriggerServerEvent('qb-assignpolicegear:server:RemovePoliceItems')
end

-- Strip weapons on client
RegisterNetEvent('qb-assignpolicegear:client:RemovePoliceWeapons', function()
    local ped = PlayerPedId()
    for _, w in ipairs({
        "weapon_stungun",
        "weapon_appistol",
        "weapon_nightstick",
        "weapon_flashlight"
    }) do
        RemoveWeaponFromPed(ped, GetHashKey(w))
    end
end)

-- Handle job updates
RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job)
    if currentJob == nil then currentJob = job.name end

    if job.name == 'police' then
        CacheCurrentOutfit()
        Wait(1000)
        ApplyPoliceUniform()
        GivePoliceItems()
    elseif currentJob == 'police' and job.name ~= 'police' then
        RemovePoliceItems()
        Wait(1000)
        RestoreCivilianOutfit()
    end

    currentJob = job.name
end)

-- On player load, apply if already police
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    local data = QBCore.Functions.GetPlayerData()
    currentJob = data.job.name
    if currentJob == 'police' then
        CacheCurrentOutfit()
        Wait(1000)
        ApplyPoliceUniform()
        GivePoliceItems()
    end
end)
