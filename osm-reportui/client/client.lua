-- MADE BY OSMIUM - DISCORD.IO/OSMFX --

RegisterCommand("reportui", function(args,rawCommand) 
    SetNuiFocus(true, true)

    SendNUIMessage({
        type = "open",
    })  
end)

RegisterNUICallback("exit" , function(data, cb)
    SetNuiFocus(false, false)

    cb(200)
end)


RegisterNUICallback('sumbit', function(data, cb)

    TriggerServerEvent("playersend", data)
    SetNuiFocus(false, false)

    cb(200)
end)