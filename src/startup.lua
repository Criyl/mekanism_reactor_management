local chatbox = peripheral.wrap('right')
local reactor = peripheral.wrap('left')
local monitor = peripheral.wrap('front')

if pcall(shell.run('reactor_control.lua')) then
else
    reactor.scram()
    reactorBroadcast('ERROR IN REACTOR CODE, REACTOR SHUTDOWN!')
end
