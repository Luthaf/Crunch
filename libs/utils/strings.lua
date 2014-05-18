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

Functions for strings management
]]

function string.starts(string, s_start)
   return string.sub(string, 1, string.len(s_start)) == start
end

function string.ends(string, s_end)
   return s_end == '' or string.sub(string, -string.len(s_end)) == s_end
end

function string.rm_start(string, s_start)
   return string.sub(string, -string.len(s_start))
end

function string.rm_end(string, s_end)
   return string.sub(string, 1, string.len(string) - string.len(s_end))
end
