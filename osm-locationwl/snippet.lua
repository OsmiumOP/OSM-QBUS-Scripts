-- CREATED BY OSMIUM#0001 | DISCORD.IO/OSMFX -- 

deferrals.update("\nLocation Whitelist System | OSMFX | discord.io/osmfx")

    local identifiers = GetPlayerIdentifiers(src)

    local joinerip = identifiers[7] -- IP Address of PERSON JOINING (using natives)

    local joinerip1, replaced = string.gsub(joinerip, "ip:", "") -- REMOVING ip: from the recieved identifier. 
    local apikey = "" -- API KEY recieved from IPSTACK.COM 

    local playerurl = "http://api.ipstack.com/"..joinerip1.."?access_key="..apikey.."" -- Final URL for 

    PerformHttpRequest(playerurl, function (errorCode, resultData, resultHeaders) -- FETCHING INFO FROM API

        local data = json.decode(resultData)
        -- print(data.country_name) 

        playercountry = data.country_name -- Reference from API DOCS
       end)
    
    Citizen.Wait(2000) -- API RESPONSE DELAY (Can be reduced but not suggested)
       
    if playercountry ~= "India" then -- If player Not from this country then won't be able to join. 
      -- Other possible ways to use it --

      -- if playercountry == "India" then -- Will kick people who belong to this specific country. 
      -- if playercountry ~= "India" or playercountry ~= "Israel" then -- Allowing people from multiple countries, but not ALL. 

        QBCore.Functions.Kick(src, 'Not Permitted to Join the Server - Location Blacklisted', setKickReason, deferrals) -- Rejected Join
        CancelEvent()
        return false

    end
