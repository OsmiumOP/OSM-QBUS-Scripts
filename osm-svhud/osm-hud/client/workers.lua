QBCore = nil

Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
}

isLoggedIn = true
stress = 0
PlayerJob = {}

Citizen.CreateThread(function() 
    while true do
        Citizen.Wait(10)
        if QBCore == nil then
            TriggerEvent("QBCore:GetObject", function(obj) QBCore = obj end)    
            Citizen.Wait(200)
        end
        if QBCore ~= nil then
            TriggerEvent("hud:client:SetMoney")
            return
        end
    end
end)

RegisterNetEvent("QBCore:Client:OnPlayerLoaded")
AddEventHandler("QBCore:Client:OnPlayerLoaded", function()
    isLoggedIn = true
    QBHud.Show = true
    PlayerJob = QBCore.Functions.GetPlayerData().job
end)

local StressGain = 0
local IsGaining = false

Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()

        if IsPedShooting(PlayerPedId()) then

                local PlusStress = math.random(2, 4)
                StressGain = StressGain + PlusStress

            if not IsGaining then
                IsGaining = true
            end
        else
            if IsGaining then
                IsGaining = false
            end
        end

        Citizen.Wait(100)
    end
end)

Citizen.CreateThread(function()
    while true do

        if not IsGaining then
                if StressGain > 0 then
                QBCore.Functions.Notify('Stress gained', "primary", 2000)
                TriggerServerEvent('qb-hud:Server:UpdateStress', StressGain)
                StressGain = 0
            end 
        end

        Citizen.Wait(2000)
    end
end)

Citizen.CreateThread(function()
    while true do
        local Gain = math.random(1,4)
        TriggerServerEvent('qb-hud:Server:UpdateNeeds', Gain)
        Citizen.Wait(60000)
    end
end)


RegisterNetEvent("hud:client:ShowMoney")
AddEventHandler("hud:client:ShowMoney", function(type)
    QBCore.Functions.GetPlayerData(function(PlayerData)
        if PlayerData ~= nil and PlayerData.money ~= nil then
            cashAmount = PlayerData.money["cash"]
        end
    end)
    TriggerEvent('chat:addMessage', {
        color = { 255, 0, 0},
        multiline = true,
        args = {"Me", 'You have $'..cashAmount..' as Cash'}
      })
            
end)

RegisterNetEvent("hud:client:ShowMoneyBank")
AddEventHandler("hud:client:ShowMoneyBank", function(type)
    QBCore.Functions.GetPlayerData(function(PlayerData)
        if PlayerData ~= nil and PlayerData.money ~= nil then
            cashAmount = PlayerData.money["bank"]
        end
    end)
    TriggerEvent('chat:addMessage', {
        color = { 255, 0, 0},
        multiline = true,
        args = {"Me", 'You have $'..cashAmount..' in Bank'}
      })
            
end)

RegisterNetEvent("hud:client:OnMoneyChange")
AddEventHandler("hud:client:OnMoneyChange", function(type, amount, isMinus)
    QBCore.Functions.GetPlayerData(function(PlayerData)
        cashAmount = PlayerData.money["cash"]
        bankAmount = PlayerData.money["bank"]
    end)
    if isMinus then 
        QBCore.Functions.Notify('$'..amount..' Deducted from Your '..type..' Account','error', 5000)
    else
         QBCore.Functions.Notify('$'..amount..' Added to Your '..type..' Account','success', 5000)
    end
end)

Citizen.CreateThread(function()
    while true do
		 local wait = 1000
        if QBCore ~= nil and isLoggedIn and QBHud.Show then
            if IsPedInAnyVehicle(PlayerPedId(), false) then
                speed = GetEntitySpeed(GetVehiclePedIsIn(PlayerPedId(), false)) * 3.6
                if speed >= QBStress.MinimumSpeed then
                    TriggerServerEvent('qb-hud:Server:UpdateStress', math.random(1, 2))
                end
            end
        end
        Citizen.Wait(wait)
    end
end)