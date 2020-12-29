---------------------------------------------------------------
-- Copyright 2020 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------

--[[
    WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP 
    WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP 
    WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP 
    WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP WIP 
    
    TODO:
        - Handle Input with the handles in this controller
        - Allow calling scripts to provide a callback
]]

--[[
    Manages the object's translation in Suite

    local translation = require(...)
    translation.attach()
    translation.detach()
]]

local controller = {}
local inlineNotification = require("devgit:source/libraries/UI/components/notifications/inlineNotification.lua")
local map = require("./handles/directions.lua")

-- TODO: REMOVE THIS
local shownDisclaimer = false

-- Move to separate module in library
local function attachHandles(obj, props)

    -- TODO: REMOVE THIS
    if not shownDisclaimer then
        inlineNotification {
            parent = core.interface,
            position = guiCoord(1, -306, 0, 8),
            type = "warning",
            iconEnabled = false,
            text = "handles are a proto, doesnt look OK yet. Consult jay"
        }
        shownDisclaimer = true
    end

    if not props then 
        props = {}
    end

    props.arms = props.arms == nil and true or props.arms
    props.shape = props.shape or "deviap:3d/cube.glb"
    props.handleSize = props.handleSize or vector3(0.2, 0.3, 0.2)

    local handles = {}
    for direction, data in pairs(map) do

        --[[
            ROOT HAS BEEN COMMENTED DUE TO AN ENGINE BUG

            Why do we create the 'root' object?

            Well, we want to have the handles always located just off the edge
            of our selected object, right?

            The root object is positioned as such so that it is stuck directly
            onto an object's outer face. (Position is relative to the parent's position AND scale).

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

        ]]

        --[[
            Now we create the actual handle and nest it in root, which sits
            on the face.

            Any position we set here can always give us a fixed distance
            from the face, even if the scale of the object changes.

            local handle = core.construct("block", {
                parent = root,
                name = "handle",
                position = vector3(0, 0.65, 0),
                scale = props.handleSize,
                colour = data[2],
                emissiveColour = data[2],
                renderQueue = 200,
                mesh = props.shape,
                inheritsScale = false
            })
        ]]

        local handle = core.construct("block", {
            parent = obj,
            name = "__" .. direction .. "Root",
            position = data[1]/1.75,
            scale = props.handleSize,
            colour = data[2],
            emissiveColour = data[2] * 0.75,
            --inheritsScale = false,
            visible = props.arms,
            renderQueue = 200,
            mesh = props.shape,
            rotation = quaternion.lookRotation(data[1]) * quaternion.euler(0, math.rad(90), math.rad(90)),
        })

        handles[handle] = direction
    end

    return handles
end
-- Create Handles.
function controller.attach(obj, properties)
    local handles = attachHandles(obj, properties)
   
    local mouseEvent = core.input:on("mouseLeftDown", require("./handles/mouseDown.lua")(handles, properties.callback))
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