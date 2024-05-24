local CreateCamWithParams              = CreateCamWithParams
local SetCamActive                     = SetCamActive
local RenderScriptCams                 = RenderScriptCams
local DestroyCam                       = DestroyCam
local GetOffsetFromEntityInWorldCoords = GetOffsetFromEntityInWorldCoords
local vector3                          = vector3
local GetEntityHeading                 = GetEntityHeading
local ClearFocus                       = ClearFocus
local SetFocusArea                     = SetFocusArea
local Wait                             = Wait

local cams                             = {}
local activeCamIndex                   = 1

cam                                    = nil

function player.createCharCam(slot)
    local entity = player.characters[slot].ped
    local entityCoords = GetOffsetFromEntityInWorldCoords(entity, 0, 0.96, 0)
    local currentSlot = slot or 1

    local camCoords = Config.PosPeds[currentSlot].camPos or vector3(entityCoords.x, entityCoords.y, entityCoords.z + (start and 0.0 or 0.70))
    local camRot = Config.PosPeds[currentSlot].camRot or vector3(-24.0, 0.0, GetEntityHeading(entity) + 160)
    local camZoom = Config.PosPeds[currentSlot].camZoom or 100.0

    if cams[activeCamIndex] then
        SetCamActive(cams[activeCamIndex].cam, false)
        RenderScriptCams(false, false, 0, true, true)
        DestroyCam(cams[activeCamIndex].cam)
        cams[activeCamIndex] = nil
    end

    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", camCoords, camRot, camZoom, false, 1)
    cams[activeCamIndex] = { cam = cam, coords = camCoords }

    if cams[activeCamIndex - 1] then
        SetCamActiveWithInterp(cam, cams[activeCamIndex - 1].cam, 1000, true, true)
    else
        SetCamActive(cam, true)
    end

    RenderScriptCams(true, true, 700, true, true)
    SetFocusArea(camCoords, 0.0, 0.0, 0.0)

    activeCamIndex = activeCamIndex + 1
end

function player.createSpawnSelectorCam(position)
    Wait(500)

    ClearFocus()
    SetFocusArea(position.camPos, 0.0, 0.0, 0.0)
    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", position.camPos, position.camRot, 100.0, false, 1)

    SetCamActive(cam, true)
    RenderScriptCams(true, false, 700, true, true)

    utils.doScreenFade("in", 250)
end

function player.setupCam(data)
    local camType = data.type
    local slot = camType == "char" and data.slot or nil
    local position = data.type ~= "char" and data.position or nil

    if camType == "char" then
        player.createCharCam(slot)
    else
        player.createSpawnSelectorCam(position)
    end
end
