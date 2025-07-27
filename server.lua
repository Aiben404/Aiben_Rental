local rentals = {}

ESX = exports['es_extended']:getSharedObject() -- or use your framework

RegisterServerEvent('rental:rentVehicle')
AddEventHandler('rental:rentVehicle', function(model, hours, paymentType)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end

    if rentals[src] then
        TriggerClientEvent('rental:notify', src, 'error', 'already_rented')
        return
    end

    local vehicleConfig
    for _, v in ipairs(Config.Vehicles) do
        if v.model == model then
            vehicleConfig = v
            break
        end
    end
    if not vehicleConfig then return end

    local price = vehicleConfig.price * hours
    if paymentType == "cash" then
        if xPlayer.getMoney() < price then
            TriggerClientEvent('rental:notify', src, 'error', 'not_enough_money')
            return
        end
        xPlayer.removeMoney(price)
    elseif paymentType == "bank" then
        if xPlayer.getAccount('bank').money < price then
            TriggerClientEvent('rental:notify', src, 'error', 'not_enough_money')
            return
        end
        xPlayer.removeAccountMoney('bank', price)
    end

    local plate = "RENT"..math.random(1000,9999)
    local expires = os.time() + (hours * 3600)
    rentals[src] = {model = model, plate = plate, expires = expires}

    -- Give rental paper item
    xPlayer.addInventoryItem(Config.RentalPaperItem, 1, {
        name = vehicleConfig.name,
        plate = plate,
        renter = xPlayer.getName(),
        expires = expires
    })

    TriggerClientEvent('rental:spawnVehicle', src, model, plate, hours, rentals[src])
end)

RegisterServerEvent('rental:recoverVehicle')
AddEventHandler('rental:recoverVehicle', function()
    local src = source
    if not rentals[src] then
        TriggerClientEvent('rental:notify', src, 'error', 'no_rental')
        return
    end
    TriggerClientEvent('rental:spawnVehicle', src, rentals[src].model, rentals[src].plate, math.ceil((rentals[src].expires - os.time()) / 3600), rentals[src])
    TriggerClientEvent('rental:notify', src, 'success', 'vehicle_recovered')
end)

-- Rental expiration check (simple timer)
CreateThread(function()
    while true do
        Wait(60000)
        local now = os.time()
        for src, data in pairs(rentals) do
            if data.expires <= now then
                rentals[src] = nil
                TriggerClientEvent('rental:notify', src, 'error', 'rental_expired')
            end
        end
    end
end)