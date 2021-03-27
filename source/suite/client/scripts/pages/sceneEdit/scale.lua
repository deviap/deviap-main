---------------------------------------------------------------
-- Copyright 2021 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------
local camera = core.scene.camera
local selection = require("client/scripts/controllers/selection.lua")

-- Hack!? 
-- Just run the normal select tool 
-- in addition to our custom logic in this tool
local selectTool = require("./select.lua")

local handles = require("client/scripts/controllers/handles.lua")
local currentHandles = nil

local function onSelectionChange()
    local items = selection.get()

    if currentHandles then
        handles.detach(currentHandles)
        currentHandles = nil
    end

    if #items > 0 then
        local lastDist = 0
        currentHandles = handles.attach(items[1], {
            shape = "deviap:3d/cube.glb",
            handleSize = vector3(0.2, 0.2, 0.2),
            dragging = function(direction, distance, lookVector3d)
                local dist = distance - lastDist
                local lv = (lookVector3d/20) * dist
                if direction == "back" or direction == "left" or direction == "bottom" then
                    lv = -lv
                end
                for _,v in pairs(items) do
                    v.scale = v.scale + lv
                end

                lastDist = distance
            end,
            dragEnd = function()
                lastDist = 0
            end
        })
    end
end

return {
    name = "scale",
    description = "Desc",
    iconId = "fullscreen_exit",
    
    activate = function(self)
        -- HACK ALERT!
        selectTool.active = true
        selectTool:activate()

        selection.addCallback("translate", onSelectionChange)
        onSelectionChange()
	end,

    deactivate = function(self)
        -- UNHACK ALERT!
        selectTool.active = false
        selectTool:deactivate()

        selection.removeCallback("translate")
        if currentHandles then
            handles.detach(currentHandles)
            currentHandles = nil
        end
	end
}