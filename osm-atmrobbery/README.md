# QBUS X OSM | OSM - ATMROBBERY | Feature Rich ATM Robbery with Cooldowns, Timers, and more 

### [DISCORD SERVER](https://discord.gg/jrNxkpVaJU)
### [TEASER](https://www.youtube.com/watch?v=fFSzehbzQfI) - Not the Entire Preview, I want you guys to Download and try it.

## Features 
- An all new Minigame (from Meta_Libs) making ATM Robberies even harder. 
- Cooldown to prevent too many Robberies in Short Time Period
- Customizable Timer to Complete Robbery
- `CONFIG.LUA` with lots of Config Vars to Change Script According to your need!
- LOTS of More Stuff inside the Script.

### SETUP 
- **Script required `META_LIBS` to be also started. Download Both Resources from this Repository, and start both of them in your Server.CFG**
- **CONFIG.LUA contains some important customisations. You can edit them as per need**
- Drill is to be used using ARROW KEYS (Hint)
### CONFIG.LUA
```
-- Police Settings:
Config.RequiredPolice = 0				-- Required Police online to rob an ATM.

-- Time Settings
Config.OnlyNight = false      -- `true` will allow Players to Rob ATMS only during Night (12AM to 6AM)

-- Reward Settings:
Config.MinReward = 15000					-- Set minimum payout
Config.MaxReward = 30000					-- Set maximum payout
Config.RewardAccount = 'cash'     -- Account which is credited for Payouts.

-- Other Settings:
Config.RobberyTime = 5 -- Time a Player will get to Complete the Robbery IN MINUTES
Config.Cooldown = 120 -- Cooldown Time Between Robberies IN MINUTES
```

### CREDITS
- Huge thanks to Ariz for all the TESTING work. 
- Thanks to Laika for the IDEA and YT VIDEO. 
- Thanks to ixTooT for providing a few resources. 

### Known Issues 
- Timer text disappears on going a bit far from ATM. (Not a Bug, but happens cuz I wanted to optimize the script by reducing loops)
- Not all ATMS are supported, Check CONFIG.LUA for supported ATM Locations.
