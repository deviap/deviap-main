local libs = require("scripts/libraries.lua")
local windowManager = libs("windowManager")
local newComponent = libs("uiLibrary").newComponent

local container = core.construct("guiFrame", {parent = core.interface}) -- This is why we need the nil-zone, Jay

local tabs = newComponent("tabs", {
	parent = container
})

local homeBarWindow = windowManager.newWindow({
	parent = core.interface,
	subContainer = container,
	size = guiCoord(0, core.input.screenSize.x - 20, 0, 100),
	position = guiCoord(0, 10, 0, 10),
	title = "Ribbon",
	icons = 
	{
		core.construct("guiIcon", {
			parent = core.interface, -- This is why we need the nil-zone, Jay
			iconColour = colour.white(),
			backgroundAlpha = 1,
			iconId = "remove",
			backgroundColour = colour(0.5, 0.5, 0.5),
		})
	}
})

homeBarWindow.props.icons[1]:on("mouseLeftUp", windowManager.applyMinimization(homeBarWindow))
windowManager.applyDraggable(homeBarWindow, homeBarWindow.topBar)
windowManager.applyResizable(homeBarWindow)

return 0