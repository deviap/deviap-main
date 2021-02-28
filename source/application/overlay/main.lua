---------------------------------------------------------------
-- Copyright 2021 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------
-- Overlay Entry Point
local devMode = core.dev.localDevGitEnabled
local navbar = require("devgit:source/libraries/UI/components/navigation/dynamicNavbar.lua")

-- Vertical Sidebar Instance
local verticalNav = navbar {
	orientation = "vertical",
	parent = core.engine.coreInterface,
	size = guiCoord(0, 62, 1, 0),
	position = guiCoord(0, -65, 0, 0),
	iconColour = colour.hex("#FFFFFF"),
	zIndex = 3
}

-- General Information/Acknowledgements Sidebar Button
verticalNav.addNavItem({
	relativeLocation = "top",
	size = guiCoord(0, 32, 0, 32),
	iconMax = 24,
	iconId = "people_alt",
	redirect = require("devgit:source/application/overlay/pages/information.lua")
})

-- Achievements Sidebar Button
verticalNav.addNavItem({
	relativeLocation = "top",
	size = guiCoord(0, 32, 0, 32),
	iconMax = 24,
	iconId = "emoji_events",
	redirect = require("devgit:source/application/overlay/pages/achievements.lua")
})

-- Performance Sidebar Button
verticalNav.addNavItem({
	relativeLocation = "top",
	size = guiCoord(0, 32, 0, 32),
	iconMax = 24,
	iconId = "bar_chart",
	redirect = require("devgit:source/application/overlay/pages/performance.lua")
})

-- Settings Sidebar Button
verticalNav.addNavItem({
	relativeLocation = "bottom",
	size = guiCoord(0, 32, 0, 32),
	iconMax = 24,
	iconId = "tune",
	redirect = require("devgit:source/application/overlay/pages/settings.lua")
})

local box = core.construct("guiFrame", {
	parent = core.engine.coreInterface,
	size = guiCoord(1, 0, 1, 0),
	backgroundAlpha = 0,
	zIndex = 2,
})

local active = false


box:on("mouseLeftDown", function()
	if not active then return end
	active = false
	verticalNav.hardReset()
	core.tween:begin(verticalNav.container, 0.3, {position = guiCoord(0, -65, 0, 0)}, "outQuad", nil)
end)


core.input:on("keyDown", function(key)
	if key == "KEY_ESCAPE" then
		verticalNav.hardReset()
		core.tween:begin(verticalNav.container, 0.3, {position = (active and guiCoord(0, -65, 0, 0)) or guiCoord(0, 0, 0, 0)}, "outQuad", nil)
		active = not active
	end
end)