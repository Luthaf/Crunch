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

Main file for Crunch game
]]

-- Libraries
sti = require("libs/sti")
gamestate = require("libs/hump/gamestate")
Collider = require("libs/HardonCollider")
require("libs/utils")
gui = require "libs/Quickie"

-- Creating gamestates
menu = {}
game = {}
levels = {}
credits = {}
options = {}
require("menu")
require("game")
require("levels")
require("credits")
require("options")


function love.load()
    gamestate.registerEvents()
    --gamestate.switch(menu)
    gamestate.switch(game, "template")
end
