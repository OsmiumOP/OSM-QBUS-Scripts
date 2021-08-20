--------------------------------------------------
-- 				Don't edit anything here		--
--				  Recreated by Polygon			--
--------------------------------------------------

local inMenu = false

local keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

-- User Interaction
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if near() then
			Notify(_U("open_menu"))
			if IsControlJustPressed(1, keys[Config.Keys.Open]) then
				openUI()
				local ped = GetPlayerPed(-1)
				TriggerServerEvent("invest:balance")
			end
	
			if IsControlJustPressed(1, keys[Config.Keys.Close]) and inMenu then
				closeUI()
			end
		end
	end
end)

Citizen.CreateThread(function()
	if Config.BlipActive then
		for k,v in ipairs(Config.BlipCoords) do
		local blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite(blip, Config.BlipID)
		SetBlipDisplay(blip, 4)
		SetBlipScale(blip, 0.9)
		SetBlipColour(blip, 2)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(Config.BlipName)
		EndTextCommandSetBlipName(blip)
		end
	end
end)

-- Events
RegisterNetEvent("invest:nui")
AddEventHandler("invest:nui", function (data)
	SendNUIMessage(data)
end)

-- UI callbacks
RegisterNUICallback('close', function(data, cb) 
	if(inMenu) then
		closeUI()
	end
end)

RegisterNUICallback("newBanking", function()
	if(inMenu) then
		closeUI()
		exports.banking:openUI()
	end
end)

RegisterNUICallback("list", function()
	TriggerServerEvent("invest:list")
end)

RegisterNUICallback("all", function()
	TriggerServerEvent("invest:all", false)
end)

RegisterNUICallback("sell", function()
	TriggerServerEvent("invest:all", true)
end)

RegisterNUICallback("sellInvestment", function(data, cb)
	TriggerServerEvent("invest:sell", data.job)
end)

RegisterNUICallback("buyInvestment", function(data, cb)
	TriggerServerEvent("invest:buy", data.job, data.amount, data.boughtRate)
end)

RegisterNUICallback("balance", function(data, cb)
	TriggerServerEvent("invest:balance")
end)

-- Open UI
function openUI()
	inMenu = true
	SetNuiFocus(true, true)
    SendNUIMessage({type = "open"})
end

-- Close UI
function closeUI() 
	inMenu = false
	SetNuiFocus(false, false)
    SendNUIMessage({type = "close"})
end

-- Close menu on close
AddEventHandler('onResourceStop', function (resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
	  return
    end
    if inMenu then
        closeUI()
    end
end)

-- near a blip
function near()
	local player = GetPlayerPed(-1)
	local playerloc = GetEntityCoords(player, 0)

	for _, search in pairs(Config.BlipCoords) do
		local distance = GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc['x'], playerloc['y'], playerloc['z'], true)

		if distance <= 4 then
			return true
		end
	end
end

function Notify(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end