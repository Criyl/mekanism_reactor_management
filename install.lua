local open = io.open

function getFileURL(version, package)
    return 'https://github.com/Criyl/'..'mekanism_reactor_management'..'/releases/download/'.. version ..'/'.. package
end

local VERSION = '0.0.1'

