-- This entrypoint is ALWAYS invoked
require("devgit:source/application/utilities/debug/output.lua")
require("devgit:source/application/utilities/debug/keybinds.lua")
local menu = require("devgit:source/application/interface/menu.lua")

-- Some devices (with notches, etc) have padding on the top of the viewport
-- We can customise the colour of the statusbar like so
core.construct("guiFrame", {
	name = "_StatusBar",
	parent = core.interface,
	size = guiCoord(1, 0, 0, 100),
	position = guiCoord(0, 0, 0, -100),
	backgroundColour = colour.rgb(40, 40, 50),
	zIndex = 32000
	-- backgroundAlpha     = 0.75
})

if false then
	core.construct("guiTextBox", {
		parent = core.engine.coreInterface,
		size = guiCoord(0, 20, 0, 12),
		position = guiCoord(0, 2, 0, 2),
		zIndex = 1000,
		textSize = 12,
		text = "LDG",
		textAlign = "middleLeft",
		textFont = "deviap:fonts/sourceCodeProSemiBold.ttf",
		textAlpha = 0.8,
		backgroundColour = colour(0.06, 0.06, 0.06),
		textColour = colour(1, 1, 0),
		strokeRadius = 4
	})
end

core.input:on("keyUp", function(key)
	if key == "KEY_ESCAPE" then
		menu.show()
	end
end)

if core.input.hasScreenKeyboard then
	local settingsButton = core.construct("guiFrame", {
		parent = core.engine.coreInterface,
		size = guiCoord(0, 80, 0, 80),
		position = guiCoord(1, -50, 1, core.input.screenPaddingBottom - 50),
		backgroundAlpha = 0.0,
		zIndex = 1000
	})

	core.construct("guiIcon", {
		parent = settingsButton,
		active = false,
		size = guiCoord(0, 20, 0, 20),
		position = guiCoord(0, 8, 0, 8),
		backgroundAlpha = 0,
		iconId = "build",
		iconColour = colour.black(),
		iconMax = 10
	})

	settingsButton:on("mouseLeftDown", function()
		menu.show()
	end)
end
