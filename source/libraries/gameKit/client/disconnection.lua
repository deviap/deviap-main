---------------------------------------------------------------
-- Copyright 2021 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------

local container = core.construct("guiFrame", {
	parent = core.interface,
	name = "_DisconnectionInterface",
	size = guiCoord(0, 200, 0, 70),
	position = guiCoord(1, -210, 1, -80),
	backgroundColour = colour.rgb(0, 0, 0),
	zIndex = 1000,
    backgroundAlpha = 0.85,
    visible = false
})

local statusText = core.construct("guiTextBox", {
	parent = container,
	size = guiCoord(1, -20, 1, -20),
	position = guiCoord(0, 10, 0, 10),
	backgroundAlpha = 0,
	textColour = colour.rgb(255, 255, 255),
	text = "You have lost connection",
	textAlign = "middle"
})

core.networking:on("_connected", function()
    container.visible = false
end)

core.networking:on("_disconnected", function()
    container.visible = true
end)
