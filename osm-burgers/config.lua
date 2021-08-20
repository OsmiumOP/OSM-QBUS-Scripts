Config = {}

Config.JobStart = {
	{ ["x"] = 94.06, ["y"] = 285.68, ["z"] = 110.51, ["h"] = 0 },
}

Config.PickUpStuff = {
	{ ["x"] = 650.68, ["y"] = 2727.25, ["z"] = 41.99, ["h"] = 0 },
}

Config.PaymentTaco = math.random(350, 450)

Config.BurgerPrice = 100 -- Driveby Burger Price

Config.Driveby = math.random(250, 350) 

Config.JobBusy = false

Config.JobData = {
 ['burgers'] = 0,
 ['register'] = 0,
 ['stock-lettuce'] = 0,
 ['stock-bread'] = 0,
 ['stock-meat'] = 0,
 ['green-tacos'] = 110,
 ['locations'] = {
    [1] = {
	  ['name'] = 'Lettuce', 
	  x = 92.22,
	  y = 295.44,
	  z = 110.51,
	},
	[2] = {
	  ['name'] = 'Meat', 
	  x = 95.23,
	  y = 294.37,
	  z = 110.21,
	},
	[3] = {
	  ['name'] = 'Shell', 
	  x = 93.59,
	  y = 294.94,
	  z = 110.51,
	},
	[4] = {
		['name'] = 'Register', 
		x = 80.65,
		y = 294.25,
		z = 110.51,
	  },
	[5] = {
		['name'] = 'GiveTaco', 
		x = 94.29,
		y = 292.56,
		z = 110.51,
	  },
	[6] = {
		['name'] = 'Stock', 
		x = 89.75,
		y = 296.58,
		z = 110.21,
	  },
	[7] = {
		['name'] = 'Bun', 
		x = 96.01,
		y = 292.66,
		z = 110.21,
	  },
	[8] = {
		['name'] = 'Driveby', 
		x = 96.56,
		y = 284.45,
		z = 110.51,
	  },
  },
}