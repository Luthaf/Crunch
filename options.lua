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

options state.
]]



function options:update(dt)	
	if gui.Button ({text = "Return to main menu", pos = {300, 200}, size = {200, 50}}) 
			then gamestate.switch(menu)	
	end
end


function options:draw()
	love.graphics.print("Options", 300, 50)
	gui.core.draw()	
end