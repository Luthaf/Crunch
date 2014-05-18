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

Functions for table management
]]

tables = tables or {}

-- Check if a table contains a given element in its values
function tables.vcontains(table, element)
    for _, value in pairs(table) do
        if value == element then
            return true
        end
    end
    return false
end

-- Check if a table contains a given element in its keys
function tables.kcontains(table, element)
    for key, _ in pairs(table) do
        if key == element then
            return true
        end
    end
    return false
end

-- Check if a table contains a given element either in key or in values
function tables.contains(table, element)
    for key, value in pairs(table) do
        if value == element or key == element then
            return true
        end
    end
    return false
end

return tables
