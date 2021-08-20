# QBUS x OSM | A VAST FARMING SCRIPT | Cows, Corn Farm, Oranges and more!
I think its one of the Largest Farming Scripts ever made for QBUS Servers. With Corn Farming , it has Cows to Get Milk from. I also integrated an Orange farm to get some oranges and pack them. Taking Reference from PawnShop, Selling System has been built to get you Money out of your Work! I hope that you guys like my work! A full list of Features is given below. 

## DISCORD
<a href="https://discord.gg/jrNxkpVaJU" rel="some text">![Discord](https://discordapp.com/api/guilds/816584206838398997/widget.png?style=banner4)</a>

## IN-RP FEATURES
- Using Tractors to Mow the Farm / Field
- Dynamic Growth of Crops after Water Supply is on!
- Cow Farm with Lots of Cows that wander around the farm.
- Milk the Cows, collect Milk and Pack it to Sell it.
- Integrated Orange Farm to collect Oranges and Pack them to Sell them!
- Selling System - PawnShop Inspired

## SCRIPT FEATURES
- Highly Customizable (You can customize literally everyting using the config.)
- Blips for all Interactable Locations 
- Unique MLO for Bradlock Farm 
- Unique Items for the Script itself with Images. 

## SETUP
1. Add these items to your `shared.lua` file. 
```
	["corn_kernel"] 		         = {["name"] = "corn_kernel", 			        ["label"] = "Cone Kernel", 	            ["weight"] = 300, 		["type"] = "item", 		["image"] = "corn_kernel.png", 	        ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Corn kernel"},
	["corn_packet"] 		         = {["name"] = "corn_packet", 			        ["label"] = "Cone Packet", 	            ["weight"] = 500, 		["type"] = "item", 		["image"] = "corn_packet.png", 	        ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Corn Packet"},
	["orange"] 		                 = {["name"] = "orange", 			            ["label"] = "Orange", 	                ["weight"] = 100, 		["type"] = "item", 		["image"] = "orange.png", 	            ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Orange"},
	["fruit_pack"] 		             = {["name"] = "fruit_pack", 			        ["label"] = "Fruit Pack", 	            ["weight"] = 300, 		["type"] = "item", 		["image"] = "fruit_pack.png", 	        ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Fruit Pack"},
	["milk"] 		                 = {["name"] = "milk", 			                ["label"] = "Milk", 	                ["weight"] = 200, 		["type"] = "item", 		["image"] = "milk.png", 	            ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Milk"},
	["milk_pack"] 		             = {["name"] = "milk_pack", 			        ["label"] = "Milk Pack", 	            ["weight"] = 500, 		["type"] = "item", 		["image"] = "milk_pack.png", 	        ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "Milk pack"},
	["box"] 		                 = {["name"] = "box", 			                ["label"] = "Box", 	                	["weight"] = 100, 		["type"] = "item", 		["image"] = "box.png", 	            ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["description"] = "box"},
```
Then navigate to your Inventory. Add Images provided in `images` folder to the Inventory. 

2. Add the Script to your resources.cfg 
3. Start your Server Again. 

## CREDITS
- Alen for Assisting in Development.
- All Contributors who gave their time into testing scripts.
- R.Linn for the IDEA! 

## LICENSE
<a rel="license" href="http://creativecommons.org/licenses/by-nc-nd/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-nd/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc-nd/4.0/">Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License</a>.

**The above applies to All Files in the Above Repository with .LUA extention. By Using the Repository in any manner, you agree to follow the terms in the License.**
