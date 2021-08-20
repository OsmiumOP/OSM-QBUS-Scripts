-- REDESIGNED BY OSMIUM | DISCORD.IO/OSMFX

--------------------
-- QBCore Core Stuff --
--------------------
QBCore = nil

Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(200)
    end
end)
---------------
-- Variables --
---------------

local mining = false
local exploded = false
local iswashing = false

---------------------
-- Citizen Threads --
---------------------
local closeTo = 0

Citizen.CreateThread(function()
    while true do
        
        for k, v in pairs(Config.MiningPositions) do
            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.coords, true) <= 2.5 then
                closeTo = v
                break
            end
        end
        
        if type(closeTo) == 'table' then
            while GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), closeTo.coords, true) <= 2.5 and not exploded do
                local counter = 0
                Wait(0)
                helpText(Strings['press_mine'])
                if IsControlJustReleased(0, 38) then
                    local player, distance = QBCore.Functions.GetClosestPlayer()
                    if distance == -1 or distance >= 4.0 then
                        mining = true
                        GiveWeaponToPed(PlayerPedId(), GetHashKey("weapon_stickybomb"), 1, false, true)
                        Citizen.Wait(1250)                                                                                      
                        TaskPlantBomb(PlayerPedId(), closeTo.coords, 218.5)

                        while mining and not exploded do
                            -- Wait(1000)
                            local time = 6
							while time > 0 do 
								QBCore.Functions.Notify("Blast in about " .. time .. "..")
								Citizen.Wait(1000)
								time = time - 1
							end
                            
							AddExplosion(closeTo.coords.x, closeTo.coords.y, closeTo.coords.z, EXPLOSION_STICKYBOMB, 4.0, true, false, 20.0)
                            exploded = true
                            local rock = GetHashKey("prop_rock_4_c")
                            rock1 = CreateObject(rock, closeTo.coords.x, closeTo.coords.y , closeTo.coords.z + 2.5, true, true, true)                           
                        end
                    else
                        QBCore.Functions.Notify(Strings['someone_close'], "error")
                        -- TriggerEvent('cy-notify:send', Strings['someone_close'], 1)
                    end
                end
            end
        end
        Wait(300)
    end
end)

Citizen.CreateThread(function()
    local sleep
    while true do
        sleep = 5
        local player = PlayerPedId()
        local pos = GetEntityCoords(player)
        if exploded then
            if GetDistanceBetweenCoords(GetEntityCoords(rock1), GetEntityCoords(player), true) <= 2.5 then
                sleep = 5
                local rpos = GetEntityCoords(rock1)
                QBCore.Functions.DrawText3D(rpos.x, rpos.y, rpos.z,'Press ~g~[ E ]~w~ to Break the Piece of Rock')
                if IsControlJustPressed(0, 38) then
                    
                    local model = loadModel(GetHashKey(Config.Objects['drill']))
                    local axe = CreateObject(model, GetEntityCoords(PlayerPedId()), true, false, false)
                    AttachEntityToEntity(axe, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.09, 0.03, -0.02, 0.0, 0.0, 0.0, false, true, true, true, 0, true)
                        Citizen.Wait(100)

                    FreezeEntityPosition(player, true)
                    local dict = loadDict('amb@world_human_const_drill@male@drill@base')
                    TaskPlayAnim(PlayerPedId(), dict, 'base', 8.0, -8.0, -1, 2, 0, false, false, false)

                    Citizen.Wait(5000)

                    ClearPedTasks(PlayerPedId())
                    FreezeEntityPosition(player, false)
                    DeleteObject(axe)
                    DeleteObject(rock1)

                    TriggerServerEvent('osm-mining:getStone')

                    iswashing = false
                    exploded = false
                    mining = false
                end
            else
                sleep = 2500
            end
        else
            sleep = 3000
        end
        Citizen.Wait(sleep)
    end
end)

local washcords = Config.WashCoords
local process = Config.GetMetal

Citizen.CreateThread(function()
	local sleep
	while true do
		sleep = 5
		local player = PlayerPedId()
		local playercoords = GetEntityCoords(player)
		local dist = #(vector3(playercoords.x,playercoords.y,playercoords.z)-vector3(washcords.x,washcords.y,washcords.z))
		if dist <= 3 and not isWashing then
			sleep = 5
			DrawText3D(washcords.x, washcords.y, washcords.z, 'Press [ E ] to Wash a Stone')
			if IsControlJustPressed(1, 51) then
				isWashing = true
				QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
                        if result then
                            local model = loadModel(Config.Objects['stone'])
                            stone = CreateObject(model, GetEntityCoords(PlayerPedId()), true, false, false)
                            AttachEntityToEntity(stone, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.09, 0.03, -0.02, 0.0, 0.0, 0.0, false, true, true, true, 0, true)
                            washing()
                        else
                            QBCore.Functions.Notify("You don't have material", "error")
                            isWashing = false
                        end
				end, 'stone')
			end
		else
			sleep = 2000
		end
		Citizen.Wait(sleep)
	end
end)

Citizen.CreateThread(function()
	local sleep
	while true do
		sleep = 5
		local player = PlayerPedId()
		local playercoords = GetEntityCoords(player)
		local dist = #(vector3(playercoords.x,playercoords.y,playercoords.z)-vector3(process.x,process.y,process.z))
		if dist <= 3 and not isProcess then
			sleep = 5
			DrawText3D(process.x, process.y, process.z, 'Press [ E ] to Process Washed Stone')
			if IsControlJustPressed(1, 51) then
				isProcess = true
				QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
                        if result then
                            processing()  
                        else
                            QBCore.Functions.Notify("You don't have Washed Stones", "error")
                            isProcess = false
                        end
				end, 'washedstone')
			end
		else
			sleep = 1500
		end
		Citizen.Wait(sleep)
	end
end)

function washing()
	local player = PlayerPedId()
	SetEntityCoords(player, washcords.x,washcords.y,washcords.z-1, 0.0, 0.0, 0.0, false)
	SetEntityHeading(player, 286.84)
	FreezeEntityPosition(player, true)
	local dict = loadDict('amb@prop_human_bum_bin@idle_a')
    TaskPlayAnim((player), 'amb@prop_human_bum_bin@idle_a', 'idle_a', 8.0, 8.0, -1, 81, 0, 0, 0, 0)
    helpText(Strings['warning'])
    
	QBCore.Functions.Progressbar("wash-", "Washing Stones..", 5000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function() -- Done
		FreezeEntityPosition(player, false)
        QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
            if result then
                TriggerServerEvent('osm-mining:washing')
                DeleteObject(stone)
                isWashing = false
            else
                QBCore.Functions.Notify("You don't have the material", "error")
                DeleteObject(stone)
                isWashing = false
            end
        end, 'stone')
     
	end, function() -- Cancel
		isWashing = false
        DeleteObject(stone)
		ClearPedTasksImmediately(player)
		FreezeEntityPosition(player, false)
	end)

end

function processing()
	local player = PlayerPedId()
	SetEntityCoords(player, process.x,process.y,process.z-1, 0.0, 0.0, 0.0, false)
	SetEntityHeading(player, 286.84)
	FreezeEntityPosition(player, true)
	local dict = loadDict('amb@prop_human_bum_bin@idle_a')
    TaskPlayAnim((player), 'amb@prop_human_bum_bin@idle_a', 'idle_a', 8.0, 8.0, -1, 81, 0, 0, 0, 0)
    helpText(Strings['warning'])
    
	QBCore.Functions.Progressbar("wash-", "Processing..", 10000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function() -- Done
		FreezeEntityPosition(player, false)
        QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
            if result then
                TriggerServerEvent('osm-mining:getItemNew')
                isProcess = false
            else
                QBCore.Functions.Notify("You don't have Washed Stones", "error")
                isProcess = false
            end
        end, 'washedstone')
     
	end, function() -- Cancel
		isProcess = false
		ClearPedTasksImmediately(player)
		FreezeEntityPosition(player, false)
	end)

end

Citizen.CreateThread(function()
    local blip1 = AddBlipForCoord(washcords.x, washcords.y, washcords.z)
	SetBlipSprite(blip, 527)
	SetBlipDisplay(blip, 4)
	SetBlipScale(blip, 0.6)
	SetBlipAsShortRange(blip, true)
	SetBlipColour(blip, 5)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName("Mining - Wash and Process")
    EndTextCommandSetBlipName(blip1)
end)

Citizen.CreateThread(function()
    local blip = AddBlipForCoord(2992.77, 2750.64, 42.78)
	SetBlipSprite(blip, 527)
	SetBlipDisplay(blip, 4)
	SetBlipScale(blip, 0.6)
	SetBlipAsShortRange(blip, true)
	SetBlipColour(blip, 5)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName("Mining")
    EndTextCommandSetBlipName(blip)
end)

loadModel = function(model)
    while not HasModelLoaded(model) do Wait(0) RequestModel(model) end
    return model
end

loadDict = function(dict, anim)
    while not HasAnimDictLoaded(dict) do Wait(0) RequestAnimDict(dict) end
    return dict
end

helpText = function(msg)
    BeginTextCommandDisplayHelp('STRING')
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandDisplayHelp(0, false, true, -1)
end

DrawText3D = function(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

-- addBlip = function(coords, sprite, colour)
--     local blip = AddBlipForCoord(coords)
--     SetBlipSprite(blip, sprite)
--     SetBlipColour(blip, colour)
--     SetBlipAsShortRange(blip, true)
--     BeginTextCommandSetBlipName("STRING")
--     AddTextComponentSubstringPlayerName("Mining")
--     EndTextCommandSetBlipName(blip)
-- end

-- Code

-- Citizen.CreateThread(function()
--     while true do
--         local ped = PlayerPedId()
--         local pos = GetEntityCoords(ped)
--         local inRange = false

--         if not notInteressted then
--             for k, v in pairs(Config.SellLocations) do
--                 local dist = GetDistanceBetweenCoords(pos, v["coords"]["x"], v["coords"]["y"], v["coords"]["z"], true)

--                 if dist < 20 then
--                     inRange = true

--                     if dist < 1 then
--                         QBCore.Functions.DrawText3D(v["coords"]["x"], v["coords"]["y"], v["coords"]["z"] - 0.1, '~g~E~w~ - Sell Mining Items')

--                         if IsControlJustPressed(0, 38) then
--                             TriggerServerEvent('osm-mining:sell')
--                         end
--                     end
--                 end
--             end
--         else
--             Citizen.Wait(5000)
--         end

--         if not inRange then
--             Citizen.Wait(1500)
--         end

--         Citizen.Wait(3)
--     end
-- end)

function ClearTimeOut()
    notInteressted = not notInteressted
end