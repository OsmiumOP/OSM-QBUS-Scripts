QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

RegisterServerEvent("osm:server:incjobrep")
AddEventHandler('osm:server:incjobrep', function(amount)

	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	
	if Player ~= nil then

		if Player.PlayerData.metadata["jobrep1"] == nil then
			Player.PlayerData.metadata["jobrep1"] = 0
		end
		
		if amount ~= nil and amount > 0 then 
			newjobrep = Player.PlayerData.metadata["jobrep1"] + amount
			Player.Functions.SetMetaData("jobrep1", newjobrep)
		else
			newjobrep = Player.PlayerData.metadata["jobrep1"] + 1
			Player.Functions.SetMetaData("jobrep1", newjobrep)
		end 

		TriggerClientEvent("QBCore:Notify", src, 'You Earn '..amount..' Job Reputation', "Success", 4000)

	end
end)

QBCore.Commands.Add("jobrep", "Current Job Reputation", {}, false, function(source, args)    
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	if Player ~= nil then
		jobrep = Player.PlayerData.metadata["jobrep1"]
		TriggerClientEvent("QBCore:Notify", src, 'Current Job Reputation : '..jobrep..'', "Success", 5000)
	end 

end)

-- QBCore.Commands.Add("testjobrep", "Money in Cash", {}, false, function(source, args)
--     TriggerClientEvent('osm:client:incjobrep', source, 10)
-- end)
