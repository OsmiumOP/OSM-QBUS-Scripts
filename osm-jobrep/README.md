# OSM x QBUS | JOB REPUTATION SYSTEM | Dynamic System for JOB EMPLOYEES to Earn Reputation based on how actively they perform their JOB. 

### FEATURES 
- Dynamic Rep System : Player earns some Rep for every hour he does a JOB in the city. 
- Customizable events to Award Rep whenever Required 
- Easy-to-use with a Detailed Guide included in the README (below). 

### [DISCORD SUPPORT SERVER](https://discord.gg/jrNxkpVaJU)
### [PREVIEW IMAGE](https://cdn.discordapp.com/attachments/829799717691981854/835178218998726726/unknown.png)

## SETUP INSTRUCTIONS 
Please take backup of files that you change. I am not responsible for any damage you do to your files/server. 
**You need basic knowledge of QBUS Framework, and basic IDEA of what events trigger when, and on what conditions. Though I can't help every single one who gets stuck, you can expect help on my DISCORD SERVER.**

**CORE CHANGE INSTRUCTIONS**
- Go to the Core -> Server Side Folder -> Player.lua
- Paste ```	PlayerData.metadata["jobrep1"] = PlayerData.metadata["jobrep1"] ~= nil and PlayerData.metadata["jobrep1"] or 0``` with other META DATA LINES (Around line 60)

**SCRIPT FUNCTIONS / TRIGGERS**
- Script should be ensured/started in the resources.cfg
- **Where ever you want JOB REPUTATION to be added to player, just go in that JOB CLIENT EVENT and use these as required.**

**FOR CLIENT-SIDE JOB EVENTS - `TriggerServerEvent('osm:server:incjobrep', repvalue)` where `repvalue` is the amount of rep you want to ADD to the EXISTING JOBREP.**

**FOR SERVER-SIDE JOB EVENTS - `TriggerClientEvent('osm:client:incjobrep', source, repvalue)` where `repvalue` is the amount of rep you want to ADD to the EXISTING JOBREP.**

- Give the server a restart. Spot for errors in scripts, cuz their is high probablility you might have done something wrong. 

---

### EXAMPLES for REFERENCE

**If you want a POLICE OFFICER to earn some REP on JAILING a person, here is a small example on how you can do it. (For QBUS POLICE SCRIPT)**
Adding `TriggerClientEvent('osm:client:incjobrep', source, 10)` near SendToJail will credit 10 rep points to POLICE OFFICER on jailing someone. 
```
RegisterServerEvent('police:server:JailPlayer')
AddEventHandler('police:server:JailPlayer', function(playerId, time)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local OtherPlayer = QBCore.Functions.GetPlayer(playerId)
    local currentDate = os.date("*t")
    if currentDate.day == 31 then currentDate.day = 30 end

    if Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "police1" or Player.PlayerData.job.name == "police2" or Player.PlayerData.job.name == "police3" or Player.PlayerData.job.name == "police4" or Player.PlayerData.job.name == "police5" or Player.PlayerData.job.name == "police6" or Player.PlayerData.job.name == "police7" or Player.PlayerData.job.name == "police8" then
        if OtherPlayer ~= nil then
            OtherPlayer.Functions.SetMetaData("injail", time)
            OtherPlayer.Functions.SetMetaData("criminalrecord", {
                ["hasRecord"] = true,
                ["date"] = currentDate
            })
            TriggerClientEvent("police:client:SendToJail", OtherPlayer.PlayerData.source, time)
            TriggerClientEvent('osm:client:incjobrep', source, 10) -- EVENT FOR REP TRIGGERED
            TriggerClientEvent('QBCore:Notify', src, "You sent the person to prison for "..time.." months")
        end
    end
end)```
