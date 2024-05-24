local Players = {}
local users = {}
local playerMaxPg

ESX.RegisterServerCallback('ars_login:getData', function(source, cb)
    local playerIdentifier = ESX.GetIdentifier(source)
    SetPlayerRoutingBucket(source, source)

    Players[playerIdentifier] = {}


    local response = MySQL.query.await('SELECT * FROM `ars_login` WHERE `identifier` = ?', {
        playerIdentifier
    })

    playerMaxPg = response[1]?.pg or Config.DefaultSlots

    MySQL.query('SELECT * FROM `users`', {}, function(response)
        if response then
            for k, v in pairs(response) do
                if string.find(v.identifier, playerIdentifier) then
                    local account = json.decode(v.accounts)

                    Players[playerIdentifier][#Players[playerIdentifier] + 1] = {
                        skin = json.decode(v.skin),
                        firstName = v.firstname,
                        lastname = v.lastname,
                        dob = v.dateofbirth,
                        sex = v.sex,
                        group = v.group,
                        job = v.job,
                        disabled = v.disabled,
                        time = v.time or 0,
                        bank = account.bank,
                        money = account.money,
                        slot = v.identifier:match("char(%d+):")
                    }
                    local playerSteam = GetPlayerName(source) or "N/A"

                    MySQL.update('UPDATE users SET steam = ? WHERE identifier = ?', {
                        playerSteam, v.identifier
                    }, function(affectedRows)
                    end)
                end
            end

            cb(Players[playerIdentifier], playerMaxPg)
        end
    end)
end)

ESX.RegisterServerCallback('ars_login:applicaSkin', function(source, cb, skin, ide)
    MySQL.query.await('UPDATE users SET skin = ? WHERE identifier = ?', { json.encode(skin), ide })
end)



RegisterNetEvent("ars_login:saveTime", function(data)
    local playerIdentifier = "char" .. data.char .. ":" .. ESX.GetIdentifier(source)

    MySQL.scalar('SELECT `time` FROM `users` WHERE `identifier` = ? LIMIT 1', {
        playerIdentifier
    }, function(value)
        -- print(value)
        MySQL.update('UPDATE users SET time = ? WHERE identifier = ?', {
            (value + data.timeToAdd), playerIdentifier
        }, function(affectedRows)
            if affectedRows then

            end
        end)
    end)
end)



RegisterNetEvent('ars_login:relog', function()
    local source = source
    ESX.Players[source] = nil
    TriggerEvent('esx:playerLogout', source)
end)



RegisterNetEvent("ars_login:loadCharacter", function(data)
    if data.new then
        TriggerEvent('esx:onPlayerJoined', source, "char" .. data.char.char, {
            firstname = data.char.nome,
            lastname = data.char.cognome,
            dateofbirth = data.char.data,
            sex = data.char.sex,
            height = data.char.altezza
        })
    else
        TriggerEvent('esx:onPlayerJoined', source, "char" .. data.char)
    end

    SetPlayerRoutingBucket(source, 0)
end)


RegisterNetEvent("ars_login:updateSlots", function(slots, license)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
    local access = false

    for _, group in pairs(Config.PanelAccess) do
        if playerGroup == group then
            access = true
            break
        end
    end

    if not access then return end
    if not license then return end
    if not slots then return end


    MySQL.insert('INSERT INTO `ars_login` (identifier, pg) VALUES (?, ?) ON DUPLICATE KEY UPDATE pg = ? ', {
        license, slots, slots
    })
end)


function PlayerOnline(ide)
    local players = GetPlayers()
    for k, v in pairs(players) do
        if GetPlayerIdentifier(v) == 'license:' .. ide then
            return true
        end
    end
    return false
end

ESX.RegisterServerCallback('ars_login:getPannelData', function(src, cb, data)
    local character = {}

    local xPlayer = ESX.GetPlayerFromId(src)
    local playerGroup = xPlayer.getGroup()
    local access = false

    for _, group in pairs(Config.PanelAccess) do
        if playerGroup == group then
            access = true
            break
        end
    end

    if not access then return end


    if data.toggleChar then
        print("questo")
        print(data.charLicense, data.toggleChar.disable and 1 or 0)
        MySQL.update('UPDATE users SET disabled = ? WHERE identifier = ?', {
            data.toggleChar.disable and 1 or 0, data.charLicense
        }, function(affectedRows)
            print(affectedRows)
        end)
    end

    if data.deleteChar then
        local response = MySQL.rawExecute.await('DELETE FROM `users` WHERE `identifier` = ?', {
            data.charLicense
        })
    end

    MySQL.query('SELECT * FROM `users`', {}, function(res)
        if res then
            for k, v in pairs(res) do
                local identifier = v.identifier

                local modIde = string.match(identifier, "char%d:(%S+)")

                for _, i in pairs(users) do
                    if i.ide == modIde then
                        trovato = true
                        break
                    end
                end

                if not trovato then
                    local bool = PlayerOnline(modIde)
                    users[#users + 1] = {
                        ide = modIde,
                        steam = v.steam,
                        online = bool
                    }
                end

                if data.refresh then
                    if not character[data.playerLicense] then
                        character[data.playerLicense] = {}
                    end

                    if string.find(identifier, data.playerLicense) then
                        if not delete or delete and data.charLicense ~= data.playerLicense then
                            character[data.playerLicense][identifier] = {}
                            character[data.playerLicense][identifier].firstName = v.firstname or "not found"
                            character[data.playerLicense][identifier].lastName = v.lastname or "not found"
                            character[data.playerLicense][identifier].dob = v.dateofbirth or "not found"
                            character[data.playerLicense][identifier].sex = v.sex or "not found"
                            character[data.playerLicense][identifier].disabled = v.disabled
                            character[data.playerLicense][identifier].height = v.height or "not found"
                            character[data.playerLicense][identifier].money = json.decode(v.accounts).money or "not found"
                            character[data.playerLicense][identifier].bank = json.decode(v.accounts).bank or "not found"
                            character[data.playerLicense][identifier].license = identifier
                            character[data.playerLicense][identifier].slot = identifier:match("char(%d+):") or "not found"
                        end
                    end
                end
            end
        end

        cb(users, character[data.playerLicense])
    end)
end)
