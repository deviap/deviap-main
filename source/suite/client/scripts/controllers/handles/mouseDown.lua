---------------------------------------------------------------
-- Copyright 2020 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------

local map = require("./directions.lua")

local toolTip = core.construct("guiTextBox", {
    backgroundAlpha = 0,
    text = "test",
    textSize = 14,
    textAlign = "middleLeft",
    textFont = "deviap:fonts/openSansBold.ttf",
    size = guiCoord(1, 0, 0, 20),
    position = guiCoord(0,100, 0, 20),
    parent = core.interface,
    name = "__translation",
    visible = false
})

return function(handles)
    return function()
        local camera = core.scene.camera

        -- Calculate the camera's position and the cursor's direction
        local camPos = camera.position
        local mousePos = camera:screenToWorld(core.input.mousePosition) * 500

        -- Perform the raycast, exclude our selection highlighter
        local hits = core.scene:raycast(camPos, camPos + mousePos)

        for _,v in pairs(hits) do
            if handles[v.hit] then
                local direction = handles[v.hit]
                local data = map[direction]

                toolTip.visible = true
                toolTip.text = direction
                toolTip.position = guiCoord(0, core.input.mousePosition.x + 12, 0, core.input.mousePosition.y)

                -- While the user is dragging we stay in this loop
                while sleep() and core.input:isMouseButtonDown(1) do
                    toolTip.position = guiCoord(0, core.input.mousePosition.x + 12, 0, core.input.mousePosition.y)
                end

                toolTip.visible = false
                break
            end
        end
    end
end