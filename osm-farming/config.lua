-- SCRIPT DEVELOPED BY OSMIUM | OSMFX | DISCORD.IO/OSMFX --

Config = {}

Config.Locale = 'en'

Config.Delays = {
	CornProcessing = 1000 * 3
}

Config.CornPlant = 'prop_plant_01a'
Config.CornOutput = math.random(2,4)

Config.MowProp = 'prop_air_lights_02b'

Config.SellLocation =  {x = -505.36, y = -695.75, z = 20.03}

Config.Tractor = 'tractor3'
Config.TractorCoords = vector3(2229.3820800781, 5605.5327148438, 54.872543334961)
Config.TractorSpawn = {x = 2195.4331054688, y = 5602.6352539062, z = 53.584144592285, h = 350.36526489258}
Config.TractorSpawnHeading = 349
Config.TractorRent = 2500

Config.CowProp = 'a_c_cow'
Config.MilkOutput = math.random(2,4)

Config.PrimaryColor = {r = 51, g = 136, b = 255, a = 255} -- Use RGB color picker
Config.SecondaryColor = {r = 33, g = 244, b = 218, a = 255} -- Use RGB color picker	

Config.CircleZones = {
	FarmCoords = {coords = vector3(2030.7340087891, 4901.2221679688, 42.721950531006), name = 'blip_weedfield', color = 25, sprite = 496, radius = 100.0},
	Water = {coords = vector3(2041.5297851562, 4854.5625, 43.097927093506), name = 'blip_weedfield', color = 25, sprite = 496, radius = 100.0},
	CowFarm = {coords = vector3(2478.392578125,4728.8315429688,34.303840637207), name = 'blip_weedprocessing', color = 0, sprite = 6, radius = 10.0},

	OrangePack = {coords = vector3(2197.1828613281,5603.3310546875,53.513450622559), name = 'blip_weedprocessing', color = 0, sprite = 6, radius = 10.0},
	MilkPack = {coords = vector3(2198.8520507812,5609.2216796875,53.442737579346), name = 'blip_weedprocessing', color = 0, sprite = 6, radius = 10.0},
	Boxes = {coords = vector3(2192.2998046875,5594.560546875,53.768180847168), name = 'blip_weedprocessing', color = 0, sprite = 6, radius = 10.0},
	CornProcessing = {coords = vector3(2196.0209960938, 5594.4755859375, 53.773300170898), name = 'blip_weedprocessing', color = 0, sprite = 6, radius = 10.0},

}

Config.OrangeFarm = {
	vector3(354.25085449219,6530.5913085938,28.372783660889),
	vector3(338.96520996094,6530.5283203125,28.569303512573),
	vector3(330.09320068359,6531.0278320312,28.569814682007),
	vector3(321.65646362305,6530.7075195312,29.177768707275),
	vector3(329.9287109375,6518.2021484375,28.958410263062),
	vector3(347.37521362305,6518.1303710938,28.804786682129),
	vector3(347.4914855957,6504.6416015625,28.815761566162)
}
-- Config.PipeRepairs = vector3(2293.6293945312,4819.9716796875,53.09984588623)
-- Config.GasSupply = vector3(2304.0451660156,4830.3271484375,50.071781158447)

Config.ItemList = {
    ["orange"] = math.random(10, 20),
    ["milk"] = math.random(15, 25),
	["corn_kernel"] = math.random(15, 20),
    ["corn_packet"] = math.random(150, 200),
    ["milk_pack"] = math.random(100, 300),
	["fruit_pack"] = math.random(150, 350),
}

Config.Blips = {
   	{title="Cow Farm", colour=16, id=141, x = 2478.392578125, y = 4728.8315429688, z = 34.303840637207},
	{title="Corn Farm Supply", colour=16, id=140, x = 2041.5297851562, y = 4854.5625, z= 43.097927093506},
	{title="Braddock Farm", colour=16, id=140, x = 2195.4331054688, y = 5602.6352539062, z = 53.584144592285},
	{title="Orange Farm", colour=16, id=103, x = 346.62341308594, y = 6522.9448242188, z = 28.830759048462},
}

