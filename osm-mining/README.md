# QBUS x OSM | Explosive Mining | Redesigned Mining Job with Explosives and Drilling. 
Redesigned the native QBUS Mining to something different. Now it involves use of Explosives, and Jackhammer to break rocks. Its different from all other out in the place, and is completely free to use. 

### [Preview](https://www.youtube.com/watch?v=H1rx_2WJVJc)
### [Discord](https://discord.gg/jrNxkpVaJU)

## Features
- Replaced native Pickaxe with Explosive Planting.
- Added Jackhammer Animations
- Added Washing and Processing at a new Spot

## Setup 
- Only one thing you must check before starting, is that the items in `config.lua` and `server.lua` must be there in your server. 

Also check if your shared.lua has Stone and Washed Stone else add this and use Images in `inventory-imgs` for icons.
```
["stone"] 		 	 		= {["name"] = "stone",           	["label"] = "Stone",	 	["weight"] = 3500, 	    ["type"] = "item", 		["image"] = "stone.png", 		["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "ORE"},

["washedstone"] 		  = {["name"] = "washedstone",           ["label"] = "Washed Stone",	 	["weight"] = 3500, 	    ["type"] = "item", 		["image"] = "washedstone.png", 		["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "ORE"},
```

## Credits
- Ariz as always for supporting Development and Testing. 
