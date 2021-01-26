---------------------------------------------------------------
-- Copyright 2021 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------
-- Creates the Scene Edit toolbar.
local gridLayout = require("devgit:source/libraries/UI/constraints/controllers/gridLayout.lua")
local navItem = require("devgit:source/libraries/UI/components/navigation/navItem.lua")

local activeDefinition = nil
local function setActiveTool(toolDefinition)
	if activeDefinition and activeDefinition.deactivate then
		activeDefinition.active = false
		activeDefinition.navItem.props.iconColour = colour.hex("#212121")
		activeDefinition.navItem.render()
		activeDefinition:deactivate()
	end

	if activeDefinition ~= toolDefinition and toolDefinition.activate then
		toolDefinition.active = true
		toolDefinition.navItem.props.iconColour = colour.hex("#0f62fe")
		toolDefinition.navItem.render()
		toolDefinition:activate()
	end

	if activeDefinition == toolDefinition then
		activeDefinition = nil
	else
		activeDefinition = toolDefinition
	end
end

local keyMap = {
	[tonumber(enums.keys.KEY_1)] = 1,
	[tonumber(enums.keys.KEY_2)] = 2,
	[tonumber(enums.keys.KEY_3)] = 3,
	[tonumber(enums.keys.KEY_4)] = 4,
	[tonumber(enums.keys.KEY_5)] = 5,
	[tonumber(enums.keys.KEY_6)] = 6,
	[tonumber(enums.keys.KEY_7)] = 7,
	[tonumber(enums.keys.KEY_8)] = 8,
	[tonumber(enums.keys.KEY_9)] = 9,
	[tonumber(enums.keys.KEY_0)] = 10,
}

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
					toolDefinition.navItem = tool

					tool.container:child("icon"):on("mouseLeftUp", function()
						setActiveTool(toolDefinition)
					end)
				end

				core.input:on("keyUp", function(key)
					-- parent is visible if this 'page' is active
					if parent.visible then
						if keyMap[tonumber(key)] and pageDefinition.tools[keyMap[tonumber(key)]] then
							setActiveTool(pageDefinition.tools[keyMap[tonumber(key)]])
						end
					end
				end)
			end
		}
	end
}
