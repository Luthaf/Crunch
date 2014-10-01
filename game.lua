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
local CRUNCH_H, CRUNCH_W

-- Map constants
local MAP_WIDTH, MAP_HEIGHT

--[[ =================================== ]]


function game:enter(current, map_name)
    map = sti.new("assets/maps/" .. map_name)
    crunch_img = love.graphics.newImage("crunch.png")
    CRUNCH_H = crunch_img:getHeight()
    CRUNCH_W = crunch_img:getWidth()

    local collision = map.layers["static_map"]
    HC = Collider(tile_size, game.crunch_collide)
    local tile
    for j, _ in pairs(collision.data) do
        for i, _ in pairs(collision.data[j]) do
            tile = HC:addRectangle((i-1)*tile_size, (j-1)*tile_size, tile_size, tile_size)
            HC:setPassive(tile)
            HC:addToGroup("platform", tile)
        end
    end

    crunch["shape"] = HC:addRectangle(X, Y, CRUNCH_W, CRUNCH_H)
    crunch["move"] = {}
    crunch.move["x"] = NONE
    crunch.move["y"] = NONE
    MAP_WIDTH = map.width * tile_size
    MAP_HEIGHT = map.height * tile_size
end


function game:draw()

    local SCROLLING_OFFSET = 300
    local width = love.graphics.getWidth()
    local MAX_SCROLLING_X = MAP_WIDTH - width + SCROLLING_OFFSET
    local height = love.graphics.getHeight()
    local MAX_SCROLLING_Y = MAP_HEIGHT - height + SCROLLING_OFFSET
    local translateX = - X + SCROLLING_OFFSET
    local translateY = - Y + SCROLLING_OFFSET

    if X < SCROLLING_OFFSET then
        translateX = 0
    elseif X > MAX_SCROLLING_X then
        translateX = - MAX_SCROLLING_X + SCROLLING_OFFSET
    end

    if Y < SCROLLING_OFFSET then
        translateY = 0
    elseif Y > MAX_SCROLLING_Y then
        translateY = - MAX_SCROLLING_Y + SCROLLING_OFFSET
    end

    love.graphics.translate(translateX, translateY)

    -- only for very big maps, to save some computation
    -- map:setDrawRange(translateX, 0, width, height)

    map:draw()

    crunch.shape:moveTo(X + CRUNCH_W/2, Y + CRUNCH_H/2)
    -- crunch.shape:draw('fill')

    love.graphics.draw(crunch_img, X, Y)
end


function game:update(dt)
    HC:update(dt)

    -- Get horizontal movement
    if love.keyboard.isDown('left') and X >= 0 then
        crunch.move.x = LEFT
    elseif love.keyboard.isDown('right') and X <= (MAP_WIDTH-tile_size) then
        crunch.move.x = RIGHT
    else
        crunch.move.x = NONE
    end

    -- Get vertical movement
    if crunch.move.y ~= NONE then
        if not game.collides(crunch.shape) then
            VY = VY + g*dt  -- gravity
        end
        if VY > MAX_VY then -- Maximum falling speed
            VY = MAX_VY
        end
    elseif game.is_floating(crunch.shape) then
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
    map = nil
    X = 0
    Y = 0
    VY = 0
end


function game.crunch_collide(dt, shape_one, shape_two, dx, dy)
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


function game.is_floating(shape)
    local collide, dx, dy
    for _, other in pairs(shape:neighbors()) do
        collide, dx, dy = shape:collidesWith(other)
        if collide and math.abs(dy) > 0.5 then  -- math.abs(dy) > epsilon ?
            return false
        end
    end
    return true
end

function game.collides(shape)
    local collide, dx, dy
    for _, other in pairs(shape:neighbors()) do
        if shape:collidesWith(other) then
            return true
        end
    end
    return false
end
