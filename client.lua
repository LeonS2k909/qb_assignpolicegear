-- Script to apply police outfit using qb-clothing correctly
local QBCore = exports['qb-core']:GetCoreObject()

local cachedClothing = nil -- store civilian outfit before police gear
local currentJob = nil

-- Save current outfit for restoring later
local function CacheCurrentOutfit()
    TriggerEvent('qb-clothing:client:saveOutfit', function(success)
        if success then
            TriggerEvent('qb-clothing:client:getOutfit', function(outfit)
                cachedClothing = outfit
                print("[DEBUG] Civilian outfit cached.")
            end)
        else
            print("[DEBUG] Failed to save outfit before caching.")
        end
    end)
end

-- Restore cached civilian outfit
local function RestoreCivilianOutfit()
    if cachedClothing then
        print("[DEBUG] Restoring cached civilian outfit.")
        TriggerEvent('qb-clothing:client:loadOutfit', cachedClothing)
    else
        print("[DEBUG] No cached outfit to restore.")
    end
end

-- Apply police outfit using proper slot keys
local function ApplyPoliceUniform()
    local playerPed = PlayerPedId()
    local gender = IsPedMale(playerPed) and "male" or "female"

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

-- Check ped model for gender detection
function IsPedMale(ped)
    local model = GetEntityModel(ped)
    return model == GetHashKey("mp_m_freemode_01")
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
    elseif currentJob == 'police' and job.name ~= 'police' then
        -- Player left police job
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
    end
end)
