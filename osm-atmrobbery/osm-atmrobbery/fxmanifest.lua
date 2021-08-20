-- resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

fx_version 'cerulean'
games { 'gta5' }

author 'OSMIUM#0001 | https://discord.io/osmfx'

description 'ADVANCED ATM ROBBERY | COOLDOWN | FLARES | TIMERS | POLICEALERTS | THRILLS :)'

client_scripts {
    "config.lua",
    "client/drill.lua",
    "client/client.lua",
}

server_scripts { 
    "config.lua",
    "server/server.lua"
}

dependencies {
	'meta_libs'
}
