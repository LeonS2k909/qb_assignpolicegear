-- Script to apply police outfit using qb-clothing correctly and give police gear
local QBCore = exports['qb-core']:GetCoreObject()

local cachedClothing = nil -- store civilian outfit before police gear
local currentJob = nil

-- Save current outfit for restoring later
local function CacheCurrentOutfit()
    local ped = PlayerPedId()
    cachedClothing = {
        outfitData = {
            ['pants']     = {item = GetPedDrawableVariation(ped, 4), texture = GetPedTextureVariation(ped, 4)},
            ['arms']      = {item = GetPedDrawableVariation(ped, 3), texture = GetPedTextureVariation(ped, 3)},
            ['t-shirt']   = {item = GetPedDrawableVariation(ped, 8), texture = GetPedTextureVariation(ped, 8)},
            ['vest']      = {item = GetPedDrawableVariation(ped, 9), texture = GetPedTextureVariation(ped, 9)},
            ['torso2']    = {item = GetPedDrawableVariation(ped, 11), texture = GetPedTextureVariation(ped, 11)},
            ['shoes']     = {item = GetPedDrawableVariation(ped, 6), texture = GetPedTextureVariation(ped, 6)},
            ['accessory'] = {item = GetPedDrawableVariation(ped, 7), texture = GetPedTextureVariation(ped, 7)},
            ['bag']       = {item = GetPedDrawableVariation(ped, 5), texture = GetPedTextureVariation(ped, 5)},
            ['hat']       = {item = GetPedPropIndex(ped, 0), texture = GetPedPropTextureIndex(ped, 0)},
            ['glass']     = {item = GetPedPropIndex(ped, 1), texture = GetPedPropTextureIndex(ped, 1)},
            ['mask']      = {item = GetPedDrawableVariation(ped, 1), texture = GetPedTextureVariation(ped, 1)}
        }
    }
    print("[DEBUG] Civilian outfit cached via ped values.")
end

-- Restore cached civilian outfit
local function RestoreCivilianOutfit()
    if cachedClothing and cachedClothing.outfitData then
        print("[DEBUG] Restoring cached civilian outfit.")
        TriggerEvent('qb-clothing:client:loadOutfit', cachedClothing)
    else
        print("[DEBUG] No cached outfit to restore.")
    end
end

-- Apply police outfit using proper slot keys
local function ApplyPoliceUniform()
    local outfit = {
        outfitData = {
            ['pants']     = {texture = 0, item = 24, defaultItem = 0, defaultTexture = 0},
            ['arms']      = {item = 19, texture = 0, defaultItem = 0, defaultTexture = 0},
            ['t-shirt']   = {item = 58, texture = 0, defaultItem = 0, defaultTexture = 0},
            ['vest']      = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0},
            ['torso2']    = {item = 55, texture = 0, defaultItem = 0, defaultTexture = 0},
            ['shoes']     = {item = 51, texture = 0, defaultItem = 0, defaultTexture = 0},
            ['accessory'] = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0},
            ['bag']       = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0},
            ['hat']       = {item = -1, texture = -1, defaultItem = 0, defaultTexture = 0},
            ['glass']     = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0},
            ['mask']      = {item = 0, texture = 0, defaultItem = 0, defaultTexture = 0}
        }
    }

    TriggerEvent('qb-clothing:client:loadOutfit', outfit)
end

-- Give police items from server
local function GivePoliceItems()
    TriggerServerEvent("qb-assignpolicegear:server:GivePoliceItems")
end

-- Apply or revert outfits based on job
RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job)
    if currentJob == nil then
        currentJob = job.name
    end

    if job.name == 'police' then
        CacheCurrentOutfit()
        Wait(1000)
        ApplyPoliceUniform()
        GivePoliceItems()
    elseif currentJob == 'police' and job.name ~= 'police' then
        Wait(1000)
        RestoreCivilianOutfit()
    end

    currentJob = job.name
end)

-- Apply if already police on load
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    local Player = QBCore.Functions.GetPlayerData()
    currentJob = Player.job.name

    if currentJob == 'police' then
        CacheCurrentOutfit()
        Wait(1000)
        ApplyPoliceUniform()
        GivePoliceItems()
    end
end)