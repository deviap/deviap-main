local libs = require("devgit:source/suite/client/scripts/libraries.lua")

core.construct("guiTextBox", {
	parent = core.interface,
	text = libs("test"),
	size = guiCoord(1, 0, 1, 0),
	textAlign = "middle"
})