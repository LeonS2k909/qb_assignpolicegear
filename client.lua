local QBCore = exports['qb-core']:GetCoreObject()

local PoliceOutfits = {
    male = {
        ["t-shirt"]     = { item = 15, texture = 0 },
        ["torso2"]      = { item = 55, texture = 0 },
        ["arms"]        = { item = 17, texture = 0 },
        ["pants"]       = { item = 52, texture = 0 },
        ["shoes"]       = { item = 25, texture = 0 },
        ["accessory"]   = { item = 0, texture = 0 },
        ["bag"]         = { item = 0, texture = 0 },
        ["hat"]         = { item = 46, texture = 0 },
    },
    female = {
        ["t-shirt"]     = { item = 3, texture = 0 },
        ["torso2"]      = { item = 48, texture = 0 },
        ["arms"]        = { item = 14, texture = 0 },
        ["pants"]       = { item = 34, texture = 0 },
        ["shoes"]       = { item = 27, texture = 0 },
        ["accessory"]   = { item = 0, texture = 0 },
        ["bag"]         = { item = 0, texture = 0 },
        ["hat"]         = { item = 45, texture = 0 },
    }
}

local function ApplyPoliceClothes()
    local ped = PlayerPedId()
    local gender = IsPedModel(ped, `mp_m_freemode_01`) and "male" or "female"
    local outfit = PoliceOutfits[gender]
    if not outfit then return end

    -- Wrap in loadOutfit2 to support table and safety checks
    TriggerEvent('qb-clothing:client:loadOutfit2', { outfitData = outfit, outfitName = "police" })
end

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job)
    if job.name == "police" then ApplyPoliceClothes() end
end)

CreateThread(function()
    while not QBCore.Functions.GetPlayerData().job do Wait(100) end
    if QBCore.Functions.GetPlayerData().job.name == "police" then ApplyPoliceClothes() end
end)
