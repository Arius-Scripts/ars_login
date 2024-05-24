--#--
--Fx info--
--#--
fx_version "cerulean"
use_fxv2_oal "yes"
lua54 "yes"
game "gta5"
ui_page "web/index.html"
ui_page_preload 'yes'


--#--
--Manifest--
--#--
client_scripts {
    "client/functions/utils.lua",
    "client/setupLogin.lua",
    "client/setupCam.lua",
    "client/interactions.lua",
    "client/loadChar.lua",
}

server_scripts {
    "@oxmysql/lib/MySQL.lua",
    "server/sql.lua",
    "server/main.lua",
}

shared_scripts {
    "@es_extended/imports.lua",
    "shared/config.lua"
}

files {
    "web/index.html",
    "web/js/script.js",
}

provides {
    "esx_multicharacter",
    "esx_identity"
}
