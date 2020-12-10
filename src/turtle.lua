movement = require "movement"

-- clone a table 
local function clone(obj)
    if type(obj) ~= 'table' then return obj end
    local res = {}
    for k, v in pairs(obj) do res[copy1(k)] = copy1(v) end
    return res
end

local function setState(previous)
    return function(next) 
		for k,v in pairs(next) do 
            previous[k] = v
        end
       
        return previous
    end
end 

-- Turtle class
Turtle = {}

function Turtle:new(t)
    t = t or {}

    t.state = t.state or { 
        x = 0,
        y = 0,
        z = 0,
        facing = 1
    }

    self.__index = self
    return setmetatable(t, self)
end 

function Turtle:up(times) 
    _, success = movement.up(setState(self.state), self.state, times)

    print("y: " .. self.state.y)

    return success
end 

return {
    Turtle = Turtle
}