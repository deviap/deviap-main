-- Copyright 2020 - Deviap (deviap.com)
-- Test file. Expect to change.

local libs = require("scripts/libraries.lua")

local addBox = core.construct("guiTextBox", {
	parent = core.interface,
	size = guiCoord(0, 150, 0, 25),
	position = guiCoord(1, -150, 0, 0),
	text = "add a notepad",	
	textAlign = "middle"
})

addBox:on("mouseLeftUp", function()
	local subContainer = core.construct("guiFrame")

	core.construct("guiTextBox", {
		size = guiCoord(1, -4, 1, -4),
		position = guiCoord(0, 2, 0, 2),

		parent = subContainer,
		textEditable = true,
		textWrap = true,
		textMultiline = true
	})

	libs("windowManager").addWindow({ 
		subContainer = subContainer,
		parent = core.interface,
		title = "notepad",
		primaryColour = colour.hex("#1e6c96")
	})
end)