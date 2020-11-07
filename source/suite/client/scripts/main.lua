local libs = require("scripts/libraries.lua")

local ui = libs("uiLibrary")

local topBar = ui.newComponent("tabs", {
	parent = core.interface,
	size = guiCoord(1, 0, 1, 0)
})

topBar.addTab(ui.newComponent("tab", {}), core.construct("guiTextBox", { text = "hello world"}))

topBar.render()