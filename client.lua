-- client.lua for qb_assignpolicegear

local QBCore = exports['qb-core']:GetCoreObject()

local cachedOutfit = nil
local currentJob = nil

-- Save the current outfit
local function CacheOutfit()
    TriggerEvent('qb-clothing:client:getOutfit', function(outfit)
        cachedOutfit = outfit
        print("[DEBUG] Outfit cached.")
    end)
end

-- Apply police clothing
local function ApplyPoliceUniform()
    local uniform = {
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

    TriggerEvent('qb-clothing:client:loadOutfit', uniform)
end

-- Restore cached outfit
local function RestoreOutfit()
    if cachedOutfit then
        TriggerEvent('qb-clothing:client:loadOutfit', cachedOutfit)
        print("[DEBUG] Outfit restored.")
    else
        print("[DEBUG] No cached outfit to restore.")
    end
end

-- Give police gear from server
local function GivePoliceItems()
    TriggerServerEvent("qb-assignpolicegear:server:GivePoliceItems")
end

-- Handle job change
RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job)
    if currentJob == nil then
        currentJob = job.name
    end

    if job.name == "police" then
        CacheOutfit()
        Wait(1000)
        ApplyPoliceUniform()
        GivePoliceItems()
    elseif currentJob == "police" and job.name ~= "police" then
        Wait(1000)
        RestoreOutfit()
    end

    currentJob = job.name
end)

-- Apply on login if police
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    local Player = QBCore.Functions.GetPlayerData()
    currentJob = Player.job.name

    if currentJob == 'police' then
        CacheOutfit()
        Wait(1000)
        ApplyPoliceUniform()
        GivePoliceItems()
    end
end)
