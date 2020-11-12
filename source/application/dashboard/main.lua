-- Copyright 2020 - Deviap (deviap.com)
-- Author(s): Sanjay-B(Sanjay)
-- Dashboard Entry file. 
local navbar = require("devgit:source/libraries/UI/components/navigation/navbar.lua")

-- Temporary loading screen until we find a better way to do this..?
local loadingScreen = require("devgit:source/application/loading/main.lua")

-- Background
core.construct("guiFrame", {
	parent = core.interface,
	size = guiCoord(1, 0, 1, 0),
	backgroundColour = colour.hex("#E0E0E0")
})

-- Tagging Fetch
local navItemSpacing = 0
local status, body = core.http:get("https://deviap.com/api/v1/users/me", {["Authorization"] = "Bearer " .. core.engine:getUserToken()})
local tagsRoles = core.json:decode(body)["roles"]

for _, role in pairs(tagsRoles) do
	navItemSpacing = navItemSpacing + 80 -- Spacing by 80 looks.
end

-- Vertical Sidebar Instance
local verticalNav = navbar {
	orientation = "vertical",
	parent = core.interface,
	size = guiCoord(0, 62, 1, 0),
	position = guiCoord(0, 0, 0, 0),
	containerBackgroundColour = colour.hex("#212121"),
	iconColour = colour.hex("#FFFFFF"),
	zIndex = 4
}

-- Home Sidebar Button
verticalNav.addNavItem({
	defaultPage = true,
	relativeLocation = "top",
	size = guiCoord(0, 32, 0, 32),
	iconMax = 32,
	iconId = "home",
	tooltip = "Home",
	alertEnabled = true,
	redirect = require("devgit:source/application/dashboard/pages/dashboard.lua")
})

-- Apps Sidebar Button
verticalNav.addNavItem({
	relativeLocation = "top",
	size = guiCoord(0, 32, 0, 32),
	iconMax = 32,
	iconId = "apps",
	tooltip = "Apps",
	redirect = require("devgit:source/application/dashboard/pages/apps.lua")
})

-- Develop Sidebar Button
verticalNav.addNavItem({
	relativeLocation = "top",
	size = guiCoord(0, 32, 0, 32),
	iconMax = 32,
	iconId = "code",
	tooltip = "Develop",
	redirect = require("devgit:source/application/dashboard/pages/develop.lua")
})

-- Groups Sidebar Button
verticalNav.addNavItem({
	relativeLocation = "top",
	size = guiCoord(0, 32, 0, 32),
	iconMax = 32,
	iconId = "question_answer",
	tooltip = "Groups",
	redirect = nil
})

-- Shop Sidebar Button
verticalNav.addNavItem({
	relativeLocation = "top",
	size = guiCoord(0, 32, 0, 32),
	iconMax = 32,
	iconId = "shopping_cart",
	tooltip = "Shop",
	redirect = nil
})

-- Settings Sidebar Button
verticalNav.addNavItem({
	relativeLocation = "bottom",
	size = guiCoord(0, 32, 0, 32),
	iconMax = 32,
	iconId = "tune",
	tooltip = "Settings",
	redirect = nil
})

-- Horizontal Navbar Instance
local horizontalNav = navbar {
	orientation = "horizontal",
	parent = core.interface,
	size = guiCoord(1, -74, 0, 62),
	position = guiCoord(0, 68, 1, -62),
	containerBackgroundColour = colour.hex("#FFFFFF"),
	iconColour = colour.hex("#212121"),
	bottomOffset = navItemSpacing,
	extensionNav = verticalNav,
	zIndex = 3
}

-- Alerts Navbar Button
horizontalNav.addNavItem({
	relativeLocation = "top",
	size = guiCoord(0, 32, 0, 32),
	iconMax = 32,
	iconId = "notifications",
	tooltip = "Alerts",
	alertEnabled = true,
	redirect = require("devgit:source/application/dashboard/pages/alerts.lua")
})

-- Direct Messages Navbar Button
horizontalNav.addNavItem({
	relativeLocation = "top",
	size = guiCoord(0, 32, 0, 32),
	iconMax = 32,
	iconId = "email",
	tooltip = "Inbox",
	redirect = nil
})

-- Friends Navbar Button
horizontalNav.addNavItem({
	relativeLocation = "top",
	size = guiCoord(0, 32, 0, 32),
	iconMax = 32,
	iconId = "group",
	tooltip = "Friends",
	redirect = nil
})

-- Add Friend Navbar Button
horizontalNav.addNavItem({
	relativeLocation = "top",
	size = guiCoord(0, 32, 0, 32),
	iconMax = 32,
	iconId = "person_add",
	tooltip = "Add Friend",
	redirect = nil
})

-- Tagging Render
for _, roleName in pairs(tagsRoles) do
	horizontalNav.addTagItem({
		relativeLocation = "bottom",
		text = roleName
	})
end

-- Report Navbar Button
horizontalNav.addNavItem({
	relativeLocation = "bottom",
	size = guiCoord(0, 32, 0, 32),
	iconMax = 32,
	iconId = "announcement",
	tooltip = "Report",
	redirect = nil
})

-- Feedback Navbar Button
horizontalNav.addNavItem({
	relativeLocation = "bottom",
	size = guiCoord(0, 32, 0, 32),
	iconMax = 32,
	iconId = "bug_report",
	tooltip = "Feedback",
	redirect = nil
})

-- Remove loading screen when done
loadingScreen:destroy()