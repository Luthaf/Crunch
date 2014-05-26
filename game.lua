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

local map, collision
local tile_size = 70
local g = 100 -- gravity
local X, Y -- player position
local VX, VY -- player speed
X, Y = 0, 0
VX, VY = 0,0

local mario, mario_img

function collide(dt, shape_one, shape_two, dx, dy)
    if shape_one == mario then
        if dx ~= 0 then VX = 0 end
        if dy ~= 0 then VY = 0 end
    elseif shape_two == mario then
        if dx ~= 0 then VX = 0 end
        if dy ~= 0 then VY = 0 end
    end
end

function game:enter(current, map_name)
    map = sti.new("assets/maps/" .. map_name)
    mario_img = love.graphics.newImage("mario.png")
    collision = map.layers[1]
    HC = Collider(tile_size, collide) -- collide, stop_collide0
    local tile
    for j, _ in pairs(collision.data) do
        for i, _ in pairs(collision.data[j]) do
            tile = HC:addRectangle((i-1)*tile_size, (j-1)*tile_size, tile_size, tile_size)
            HC:addToGroup("platform", tile)
        end
    end
    mario = HC:addRectangle(X, Y, 70, 70)
end

function game:draw()
    map:draw()
    love.graphics.draw(mario_img, X, Y)
end

function game:update(dt)
    mario:moveTo(X + tile_size/2, Y + tile_size/2)
    HC:update(dt)
    X = X + VX*dt
    Y = Y + VY*dt
    VY = VY + g*dt
end

function game:keypressed(key, code)
    if key == 'escape' then
        gamestate.switch(menu)
    elseif key == 'f' then
        VY = VY - 100
    elseif key == 'left' then
        VX = VX - 40
    elseif key == 'right' then
        VX = VX + 40
   end
end


function game:leave()
    HC:clear()
end
