fx_version'cerulean'
game'gta5'

-- Forked from Atom's Pause Menu :
-- https://github.com/At0mit0s/fl_pause_menu

author 'Fantucie & Wolphwood'
description 'Pause Menu'
version '1.0.0'

lua54   'yes'
license 'GPL-3.0-or-later'

server_scripts ({
    'server.lua'
})

shared_script {
    '@es_extended/imports.lua',
    '@ox_lib/init.lua',
	'utils.lua',
	'config.lua',
}

client_script {
    'client.lua',
}

files({
    "locales/**",
    "nui/dist/**",
})

ui_page("nui/dist/index.html")