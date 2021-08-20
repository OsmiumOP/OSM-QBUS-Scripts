posX = 0.01
posY = 0.0-- 0.0152

width = 0.183
height = 0.24--0.354

local loaded = false

AddEventHandler("playerSpawned", function()
	if not loaded then
		loaded = true
	
		RequestStreamedTextureDict("circlemap", false)
		while not HasStreamedTextureDictLoaded("circlemap") do
			Wait(100)
		end

		AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "circlemap", "radarmasksm")

		SetMinimapClipType(1)
		SetMinimapComponentPosition('minimap', 'L', 'B', posX, posY - 0.05, width, height)
		--SetMinimapComponentPosition('minimap_mask', 'L', 'B', 0.0, 0.032, 0.101, 0.259)
		SetMinimapComponentPosition('minimap_mask', 'L', 'B', posX, posY, width, height)
		SetMinimapComponentPosition('minimap_blur', 'L', 'B', 0.012, 0.022, 0.256, 0.337)

		local minimap = RequestScaleformMovie("minimap")
		SetRadarBigmapEnabled(true, false)
		Wait(0)
		SetRadarBigmapEnabled(false, false)

		while true do
			Wait(0)
			BeginScaleformMovieMethod(minimap, "SETUP_HEALTH_ARMOUR")
			ScaleformMovieMethodAddParamInt(3)
			EndScaleformMovieMethod()
		end
	end
end)

AddEventHandler("osm-gameplay:enteredVehicle", function()
	SendNUIMessage({
		action = "displayUI"
	})
end)

AddEventHandler("osm-gameplay:exitVehicle", function()
	SendNUIMessage({
		action = "hideUI"
	})
end)

local pauseMenu = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		
		if IsPauseMenuActive() and not pauseMenu then
			pauseMenu = true
			SendNUIMessage({
				open = 30,
			}) 
			if IsPedInAnyVehicle(PlayerPedId()) then
				SendNUIMessage({
					action = "hideUI"
				})
			end
		elseif not IsPauseMenuActive() and pauseMenu then
			pauseMenu = false
			if IsPedInAnyVehicle(PlayerPedId()) then
				SendNUIMessage({
					action = "displayUI"
				})
			end
		end
	end
end)