local window = require("devgit:source/libraries/legacy/UI/components/widgets/window.lua")
local primaryButton = require("devgit:source/libraries/legacy/UI/components/buttons/primaryButton.lua")
local secondaryButton = require("devgit:source/libraries/legacy/UI/components/buttons/secondaryButton.lua")

local newFileExplorer = require("./fileExplorer.lua")


local container = core.construct("guiFrame", {
	parent = core.interface,
})

local fileExplorer = newFileExplorer.construct {
	parent = container,
	size = guiCoord(1, 0, 0.9, 0)
}

local accept = primaryButton {
	parent = container,
	size = guiCoord(0.5, 0, 0.1, 0),
	position  =  guiCoord(0.5, 0, 0.9, 0),
	text = "Confirm"
}

local cancel = secondaryButton {
	parent = container,
	size = guiCoord(0.5, 0, 0.1, 0),
	position  = guiCoord(0, 0, 0.9, 0),
	text = "Cancel"	
}

window {
	parent = core.interface,
	position = guiCoord(0, 100, 0, 100),
	size = guiCoord(0, 300, 0, 200),
	title = "Select a file",
	content = container
}


return 1