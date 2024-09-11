-- ════════════════════════════════════════════════════════════════════════════════════ --
-- Trusted Development || Debug-print
-- ════════════════════════════════════════════════════════════════════════════════════ --

local filename = function()
    local str = debug.getinfo(2, "S").source:sub(2)
    return str:match("^.*/(.*).lua$") or str
end
print("^6[SHARED] - DEBUG] ^0: "..filename()..".lua started");

-- ════════════════════════════════════════════════════════════════════════════════════ --
-- Trusted Development || System
-- ════════════════════════════════════════════════════════════════════════════════════ --

Trusted = {}
Trusted.Debug = false

-- ════════════════════════════════════════════════════════════════════════════════════ --
-- Code
-- ════════════════════════════════════════════════════════════════════════════════════ --

Config = {}

-- whitelisted Heli -> whitelisted seats to rappel
Config.WhitelistedHelis = {
    [GetHashKey("annihilator")] = {1, 2, 3, 4, 5},
}

Config.MinHeightToRappel = 20.0
Config.MaxHeightToRappel = 80.0
Config.MaxSpeedToRappel = 4.0

Config.Text = {
    ['press_to_rappel'] = "Press %s to rappel"
}