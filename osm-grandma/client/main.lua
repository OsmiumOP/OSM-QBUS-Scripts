QBCore = nil

Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(0)
    end
end)

-- CONFIG VARS
local grannypos = { x = 3312.95, y = 5178.88, z = 18.63, h = 210.79 }
Citizen.CreateThread(function()
    modelHash = GetHashKey("ig_mrs_thornhill")
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do
        Wait(1)
    end
    creategrannypos()
end)

function creategrannypos()
    created_ped = CreatePed(0, modelHash, grannypos.x, grannypos.y, grannypos.z, grannypos.h, false, true)
    FreezeEntityPosition(created_ped, true)
    SetEntityInvincible(created_ped, true)
    SetBlockingOfNonTemporaryEvents(created_ped, true)
    TaskStartScenarioInPlace(created_ped, "WORLD_HUMAN_COP_IDLES", 0, true)
end

local prob = math.random(1,10)

healAnimDict = "mini@cpr@char_a@cpr_str"
healAnim = "cpr_pumpchest"

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
    local plyCoords = GetEntityCoords(PlayerPedId(), 0)
    local pos = GetEntityCoords(GetPlayerPed(-1))
        local distance = #(vector3(grannypos.x, grannypos.y, grannypos.z) - plyCoords)
        if distance < 10 then
            if not IsPedInAnyVehicle(PlayerPedId(), true) then
                if distance < 3 then
                    QBCore.Functions.DrawText3D(grannypos.x, grannypos.y, grannypos.z + 0.5, '[E] - Request Grandma for $2,000')
                    DisableControlAction(0, 57, true)
                    if IsDisabledControlJustReleased(0, 54) then

                        QBCore.Functions.Progressbar("check-", "Requesting Grandma for Help", 5000, false, true, {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        }, {}, {}, {}, function()
                            if prob > 5 then
                             loadAnimDict('missheistdockssetup1clipboard@base')
                             TaskPlayAnim(PlayerPedId(), "missheistdockssetup1clipboard@base", "base", 3.0, 1.0, -1, 49, 0, 0, 0, 0 ) 
                             loadAnimDict(healAnimDict)	
                             TaskPlayAnim(created_ped, healAnimDict, healAnim, 3.0, 3.0, 8000, 49, 0, 0, 0, 0)
                             QBCore.Functions.Progressbar("check-", "Blessing You with a Life", 10000, false, true, {
                                disableMovement = true,
                                disableCarMovement = true,
                                disableMouse = false,
                                disableCombat = true,
                             }, {}, {}, {}, function()
                                QBCore.Functions.Notify("You're were treated! ..", "success")
                                TriggerEvent('hospital:client:Revive')
                                TriggerServerEvent('osm-grandma:server:Charge')
                                ClearPedTasks(PlayerPedId())
                             end, function() -- Cancel
                                ClearPedTasks(PlayerPedId())
                            end)
                        else 
                            QBCore.Functions.Notify("Grandma Refused to Help", "error")
                        end 
                        end)
                            
                        
                    end
                end
            end
        else
            Citizen.Wait(1000)
        end
    end
end)


function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(2)
	end
end
