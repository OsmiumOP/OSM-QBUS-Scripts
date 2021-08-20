
Server = {
    Routes = {},
    Middlewares = {}
}

InvokeHttpRequest = nil

if SetHttpHandler == nil then
    SetHttpHandler = function(cb)
        InvokeHttpRequest = function(requestData, responseData)
            responseData.send = function(data)
                print("Sending", data)
            end
            responseData.writeHead = function(key, value)
                print("Writing to header", "status: " .. key, "headers", json.encode(value))
            end
            cb(requestData, responseData)
        end
    end
end

--- Starts the server. Call this after all routes have been created
function Server.listen()
    SetHttpHandler(function(req, res)
        print(req.method .. " => " .. req.path)
        ---@type string
        local path = req.path
        local method = req.method
        for k,v in pairs(Server.Routes) do
            for b,z in pairs(v.Paths) do
                if string.match(path, "^" .. z.path .. "$") then
                    if z.method == method then
                        local response = Response.new(res)
                        local request = Request.new(req)
                        if z.pathData then
                            local start = 1
                            for i,j in path:gmatch(z.path) do
                                print("checking path", i, start)
                                if z.pathData.params[start] == nil then print("breaking") break end
                                z.pathData.params[start].value = i
                                start = start + 1
                            end
                            for i,j in pairs(z.pathData.params) do
                                print("setting param", j.name, j.value)
                                request:SetParam(j.name, j.value)
                            end
                        end
                        if z.method == "POST" then
                            req.setDataHandler(function(data)
                                request._Body = json.decode(data) or ""
                                local status, ret = z.handler(request, response)
                                if status ~= nil then
                                    if type(status) == "number" then
                                        if type(ret) ~= "table" then
                                            response:Send(ret)
                                        else
                                            response:Send(json.encode(ret))
                                        end
                                    end
                                end
                            end)
                        else
                            local status, ret = z.handler(request, response)
                            if status ~= nil then
                                if type(status) == "number" then
                                    if type(ret) ~= "table" then
                                        response:Send(ret)
                                    else
                                        response:SetHeader("Content-Type", "application/json")
                                        response:Send(json.encode(ret))
                                    end
                                end
                            end
                        end
                        return
                    end
                end
            end
        end
        local response = Response.new(res)
        local request = Request.new(req)
        response:Status(404)
        response:Send("Not Found: " .. request:Method() .. " " .. request:Path())
    end)
end

--- Specifies a handler/middleware for the server to use
---@param path string The path for this handler
---@param handler Router The router to handle this path
function Server.use(path, handler)
    if type(path) == "string" then
        if type(handler) == "function" then

        elseif type(handler) == "table" then
            local mt = getmetatable(handler)
            if mt == nil then print("^1Error^0: " + "failed to load route " + path + "expected route class") return end
            if mt.__call() ~= "Router" then print("^1Error^0: " + "failed to load route " + path + "expected route class") return end
            for k,v in pairs(handler.Paths) do
               if Config.Log == true then
                 print("Mounting: ", path .. v.path)
               end
                v.path = path .. v.path
            end
            table.insert(Server.Routes, handler)
        end
    end
end


---@class Request
Request = setmetatable({}, Request)

Request.__call = function()
    return "Request"
end

Request.__index = Request

--- Creates a new Request class instance
---@param request table Expects a request object from the `SetHttpHandler` callback
function Request.new(request)

    local _Request = {
        _Raw = request,
        _Params = {}
    }

    request.body = request.body or ""

    if json.decode(request.body) then
        _Request._Body = json.decode(request.body)
    else
        _Request._Body = request.body
    end

    return setmetatable(_Request, Request)
end

--- Get the value for a named parameter. i.e. `/users/:id` to fetch "id" use `Request:Param("id")`
---@param name string Name of the parameter to get
---@return string
function Request:Param(name)
    return self._Params[name]
end

--- Returns all parameters as a table
---@return table
function Request:Params()
    return self._Params
end

--- Sets the value of a parameter. (internal)
---@private
---@param name string The name of the parameter to set
---@param val string The value of this parameter
function Request:SetParam(name, val)
    self._Params[name] = val
end

--- Returns the body of this request
---@return string|table
function Request:Body()
    return self._Body
end

--- Returns the path of this request
---@return string
function Request:Path()
    return self._Raw.path
end

--- Returns the method of this request
---@return string
function Request:Method()
    return self._Raw.method
end


---@class Response
Response = setmetatable({}, Response)

Response.__call = function()
    return "Response"
end

Response.__index = Response

--- Creates a new instance of the Response class
---@param response table The response object from the `SetHttpHandler` callback
function Response.new(response)
    local _Response = {
        _Raw = response,
        Headers = {
            ["X-POWERED-BY"] = "Cyntaax-FiveM-Express"
        },
        _Status = 200
    }

    return setmetatable(_Response, Response)
end

--- Sets a header for the response
---@param key string Name of the header to set
---@param value string Value for this header
function Response:SetHeader(key, value)
    self.Headers[key] = value
end

--- Gets or sets the status of the response
---@param status number The HTTP status code to set
---@return nil|number
function Response:Status(status)
    if status == nil then return self._Status end
    self._Status = tonumber(status) or 200
    return self
end

--- Sends the response. If the data type is a table, it will be automatically converted to a JSON string
---@param data string|table The data to send
---@param status number The http status of the response
function Response:Send(data, status)
    status = tonumber(status) or 200
    self:Status(status)
    if type(data) ~= "string" then
        if type(data) == "number" then
            data = tostring(data)
        elseif type(data) == "boolean" then
            data = tostring(data)
        elseif type(data) == "table" then
            data = json.encode(data) or ""
            if data ~= "" then
                self:SetHeader("content-type", "application/json")
            end
        end
    end

    self._Raw.writeHead(self:Status(), self.Headers)

    self._Raw.send(data)
end



---@class Router
Router = setmetatable({}, Router)

Router.__call = function()
    return "Router"
end

Router.__index = Router

function Router.new()
    local _Router = {
        Paths = {}
    }

    return setmetatable(_Router, Router)
end

---@param path string
---@param handler fun(req: Request, res: Response): void
function Router:Get(path, handler)
    local parsed = PatternToRoute(path)
    table.insert(self.Paths, {
        method = "GET",
        path = parsed.route,
        handler = handler,
        pathData = parsed
    })
end

---@param path string
---@param handler fun(req: Request, res: Response): void
function Router:Post(path, handler)
    local parsed = PatternToRoute(path)
    table.insert(self.Paths, {
        method = "POST",
        path = parsed.route,
        handler = handler,
        pathData = parsed
    })
end




---@private
--- Converts a string pattern "`/users/:id`" to an object for the Request class to use
function PatternToRoute(input)
    if input == "/" then input = "" end
    local routeData = {
        route = input,
        params = {}
    }
    local matcher = input
    for k,v in input:gmatch "/(:%w+)" do
        local rawname = k:gsub(":", "")
        table.insert(routeData.params, {
            name = rawname
        })
        matcher, _ = matcher:gsub(k, "(%%w+)", 1)
    end
    routeData.route = matcher
    return routeData
end


