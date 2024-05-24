local RequestAnimDict = RequestAnimDict
local HasAnimDictLoaded = HasAnimDictLoaded
local TaskPlayAnim = TaskPlayAnim
local RemoveAnimDict = RemoveAnimDict
local TaskStartScenarioInPlace = TaskStartScenarioInPlace
local RequestModel = RequestModel
local HasModelLoaded = HasModelLoaded
local PlayerPedId = PlayerPedId
local SetEntityVisible = SetEntityVisible
local FreezeEntityPosition = FreezeEntityPosition
local SetNuiFocus = SetNuiFocus
local DoScreenFadeIn = DoScreenFadeIn
local IsScreenFadedIn = IsScreenFadedIn
local DoScreenFadeOut = DoScreenFadeOut
local IsScreenFadedOut = IsScreenFadedOut


utils = {}


function utils.playAnim(entity, animDict, animClip, scenario)
    if not scenario then
        RequestAnimDict(animDict)
        while not HasAnimDictLoaded(animDict) do
            RequestAnimDict(animDict)
            Wait(10)
        end

        TaskPlayAnim(entity, animDict, animClip, 8.0, 8.0, -1, 1, 1, false, false, false)

        RemoveAnimDict(animDict)
    else
        TaskStartScenarioInPlace(entity, scenario, 0, true)
    end
end

function utils.requestModel(model, tick)
    RequestModel(model)

    while not HasModelLoaded(model) do
        Wait(tick)
    end
end

function utils.charToCreate(table)
    local smallest = math.huge
    local foundSmallest = false
    local numbers = {}

    for k, v in pairs(table) do
        local n = tonumber(v)
        if n then
            numbers[n] = true
            if n < smallest then
                smallest = n
                foundSmallest = true
            end
        end
    end

    if not foundSmallest then
        return 1
    end

    if smallest > 1 then
        return 1
    end

    for i = smallest + 1, math.huge do
        if not numbers[i] then
            return i
        end
    end
end

function utils.resetSettings()
    local playerPed = PlayerPedId()

    SetEntityVisible(playerPed, true)
    FreezeEntityPosition(playerPed, false)

    SetNuiFocus(false, false)

    SetCamActive(cam, false)
    RenderScriptCams(false, false, 0, true, true)
    DestroyCam(cam)
end

function utils.doScreenFade(type, time)
    if type == "in" then
        DoScreenFadeIn(time)
        while not IsScreenFadedIn() do Wait(10) end
    elseif type == "out" then
        DoScreenFadeOut(time)
        while not IsScreenFadedOut() do Wait(10) end
    end
end
