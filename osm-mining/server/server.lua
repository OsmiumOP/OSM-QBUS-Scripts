-- MADE BY OSMIUM | DISCORD.IO/OSMFX

QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

RegisterServerEvent('osm-mining:getItemNew')
AddEventHandler('osm-mining:getItemNew', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local randomItem = Config.Items[math.random(1, #Config.Items)]
    if Player ~= nil then
        Player.Functions.RemoveItem('washedstone', 1)
        Player.Functions.AddItem(randomItem, math.random(1,3))   ----chnage these to give different amounts once completed mining
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[randomItem], 'add')
    end
end)

RegisterServerEvent('osm-mining:getStone')
AddEventHandler('osm-mining:getStone', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local amount = math.random(2,6)  
    if Player ~= nil then   
        Player.Functions.AddItem('stone', amount)   ----chnage these to give different amounts once completed mining
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['stone'], 'add')
    end
end)

RegisterServerEvent("osm-mining:washing")
AddEventHandler("osm-mining:washing", function(x,y,z)
  	local src = source
  	local Player = QBCore.Functions.GetPlayer(src)
	local pick = Config.Items

		if 	TriggerClientEvent("QBCore:Notify", src, "You Washed One Stone!", "Success", 5000) then
			Player.Functions.RemoveItem('stone', 1)
			Player.Functions.AddItem('washedstone', 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['stone'], "remove")
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['washedstone'], "add")
		end
end)
---price of items to sell

local ItemList = {
    ["steel"] = math.random(50, 90),
    ["copper"] = math.random(40, 80),
    ["aluminum"] = math.random(70, 130),
    ["iron"] = math.random(50, 70),
    ["metalscrap"] = math.random(90, 140),

}

RegisterServerEvent('osm-mining:sell')
AddEventHandler('osm-mining:sell', function()
    local src = source
    local price = 0
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.items ~= nil and next(Player.PlayerData.items) ~= nil then 
        for k, v in pairs(Player.PlayerData.items) do 
            if Player.PlayerData.items[k] ~= nil then 
                if ItemList[Player.PlayerData.items[k].name] ~= nil then 
                    price = price + (ItemList[Player.PlayerData.items[k].name] * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem(Player.PlayerData.items[k].name, Player.PlayerData.items[k].amount, k)
                end
            end
        end
        Player.Functions.AddMoney("cash", price, "sold-items")
        TriggerClientEvent('QBCore:Notify', src, "You have sold your items")
        -- TriggerClientEvent('cy-notify:send', src, "You have sold your items")
    end
end)
