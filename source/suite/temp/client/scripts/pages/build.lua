---------------------------------------------------------------
-- Copyright 2020 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------
-- Author(s): Sanjay-B(Sanjay)
-- Creates the Build toolbar.
local gridLayout = require("devgit:source/libraries/UI/constraints/controllers/gridLayout.lua")
local navItem = require("devgit:source/libraries/UI/components/navigation/navItem.lua")
local newInstance = require("devgit:source/suite/temp/client/scripts/toolchain/newInstance.lua")


return {
	default = false,
	construct = function(parent)

		local layout = gridLayout()
		layout.container.parent = parent
		layout.container.position = guiCoord(0, 6, 0, 5)
		layout.container.size = guiCoord(1, 0, 1, 0)
		layout.container.canvasSize = guiCoord(1, 0, 1, 0)
		layout.container.backgroundColour = colour.hex("#FF0000")
		layout.container.backgroundAlpha = 0
		layout.container.scrollbarAlpha = 0
		layout.rows = 8
		layout.columns = 8
		layout.cellSize = vector2(20, 20)
		layout.cellSpacing = vector2(10, 10)
		layout.fitX = false
		layout.fitY = false
		layout.wrap = true

        -- Creates a base block instance.
        local newBlock = navItem {
            parent = layout.container,
            size = guiCoord(0, 28, 0, 28),
            navOrientation = "horizontal",
            iconColour = colour.hex("#212121"),
            iconMax = 20,
            iconId = "stop",
            redirect = 
        }
	end
}

--[[
    newInstance("block", {
        parent = core.scene,
        position = vector3(0, 10, 0),
        scale = vector3(5, 5, 5),
        colour = colour.hex("#616161")
    })
]]--