---------------------------------------------------------------
-- Copyright 2020 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------
-- Creates the Scene Edit toolbar.
local gridLayout = require("devgit:source/libraries/UI/constraints/controllers/gridLayout.lua")
local navItem = require("devgit:source/libraries/UI/components/navigation/navItem.lua")

return {
	createRedirect = function(pageDefinition)
		return {
			-- default = true,
			construct = function(parent)
				local layout = gridLayout()
				layout.container.parent = parent
				layout.container.position = guiCoord(0, 8, 0, 5)
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

				for _, toolDefinition in pairs(pageDefinition.tools) do
					local tool = navItem {
						parent = layout.container,
						size = guiCoord(0, 28, 0, 28),
						navOrientation = "horizontal",
						iconColour = colour.hex("#212121"),
						iconMax = 20,
						iconId = toolDefinition.iconId,
						tooltip = nil,
						redirect = nil
					}
				end
			end
		}
	end
}
