-- Debug version of police uniform application
local QBCore = exports['qb-core']:GetCoreObject()

local function IsPedMale(ped)
    local model = GetEntityModel(ped)
    return model == GetHashKey("mp_m_freemode_01")
end

local function ApplyPoliceUniform()
    local gender = IsPedMale(PlayerPedId()) and "male" or "female"

    local uniform = {
        outfitData = {
            pants = { item = 24, texture = 0 },
            arms = { item = 17, texture = 0 },
            tshirt = { item = 15, texture = 0 },
            vest = { item = 13, texture = 0 },
            torso2 = { item = gender == "male" and 95 or 90, texture = 0 },
            shoes = { item = 10, texture = 0 },
            bag = { item = 0, texture = 0 },
            decal = { item = 0, texture = 0 },
            accessory = { item = 0, texture = 0 },
            hat = { item = -1, texture = 0 },
            glasses = { item = 0, texture = 0 },
            mask = { item = 0, texture = 0 }
        }
    }

    print("[DEBUG] Attempting to load outfit:", json.encode(uniform))
    TriggerEvent('qb-clothing:client:loadOutfit', uniform)
end
