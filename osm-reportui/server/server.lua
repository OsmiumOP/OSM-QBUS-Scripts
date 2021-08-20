-- MADE BY OSMIUM - DISCORD.IO/OSMFX --

local DISCORD_WEBHOOK = ""

RegisterServerEvent('playersend')
AddEventHandler('playersend', function(data)

    local playerId = data.name

    local steamid  = false
    local license  = false
    local discord  = false
    local xbl      = false
    local liveid   = false
    local playerip = false

    local player = GetPlayerName(playerId)
    local playersrc = GetPlayerName(source)

  for k,v in pairs(GetPlayerIdentifiers(playerId))do
    --print(v)
        
      if string.sub(v, 1, string.len("steam:")) == "steam:" then
        steamid = v
      elseif string.sub(v, 1, string.len("license:")) == "license:" then
        license = v
      elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
        xblid  = v
      elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
        playerip = v
      elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
        discord = v
      elseif string.sub(v, 1, string.len("live:")) == "live:" then
        liveid = v
      end
    
  end

  for k,v in pairs(GetPlayerIdentifiers(source))do
    --print(v)
        
      if string.sub(v, 1, string.len("steam:")) == "steam:" then
        steamidsrc = v
      elseif string.sub(v, 1, string.len("license:")) == "license:" then
        licensesrc = v
      elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
        discordsrc = v
      end
    
  end

  local identifier1,license1liveid1,xblid1,discord1,playerip1,message
  if not identifier       then identifier1       = "N/A" else identifier1       = identifier       end
  if not license          then license1          = "N/A" else license1          = license          end
  if not liveid           then liveid1           = "N/A" else liveid1           = liveid           end
  if not xblid            then xblid1            = "N/A" else xblid1            = xblid           end
  if not discord          then discord1          = "N/A" else discord1          = discord          end
  if not playerip         then playerip1        = "N/A" else playerip1           = playerip         end
  if not discordsrc         then discordidsrc1        = "N/A" else discordidsrc1           = discordsrc         end

local discordid, replaced = string.gsub(discord1, "discord:", "")
  local discordidsrc, replaced = string.gsub(discordidsrc1, "discord:", "")

--print(newStr)
    local connect = {
        {
            ["color"] = "255",
            ["title"] = "Player Report Issued ",
            ["description"] = "**Report against Player ID** : `"..data.name.."` \n **Report Description:** `"..data.message.."` \n \n**Report issued against Discord**: \n <@"..discordid.."> \n \n  **Accused's Identifiers:** \n`Steam : "..steamid..", \nSteam Name : "..player..", XBL : "..xblid1..", \nFiveM : "..license1..", \nLive : "..liveid1.."` \n \n**Reported by :** <@"..discordidsrc.."> , \n**Steam** : "..steamidsrc..", \n**Licence** : "..licensesrc.."",
	        ["footer"] = {
                ["text"] = "OSM-Report UI",
            },
        }
    }
    PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = "Player Reports",  avatar_url = "https://cdn1.iconfinder.com/data/icons/ios-11-glyphs/30/error-512.png",embeds = connect}), { ['Content-Type'] = 'application/json' })
  
    TriggerClientEvent('chatMessage', source, "Report Submitted Successfully.")

end)

