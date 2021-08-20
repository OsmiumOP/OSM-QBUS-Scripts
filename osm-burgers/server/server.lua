QBCore = nil

TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

RegisterServerEvent('osm-mcd:server:start:black')
AddEventHandler('osm-mcd:server:start:black', function()
    local src = source
    
    TriggerClientEvent('osm-mcd:start:black:job', src)
end)

RegisterServerEvent('osm-mcd:server:reward:money')
AddEventHandler('osm-mcd:server:reward:money', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    Player.Functions.AddMoney("cash", Config.PaymentTaco, "taco-reward-money")
    TriggerClientEvent('QBCore:Notify', src, "Taco delivered! Go back to the taco shop for a new delivery")
end)

QBCore.Functions.CreateCallback('osm-mcd:server:GetConfig', function(source, cb)
    cb(Config)
end)
QBCore.Functions.CreateCallback('osm-mcd:server:truealways', function(source, cb)
    cb(true)
end)

RegisterServerEvent('osm-mcd:server:get:stuff')
AddEventHandler('osm-mcd:server:get:stuff', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if Player ~= nil then
        Player.Functions.AddItem("burger-box", 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['burger-box'], "add")
    end
end)

RegisterServerEvent('osm-mcd:server:driveby')
AddEventHandler('osm-mcd:server:driveby', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
  
    if Player ~= nil then
       
          if (Player.PlayerData.money.bank > Config.BurgerPrice) then
            Player.Functions.RemoveMoney('bank', Config.BurgerPrice, "Bought a Burger")
            Player.Functions.AddItem("burger", 1)
            TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['burger'], "add")
            TriggerClientEvent('drivebycut')
        else
            TriggerClientEvent('QBCore:Notify', src, "You don't have Enough Money in your BANK", "error")
         end
       
    end
end)

QBCore.Functions.CreateUseableItem("burger", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("consumables:client:Eat", source, item.name)
    end
end)

QBCore.Functions.CreateCallback('osm-mcd:server:get:ingredient', function(source, cb)
    local src = source
    local Ply = QBCore.Functions.GetPlayer(src)
    local lettuce = Ply.Functions.GetItemByName("lettuce")
    local meat = Ply.Functions.GetItemByName("meat")
    local buns = Ply.Functions.GetItemByName("bun")
    if lettuce ~= nil and meat ~= nil and buns ~= nil then
        cb(true)
    else
        cb(false)
    end
end)

QBCore.Functions.CreateCallback('osm-mcd:server:get:burgerbox', function(source, cb)
    local src = source
    local Ply = QBCore.Functions.GetPlayer(src)
    local box = Ply.Functions.GetItemByName("burger-box")
    if box ~= nil then
        cb(true)
    else
        cb(false)
    end
end)

QBCore.Functions.CreateCallback('osm-mcd:server:get:burgers', function(source, cb)
    local src = source
    local Ply = QBCore.Functions.GetPlayer(src)
    local taco = Ply.Functions.GetItemByName('burger')
    if taco ~= nil then
        cb(true)
    else
        cb(false)
    end
end)