local rentalPeds = {}

-- Spawn rental peds and add ox_target interaction to each
CreateThread(function()
    for i, loc in pairs(Config.Locations) do
        if loc.ped and loc.ped.model then
            RequestModel(loc.ped.model)
            while not HasModelLoaded(loc.ped.model) do
                Wait(10)
            end
            local ped = CreatePed(0, loc.ped.model, loc.coords.x, loc.coords.y, loc.coords.z - 1.0, loc.ped.heading or 0.0, false, true)
            SetEntityInvincible(ped, true)
            SetBlockingOfNonTemporaryEvents(ped, true)
            FreezeEntityPosition(ped, true)
            -- Optional: Play idle animation
            TaskStartScenarioInPlace(ped, "WORLD_HUMAN_CLIPBOARD", 0, true)
            rentalPeds[i] = ped

            -- Add ox_target interaction to the ped
            exports.ox_target:addLocalEntity(ped, {
                {
                    name = 'rental_menu_'..loc.label,
                    icon = loc.targetIcon,
                    label = loc.targetLabel,
                    onSelect = function()
                        openRentalMenu(loc)
                    end
                }
            })
        end
    end
end)

-- Rental menu logic
function openRentalMenu(location)
    local options = {}
    for i, v in ipairs(Config.Vehicles) do
        table.insert(options, {
            title = v.name,
            description = v.description .. " | $" .. v.price .. "/hr",
            image = v.image,
            onSelect = function()
                selectRentalTime(v)
            end
        })
    end

    lib.registerContext({
        id = 'rental_menu',
        title = location.label,
        options = options
    })
    lib.showContext('rental_menu')
end

function selectRentalTime(vehicle)
    local input = lib.inputDialog('Select Rental Time', {
        {type = 'number', label = 'Hours', min = Config.MinRentalHours, max = Config.MaxRentalHours, required = true},
        {type = 'select', label = 'Payment', options = { {label = 'Cash', value = 'cash'}, {label = 'Bank', value = 'bank'} }, required = true}
    })
    if not input then return end

    local hours, paymentType = input[1], input[2]
    if hours < Config.MinRentalHours or hours > Config.MaxRentalHours then
        lib.notify({type = 'error', description = Locales['invalid_time']})
        return
    end

    TriggerServerEvent('rental:rentVehicle', vehicle.model, hours, paymentType)
end

RegisterNetEvent('rental:notify', function(type, msg, ...)
    lib.notify({type = type, description = string.format(Locales[msg], ... or "")})
end)

RegisterNetEvent('rental:spawnVehicle', function(model, plate, hours, rentalData)
    lib.notify({type = 'success', description = string.format(Locales['rental_success'], hours)})
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    lib.requestModel(model)
    local veh = CreateVehicle(model, coords.x, coords.y, coords.z, GetEntityHeading(playerPed), true, false)
    SetVehicleNumberPlateText(veh, plate)
    TaskWarpPedIntoVehicle(playerPed, veh, -1)
    SetEntityAsMissionEntity(veh, true, true)
end)

RegisterCommand('recovervehicle', function()
    TriggerServerEvent('rental:recoverVehicle')
end)