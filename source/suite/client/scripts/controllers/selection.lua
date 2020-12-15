---------------------------------------------------------------
-- Copyright 2020 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------
--[[
    Manages the user's selection in Suite

    local selection = require(...)
    selection.clear()
    selection.set({obj1, obj2, ...})
    selection.get()
    selection.select(obj)
    selection.deselect(obj)
    selection.isSelected(obj)
]]
local outliner = require("client/scripts/controllers/outliner.lua")

local controller = {}
local _selection = {}

local function selectable(object)
    return true -- placeholder
end

function controller.clear()
    for object, selectionData in pairs(_selection) do
		outliner.remove(object)
	end
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
		outliner.add(object)
        return true
    else 
        warn("select failed")
        return false
    end
end

function controller.deselect(object)
    if controller.isSelected(object) then
        _selection[object] = nil
		outliner.remove(object)
    end
end

function controller.isSelected(object)
    return _selection[object] ~= nil
end

return controller
