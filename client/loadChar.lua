local SetNuiFocus              = SetNuiFocus
local SendNUIMessage           = SendNUIMessage
local Wait                     = Wait
local PlayerId                 = PlayerId
local PlayerPedId              = PlayerPedId
local GetEntityCoords          = GetEntityCoords
local SetPlayerModel           = SetPlayerModel
local SetModelAsNoLongerNeeded = SetModelAsNoLongerNeeded
local SetEntityCoords          = SetEntityCoords
local SetPedAoBlobRendering    = SetPedAoBlobRendering
local ResetEntityAlpha         = ResetEntityAlpha
local SetEntityVisible         = SetEntityVisible
local FreezeEntityPosition     = FreezeEntityPosition
local SetFocusArea             = SetFocusArea
local SetEntityCoordsNoOffset  = SetEntityCoordsNoOffset
local SetEntityHeading         = SetEntityHeading
local TriggerEvent             = TriggerEvent
local TriggerServerEvent       = TriggerServerEvent
local RegisterNetEvent         = RegisterNetEvent
local AddEventHandler          = AddEventHandler

local function initSpawnSelector(isNew)
    SetNuiFocus(true, true)
    player.setupCam({ type = "spawnSelector", position = Config.SpawnPositions[1] })
    SendNUIMessage({
        action = "spawnSelector",
        numeroMax = #Config.SpawnPositions,
        isNew = isNew,
        lang = Config.Lang
    })
    player.selectingSpawnPoint = true

    while player.selectingSpawnPoint do
        Wait(100)
    end
end


local function setSelectedPlayer(slot)
    local found = false
    for k, v in pairs(player.characters) do
        if v?.info?.slot and v?.info?.slot == slot then
            player.selectedCharacter = v
            found = true
        end
    end
    if not found then
        player.selectedCharacter = player.characters[tonumber(slot)]
        player.selectedCharacter.info = {}
        player.selectedCharacter.info.slot = slot
    end
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(playerData, isNew, skin)
    local spawn = playerData.coords or Config.ClothingPos
    setSelectedPlayer(playerData.identifier:match("char(%d+):"))

    if isNew or not skin or #skin == 1 then
        local finished = false

        skin = Config.SpawnClothes[playerData.sex]
        skin.sex = playerData.sex == "m" and 0 or 1

        local model = skin.sex == 0 and mp_m_freemode_01 or mp_f_freemode_01

        utils.requestModel(model)

        SetPlayerModel(PlayerId(), model)
        SetModelAsNoLongerNeeded(model)
        SetEntityCoords(PlayerPedId(), Config.ClothingPos.x, Config.ClothingPos.y, Config.ClothingPos.z)
        SetPedAoBlobRendering(PlayerPedId(), true)
        ResetEntityAlpha(PlayerPedId())
        SetEntityVisible(PlayerPedId(), true)
        FreezeEntityPosition(PlayerPedId(), false)
        SetFocusArea(GetEntityCoords(PlayerPedId()), 0.0, 0.0, 0.0)


        TriggerEvent('skinchanger:loadSkin', skin, function()
            local playerPed = PlayerPedId()
            SetPedAoBlobRendering(playerPed, true)
            ResetEntityAlpha(playerPed)
            TriggerEvent('esx_skin:openSaveableMenu', function()
                finished = true
            end, function()
                finished = true
            end)
        end)

        repeat Wait(200) until finished
    end

    while LocalPlayer.state.facendoDocumenti do Wait(200) end

    local playerPed = PlayerPedId()

    -- utils.doScreenFade("out", 500)

    ClearFocus()

    if Config.ShowAllwaysSpawnSelector or not Config.ShowAllwaysSpawnSelector and isNew then
        initSpawnSelector(isNew)
    else
        SetEntityCoordsNoOffset(playerPed, spawn.x, spawn.y, spawn.z, false, false, false)
        SetEntityHeading(playerPed, spawn.heading)
    end

    if player.spawnLast then
        SetEntityCoordsNoOffset(playerPed, spawn.x, spawn.y, spawn.z, false, false, false)
        SetEntityHeading(playerPed, spawn.heading)
    end

    if not isNew then
        TriggerEvent('skinchanger:loadSkin', skin or player.selectedCharacter.skin)
    end

    Wait(400)

    utils.doScreenFade("in", 400)

    TriggerServerEvent('esx:onPlayerSpawn')
    TriggerEvent('esx:onPlayerSpawn')
    -- TriggerEvent('playerSpawned') -- tolto perche faceva un fade in out inutile poi questa funziona è uguale al esx:onPlayerSpawn
    TriggerEvent('esx:restoreLoadout')

    if Config.ShowAllwaysSpawnSelector or not Config.ShowAllwaysSpawnSelector and isNew then
        SetFocusArea(Config.SpawnPositions[1].camPos, 0.0, 0.0, 0.0)
    end

    canRelog = true
    player.spawnLast = false

    ClearFocus()
    player.startTimer()
end)

RegisterNetEvent('esx:onPlayerLogout')
AddEventHandler('esx:onPlayerLogout', function()
    utils.doScreenFade("out", 500)

    player.saveTime()

    Wait(1000)

    player.selectedCharacter = nil

    player.clearPeds()
    player.initLogin()
    TriggerEvent('esx_skin:resetFirstSpawn')
end)
