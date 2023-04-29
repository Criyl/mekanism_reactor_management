local chatbox = peripheral.wrap('right')
local reactor = peripheral.wrap('left')
local monitor = peripheral.wrap('front')

local MAX_REACTOR_COOLANT = reactor.getCoolantCapacity()
local MAX_REACTOR_COOLANT_HEATED = reactor.getHeatedCoolantCapacity()

local SAFE_PERCENT = 0.5
local LOCATION = reactor.getMinPos()

monitor.setTextScale(1)

function shouldScram()
    if reactor.getHeatedCoolant().amount >= MAX_REACTOR_COOLANT_HEATED * SAFE_PERCENT then
        return true
    end

    if reactor.getCoolant().amount < MAX_REACTOR_COOLANT * SAFE_PERCENT then
        return true
    end

    return false
end

function shouldActivate()
    if shouldScram() then
        return false
    end

    if reactor.getCoolant().amount == MAX_REACTOR_COOLANT then
        return true
    end

    return false
end

function reactorBroadcast(text)
    local message = {
        {
            text = "WARNING",
            color  = "#FF0000"},
        {
            text = ": ", 
        },
        {
            text = "Reactor @ ",
            color = "#CE9178",
        },
        {
            text = LOCATION.x..','..LOCATION.y..','..LOCATION.z,
            underlined = true,
            color = "aqua",
            clickEvent = {
                action="copy_to_clipboard",
                value = LOCATION.x..','..LOCATION.y..','..LOCATION.z
            },
            hoverEvent = {
                action ="show_text",
                value = "its a location dumbass"
            }
        },
        {
            text = " " .. text,
            color = "#CE9178"
        }
    }

    local json = textutils.serialiseJSON(message)
    chatbox.sendFormattedMessage(json,'reactor_C01')
end

function checkCoolant()
    if reactor.getStatus() and shouldScram() then
        reactor.scram()
        reactorBroadcast('has ran out of coolant and will be shutting down!')

    elseif not reactor.getStatus() and shouldActivate() then
        reactor.activate()
        reactorBroadcast('has resumed regular operations.')
    end
end



function printInfo()
    monitor.clear()

    monitor.setCursorPos(1,1)
    monitor.write('Coolage level: ' .. reactor.getCoolant().amount)

    monitor.setCursorPos(1,2)
    monitor.write('Temperage: ' .. reactor.getTemperature())
    
    monitor.setCursorPos(1,3)
    monitor.write('Burn Rate: ' .. reactor.getActualBurnRate())
end


function mainloop()
    checkCoolant()
    printInfo()
end


print("Starting reactor monitoring.")
while true do 
    mainloop()
    os.sleep(0.5)
end