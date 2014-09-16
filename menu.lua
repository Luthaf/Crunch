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

function menu:enter()
	button1 = love.graphics.newImage("Images/Button1.png")
end
	
	
function menu:update(dt)	
	if gui.Button({text = "Levels", pos = {300, 200}, size = {200, 50}}) 
			then gamestate.switch(levels)
	elseif gui.Button({text = "Credits", pos = {300, 300}, size = {200, 50}}) 
			then gamestate.switch(credits)
	elseif gui.Button({text = "Options", pos = {300, 400}, size = {200, 50}}) 
			then gamestate.switch(options)	
	elseif gui.Button({text = "Quit", pos = {300, 500}, size = {200, 50}}) 
			then love.event.quit()			
	end
end
 
 
function menu:draw()
	love.graphics.print("Funky CRUNCH title", 300, 50)
	love.graphics.draw(button1, 300, 300)
	gui.core.draw()	
	
	
end


--function menu:keyreleased(key, code)
   -- if tables.kcontains(MAPS, key) then
   --   gamestate.switch(game, MAPS[key])
   -- elseif key == "q" then
   --  love.event.quit()
--    end
--end
