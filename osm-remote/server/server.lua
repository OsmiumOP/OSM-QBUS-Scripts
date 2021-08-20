QBCore = nil

TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

pass = Config.PASS

-- PLAYER COUNT 

local r1 = Router.new()
r1:Get("/", function(req, res)
 res:Send("Player Count on Your Server : " ..GetNumPlayerIndices())
end)

Server.use("/players", r1)
Server.listen()


-- ADD MONEY SETUP

local r2 = Router.new()
r2:Post("/", function(Req, Res)

local body = Req:Body()

if (body.auth == pass) then 

local pid = body.id
local pamt = body.amt
local ptype = body.type
	
local Player = QBCore.Functions.GetPlayer(pid)
if Player ~= nil then
	Player.Functions.AddMoney(ptype, tonumber(pamt))
	Res:Send("Success")
else
	Res:Send("Fail")
end

end
end)

Server.use("/addmoney", r2)
Server.listen()

-- SETJOB SETUP 

local r3 = Router.new()
r3:Post("/", function(Req, Res)

local body = Req:Body()

if (body.auth == pass) then 

local pid = body.id
local pjob = body.job
local pgrade = body.grade

local Player = QBCore.Functions.GetPlayer(pid)

if (Config.JobGrades == true) then -- Grades System Condition 
    if Player ~= nil then
        Player.Functions.SetJob(tostring(pjob), tonumber(pgrade))
        Res:Send("Success")
	else
		Res:Send("Fail")
	end
else 
	if Player ~= nil then
		Player.Functions.SetJob(tostring(pjob))
        Res:Send("Success")
	else
		Res:Send("Fail")
	end
end
end

end)

Server.use("/setjob", r3)
Server.listen()


-- REMOVE MONEY SETUP

local r4 = Router.new()
r4:Post("/", function(Req, Res)

local body = Req:Body()

if (body.auth == pass) then 

local pid = body.id
local pamt = body.amt
local ptype = body.type

local Player = QBCore.Functions.GetPlayer(pid)
if Player ~= nil then
    Player.Functions.RemoveMoney(ptype, tonumber(pamt))
    Res:Send("Success")
else
    Res:Send("Fail")
end
end
end)

Server.use("/rmoney", r4)
Server.listen()

-- GETJOB COMMAND

local r5 = Router.new()
r5:Post("/", function(Req, Res)

local body = Req:Body()

if (body.auth == pass) then 

local pid = body.id

local Player = QBCore.Functions.GetPlayer(pid)
if Player ~= nil then
    local Player = QBCore.Functions.GetPlayer(pid)
	local curjob = Player.PlayerData.job.label
    Res:Send(curjob)
else
    Res:Send("Fail")
end
end
end)

Server.use("/getjob", r5)
Server.listen()

-- BAN HAMMER 

local r6 = Router.new()
r6:Post("/", function(Req, Res)

local body = Req:Body()

if (body.auth == pass) then 

local playerId = body.id
local reason = body.reason
local hours = tonumber(body.time)

local time = tonumber(hours * 3600)
local banTime = tonumber(os.time() + time)


if banTime > 2147483647 then -- Perma Ban
    banTime = 2147483647
end

local timeTable = os.date("*t", banTime)

if (Config.EnableBan == true) then -- Check Config Var
     QBCore.Functions.ExecuteSql(false, "INSERT INTO `bans` (`name`, `steam`, `license`, `discord`,`ip`, `reason`, `expire`, `bannedby`) VALUES ('"..GetPlayerName(playerId).."', '"..GetPlayerIdentifiers(playerId)[1].."', '"..GetPlayerIdentifiers(playerId)[2].."', '"..GetPlayerIdentifiers(playerId)[3].."', '"..GetPlayerIdentifiers(playerId)[4].."', '"..reason.."', "..banTime..", `Discord Admin`)")
     DropPlayer(playerId, "You have been banished from the server:\n"..reason.."\n\nBan expires: "..timeTable["day"].. "/" .. timeTable["month"] .. "/" .. timeTable["year"] .. " " .. timeTable["hour"].. ":" .. timeTable["min"] .. "\n🔸 Join our Discord for further information")
     Res:Send(GetPlayerIdentifiers(playerId)[1])
else
    Res:Send("Fail")
end

end

end)
Server.use("/banhammer", r6)
Server.listen()
     

-- KICK 


local r7 = Router.new()
r7:Post("/", function(Req, Res)

local body = Req:Body()

if (body.auth == pass) then 

local playerId = body.id
local reason = body.reason

if (playerId ~= nil) then -- Check Config Var
    DropPlayer(playerId, "You have been Kicked from the server:\n"..reason.."\nJoin our Discord for further information")
    Res:Send(GetPlayerIdentifiers(playerId)[1])
else
    Res:Send("Fail")
end
end

end)
Server.use("/kickp", r7)
Server.listen()

-- KILL 
local r8 = Router.new()
r8:Post("/", function(Req, Res)

local body = Req:Body()

if (body.auth == pass) then 

local playerId = body.id
local Player = QBCore.Functions.GetPlayer(playerId)

if (Player ~= nil) then -- Check Config Var
    TriggerClientEvent('hospital:client:KillPlayer', Player.PlayerData.source)
    Res:Send("Success")
else
    Res:Send("Fail")
end
end

end)
Server.use("/killp", r8)
Server.listen()

-- REVIVE
local r9 = Router.new()
r9:Post("/", function(Req, Res)

local body = Req:Body()

if (body.auth == pass) then 

local playerId = body.id
local Player = QBCore.Functions.GetPlayer(playerId)

if (Player ~= nil) then -- Check NIL Value
    TriggerClientEvent('hospital:client:Revive', Player.PlayerData.source)
    Res:Send("Success")
else
    Res:Send("Fail")
end
end

end)
Server.use("/revivep", r9)
Server.listen()

-- ANNOUNCE
local r10 = Router.new()
r10:Post("/", function(Req, Res)

local body = Req:Body()

if (body.auth == pass) then 

local msg = body.msg

if (msg ~= nil) then -- Check NIL Value
    for i = 1, 3, 1 do
        TriggerClientEvent('chatMessage', -1, "SYSTEM", "error", msg)
    end
else
    Res:Send("Fail")
end
end

end)
Server.use("/announce", r10)
Server.listen()

