local container = core.construct("guiFrame", {
	parent = core.interface,
	size = guiCoord(1, 0, 1, 0),
	position = guiCoord(0, 0, 0, 0),
	backgroundColour = colour.rgb(255, 255, 0),
})

local text = core.construct("guiTextBox", {
    parent = container,
    text = "Client Update Detected \n\nThis is a placeholder interface.\n\nThere was an update interface but it appeared broken, so here's a nice yellow screen of doom!",
    size = guiCoord(1, -60, 1, -60),
    position = guiCoord(0, 30, 0, 30),
    backgroundAlpha = 0,
    textColour = colour.rgb(0, 0, 0),
    textWrap = true
})