
# OSM x QBUS | BURGERS JOB | Custom Job for McDonalds MLO

#### A Taco-Inspired McDonalds Job for an MLO (by UT MODZ). It is a WIP Job for servers who want to boost their RPs by increasing number of Legal Jobs in the City. With lots of config vars, it can be configured as required. It is by default a job that would require time to be spent on, and would yeild good earnings. 

### [My Discord Server](https://discord.gg/bfPKqNhQPQ) (You can boost it if you like my work :)
### [MLO Preview](https://www.youtube.com/watch?v=qHw63IeCcJs) is available on My Discord Server as well as R5M Forum.


## Script Features 

#### - Specially designed for [THIS MLO](https://www.youtube.com/watch?v=qHw63IeCcJs). 
#### - Added *Burger Bun Making* as an extra part of the JOB.
#### - Added *DRIVEBY* where other citizens can also buy Burgers (if someone makes burgers)
#### - All other features of TACO JOB intact, optimized slightly, and removed useless stuff. 
#### - Locations adapted well to the Beautiful MLO by [UT MODZ](https://www.youtube.com/channel/UCLyHsvgL80IIatiWyhG-TjA)
#### - New Items added and all the code and images are also attached with the resource. 

#### Blips are there on the Map for `McDonalds Outlet` and `McDonalds Storage`

## Instructions for Installation / Setup 

#### Make sure you Have the MLO before hand and started. 

#### Item Images are included in the folder `inv-images` | Should be copied into Inventory Images.

#### Add this into your `SHARED.LUA` in the `Shared Items` (in the CORE FOLDER)

```
["burger"] 		 			 	 = {["name"] = "burger",       		    		["label"] = "Burger",	 					["weight"] = 300, 		["type"] = "item", 		["image"] = "burger.png", 				["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "Some big burger brother"},
["bread"] 		 			 	 = {["name"] = "bread",       		    		["label"] = "Raw Bread",	 				["weight"] = 100, 		["type"] = "item", 		["image"] = "bread.png", 				["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "Some big burger brother"},
["bun"] 		 			 	 = {["name"] = "bun",       		    		["label"] = "Bun",	 					["weight"] = 100, 		["type"] = "item", 		["image"] = "bun.png", 				        ["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "Some big burger brother"},
["meat"] 		 			 	 = {["name"] = "meat",       		    		["label"] = "Meat",	 					["weight"] = 100, 		["type"] = "item", 		["image"] = "meat.png", 				["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "Some big burger brother"},
["lettuce"] 	 			 	    = {["name"] = "lettuce",       			        ["label"] = "Lettuce",	 				["weight"] = 100, 		["type"] = "item", 		["image"] = "lettuce.png", 				["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "Some big burger brother"},
["burger-box"] 	 			    = {["name"] = "burger-box",       			        ["label"] = "Burger Box",	 				["weight"] = 100, 		["type"] = "item", 		["image"] = "taco-box.png",     ["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,                     ["combinable"] = nil,   ["description"] = "Some big burger brother"},
["burger-bag"] 	 			 	  = {["name"] = "burger-bag",       			    ["label"] = "Burger Bag",	 				["weight"] = 100, 		["type"] = "item", 		["image"] = "taco-bag.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,                     ["combinable"] = nil,   ["description"] = "Some big burger brother"},
```
#### Start the Resource and Enjoy. 
