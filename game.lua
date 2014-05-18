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

function game:enter(current, map_name)
    map = sti.new("assets/maps/" .. map_name)
    player_X = 0
    player_Y = 0
end

function game:draw()
    love.graphics.translate(-player_X, player_Y)
    map:draw()
end

function game:keypressed(key, code)
    if key == 'escape' then
        gamestate.switch(menu)
    elseif key == 'down' then
        player_Y = player_Y - 35
    elseif key == 'up' then
        player_Y = player_Y + 35
    elseif key == 'left' then
        player_X = player_X - 35
    elseif key == 'right' then
        player_X = player_X + 35
   end
end
