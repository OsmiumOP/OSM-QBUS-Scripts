fx_version 'cerulean'
game 'gta5'

author 'OSMIUM#0001 and some other peeps'

description "Car Hud - SVRP Inspired"

discord 'https://discord.gg/jrNxkpVaJU'

client_script {
	'client/client.lua',
	'client/workers.lua',
	'config.lua'
}

server_script {
	'server/server.lua',
	'config.lua'
}

ui_page('html/index.html')

files({
	"html/script.js",
	"html/jquery.min.js",
	"html/jquery-ui.min.js",
	"html/js-fluid-meter.js",
	"html/styles.css",
	"html/img/*.svg",
	"html/*.png",
	"html/index.html",
})