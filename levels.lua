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

levels state.
]]

local MAPS = {}
local n_MAPS = 0

levels = levels or {}

function levels:enter()
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


function levels:update(dt)
	local x = 300
	local y = 200
	for key,map in pairs(MAPS) do
		if gui.Button ({text = "(".. map .. ")", pos = {x, y}, size = {200, 50}})
			then gamestate.switch(game, MAPS[key])
		end
		y = y + 100
	end
	if gui.Button ({text = "Return to main menu", pos = {x, y}, size = {200, 50}})
		then gamestate.switch(menu)
	end
end


function levels:draw()
	love.graphics.print("Choose your map : ", 300, 50)
	gui.core.draw()
end
