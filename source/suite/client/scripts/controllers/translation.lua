---------------------------------------------------------------
-- Copyright 2020 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------
--[[
    Manages the object's translation in Suite

    local translation = require(...)
    translation.attach()
    translation.detach()
]]
local controller = {}

local map = {
    ["front"] = {vector3(1, 0, 0), colour.hex("f44336")}, -- x +, handle colour (red)
    ["back"] = {vector3(-1, 0, 0), colour.hex("f44336")}, -- x -, handle colour (red)
    ["right"] = {vector3(0, 0, 1), colour.hex("3F51B5")}, -- z +, handle colour (green)
    ["left"] = {vector3(0, 0, -1), colour.hex("3F51B5")}, -- z -, handle colour (green)
    ["top"] = {vector3(0, 1, 0), colour.hex("4CAF50")}, -- y +, handle colour (blue)
    ["bottom"] = {vector3(0, -1, 0), colour.hex("4CAF50")} -- y -, handle colour (blue)
}

-- Move to separate module in library
local function attachHandles(obj)
    for direction, data in pairs(map) do
        core.construct("block", {
            parent = obj,
            name = direction.."Handle",
            position = data[1],
            scale = vector3(0.4, 0.4, 0.4),
            colour = data[2],
            emissiveColour = data[2],
            renderQueue = 200,
            mesh = "deviap:3d/Sphere.glb",
            inheritsScale = false
        })
    end
end

-- Create Handles.
function controller.attach(obj)
    attachHandles(obj)
end

-- Remove Handles.
function controller.detach(obj)
    if not obj.children then return end
    for i,v in pairs(obj.children) do
        if string.find(v.name, "Handle") then
            v:destroy()
        end
    end
end

function controller.getFaceMapping(face)
    return map[face]
end

return controller