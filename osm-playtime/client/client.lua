-- MADE BY OSMIUM - DISCORD.IO/OSMFX --
QBCore = nil

Citizen.CreateThread(function() 
    while QBCore == nil do
          TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end) 
          Citizen.Wait(200)
    end
end)

local isLoggedIn = false

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
    TriggerEvent('osm-playtime:Main')   
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload')
AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    isLoggedIn = false
end)

RegisterNetEvent('osm-playtime:Main')
AddEventHandler('osm-playtime:Main', function()
    while true do 
        if isLoggedIn then 
            Citizen.Wait(120000)
            TriggerServerEvent('osm-playtime:Server:MainTrigger')
        else
            Citizen.Wait(120000)
        end
    end
end)

RegisterNetEvent('osm-playtime:Leaderboard')
AddEventHandler('osm-playtime:Leaderboard', function(res)
    TriggerEvent('chat:addMessage', {
        template = '<div class="chat-message advert"><div class="chat-message-body"><strong>OSM-REFERRALS LEADERBOARD</strong><br>'..res..'</div></div>',
    })
end)
