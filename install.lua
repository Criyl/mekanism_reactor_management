local open = io.open

function getFileURL(version, package)
    return 'https://github.com/Criyl/' .. 'mekanism_reactor_management' .. '/releases/download/' .. version .. '/' ..
               package
end

local VERSION = 'v0.0.1'
local files = {'startup.lua', 'reactor_control.lua'}

for i, file in pairs(files) do
    print('installing ' .. file)
    shell.run('wget ' .. getFileURL(VERSION, file) .. ' ' .. file)
end
