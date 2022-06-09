resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'It is a user interface where you can buy and sell casino coins in FiveM servers.'
author 'Enzo Cazenave (Chiki#4155)'

server_scripts {
    "config.lua",
    "server.lua"
}

client_scripts {
	"config.lua",
    "client.lua"
}

ui_page "html/index.html"

files {
    "html/index.html",
    "html/styles.css",
    "html/script.js"
}