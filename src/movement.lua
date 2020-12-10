-- cardinal directions are keyed as the following:
-- 1 = North
-- 2 = East
-- 3 = South 
-- 4 = West

--[[
    Moves the turtle up
    Updates the turtles y state
]]
function up(setState, state, times) 
    local moved = 0 

    for i=1, times do
        -- attempt to move down
        if turtle.up() then
            moved = moved + 1
        end 
    end 

    return setState({ y = state.y + moved }), moved == times
end 

--[[
    Moves the turtle down
    Updates the turtles y state
]]
function down(setState, state, times)
    local moved = 0

    for i=1, times do
        -- attempt to move down
        if turtle.down() then
            moved = moved + 1
        end 
    end 

    return setState({ y = state.y - moved }), moved == times
end 

--[[
    Moves the turtle forward.
    Updates the turtles x and z state.
]]
local function forward(setState, state, times)
    -- tracks the blocks moved 
    local moved = 0

    for i=1, times do 
        -- attempt to move forward the amount specified
        if turtle.forward() then 
            moved = moved + 1
        end 
    end 

    -- update the x and z state 
    local movements = { 1, 1, -1, -1 }
    local x = state.x
    local z = state.z

    if facing == 1 or facing == 3 then 
        -- moved north or south
        -- increment x the times moved 
        x = x + (movements[facing] * moved)
    end 

    if facing == 2 or facing == 4 then
        -- moved east or west 
        -- increment z the times moved
        z = z + (movements[facing] * moved)
    end 

    -- return state, flag indicating if all moves were made
    return setState({ z = z, x = x }), moved == times
end 

---------------------------------------------------
--                  Turning                      --
---------------------------------------------------

-- Gets the updated facing value given the currect state, direction and number of turns
local function updateFacing(state, direction, times)
    -- directions we can turn
    local directions = {
        left = -1,
        right = 1
    }

    -- update the facing state 
    local facing = state.facing + (directions[direction] * times)

    while facing < 1 do
        facing = facing + 4
    end 

    while facing > 4 do
        facing = facing - 4
    end 

    return facing
end 

--[[
    Turns the turtle left or right.
    Updates the turtles facing state.
]]
local function turn(setState, state, direction, times)
    if direction == "left" then 
        for i=1, times do
        	turtle.turnLeft()
        end 
    end
    
    if direction == "right" then 
        for i=1, times do
        	turtle.turnRight() 
        end
   	end 

    -- update the facing state 
    local facing = updateFacing(state, direction, times)

    return setState({ facing = facing }), true
end 

-- Turns the turtle left
local function turnLeft(setState, state, times)
    return turn(setState, state, "left", times)
end 

-- Turns the turtle right
local function turnRight(setState, state, times)
    return turn(setState, state, "right", times)
end 

---------------------------------------------------
--              Cardinal Directions              --
---------------------------------------------------

-- Faces the turtle in a given cardinal direction
local function faceCardinalDirection(setState, state, direction) 
    local directions = {
        north = 1,
        east = 2,
        south = 3,
        west = 4
    }

    local facing = state.facing

    if facing == directions[direction] then 
        return state, true
    end
    
    if updateFacing(state, "left", 1) == directions[direction] then
        return turnLeft(setState, state, 1)
    end 

    if updateFacing(state, "right", 1) == directions[direction] then
        return turnRight(setState, state, 1)
    end 

    -- anything else is a spin
    return turnRight(setState, state, 2)
end 

-- Faces the turtle north
local function faceNorth(setState, state) 
    return faceCardinalDirection(setState, state, "north")
end 

-- Faces the turtle east
local function faceEast(setState, state)
    return faceCardinalDirection(setState, state, "east")
end

-- Faces the turtle south
local function faceSouth(setState, state)
    return faceCardinalDirection(setState, state, "south")
end

-- Faces the turtle west 
local function faceWest(setState, state)
    return faceCardinalDirection(setState, state, "west")
end

-- Exports 
return {
    up = up,
    down = down,
    forward = forward,
    turnLeft = turnLeft,
    turnRight = turnRight,
    faceNorth = faceNorth,
    faceEast = faceEast,
    faceSouth = faceSouth,
    faceWest = faceWest 
}