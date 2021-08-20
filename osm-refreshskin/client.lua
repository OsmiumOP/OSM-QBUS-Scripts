QBCore = nil

Citizen.CreateThread(function() 
  while true do
    Citizen.Wait(1)
    if QBCore == nil then
      TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end) 
      Citizen.Wait(200)
    end
  end
end)

----------------------------------------------------------------------------------------------------

RegisterCommand("refreshskin", function(source, args, rawCommand)


  local playerPed = PlayerPedId()
  local maxhealth = GetEntityMaxHealth(playerPed)
  local health = GetEntityHealth(playerPed)

  reloadSkin(health)

end)

function reloadSkin(health)

  local model = nil
       
  local gender = QBCore.Functions.GetPlayerData().charinfo.gender

  if gender == 1 then -- Gender is ONE for FEMALE
    model = GetHashKey("mp_f_freemode_01") -- Female Model
  else 
    model = GetHashKey("mp_m_freemode_01") -- Male Model
  end 

  RequestModel(model)

  SetPlayerModel(PlayerId(), model)
  SetModelAsNoLongerNeeded(model)
    Citizen.Wait(1000) -- Safety Delay
   
  TriggerServerEvent("qb-clothes:loadPlayerSkin") -- LOADING PLAYER'S CLOTHES
  TriggerServerEvent("qb-clothing:loadPlayerSkin") -- LOADING PLAYER'S CLOTHES - Event 2

  SetPedMaxHealth(PlayerId(), maxhealth)
    Citizen.Wait(1000) -- Safety Delay
  SetEntityHealth(PlayerPedId(), health)

end
