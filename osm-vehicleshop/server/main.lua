QBCore = nil

TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

local NumberCharset = {}
local Charset = {}

for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end

for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end


Citizen.CreateThread(function()
    while true do
        
        local timestamp = os.time()
        local d = os.date('*t', timestamp).wday
        local h = tonumber(os.date('%H', timestamp))
        local m = tonumber(os.date('%M', timestamp))


        if h == Config.HouroftheDay then 
            TriggerEvent('qb-vehicleshop:server:CutFinance')
        end
        Citizen.Wait(60000 * 60)
    end
end)


-- code

RegisterNetEvent('qb-vehicleshop:server:buyVehicle')
AddEventHandler('qb-vehicleshop:server:buyVehicle', function(vehicleData, garage)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    local cid = pData.PlayerData.citizenid
    local vData = QBCore.Shared.Vehicles[vehicleData["model"]]
    local balance = pData.PlayerData.money["bank"]
    
    if (balance - vData["price"]) >= 0 then
        local plate = GeneratePlate()
        QBCore.Functions.ExecuteSql(false, "INSERT INTO `player_vehicles` (`steam`, `citizenid`, `vehicle`, `hash`, `mods`, `plate`, `garage`) VALUES ('"..pData.PlayerData.steam.."', '"..cid.."', '"..vData["model"].."', '"..GetHashKey(vData["model"]).."', '{}', '"..plate.."', '"..garage.."')")
        TriggerClientEvent("QBCore:Notify", src, "Successful! Your vehicle was delivered to "..QB.GarageLabel[garage], "success", 5000)
        pData.Functions.RemoveMoney('bank', vData["price"], "vehicle-bought-in-shop")
        TriggerEvent("qb-log:server:sendLog", cid, "vehiclebought", {model=vData["model"], name=vData["name"], from="garage", location=QB.GarageLabel[garage], moneyType="bank", price=vData["price"], plate=plate})
        TriggerEvent("qb-log:server:CreateLog", "vehicleshop", "Vehicle Purchased (garage)", "green", "**"..GetPlayerName(src) .. "** has bought " .. vData["name"] .. " one for $" .. vData["price"])
    else
		TriggerClientEvent("QBCore:Notify", src, "You don't have enough money, you are missing $"..format_thousand(vData["price"] - balance), "error", 5000)
    end
end)

RegisterNetEvent('qb-vehicleshop:server:buyShowroomVehicle')
AddEventHandler('qb-vehicleshop:server:buyShowroomVehicle', function(vehicle, class)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    local cid = pData.PlayerData.citizenid
    local balance = pData.PlayerData.money["bank"]
    local vehiclePrice = QBCore.Shared.Vehicles[vehicle]["price"]
    local plate = GeneratePlate()
    if (balance - vehiclePrice) >= 0 then
        QBCore.Functions.ExecuteSql(false, "INSERT INTO `player_vehicles` (`steam`, `citizenid`, `vehicle`, `hash`, `mods`, `plate`, `state`) VALUES ('"..pData.PlayerData.steam.."', '"..cid.."', '"..vehicle.."', '"..GetHashKey(vehicle).."', '{}', '"..plate.."', 0)")
        TriggerClientEvent("QBCore:Notify", src, "Successful! Your vehicle is waiting for you outside.", "success", 5000)
        TriggerClientEvent('qb-vehicleshop:client:buyShowroomVehicle', src, vehicle, plate)
        pData.Functions.RemoveMoney('bank', vehiclePrice, "vehicle-bought-in-showroom")
        TriggerEvent("qb-log:server:sendLog", cid, "vehiclebought", {model=vehicle, name=QBCore.Shared.Vehicles[vehicle]["name"], from="showroom", moneyType="bank", price=QBCore.Shared.Vehicles[vehicle]["price"], plate=plate})
        TriggerEvent("qb-log:server:CreateLog", "vehicleshop", "Vehicle bought (showroom)", "green", "**"..GetPlayerName(src) .. "** has bought " .. QBCore.Shared.Vehicles[vehicle]["name"] .. " one for $" .. QBCore.Shared.Vehicles[vehicle]["price"])
    else
        TriggerClientEvent("QBCore:Notify", src, "You don't have enough money, you are missing $"..format_thousand(vehiclePrice - balance), "error", 5000)
    end
end)

RegisterNetEvent('qb-vehicleshop:server:FinanceVehicle')
AddEventHandler('qb-vehicleshop:server:FinanceVehicle', function(vehicle, class, finserv, downp)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    local cid = pData.PlayerData.citizenid
    local balance = pData.PlayerData.money["bank"]
    local vehicleValue = QBCore.Shared.Vehicles[vehicle]["price"]
    local finserv1 = finserv / 100
    local financeInstallment = (QBCore.Shared.Vehicles[vehicle]["price"] * finserv1)
    local plate = GeneratePlate()

    QBCore.Functions.ExecuteSql(false, "SELECT * FROM `players` WHERE `citizenid` = '"..cid.."' ", function(result)
        if result[1] ~= nil then
            for k, v in pairs(result) do
                if v.pending_finance == 0 then
                        if (balance - downp) >= 0 then
                            QBCore.Functions.ExecuteSql(false, "INSERT INTO `player_vehicles` (`steam`, `citizenid`, `vehicle`, `hash`, `mods`, `plate`, `state`,`finance_owed`, `finperc`) VALUES ('"..pData.PlayerData.steam.."', '"..cid.."', '"..vehicle.."', '"..GetHashKey(vehicle).."', '{}', '"..plate.."', 0, '"..vehicleValue.."', '"..finserv.."')")
                            QBCore.Functions.ExecuteSql(false, "UPDATE `players` SET `pending_finance` = 1 WHERE `citizenid` = '"..cid.."'")
                            TriggerClientEvent("QBCore:Notify", src, "Successful! Your vehicle is waiting for you outside.", "success", 5000)
                            TriggerClientEvent('qb-vehicleshop:client:buyShowroomVehicle', src, vehicle, plate)
                            pData.Functions.RemoveMoney('bank', downp, "vehicle-financed-in-showroom")
                            TriggerEvent("qb-log:server:sendLog", cid, "vehiclebought", {model=vehicle, name=QBCore.Shared.Vehicles[vehicle]["name"], from="showroom", moneyType="bank", price=QBCore.Shared.Vehicles[vehicle]["price"], plate=plate})
                            TriggerEvent("qb-log:server:CreateLog", "vehicleshop", "Vehicle bought (showroom)", "green", "**"..GetPlayerName(src) .. "** has bought " .. QBCore.Shared.Vehicles[vehicle]["name"] .. " one for $" .. QBCore.Shared.Vehicles[vehicle]["price"])
                        else
                            TriggerClientEvent("QBCore:Notify", src, "You don't have enough money, you are missing $"..format_thousand(downp - balance), "error", 5000)
                        end 
                else
                    TriggerClientEvent("QBCore:Notify", src, "You have pending Vehicle Finance", "error", 5000)
                end
            end
        end
    end)

    
end)

function GetSrc(citizenid)
	for src, player in pairs(QBCore.Players) do
		local cid = citizenid
		if QBCore.Players[src].PlayerData.citizenid == cid then
			return src
		end
	end
	return nil
end

RegisterNetEvent('qb-vehicleshop:server:CutFinance')
AddEventHandler('qb-vehicleshop:server:CutFinance', function(vehicle, class)

print("Cutting finances")
    QBCore.Functions.ExecuteSql(false, "SELECT * FROM `player_vehicles`", function(result)
        if result[1] ~= nil then
            for k, v in pairs(result) do
                local Player = QBCore.Functions.GetPlayerByCitizenId(v.citizenid)
                local VehicleData = QBCore.Shared.Vehicles[v.vehicle]
                local finowd = v.finance_owed
                if v.finance_owed ~= nil and v.finperc ~= nil then
                	if Player ~= nil then
	                    if v.finance_owed > 0 then
                            local multiplier = v.finperc / 100
	                        installment = ( VehicleData["price"] * multiplier)
	                        balance = Player.PlayerData.money["bank"]
	                        if (balance - installment >= 0) then
	                            QBCore.Functions.ExecuteSql(false, "UPDATE `player_vehicles` SET `finance_owed` = '"..v.finance_owed.."' - '"..installment.."' WHERE `plate` = '"..v.plate.."'")
	                            Player.Functions.RemoveMoney("bank",installment,'paid-finance')
                                -- Player.Functions.Notify('Finance Installment Paid - $'..installment)
                                local src = GetSrc(v.citizenid)
                                TriggerClientEvent("QBCore:Notify", src, "Vehicle Finance Installment Paid - $"..installment, "error", 6000)
	                        end
	                    elseif v.finance_owed < 0 then
	                        QBCore.Functions.ExecuteSql(false, "UPDATE `player_vehicles` SET `finance_owed` = 0 WHERE `plate` = '"..v.plate.."'")
                            QBCore.Functions.ExecuteSql(false, "UPDATE `players` SET `pending_finance` = 0 WHERE `citizenid` = '"..v.citizenid.."'")
	                    end
                    else
                        QBCore.Functions.ExecuteSql(false, "SELECT * FROM `players` WHERE `citizenid` = '"..v.citizenid.."'", function(result)
                            if result[1] ~= nil then
                                if finowd > 0 then
                                    local multiplier = v.finperc / 100
                                    local installment = (VehicleData["price"] * multiplier)
                                    local NewBal = json.decode(result[1].money)
                                    NewBal.bank = NewBal.bank - installment
                                    if NewBal.bank >= 0 then
                                        QBCore.Functions.ExecuteSql(false,"UPDATE `players` SET `money` = '"..json.encode(NewBal).."' WHERE `citizenid` = '"..v.citizenid.."'")
                                        QBCore.Functions.ExecuteSql(false, "UPDATE `player_vehicles` SET `finance_owed` = '"..v.finance_owed.."' - '"..installment.."' WHERE `plate` = '"..v.plate.."'")
                                    end
                                elseif finowd < 0 then 
                                    QBCore.Functions.ExecuteSql(false, "UPDATE `player_vehicles` SET `finance_owed` = 0 WHERE `plate` = '"..v.plate.."'")
                                    QBCore.Functions.ExecuteSql(false, "UPDATE `players` SET `pending_finance` = 0 WHERE `citizenid` = '"..v.citizenid.."'")                              
                                end
                            end
                        end)
	                end
                end
            end
        end
    end)

end)



function format_thousand(v)
    local s = string.format("%d", math.floor(v))
    local pos = string.len(s) % 3
    if pos == 0 then pos = 3 end
    return string.sub(s, 1, pos)
            .. string.gsub(string.sub(s, pos + 1), "(...)", ",%1")
end

function GeneratePlate()
    local plate = tostring(GetRandomNumber(1)) .. GetRandomLetter(2) .. tostring(GetRandomNumber(3)) .. GetRandomLetter(2)
    QBCore.Functions.ExecuteSql(true, "SELECT * FROM `player_vehicles` WHERE `plate` = '"..plate.."'", function(result)
        while (result[1] ~= nil) do
            plate = tostring(GetRandomNumber(1)) .. GetRandomLetter(2) .. tostring(GetRandomNumber(3)) .. GetRandomLetter(2)
        end
        return plate
    end)
    return plate:upper()
end

function GetRandomNumber(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end

function GetRandomLetter(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
	else
		return ''
	end
end

RegisterServerEvent('qb-vehicleshop:server:setShowroomCarInUse')
AddEventHandler('qb-vehicleshop:server:setShowroomCarInUse', function(showroomVehicle, bool)
    QB.ShowroomVehicles[showroomVehicle].inUse = bool
    TriggerClientEvent('qb-vehicleshop:client:setShowroomCarInUse', -1, showroomVehicle, bool)
end)

RegisterServerEvent('qb-vehicleshop:server:setShowroomVehicle')
AddEventHandler('qb-vehicleshop:server:setShowroomVehicle', function(vData, k)
    QB.ShowroomVehicles[k].chosenVehicle = vData
    TriggerClientEvent('qb-vehicleshop:client:setShowroomVehicle', -1, vData, k)
end)

RegisterServerEvent('qb-vehicleshop:server:SetCustomShowroomVeh')
AddEventHandler('qb-vehicleshop:server:SetCustomShowroomVeh', function(vData, k)
    QB.ShowroomVehicles[k].vehicle = vData
    TriggerClientEvent('qb-vehicleshop:client:SetCustomShowroomVeh', -1, vData, k)
end)

RegisterServerEvent('qb-vehicleshop:server:SetFin')
AddEventHandler('qb-vehicleshop:server:SetFin', function(fin)
    TriggerClientEvent('qb-vehicleshop:client:SetFin', -1, fin)
end)

RegisterServerEvent('qb-vehicleshop:server:SetDP')
AddEventHandler('qb-vehicleshop:server:SetDP', function(dp)
    TriggerClientEvent('qb-vehicleshop:client:SetDP', -1, dp)
end)

QBCore.Commands.Add("sellv", "Sell ​​vehicle from Custom Car Dealer", {}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    local TargetId = args[1]

    if Player.PlayerData.job.name == "cardealer" then
        if TargetId ~= nil then
            TriggerClientEvent('qb-vehicleshop:client:SellCustomVehicle', source, TargetId)
        else
            TriggerClientEvent('QBCore:Notify', source, 'You must provide a Player ID!', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', source, 'You are not a Vehicle Dealer', 'error')
    end
end)

QBCore.Commands.Add("testdrive", "Test Drive the car", {}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    local TargetId = args[1]

    if Player.PlayerData.job.name == "cardealer" then
        TriggerClientEvent('qb-vehicleshop:client:DoTestrit', source, GeneratePlate())
    else
        TriggerClientEvent('QBCore:Notify', source, 'You are not a Vehicle Dealer', 'error')
    end
end)

RegisterServerEvent('qb-vehicleshop:server:TestDrivePDM')
AddEventHandler('qb-vehicleshop:server:TestDrivePDM', function()
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "cardealer" then
        TriggerClientEvent('qb-vehicleshop:client:DoTestPDM', source, GeneratePlate())
    else
        TriggerClientEvent('QBCore:Notify', source, 'You are not a Vehicle Dealer', 'error')
    end
end)

QBCore.Commands.Add("financev", "Sell ​​vehicle from Custom Car Dealer", {}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    local TargetId = args[1]

    if Player.PlayerData.job.name == "cardealer" then
        if TargetId ~= nil then
            TriggerClientEvent('qb-vehicleshop:client:FinanceCustomVehicle', source, TargetId)
        else
            TriggerClientEvent('QBCore:Notify', source, 'You must provide a Player ID!', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', source, 'You are not a Vehicle Dealer', 'error')
    end
end)

QBCore.Commands.Add("finance", "Check Pending Finance and Pay it", {{name="amount", help="Amount to Pay (Leave Blank for Checking)"}}, false, function(source, args)
    
    local Player = QBCore.Functions.GetPlayer(source)
    local cid = Player.PlayerData.citizenid
    local amount = (tonumber(args[1]))
    local balance = Player.PlayerData.money["bank"]

    QBCore.Functions.ExecuteSql(false, "SELECT * FROM `players` WHERE `citizenid` = '"..cid.."' ", function(result)
        if result[1] ~= nil then
            for k, v in pairs(result) do
                if v.pending_finance == 0 then
                    TriggerClientEvent('chatMessage', source, "SYSTEM", "error", 'You don\'t have Pending Finances.')
                else
                    QBCore.Functions.ExecuteSql(false, "SELECT * FROM `player_vehicles` WHERE `citizenid` = '"..cid.."' ", function(result)
                        if result[1] ~= nil then
                        for k, v in pairs(result) do
                            if amount == nil and v.finance_owed > 0 then 
                                TriggerClientEvent('chatMessage', source, "SYSTEM", "error", 'You currently owe $'..v.finance_owed..' to PDM Finserv')
                            elseif amount ~= nil then 
                            if v.finance_owed > 0 then
                                if (amount - v.finance_owed) < 0 then
                                            if (balance >= amount) then
                                                QBCore.Functions.ExecuteSql(false, "UPDATE `player_vehicles` SET `finance_owed` = '"..v.finance_owed.."' - '"..amount.."' WHERE `plate` = '"..v.plate.."'")
                                                Player.Functions.RemoveMoney("bank",amount,'paid-finance')
                                                TriggerClientEvent('chatMessage', source, "SYSTEM", "success", 'You paid $'..amount..' against pending finances.')
                                            else
                                                TriggerClientEvent('chatMessage', source, "SYSTEM", "error", 'You don\'t have enough money.')
                                            end
                                elseif (amount - v.finance_owed) == 0 then
                                            if (balance >= amount) then
                                                QBCore.Functions.ExecuteSql(false, "UPDATE `player_vehicles` SET `finance_owed` = '"..v.finance_owed.."' - '"..amount.."' WHERE `plate` = '"..v.plate.."'")
                                                Player.Functions.RemoveMoney("bank",amount,'paid-finance')
                                                TriggerClientEvent('chatMessage', source, "SYSTEM", "success", 'You paid $'..amount..' against pending finances.')
                                                QBCore.Functions.ExecuteSql(false, "UPDATE `players` SET `pending_finance` = 0 WHERE `citizenid` = '"..cid.."'")
                                            else
                                                TriggerClientEvent('chatMessage', source, "SYSTEM", "error", 'You don\'t have enough money.')
                                            end
                                else 
                                    TriggerClientEvent('chatMessage', source, "SYSTEM", "error", 'Seems like you are paying more than required')
                                end         
                            end
                            end
                        end
                    end
                end)
                end
            end
        end
    end)
    
end)


RegisterServerEvent('qb-vehicleshop:server:SellCustomVehicle')
AddEventHandler('qb-vehicleshop:server:SellCustomVehicle', function(TargetId, ShowroomSlot)
    TriggerClientEvent('qb-vehicleshop:client:SetVehicleBuying', TargetId, ShowroomSlot)
end)

RegisterServerEvent('qb-vehicleshop:server:FinanceCustomVehicle')
AddEventHandler('qb-vehicleshop:server:FinanceCustomVehicle', function(TargetId, ShowroomSlot)
    TriggerClientEvent('qb-vehicleshop:client:SetVehicleFinance', TargetId, ShowroomSlot)
end)

RegisterServerEvent('qb-vehicleshop:server:ConfirmVehicle')
AddEventHandler('qb-vehicleshop:server:ConfirmVehicle', function(ShowroomVehicle)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local VehPrice = QBCore.Shared.Vehicles[ShowroomVehicle.vehicle].price
    local plate = GeneratePlate()

    if Player.PlayerData.money.cash >= VehPrice then
        Player.Functions.RemoveMoney('cash', VehPrice)
        TriggerEvent("qb-moneysafe:server:Depositcardealer",VehPrice*0.2)
        TriggerClientEvent('qb-vehicleshop:client:ConfirmVehicle', src, ShowroomVehicle, plate)
        QBCore.Functions.ExecuteSql(false, "INSERT INTO `player_vehicles` (`steam`, `citizenid`, `vehicle`, `hash`, `mods`, `plate`, `state`) VALUES ('"..Player.PlayerData.steam.."', '"..Player.PlayerData.citizenid.."', '"..ShowroomVehicle.vehicle.."', '"..GetHashKey(ShowroomVehicle.vehicle).."', '{}', '"..plate.."', 0)")
    elseif Player.PlayerData.money.bank >= VehPrice then
        Player.Functions.RemoveMoney('bank', VehPrice)
        TriggerEvent("qb-moneysafe:server:Depositcardealer",VehPrice*0.2)
        TriggerClientEvent('qb-vehicleshop:client:ConfirmVehicle', src, ShowroomVehicle, plate)
        QBCore.Functions.ExecuteSql(false, "INSERT INTO `player_vehicles` (`steam`, `citizenid`, `vehicle`, `hash`, `mods`, `plate`, `state`) VALUES ('"..Player.PlayerData.steam.."', '"..Player.PlayerData.citizenid.."', '"..ShowroomVehicle.vehicle.."', '"..GetHashKey(ShowroomVehicle.vehicle).."', '{}', '"..plate.."', 0)")
    else
        if Player.PlayerData.money.cash > Player.PlayerData.money.bank then
            TriggerClientEvent('QBCore:Notify', src, 'You don\'t have enough money ... You are missing ('..(Player.PlayerData.money.cash - VehPrice)..',-)')
        else
            TriggerClientEvent('QBCore:Notify', src, 'You don\'t have enough money ... You are missing ('..(Player.PlayerData.money.bank - VehPrice)..',-)')
        end
    end
end)

RegisterNetEvent('qb-vehicleshop:server:ConfirmVehicleFinance')
AddEventHandler('qb-vehicleshop:server:ConfirmVehicleFinance', function(vehicle, class)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    local cid = pData.PlayerData.citizenid
    local balance = pData.PlayerData.money["bank"]
    local vehicleValue = QBCore.Shared.Vehicles[ShowroomVehicle.vehicle].price
    local financeInstallment = (vehicleValue * 0.15)
    local plate = GeneratePlate()

    if (balance - financeInstallment) >= 0 then
        QBCore.Functions.ExecuteSql(false, "INSERT INTO `player_vehicles` (`steam`, `citizenid`, `vehicle`, `hash`, `mods`, `plate`, `state`,`finance_owed`) VALUES ('"..pData.PlayerData.steam.."', '"..cid.."', '"..ShowroomVehicle.vehicle.."', '"..GetHashKey(ShowroomVehicle.vehicle).."', '{}', '"..plate.."', 0, '"..vehicleValue.."')")
        TriggerClientEvent("QBCore:Notify", src, "Successful! Your vehicle is waiting for you outside.", "success", 5000)
        TriggerClientEvent('qb-vehicleshop:client:ConfirmVehicle', src, ShowroomVehicle, plate)
        pData.Functions.RemoveMoney('bank', financeInstallment, "vehicle-financed-in-showroom")
        TriggerEvent("qb-log:server:sendLog", cid, "vehiclebought", {model=vehicle, name=QBCore.Shared.Vehicles[ShowroomVehicle.vehicle]["name"], from="showroom", moneyType="bank", price=QBCore.Shared.Vehicles[ShowroomVehicle.vehicle]["price"], plate=plate})
        TriggerEvent("qb-log:server:CreateLog", "vehicleshop", "Vehicle bought (showroom)", "green", "**"..GetPlayerName(src) .. "** has bought " .. QBCore.Shared.Vehicles[ShowroomVehicle.vehicle]["name"] .. " one for $" .. QBCore.Shared.Vehicles[ShowroomVehicle.vehicle]["price"])
    else
        TriggerClientEvent("QBCore:Notify", src, "You don't have enough money, you are missing $"..format_thousand(financeInstallment - balance), "error", 5000)
    end
end)

QBCore.Functions.CreateCallback('qb-vehicleshop:server:SellVehicle', function(source, cb, vehicle, plate)
    local VehicleData = QBCore.Shared.VehicleModels[vehicle]
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    QBCore.Functions.ExecuteSql(false, "SELECT * FROM `player_vehicles` WHERE `citizenid` = '"..Player.PlayerData.citizenid.."' AND `plate` = '"..plate.."'", function(result)
        if result[1] ~= nil then
            if result[1].finance_owed <= 0 then
                Player.Functions.AddMoney('bank', math.ceil(VehicleData["price"] / 100 * 60))
                QBCore.Functions.ExecuteSql(false, "DELETE FROM `player_vehicles` WHERE `citizenid` = '"..Player.PlayerData.citizenid.."' AND `plate` = '"..plate.."'")
                cb(true)
            else
                TriggerClientEvent("QBCore:Notify",src ,"This vehicle is on finance, it cannot be sold untill all payments are made", "error")
                cb(false)
            end
        else
            cb(false)
        end
    end)
end)
