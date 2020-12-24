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
local function attachHandles(obj, props)
    if not props then 
        props = {}
    end

    props.arms = props.arms == nil and true or props.arms
    props.shape = props.shape or "deviap:3d/cube.glb"
    props.handleSize = props.handleSize or vector3(0.3, 0.3, 0.3)

    for direction, data in pairs(map) do

        --[[
            Why do we create the 'root' object?

            Well, we want to have the handles always located just off the edge
            of our selected object, right?

            The root object is positioned as such so that it is stuck directly
            onto an object's outer face. (Position is relative to the parent's position AND scale).
        ]]
        local root = core.construct("block", {
            parent = obj,
            name = "__" .. direction .. "Root",
            position = data[1]/2,
            scale = vector3(0.025, 1.0, 0.025),
            rotation = quaternion.lookRotation(data[1]) * quaternion.euler(0, math.rad(90), math.rad(90)),
            colour = data[2],
            emissiveColour = data[2] * 0.75,
            inheritsScale = false,
            visible = props.arms,
        })
        core.graphics.clearColour = colour.random()
        --[[
            Now we create the actual handle and nest it in root, which sits
            on the face.

            Any position we set here can always give us a fixed distance
            from the face, even if the scale of the object changes.
        ]]
        core.construct("block", {
            parent = root,
            name = "handle",
            position = vector3(0, 0.65, 0),
            scale = props.handleSize,
            colour = data[2],
            emissiveColour = data[2],
            renderQueue = 200,
            mesh = props.shape,
            inheritsScale = false,
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