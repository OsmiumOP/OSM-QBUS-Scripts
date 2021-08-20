fx_version 'adamant'

game 'gta5'

author 'VISBAIT | OSMIUM (for QBUS)'
discord 'discord.io/osmfx'
description 'VB-BANKING FOR QBUS'
version '1.0.0'

ui_page "html/index.html"

client_scripts {
    'client/*.lua',
    'config.lua'
}

server_scripts {
    'server/main.lua',
    'config.lua'
}

files {
    'html/*.html',
    'html/js/*.js',
    'html/img/*.png',
    'html/img/*.PNG',
    'html/img/*.jpg',
    'html/css/*.css',
    'html/img/fonts/*.ttf',
    'html/img/fonts/*.otf',
    'html/img/fonts/*.woff',
}
