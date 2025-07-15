local QBCore = exports['qb-core']:GetCoreObject()

-- Define your police uniform exactly as qb-clothing expects
local policeUniform = {
    outfitData = {
        ["pants"]     = { item = 24, texture = 0 },
        ["arms"]      = { item = 19, texture = 0 },
        ["t-shirt"]   = { item = 58, texture = 0 },
        ["vest"]      = { item = 0,  texture = 0 },
        ["torso2"]    = { item = 55, texture = 0 },
        ["shoes"]     = { item = 51, texture = 0 },
        ["accessory"] = { item = 0,  texture = 0 },
        ["bag"]       = { item = 0,  texture = 0 },
        ["hat"]       = { item = -1, texture = -1 },
        ["glass"]     = { item = 0,  texture = 0 },
        ["mask"]      = { item = 0,  texture = 0 },
    }
}

-- Listen for the client-side job update (this fires AFTER player data is in the client)
RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job)
    if job and job.name == 'police' then
        -- Load the uniform into qb-clothing
        TriggerEvent('qb-clothing:client:loadOutfit', policeUniform)
        QBCore.Functions.Notify('Police uniform applied', 'success')
        print('[qb-assignpolicegear] Police uniform loaded')
    end
end)
