---------------------------------------------------------------
-- Copyright 2020 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------
-- Author(s): Sanjay-B(Sanjay)
-- Suite Entry Point
require("devgit:source/application/utilities/camera.lua")

core.scene.simulate = true
core.scene.camera.position = vector3(10, 10, -10)
core.scene.camera.rotation = quaternion.euler(math.rad(25), 0, 0)

core.graphics.ambientDirection = vector3(0, 1, 0)
--core.graphics.upperAmbient = colour.rgb(255, 0, 0)
--core.graphics.lowerAmbient = colour.rgb(0, 255, 0)

core.graphics.sky = ""

local base = core.construct("block", {
	position = vector3(0, -10, 0),
	scale = vector3(30, 1, 30),
	colour = colour.hex("#212121")
})

core.scene.camera:lookAt(base.position)

-- MAIN INTERFACE IGNORE ABOVE
local navbar = require("devgit:source/libraries/UI/components/navigation/navbarAnimated.lua")

-- Vertical Sidebar Instance
local verticalNav = navbar {
	orientation = "vertical",
	parent = core.interface,
	size = guiCoord(0, 40, 1, 0),
	position = guiCoord(0, 0, 0, 0),
	containerBackgroundColour = colour.hex("#212121"),
	iconColour = colour.hex("#FFFFFF"),
	zIndex = 4
}

-- Scene/World Edit button
verticalNav.addNavItem({
	defaultPage = true,
	relativeLocation = "top",
	size = guiCoord(0, 32, 0, 32),
	iconMax = 20,
	iconId = "pan_tool",
	tooltip = "Scene Edit",
	redirect = require("devgit:source/suite/temp/client/scripts/pages/SceneEdit.lua")
})

-- Gui (editing gui/guis) button
verticalNav.addNavItem({
	defaultPage = false,
	relativeLocation = "top",
	size = guiCoord(0, 32, 0, 32),
	iconMax = 20,
	iconId = "view_quilt",
	tooltip = "Gui",
	redirect = nil
})

-- Build/Construct button
verticalNav.addNavItem({
	defaultPage = false,
	relativeLocation = "top",
	size = guiCoord(0, 32, 0, 32),
	iconMax = 20,
	iconId = "construction",
	tooltip = "Build",
	redirect = nil
})

-- Test/Play button
verticalNav.addNavItem({
	defaultPage = false,
	relativeLocation = "top",
	size = guiCoord(0, 32, 0, 32),
	iconMax = 20,
	iconId = "play_arrow",
	tooltip = "Test",
	redirect = nil
})

-- Settings button
verticalNav.addNavItem({
	defaultPage = false,
	relativeLocation = "bottom",
	size = guiCoord(0, 32, 0, 32),
	iconMax = 20,
	iconId = "tune",
	tooltip = "Settings",
	redirect = nil
})

-- Save Button (Eventually replace to auto-save)
verticalNav.addNavItem({
	defaultPage = false,
	relativeLocation = "bottom",
	size = guiCoord(0, 32, 0, 32),
	iconMax = 20,
	iconId = "save",
	tooltip = "Save",
	redirect = nil
})

-- Horizontal Navbar Instance
local horizontalNav = navbar {
	orientation = "horizontal",
	parent = core.interface,
	size = guiCoord(590, 0, 0, 15),
    position = guiCoord(0, 40, 1, -45),
	containerBackgroundColour = colour.hex("#212121"),
	iconColour = colour.hex("#212121"),
	zIndex = 3
}

horizontalNav.addNavTextItem({
	defaultPage = false,
	relativeLocation = "top",
	size = guiCoord(0, 65, 0, 10),
	textColour = colour.hex("#FFFFFF"),
	text = "EXPLORER",
	redirect = nil
})
