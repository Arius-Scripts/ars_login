local CreatePed                = CreatePed
local SetEntityAlpha           = SetEntityAlpha
local SendNUIMessage           = SendNUIMessage
local SetNuiFocus              = SetNuiFocus
local TriggerEvent             = TriggerEvent
local CreateThread             = CreateThread
local NetworkIsPlayerActive    = NetworkIsPlayerActive
local ShutdownLoadingScreen    = ShutdownLoadingScreen
local ShutdownLoadingScreenNui = ShutdownLoadingScreenNui
local SetEntityCoords          = SetEntityCoords
local FreezeEntityPosition     = FreezeEntityPosition
local SetEntityVisible         = SetEntityVisible
local DisplayRadar             = DisplayRadar
local Wait                     = Wait
local RegisterCommand          = RegisterCommand
local GetCurrentResourceName   = GetCurrentResourceName
local DeleteEntity             = DeleteEntity


mp_m_freemode_01           = `mp_m_freemode_01`
mp_f_freemode_01           = `mp_f_freemode_01`

player                     = {}
player.characters          = {}
player.slotsOccupied       = 0
player.currentSlot         = 1
player.maxSlots            = Config.DefaultSlots or 1
player.charsOccupied       = {}
player.canRelog            = false
player.spawnLast           = false
player.selectingSpawnPoint = false
player.selectedCharacter   = nil


function player.setupCharacters()
    ESX.PlayerLoaded = false
    ESX.PlayerData = {}

    ESX.TriggerServerCallback('ars_login:getData', function(data, playerMaxPg)
        if playerMaxPg then maxSlots = playerMaxPg end

        for slot = 1, maxSlots do
            player.characters[slot] = {}

            local cfg = Config.PosPeds[slot]
            local model = data[slot]?.skin ~= nil and data[slot]?.skin?.model or mp_m_freemode_01

            player.characters[slot].ped = CreatePed(0, model, cfg.coords, false, true)
            player.characters[slot].info = data[slot]

            if player.characters[slot].info then
                player.slotsOccupied += 1
                player.charsOccupied[#player.charsOccupied + 1] = data[slot].slot
            else
                SetEntityAlpha(player.characters[slot].ped, 150)
            end

            utils.playAnim(player.characters[slot].ped, cfg.anim[1], cfg.anim[2], cfg.anim[3])
            exports[Config.ClothingScript]:setPedAppearance(player.characters[slot].ped, data[slot]?.skin)
        end

        utils.doScreenFade("in", 0)


        SendNUIMessage({
            action = "infoPg",
            data = player.characters,
            lang = Config.Lang
        })

        SetNuiFocus(true, true)
        player.setupCam({ type = "char", slot = 1 })
    end)
end

function player.initLogin()
    local playerPed = PlayerPedId()

    utils.requestModel(mp_m_freemode_01, 0)
    utils.requestModel(mp_f_freemode_01, 0)

    ShutdownLoadingScreen()
    ShutdownLoadingScreenNui()
    TriggerEvent('esx:loadingScreenOff')

    SetEntityCoords(playerPed, Config.CamStartPos.x, Config.CamStartPos.y, Config.CamStartPos.z, true, false, false,
        false)
    SetEntityHeading(player, Config.CamStartPos.w)
    FreezeEntityPosition(playerPed, true)
    SetEntityVisible(playerPed, false)

    DisplayRadar(false)

    player.setupCharacters()
end

function player.setupLogin()
    while not ESX.PlayerLoaded do
        Wait(100)

        if NetworkIsPlayerActive(PlayerId()) then
            exports["spawnmanager"]:setAutoSpawn(false)

            utils.doScreenFade("out", 0)

            player.initLogin()
            break
        end
    end
end

CreateThread(player.setupLogin)

if Config.Relog then
    RegisterCommand('relog', function()
        canRelog = true
        if canRelog then
            canRelog = false

            TriggerServerEvent('ars_login:relog')
            ESX.SetTimeout(10000, function()
                canRelog = true
            end)
        end
    end)
end


function player.startTimer()
    player.selectedCharacter.timePlayed = 0

    CreateThread(function()
        while ESX.PlayerLoaded do
            Wait(1 * 60000)
            player.selectedCharacter.timePlayed += 1
        end
    end)
end

function player.saveTime()
    if not player.selectedCharacter?.timePlayed then return end

    TriggerServerEvent("ars_login:saveTime", { timeToAdd = player.selectedCharacter.timePlayed, char = player.selectedCharacter?.info?.slot })
end

function player.clearPeds()
    for index, slot in pairs(player.characters) do
        if slot.ped and DoesEntityExist(slot.ped) then
            DeleteEntity(slot.ped)
        end
    end
end

AddEventHandler("onResourceStop", function(resourceName)
    if resourceName == GetCurrentResourceName() then
        player.clearPeds()
    end
end)
