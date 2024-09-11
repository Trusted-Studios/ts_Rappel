-- ════════════════════════════════════════════════════════════════════════════════════ --
-- Trusted Development || Debug-print
-- ════════════════════════════════════════════════════════════════════════════════════ --

if Trusted.Debug then
    local filename = function()
        local str = debug.getinfo(2, "S").source:sub(2)
        return str:match("^.*/(.*).lua$") or str
    end
    print("^6[CLIENT - DEBUG] ^0: "..filename()..".lua started");
end

-- ════════════════════════════════════════════════════════════════════════════════════ --
-- Code
-- ════════════════════════════════════════════════════════════════════════════════════ --

Rappel = {}

function Rappel.Main()
    local ped <const> = PlayerPedId()

    if not IsPedSittingInAnyVehicle(ped) then
        Wait(1000)
        return
    end

    local vehicle <const> = GetVehiclePedIsIn(ped, false)
    local vehicleClass <const> = GetVehicleClass(vehicle)

    if vehicleClass ~= 15 then
        Wait(1000)
        return
    end

    local vehicleModel <const> = GetEntityModel(vehicle)

    if not Config.WhitelistedHelis[vehicleModel] then
        Wait(1000)
        return
    end

    local heli <const> = Config.WhitelistedHelis[vehicleModel]
    local isInWhitelistedSeat = false

    for i = 1, #heli do
        if GetPedInVehicleSeat(vehicle, heli[i]) == ped then
            isInWhitelistedSeat = true
            break
        end
    end

    if not isInWhitelistedSeat then
        Wait(1000)
        return
    end

    if GetEntityHeightAboveGround(vehicle) < Config.MinHeightToRappel then
        Wait(1000)
        return
    end

    if GetEntityHeightAboveGround(vehicle) > Config.MaxHeightToRappel then
        Wait(1000)
        return
    end

    if GetEntitySpeed(vehicle) > Config.MaxSpeedToRappel then
        Wait(1000)
        return
    end

    Visual.ShowHelp(Config.Text['press_to_rappel']:format('~INPUT_CONTEXT~'), true)
    if IsControlJustPressed(0, 38) then
        SetPedGadget(ped, 0xfbab5776, false)
        Wait(250)
        TaskRappelFromHeli(ped, 1)
    end
end

CreateThread(function()
    while true do
        Wait(0)
        Rappel.Main()
    end
end)

Visual = {}

---@param text string
---@param bleep boolean
---@meta:
--- Adds a basic GTA help notification in the top left side of screen.
function Visual.ShowHelp(text, bleep)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayHelp(0, false, bleep, -1)
end