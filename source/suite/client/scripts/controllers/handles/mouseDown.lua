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

return function(handles, dragging, dragEnd)
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

                -- Here we attempt to convert the 3D look vector
                -- of the axe, to a 2D look vector for mouse movements.
                local lookVector3d = v.hit.parent.rotation * (data[1] * 4)
                local point3dA = v.hit.parent.position
                local point3dB = point3dA + lookVector3d
            
                local point2dA = camera:worldToScreen(point3dA)
                local point2dB = camera:worldToScreen(point3dB)
                local lookVector2d = (point2dA - point2dB):normal()
                
                -- Store the mouse position before the drag
                local startMousePosition = core.input.mousePosition
                local lastMousePosition = startMousePosition

                local lastDist = 0
                -- While the user is dragging we stay in this loop
                while sleep() and core.input:isMouseButtonDown(1) do
                    -- Calculate the offset from the start mouse pos
                    local mousePosition = core.input.mousePosition
                    local offsetMousePosition = startMousePosition - mousePosition

                    if lastMousePosition ~= mousePosition then
                        if offsetMousePosition:length() ~= 0 then
                            -- Some arbitrary code to try and map the mouse's
                            -- movement, to units of the approximate 2d lv we made
                            local test = offsetMousePosition / lookVector2d
                            local dist = 0
                            if lookVector2d.x ~= 0 and lookVector2d.y ~= 0 then
                                dist = (test.x + test.y) / 2
                            elseif lookVector2d.x ~= 0 then
                                dist = test.x
                            elseif lookVector2d.y ~= 0 then
                                dist = test.y
                            end

                            -- Display the movement to the user
                            toolTip.visible = true
                            toolTip.position = guiCoord(0, mousePosition.x + 12, 0, mousePosition.y)
                            toolTip.text = tostring(dist)

                            -- smack the callback
                            if dragging and lastDist ~= dist then
                                dragging(direction, dist, lookVector3d:normal())
                                lastDist = dist
                            end
                        else
                            toolTip.visible = false
                        end

                        lastMousePosition = mousePosition
                    end
                end

                if dragEnd then
                    dragEnd()
                end
                toolTip.visible = false
                break
            end
        end
    end
end