Config = {}

Config.Lang = {
    char_selction = "SELECT CHARACTER",
    select_pg = "SELECT",
    gender = "Gender",
    date = "Date",
    money = "Cash",
    bank = "Bank",
    played_time = "Played Time",
    create_char = "CREATE CHARACTER",
    male = "Male",
    female = "Female",
    create = "CREATE",
    last_position = "LAST POSITION",
    spawn = "SPAWN",
    enable = "ENABLE",
    disable = "DISABLE",
    pg_disabled = "DISABLED",
    new_slot = "+ Slot",
    create_new_char = "Create a new character",
    back = "BACK",
    set_pg = "How many slots do you want to set?",
    confirm = "CONFIRM"
}


Config.ClothingScript = "illenium-appearance" -- "illenium-appearance" or "fivem-appearance"

Config.fivemAppConfig = {
    ped = true,
    headBlend = true,
    faceFeatures = true,
    headOverlays = true,
    components = true,
    componentConfig = {
        masks = true,
        upperBody = true,
        lowerBody = true,
        bags = true,
        shoes = true,
        scarfAndChains = true,
        bodyArmor = true,
        shirts = true,
        decals = true,
        jackets = true
    },
    props = true,
    propConfig = { hats = true, glasses = true, ear = true, watches = true, bracelets = true },
    tattoos = true,
    enableExit = true,
}

Config.CanDelete = true
Config.Relog = true

Config.CamStartPos = vector4(-3082.96, 343.36, 18.84, 86.92)
Config.ClothingPos = vector4(-285.0356, 563.2471, 173.8184, 359.9957)
Config.ShowAllwaysSpawnSelector = false -- if true it will always show the spawhselector when character choosen

Config.DefaultSlots = 4

Config.PanelAccess = {
    "admin",
}

Config.SpawnPositions = {
    [1] = {
        coords = vector4(-269.4092, -954.9990, 31.2231, 199.3808),
        camPos = vector3(-243.55073547363, -998.76782226563, 41.608463287354),
        camRot = vector3(-24.999923706055, -0.0, 31.852989196777),
        label = "City Center"
    },
    [2] = {
        coords = vector4(120.1660, -1730.9347, 30.1114, 136.7644),
        camPos = vector3(122.46654510498, -1755.5643310547, 38.958198547363),
        camRot = vector3(-33.199821472168, 2.1344339984353e-06, 8.1711311340332),
        label = "Near Groove"
    },
    [3] = {
        coords = vector4(-251.8946, -305.2152, 21.6264, 189.4710),
        camPos = vector3(-255.71199035645, -343.19055175781, 32.884384155273),
        camRot = vector3(-19.999992370605, 3.4150943974964e-06, -47.00061416626),
        label = "Burton"
    },
}

Config.PosPeds = {
    [1] = {
        coords = vector4(-3100.24, 342.16, 14.44, 274.04),
        camPos = vector3(-3098.8088378906, 342.54318237305, 15.140819549561),
        camRot = vector3(-27.19995880127, -1.2806606264348e-06, 92.662940979004),
        camZoom = 70.0,
        anim = { "timetable@reunited@ig_10", "base_amanda", false }
    },
    [2] = {
        coords = vector4(-3093.52, 351.64, 13.44, 254.92),
        camPos = vector3(-3090.6613769531, 349.62677001953, 15.743614196777),
        camRot = vector3(-16.599975585938, -3.4150943974964e-06, 55.250301361084),
        camZoom = 70.0,
        anim = { "amb@world_human_leaning@female@wall@back@hand_up@idle_a", "idle_a", "WORLD_HUMAN_LEANING" }
    },
    [3] = {
        coords = vector4(-3094.0, 339.8, 7.48, 280.56),
        camPos = vector3(-3090.2978515625, 341.02301025391, 9.020655632019),
        camRot = vector3(-24.199848175049, 2.561320343375e-06, 101.50094604492),
        camZoom = 70.0,
        anim = { false, false, "WORLD_HUMAN_LEANING" }
    },
    [4] = {
        coords = vector4(-3086.92, 351.72, 7.48, 0.0),
        camPos = vector3(-3084.6994628906, 352.8180847168, 8.3106670379639),
        camRot = vector3(-31.199615478516, 1.2806603990612e-06, 102.03371429443),
        camZoom = 70.0,
        anim = { "amb@world_human_picnic@male@idle_a", "idle_a", false }
    },
}


Config.SpawnClothes = {
    ["m"] = {
        mom = 43,
        dad = 29,
        face_md_weight = 61,
        skin_md_weight = 27,
        nose_1 = -5,
        nose_2 = 6,
        nose_3 = 5,
        nose_4 = 8,
        nose_5 = 10,
        nose_6 = 0,
        cheeks_1 = 2,
        cheeks_2 = -10,
        cheeks_3 = 6,
        lip_thickness = -2,
        jaw_1 = 0,
        jaw_2 = 0,
        chin_1 = 0,
        chin_2 = 0,
        chin_13 = 0,
        chin_4 = 0,
        neck_thickness = 0,
        hair_1 = 76,
        hair_2 = 0,
        hair_color_1 = 61,
        hair_color_2 = 29,
        tshirt_1 = 4,
        tshirt_2 = 2,
        torso_1 = 23,
        torso_2 = 2,
        decals_1 = 0,
        decals_2 = 0,
        arms = 1,
        arms_2 = 0,
        pants_1 = 28,
        pants_2 = 3,
        shoes_1 = 70,
        shoes_2 = 2,
        mask_1 = 0,
        mask_2 = 0,
        bproof_1 = 0,
        bproof_2 = 0,
        chain_1 = 22,
        chain_2 = 2,
        helmet_1 = -1,
        helmet_2 = 0,
        glasses_1 = 0,
        glasses_2 = 0,
        watches_1 = -1,
        watches_2 = 0,
        bracelets_1 = -1,
        bracelets_2 = 0,
        bags_1 = 0,
        bags_2 = 0,
        eye_color = 0,
        eye_squint = 0,
        eyebrows_2 = 0,
        eyebrows_1 = 0,
        eyebrows_3 = 0,
        eyebrows_4 = 0,
        eyebrows_5 = 0,
        eyebrows_6 = 0,
        makeup_1 = 0,
        makeup_2 = 0,
        makeup_3 = 0,
        makeup_4 = 0,
        lipstick_1 = 0,
        lipstick_2 = 0,
        lipstick_3 = 0,
        lipstick_4 = 0,
        ears_1 = -1,
        ears_2 = 0,
        chest_1 = 0,
        chest_2 = 0,
        chest_3 = 0,
        bodyb_1 = -1,
        bodyb_2 = 0,
        bodyb_3 = -1,
        bodyb_4 = 0,
        age_1 = 0,
        age_2 = 0,
        blemishes_1 = 0,
        blemishes_2 = 0,
        blush_1 = 0,
        blush_2 = 0,
        blush_3 = 0,
        complexion_1 = 0,
        complexion_2 = 0,
        sun_1 = 0,
        sun_2 = 0,
        moles_1 = 0,
        moles_2 = 0,
        beard_1 = 11,
        beard_2 = 10,
        beard_3 = 0,
        beard_4 = 0
    },
    ["f"] = {
        mom = 28,
        dad = 6,
        face_md_weight = 63,
        skin_md_weight = 60,
        nose_1 = -10,
        nose_2 = 4,
        nose_3 = 5,
        nose_4 = 0,
        nose_5 = 0,
        nose_6 = 0,
        cheeks_1 = 0,
        cheeks_2 = 0,
        cheeks_3 = 0,
        lip_thickness = 0,
        jaw_1 = 0,
        jaw_2 = 0,
        chin_1 = -10,
        chin_2 = 10,
        chin_13 = -10,
        chin_4 = 0,
        neck_thickness = -5,
        hair_1 = 43,
        hair_2 = 0,
        hair_color_1 = 29,
        hair_color_2 = 35,
        tshirt_1 = 111,
        tshirt_2 = 5,
        torso_1 = 25,
        torso_2 = 2,
        decals_1 = 0,
        decals_2 = 0,
        arms = 3,
        arms_2 = 0,
        pants_1 = 12,
        pants_2 = 2,
        shoes_1 = 20,
        shoes_2 = 10,
        mask_1 = 0,
        mask_2 = 0,
        bproof_1 = 0,
        bproof_2 = 0,
        chain_1 = 85,
        chain_2 = 0,
        helmet_1 = -1,
        helmet_2 = 0,
        glasses_1 = 33,
        glasses_2 = 12,
        watches_1 = -1,
        watches_2 = 0,
        bracelets_1 = -1,
        bracelets_2 = 0,
        bags_1 = 0,
        bags_2 = 0,
        eye_color = 8,
        eye_squint = -6,
        eyebrows_2 = 7,
        eyebrows_1 = 32,
        eyebrows_3 = 52,
        eyebrows_4 = 9,
        eyebrows_5 = -5,
        eyebrows_6 = -8,
        makeup_1 = 0,
        makeup_2 = 0,
        makeup_3 = 0,
        makeup_4 = 0,
        lipstick_1 = 0,
        lipstick_2 = 0,
        lipstick_3 = 0,
        lipstick_4 = 0,
        ears_1 = -1,
        ears_2 = 0,
        chest_1 = 0,
        chest_2 = 0,
        chest_3 = 0,
        bodyb_1 = -1,
        bodyb_2 = 0,
        bodyb_3 = -1,
        bodyb_4 = 0,
        age_1 = 0,
        age_2 = 0,
        blemishes_1 = 0,
        blemishes_2 = 0,
        blush_1 = 0,
        blush_2 = 0,
        blush_3 = 0,
        complexion_1 = 0,
        complexion_2 = 0,
        sun_1 = 0,
        sun_2 = 0,
        moles_1 = 12,
        moles_2 = 8,
        beard_1 = 0,
        beard_2 = 0,
        beard_3 = 0,
        beard_4 = 0
    }

}
