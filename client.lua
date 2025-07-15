local QBCore = exports['qb-core']:GetCoreObject()

-- Define police outfits: ensure correct key names
local PoliceOutfits = {
    male = {
        ["pants"]     = { item = 24, texture = 0 },
        ["arms"]      = { item = 17, texture = 0 },
        ["t-shirt"]   = { item = 15, texture = 0 },
        ["vest"]      = { item = 0, texture = 0 },
        ["torso2"]    = { item = 55, texture = 0 },
        ["shoes"]     = { item = 25, texture = 0 },
        ["bag"]       = { item = 0, texture = 0 },
        ["decals"]    = { item = 0, texture = 0 },
        ["accessory"] = { item = 0, texture = 0 },
        ["mask"]      = { item = 0, texture = 0 },
        ["hat"]       = { item = 46, texture = 0 },
        ["glass"]     = { item = 0, texture = 0 },
        ["ear"]       = { item = 0, texture = 0 },
        ["watch"]     = { item = 0, texture = 0 },
        ["bracelet"]  = { item = 0, texture = 0 },
    },
    female = {
        ["pants"]     = { item = 34, texture = 0 },
        ["arms"]      = { item = 14, texture = 0 },
        ["t-shirt"]   = { item = 3, texture = 0 },
        ["vest"]      = { item = 0, texture = 0 },
        ["torso2"]    = { item = 48, texture = 0 },
        ["shoes"]     = { item = 27, texture = 0 },
        ["bag"]       = { item = 0, texture = 0 },
        ["decals"]    = { item = 0, texture = 0 },
        ["accessory"] = { item = 0, texture = 0 },
        ["mask"]      = { item = 0, texture = 0 },
        ["hat"]       = { item = 45, texture = 0 },
        ["glass"]     = { item = 0, texture = 0 },
        ["ear"]       = { item = 0, texture = 0 },
        ["watch"]     = { item = 0, texture = 0 },
        ["bracelet"]  = { item = 0, texture = 0 },
    }
}

-- Function to apply outfit
local function ApplyPoliceClothes()
    local ped = PlayerPedId()
    local data = QBCore.Functions.GetPlayerData()
    local gender = (IsPedModel(ped, `mp_m_freemode_01`) and "male") or "female"
    local outfit = PoliceOutfits[gender]

    if not outfit then
        print("^1[PoliceGear]^7 Missing outfit for gender:", gender)
        return
    end

    print("^2[PoliceGear]^7 Applying outfit:", json.encode(outfit))
    TriggerEvent('qb-clothing:client:loadOutfit2', { outfitData = outfit, outfitName = "PoliceGear" })
end

-- Job update listener
RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job)
    print("^3[PoliceGear]^7 Job updated to:", job.name)
    if job.name == "police" then
        ApplyPoliceClothes()
    end
end)

-- On player loaded / resource start
CreateThread(function()
    while not QBCore.Functions.GetPlayerData().job do
        Wait(100)
    end
    local job = QBCore.Functions.GetPlayerData().job
    if job.name == "police" then
        ApplyPoliceClothes()
    end
end)
