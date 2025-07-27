fx_version 'cerulean'
game 'gta5'

lua54 'yes'

author 'Aiben'
description 'Vehicle Rental System with ox_lib and ox_target'
version '1.1.0'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
    'locales/en.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua'
}

files {
    'images/*.png'
}