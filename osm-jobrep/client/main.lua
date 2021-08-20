QBCore = nil

Citizen.CreateThread(function() 
    while true do
        Citizen.Wait(1)
		if QBCore == nil then
			
            TriggerEvent("QBCore:GetObject", function(obj) QBCore = obj end)    
            Citizen.Wait(200)
        end
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
end)

RegisterNetEvent('osm:client:incjobrep')
AddEventHandler('osm:client:incjobrep', function(amount)
		
	if amount ~= nil then 
		TriggerServerEvent('osm:server:incjobrep', amount) 
	end
	
end)

Citizen.CreateThread(function()
	while true do

		Citizen.Wait(Config.Time * 60000)

		if Config.TimeBasedRep ~= 0 then 
	
			QBCore.Functions.GetPlayerData(function(PlayerData)
				if PlayerData ~= nil then
					curjobrep = PlayerData.metadata["jobrep1"]
					job = PlayerData.job
				end
			end)
					
			if curjobrep ~= nil and curjobrep > 0 and job ~= "unemployed" then 
					TriggerServerEvent('osm:server:incjobrep', Config.TimeBasedRep) 
			end 	
				
		end

	end
end)

