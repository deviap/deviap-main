---------------------------------------------------------------
-- Copyright 2020 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------
--[[
    Draws a wireframe around objects you choose

    local outliner = require(...)
    outliner.add(block, colour(1, 0, 0))
    outliner.update(block, colour(1, 0, 0))
    outliner.remove(block)
]]
local controller = {}
controller.blocks = {}

function controller.add(block, outlineColour)
    if not outlineColour then outlineColour = colour(1, 0, 0) end

    if controller.blocks[block] then
        controller.update(block, outlineColour)
        return nil
    end

    local wireframe = block:clone {
        name = "__WIREFRAME__" .. block.id,
        wireframe = true,
        simulated = false,
        emissiveColour = outlineColour,
        renderQueue = 200,
        parent = block.parent or core.scene
    }

    -- we must delete wireframe if actual obj is deleted
    local onDestroy = block:on("destroying", function()
        controller.destroy(block)
    end)

    local onUpdate = block:on("changed", function()
        wireframe.position = block.position
        wireframe.rotation = block.rotation
        wireframe.scale = block.scale
    end)

    controller.blocks[block] = {
        wireframe = wireframe,
        onDestroy = onDestroy,
        onUpdate = onUpdate
    }

    return wireframe
end

function controller.update(block, outlineColour)
    if not outlineColour then outlineColour = colour(1, 0, 0) end
    if not controller.blocks[block] then return false end

    controller.blocks[block].wireframe.emissiveColour = outlineColour

    return true
end

function controller.remove(block)
    if not controller.blocks[block] then return false end

    controller.blocks[block].wireframe:destroy()
    core.disconnect(controller.blocks[block].onDestroy)
    core.disconnect(controller.blocks[block].onUpdate)
    controller.blocks[block] = nil

    return true
end

return controller
