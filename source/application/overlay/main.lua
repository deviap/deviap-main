---------------------------------------------------------------
-- Copyright 2021 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------
-- Overlay Entry Point
local devMode = core.dev.localDevGitEnabled
local navbar = require("devgit:source/libraries/UI/components/navigation/dynamicNavbar.lua")

local active = false

-- Vertical Sidebar Instance
local verticalNav = navbar {
	orientation = "vertical",
	parent = core.engine.coreInterface,
	size = guiCoord(0, 62, 1, 0),
	position = guiCoord(0, -65, 0, 0),
	iconColour = colour.hex("#FFFFFF"),
	zIndex = 2
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

core.input:on("keyDown", function(key)
	if key == "KEY_ESCAPE" then
		verticalNav.hardReset()
		core.tween:begin(verticalNav.container, 0.3, {position = (active and guiCoord(0, -65, 0, 0)) or guiCoord(0, 0, 0, 0)}, "outQuad", nil)
		active = not active
	end
end)