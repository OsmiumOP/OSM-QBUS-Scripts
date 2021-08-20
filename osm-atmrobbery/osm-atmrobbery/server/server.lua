local QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

-- Callback to get hacker device count:
QBCore.Functions.CreateCallback("osm-atmrobbery:getHackerDevice",function(source,cb)
	local xPlayer = QBCore.Functions.GetPlayer(source)
	if xPlayer.Functions.GetItemByName("electronickit") and xPlayer.Functions.GetItemByName("drill") then
		cb(true)
	else
		cb(false)
		TriggerClientEvent('QBCore:Notify', source, "You need an Electronic Kit and a Drill to proceed.")
	end
end)

RegisterServerEvent('itemsil')
AddEventHandler('itemsil', function()
local xPlayer = QBCore.Functions.GetPlayer(source)
	xPlayer.Functions.RemoveItem('drill', 1)
end)

QBCore.Functions.CreateUseableItem('electronickit', function(source)
	TriggerClientEvent('atm:item', source)
end)


-- Event to reward after successfull robbery

RegisterServerEvent("osm-atmrobbery:success")
AddEventHandler("osm-atmrobbery:success",function()
	local xPlayer = QBCore.Functions.GetPlayer(source)
    local reward = math.random(Config.MinReward,Config.MaxReward)
		xPlayer.Functions.AddMoney(Config.RewardAccount, tonumber(reward))

		TriggerClientEvent("QBCore:Notify",source,"Succesful Robbery | You earn't $"..reward.. " !")
end)

---

cooldowntime = Config.Cooldown 

undercd = false

RegisterServerEvent('osm:CooldownServer')
AddEventHandler('osm:CooldownServer', function(bool)
    undercd = bool
	if bool then 
		cooldown()
	end	 
end)

RegisterServerEvent('osm:CooldownNotify')
AddEventHandler('osm:CooldownNotify', function()
	TriggerClientEvent("QBCore:Notify",source,"An ATM Robbery has happened Recently. Please Wait "..cooldowntime.." Minutes!")
end)

function cooldown()

	while true do 
	Citizen.Wait(60000)

	cooldowntime = cooldowntime - 1 

	if cooldowntime <= 0 then
		undercd = false
		break
	end

end
end

QBCore.Functions.CreateCallback("osm:GetCooldown",function(source,cb)
	cb(undercd)
end)
