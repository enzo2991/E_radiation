fx_version 'cerulean'
game 'gta5'
author "Enzo2991 | Enzo Galantino"
description "radiation system for kill player if stay in zone"

shared_scripts {
    '@es_extended/imports.lua',
    'config.lua'
}

client_scripts {
    '@PolyZone/client.lua',
    'client/zone.lua',
    'client/entitydamage.lua'
}

files {
    'ui/index.html',
    'ui/sound/*'
}

ui_page 'ui/index.html'
