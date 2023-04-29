local chatbox = peripheral.wrap('right')
local reactor = peripheral.wrap('left')
local monitor = peripheral.wrap('front')


'https://github.com/Criyl/'..'mekanism_reactor_management'..'/releases/download/'.. VERSION ..'/'..''
shell.run("pastebin get CmWgyMpn inventory")

if pcall( shell.run('reactor_control.lua') ) then
else
    reactor.scram()
    reactorBroadcast('ERROR IN REACTOR CODE, REACTOR SHUTDOWN!')
end