fx_version 'cerulean'
game 'gta5'

name 'osm-reportui'
description 'Standalone Reporting Script with a Cool UI' 

author 'OSMIUM | discord.io/osmfx'

ui_page 'html/index.html'

files {
  'html/index.html',
  'html/assets/js/*.js',
  'html/assets/css/*.css',
  'html/assets/bootstrap/js/*.js',
  'html/assets/bootstrap/css/*.css',
}

client_script "client/client.lua"
server_script "server/server.lua"

