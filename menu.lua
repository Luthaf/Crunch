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

Menu state.
]]

local MAPS = {}
local n_MAPS = 0

function menu:enter()
    content = love.filesystem.getDirectoryItems("assets/maps")
    n_MAPS = 0
    MAPS = {}
    for key,value in pairs(content) do
        if string.ends(value, ".lua") then
            n_MAPS = n_MAPS + 1
            key = string.char(n_MAPS + 96) -- ASCII code
            MAPS[key] = string.rm_end(value, ".lua")
        end
    end
end

function menu:draw()
    love.graphics.print("Choose your map : ", 150, 10)
    local i = 1
    for name, map in pairs(MAPS) do
        love.graphics.print("(".. name ..")", 120, 10 + i*20)
        love.graphics.print(map, 150, 10 + i*20)
        i = i + 1
    end
    love.graphics.print("(q)", 120, 40 + i*20)
    love.graphics.print("Quit", 150, 40 + i*20)
end

function menu:keyreleased(key, code)
    if tables.kcontains(MAPS, key) then
        gamestate.switch(game, MAPS[key])
    elseif key == "q" then
        love.event.quit()
    end
end
