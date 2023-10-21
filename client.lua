function RemoveVehicle()
    local playerped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerped, false)

    DeleteEntity(vehicle)
end

function Notification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentSubstringPlayerName(text)
    DrawNotification(false, false)
end

RegisterCommand("car", function (source, args, rawCommand)
    local playerped = PlayerPedId()
    local coords = GetEntityCoords(playerped)
    local heading = GetEntityHeading(playerped)
    local vehiclename = args[1]

    if vehiclename == nil then
        vehiclename = Config.StandardVehicle
    end

    if Config.DeleteOldVehicle then
        RemoveVehicle()
    end
    RequestModel(vehiclename)

    while not HasModelLoaded(vehiclename) do
        local waiting = 0
        waiting = waiting + 100
        
        Wait(100)
        if waiting > 2000 then
            Notification("~r~ Couldn't load Vehicle")          
            break
        end

    end

    local vehicle = CreateVehicle(vehiclename, coords.x, coords.y, coords.z, heading, Config.network, false)
    TaskWarpPedIntoVehicle(playerped, vehicle, -1)

end, Config.UseAce)



