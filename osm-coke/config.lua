Config = {}
Config.Locale = 'en' -- English, German or Spanish - (en/de/es)

Config.useMythic = true -- change this if you want to use mythic_notify or not
Config.progBar = true -- change this if you want to use Progress Bar or not

Config.doorHeading = 112.32 -- change this to the proper heading to look at the door you start the runs with
Config.price = 1500 -- amount you get after the run 
Config.amount = 2000 --amount you have to pay to start a run 
Config.cokeTime = 60000 -- time in ms the effects of coke will last for
Config.pickupTime = 5000 -- time it takes to pick up the delivery 
Config.randBrick = math.random(1,2) -- change the numbers to how much coke you want players to receive after breaking down bricks
Config.takeBrick = 1 -- amount of brick you want to take after processing
Config.getCoords = false -- gets coords with /mycoords

Config.RunTime = 120   -- TIME in SEC

Config.locations = {
	[1] = { 
		fuel = {x = 2140.458, y = 4789.831, z = 40.97033}, -- location of the jerry can/waypoint
		landingLoc = {x = 1743.822, y = 3258.627, z = 41.36734}, -- don't mess with this unless you know what you're doing
		plane = {x = 736.6801, y = 2973.17, z = 93.81644, h = 284.13}, -- don't mess with this unless you know what you're doing
		runwayStart = {x = 1709.604, y = 3251.045, z = 41.03549}, -- don't mess with this unless you know what you're doing
		runwayEnd = {x = 1064.045, y = 3076.735, z = 41.16898}, -- don't mess with this unless you know what you're doing
		fuselage = {x = 2134.83, y = 4782.82, z = 41.19522}, -- location of the 3D text to fuel the plane
		stationary = {x = 2134.83, y = 4782.82, z = 41.19522, h = 296.68}, -- location of the plane if Config.landPlane is false 
		delivery = {x = -3101.3, y = 5379.65, z = 3.9}, -- delivery location
		hangar = {x = 2134.474, y = 4780.939, z = 40.97027}, -- end location
		parking = {x = 2133.455078125, y = 4783.6123046875, z = 40.970287322998, h = 24.761905670166}, -- don't mess with this unless you know what you're doing															
	},
}




