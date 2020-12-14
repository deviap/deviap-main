---------------------------------------------------------------
-- Copyright 2020 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------
--[[
    local selection = require(...)
    selection.clear()
    selection.set({obj1, obj2, ...})
    selection.get()
    selection.select(obj)
    selection.deselect(obj)
    selection.isSelected(obj)
]]
local controller = {}
local _selection = {}

local function selectable(object)
    return true -- placeholder
end

function controller.clear()
    _selection = {}
end

function controller.set(objects)
    controller.clear()
	for _, object in pairs(objects) do
		controller.select(object)
	end
end

function controller.get()
    local copy = {}
    for object, selectionData in pairs(_selection) do
		table.insert(copy, object)
	end
    return copy
end

function controller.select(object)
    if selectable(object) then
        _selection[object] = {} -- placeholder
        return true
    else 
        warn("select failed")
        return false
    end
end

function controller.deselect(object)
    if controller.isSelected[object] then
        _selection[object] = nil
    end
end

function controller.isSelected(object)
    return _selection[object] ~= nil
end

return controller
