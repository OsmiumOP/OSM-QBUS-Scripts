-- BY OSMIUM #0001 -- 
-- TO BE PASTED IN [CORE FOLDER]/SERVER/COMMANDS.LUA --
-- MY DISCORD : https://discord.gg/bfPKqNhQPQ --


-- For admins to add Reputation to anyone
QBCore.Commands.Add("addrep", "Add Reputation to a Player", {{name="id", help="ID of player"}, {name="type", help="dealer/crafting/atcrafting"}, {name="amount", help="Amount of Rep"}}, false, function(source, args)

        
        local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))

       if Player ~= nil then 
        if args[1] ~= nil and args[2] ~= nil and args[3] ~= nil then
            local x = tonumber(args[1])
            local y = args[2]
            local z = tonumber(args[3])

            if y == "dealer" then
                local newrep = Player.PlayerData.metadata["dealerrep"] + z
                Player.Functions.SetMetaData("dealerrep", newrep)
                TriggerClientEvent('chatMessage', Player, "SYSTEM", "error", "Added Rep")
            end
            if y == "crafting" then
                local newrep = Player.PlayerData.metadata["craftingrep"] + z
                Player.Functions.SetMetaData("craftingrep", newrep)
                TriggerClientEvent('chatMessage', Player, "SYSTEM", "error", "Added Rep")
            end
            if y == "atcrafting" then
                local newrep  = Player.PlayerData.metadata["attachmentcraftingrep"]  + z
                Player.Functions.SetMetaData("attachmentcraftingrep", newrep)
                TriggerClientEvent('chatMessage', Player, "SYSTEM", "error", "Added Rep")
            end
        else
            TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "Not every argument has been entered.")
        end
      else 
       TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "Player not Online")
end
end, "admin") -- change allowed role here 

-- DELETE PLAYER's ENTIRE REP 
QBCore.Commands.Add("deleterep", "Delete all Reputation to a Player", {{name="id", help="ID of player"}, {name="type", help="dealer/crafting/atcrafting"}}, false, function(source, args)

    local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))

   if Player ~= nil then 
    if args[1] ~= nil and args[2] ~= nil then
        local x = tonumber(args[1])
        local y = args[2]

        if y == "dealer" then
            Player.Functions.SetMetaData("dealerrep", 0)
            TriggerClientEvent('chatMessage', source, "SYSTEM", "error", 'Cleared ALL Dealer-Rep of ID '..x..'')
        end
        if y == "crafting" then
            Player.Functions.SetMetaData("craftingrep", 0)
            TriggerClientEvent('chatMessage', source, "SYSTEM", "error", 'Cleared ALL Crafting-Rep of ID '..x..'')
        end
        if y == "atcrafting" then
            Player.Functions.SetMetaData("attachmentcraftingrep", 0)
            TriggerClientEvent('chatMessage', source, "SYSTEM", "error", 'Cleared ALL At-Rep of ID '..x..'')
        end
    else
        TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "Not every argument has been entered.")
    end
  else 
   TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "Player not Online")
end
end, "admin") -- change allowed role here 

-- CHECK REP OF ANY ONLINE PLAYER (ADMIN ONLY)
QBCore.Commands.Add("checkrep", "Check Reputation of a Player", {{name="id", help="ID of player"}, {name="type", help="dealer/crafting/atcrafting"}}, false, function(source, args)

    local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))

   if Player ~= nil then 
    if args[1] ~= nil and args[2] ~= nil then
        local x = tonumber(args[1])
        local y = args[2]

        if y == "dealer" then
            local newrep = Player.PlayerData.metadata["dealerrep"]
            TriggerClientEvent('chatMessage', source, "SYSTEM", "error", 'Current Dealer-Rep of ID '..x..' is '..newrep..'')
        end
        if y == "crafting" then
            local newrep = Player.PlayerData.metadata["craftingrep"] 
            TriggerClientEvent('chatMessage', source, "SYSTEM", "error", 'Current Crafting-Rep of ID '..x..' is '..newrep..'')
        end
        if y == "atcrafting" then
            local newrep  = Player.PlayerData.metadata["attachmentcraftingrep"] 
            TriggerClientEvent('chatMessage', source, "SYSTEM", "error", 'Current At-Rep of ID '..x..' is '..newrep..'')
        end
    else
        TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "Not every argument has been entered.")
    end
  else 
   TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "Player not Online")
end
end, "admin") -- change allowed role here 

-- CHECK PLAYER OWN REPS (ALL IN ONE MESSAGE)
QBCore.Commands.Add("myrep", "Check Your Reputations", {}, false, function(source, args)

local Player = QBCore.Functions.GetPlayer(source)

   if Player ~= nil then 
    
        local x = Player.PlayerData.metadata["dealerrep"] 
        local y = Player.PlayerData.metadata["craftingrep"] 
        local z = Player.PlayerData.metadata["attachmentcraftingrep"] 

        TriggerClientEvent('chatMessage', source, "SYSTEM", "error", 'Your Current Dealer-Rep '..x..'')
        TriggerClientEvent('chatMessage', source, "SYSTEM", "error", 'Your Current Crafting-Rep '..y..'')
        TriggerClientEvent('chatMessage', source, "SYSTEM", "error", 'Your Current Attachment-Rep '..z..'')

  else 

   TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "Player not Online")
end
end)

-- GIVE YOUR REPUTATION TO OTHER PLAYERS

QBCore.Commands.Add("giverep", "Add Reputation to a Player", {{name="id", help="ID of player"}, {name="type", help="dealer/crafting/atcrafting"}, {name="amount", help="Amount of Rep"}}, false, function(source, args)

        local Self = QBCore.Functions.GetPlayer(source)
        local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))

       if Player ~= nil and Self ~= nil then 
        if args[1] ~= nil and args[2] ~= nil and args[3] ~= nil then
            local x = tonumber(args[1])
            local y = args[2]
            local z = tonumber(args[3])
        if z > 0 then  
            if y == "dealer" and Self.PlayerData.metadata["dealerrep"] >= z then
                local selfrep = Self.PlayerData.metadata["dealerrep"] - z
              local newrep = Player.PlayerData.metadata["dealerrep"] + z
                Player.Functions.SetMetaData("dealerrep", newrep)
                Self.Functions.SetMetaData("dealerrep", selfrep)
                TriggerClientEvent('chatMessage', Player, "SYSTEM", "error", "You received some DEALER REP")
            end
            if y == "crafting" and Self.PlayerData.metadata["craftingrep"] >= z then
                local selfrep = Self.PlayerData.metadata["craftingrep"] - z
              local newrep = Player.PlayerData.metadata["craftingrep"] + z
                Player.Functions.SetMetaData("craftingrep", newrep)
                Self.Functions.SetMetaData("craftingrep", selfrep)
                TriggerClientEvent('chatMessage', Player, "SYSTEM", "error", "You received some CRAFTING REP")
            end
            if y == "atcrafting" and Self.PlayerData.metadata["attachmentcraftingrep"] >= z then
                local selfrep = Self.PlayerData.metadata["attachmentcraftingrep"] - z
              local newrep = Player.PlayerData.metadata["attachmentcraftingrep"] + z
                Player.Functions.SetMetaData("attachmentcraftingrep", newrep)
                Self.Functions.SetMetaData("attachmentcraftingrep", selfrep)
                TriggerClientEvent('chatMessage', Player, "SYSTEM", "error", "You received some ATTACHMENT CRAFTING REP")
            end
        else
            TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "Negative Values not Allowed.")
        end
        else
            TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "Not every argument has been entered.")
        end
      else 
       TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "Player not Online")
end
end)
