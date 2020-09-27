local libs = require("scripts/libraries.lua")

core.construct("guiTextBox", {
	parent = core.interface,
	text = libs("test"),
	size = guiCoord(0.5, 0, 0.5, 0),
	position = guiCoord(0.25, 0, 0.25, 0),
	textAlign = "middle"
})

print"hello world"

