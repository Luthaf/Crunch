--[[
Crunch, a funky platform game
Copyright (C) 2014 Guillaume Fraux

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.
This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.
You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

Main game state.
]]


local map

--[[ ========== Game constants ========== ]]
local tile_size = 70.0

local g = 800       -- gravity
local X = 0         -- player position
local Y = 0
local VY = 0        -- player speed
local MAX_VY = 750
local MIN_VY = 15
local MAX_VX = 200

local epsilon_y = 0.0001


-- Various movement constants
local LEFT = -1
local RIGHT = 1
local NONE = 0
local YES = 1

-- Player
local crunch = {}
local crunch_img

--[[ =================================== ]]


function game:enter(current, map_name)
    map = sti.new("assets/maps/" .. map_name)
    crunch_img = love.graphics.newImage("mario.png")
    local collision = map.layers[1]
    HC = Collider(tile_size, collide) -- collide, stop_collide0
    local tile
    for j, _ in pairs(collision.data) do
        for i, _ in pairs(collision.data[j]) do
            tile = HC:addRectangle((i-1)*tile_size, (j-1)*tile_size, tile_size, tile_size)
            HC:setPassive(tile)
            HC:addToGroup("platform", tile)
        end
    end
    crunch["shape"] = HC:addRectangle(X, Y, 50, 70)
    crunch["move"] = {}
    crunch.move["x"] = NONE
    crunch.move["y"] = NONE

end


function game:draw()

    local SCROLLING_OFFSET = 300
    local width = love.graphics.getWidth()
    local MAX_SCROLLING = (map.width * tile_size) - width + SCROLLING_OFFSET
    -- local height = love.graphics.getHeight()
    local translateX = - X + SCROLLING_OFFSET
    if X < SCROLLING_OFFSET then
        translateX = 0
    elseif X > MAX_SCROLLING then
        translateX = - MAX_SCROLLING + SCROLLING_OFFSET
    end

    love.graphics.translate(translateX, 0)

    -- only for very big maps, to save some computation
    -- map:setDrawRange(translateX, 0, width, height)

    map:draw()

    crunch.shape:moveTo(X + tile_size/2, Y + tile_size/2)
    love.graphics.draw(crunch_img, X, Y)
end


function game:update(dt)
    HC:update(dt)

    if love.keyboard.isDown('left') then
        crunch.move.x = LEFT
    elseif love.keyboard.isDown('right') then
        crunch.move.x = RIGHT
    else
        crunch.move.x = NONE
    end

    if crunch.move.y ~= NONE then
        if not collides(crunch.shape) then
            VY = VY + g*dt  -- gravity
        end
        if VY > MAX_VY then -- Maximum falling speed
            VY = MAX_VY
        end
    elseif is_floating(crunch.shape) then
        crunch.move.y = YES
    end

    X = X + crunch.move.x * MAX_VX * dt
    Y = Y + VY * dt
end


function game:keypressed(key, code)
    if key == 'escape' then
        gamestate.switch(menu)
    elseif key == 'up' and crunch.move.y == NONE then
        VY = - MAX_VY
        crunch.move.y = YES
    end
end


function game:leave()
    HC:clear()
end


function collide(dt, shape_one, shape_two, dx, dy)
    if shape_one == crunch.shape then
        if dx ~= 0 then
            X = X + dx
        end
        if dy ~= 0 and math.abs(dy) > 1 then
            VY = 0
            Y = Y + dy/2
            crunch.move.y = NONE
        end
    elseif shape_two == crunch.shape then
        if dx ~= 0 then
            X = X - dx
        end
        if dy ~= 0 and math.abs(dy) > 1 then
            print(dy)
            VY = 0
            Y = Y - dy/4
            crunch.move.y = NONE
        end
    end
end


function is_floating(shape)
    local collide, dx, dy
    for _, other in pairs(shape:neighbors()) do
        collide, dx, dy = shape:collidesWith(other)
        if collide and math.abs(dy) > 0.5 then  -- math.abs(dy) > epsilon ?
            return false
        end
    end
    return true
end

function collides(shape)
    local collide, dx, dy
    for _, other in pairs(shape:neighbors()) do
        if shape:collidesWith(other) then
            return true
        end
    end
    return false
end
