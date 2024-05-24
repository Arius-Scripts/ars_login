local tonumber                 = tonumber
local SetNuiFocus              = SetNuiFocus
local TriggerServerEvent       = TriggerServerEvent
local Wait                     = Wait
local PlayerPedId              = PlayerPedId
local SetEntityCoordsNoOffset  = SetEntityCoordsNoOffset
local SetEntityHeading         = SetEntityHeading
local ClearPedTasksImmediately = ClearPedTasksImmediately
local RegisterNuiCallback      = RegisterNuiCallback

---@param nextSlot number
function player.switchSlot(nextSlot)
    local slot = tonumber(nextSlot)
    if slot == player.currentSlot then return end

    player.currentSlot = slot

    player.setupCam({ type = "char", slot = slot })
end

---@param index number
function player.selectCharacter(index)
    player.clearPeds()
    local slot = tonumber(index)

    utils.doScreenFade("out", 400)

    if not Config.ShowAllwaysSpawnSelector then
        utils.resetSettings()
    end

    TriggerServerEvent("ars_login:loadCharacter", { new = false, char = slot })
end

---@class data value char value
function player.createCharacter(data)
    data.char = utils.charToCreate(player.charsOccupied)

    utils.resetSettings()

    TriggerServerEvent("ars_login:loadCharacter", { new = true, char = data })
end

---@param change type changeview,last,spawn
---@param point iftype default_spawnpoint
function player.selectSpawnPoint(change, point)
    utils.doScreenFade("out", 250)


    local spawnPoint = point or Config.SpawnPositions[1]

    if change == true then
        player.setupCam({
            type = "cam",
            position = spawnPoint
        })
    elseif change == "last" then
        player.spawnLast = true
        utils.resetSettings()
    else
        local playerPed = PlayerPedId()
        utils.resetSettings()

        Wait(500)

        SetEntityCoordsNoOffset(playerPed, spawnPoint.coords.xyz, false, false, false)
        SetEntityHeading(playerPed, spawnPoint.coords.w)
        ClearPedTasksImmediately(playerPed)

        utils.doScreenFade("in", 250)
    end

    player.selectingSpawnPoint = false
end

RegisterNuiCallback("action", function(data, cb)
    local action = data.tipo

    if action == "changeChar" then
        player.switchSlot(data.slot)
    elseif action == "selectCharacter" then
        player.selectCharacter(data.slot)
    elseif action == "emptyChar" then
        player.switchSlot(data.idPg + 1)
    elseif action == "createChar" then
        player.createCharacter(data)
    elseif action == "changeSpawnPoint" then
        player.selectSpawnPoint(true, Config.SpawnPositions[data.index])
        cb(Config.SpawnPositions[data.index].label)
    elseif action == "selectSpawnPoint" then
        player.selectSpawnPoint(false, Config.SpawnPositions[data.index])
        cb(Config.SpawnPositions[1].label)
    elseif action == "spawnLast" then
        player.selectSpawnPoint("last", false)
        cb(Config.SpawnPositions[1].label)
    elseif action == "charactersList" or action == "changeStatus" or action == "deleteCharacter" then
        local send = {
            refresh = true,
            playerLicense = action == "charactersList" and data.ide or string.match(data.license, "char%d:(%S+)"),
            toggleChar = action == "changeStatus" and { disable = data.status == "DISATTIVA" and true or false } or false,
            deleteChar = action == "deleteCharacter" and true or false,
            charLicense = action ~= "charactersList" and data.license or false
        }

        ESX.TriggerServerCallback('ars_login:getPannelData', function(users, characters)
            cb(characters)
        end, send)
    elseif action == "updateSots" then
        TriggerServerEvent("ars_login:updateSlots", data.slots, data.license)
    elseif data.tipo == "close" then
        SetNuiFocus(false, false)
    end
end)


RegisterCommand('charspanel', function()
    local send = {
        refresh = false,
        playerLicense = false,
        toggleChar = false,
        deleteChar = false,
        charLicense = false,
    }

    ESX.TriggerServerCallback('ars_login:getPannelData', function(users, character)
        SetNuiFocus(true, true)
        SendNUIMessage({
            action = "openPannel",
            users = users,
            lang = Config.Lang
        })
    end, send)
end)
