-- Copyright 2020 - Deviap (deviap.com)
local breakpointer = require("devgit:source/libraries/UI-breakpointer/main.lua")
local colourMap = require("devgit:source/application/utilities/colourScheme.lua")

local container = core.construct("guiFrame", {
	parent = core.interface,
	size = guiCoord(1, 0, 1, 100),
	position = guiCoord(0, 0, 0, -50),
	backgroundColour = colourMap.orange
})

local pattern = core.construct("guiImage", {
	parent = container,
	size = guiCoord(0, 3000, 0, 3000),
	backgroundAlpha = 0,
	image = "devgit:assets/images/tile.png",
	patternScaleValues = false,
	imageTopLeft = vector2(0, 0),
	imageBottomRight = vector2(25, 25),
	imageColour = colour.black()
})

local tween;
tween = core.tween:begin(pattern, 10, {
	imageTopLeft = vector2(-1, 1),
	imageBottomRight = vector2(24, 26)
}, "linear", function()
	tween:reset()
	tween:resume()
end)

local sideContainer = core.construct("guiFrame", {
	parent = core.interface,
	backgroundAlpha = 0
})

breakpointer:bind(sideContainer, "xs", {
	size = guiCoord(1, -50, 1, -50),
	position = guiCoord(0, 25, 0, 25)
})

breakpointer:bind(sideContainer, "md", {
	size = guiCoord(0.5, 0, 1, -200),
	position = guiCoord(0.5, 0, 0, 100)
})

require("devgit:source/application/utilities/logo.lua")({
	parent = sideContainer,
	size = guiCoord(0, 50, 0, 50),
	position = guiCoord(0.5, -25, 0.5, -80)
})

local button = core.construct("guiFrame", {
	parent = sideContainer,
	size = guiCoord(0, 130, 0, 30),
	position = guiCoord(0.5, -65, 0.5, -15),
	strokeRadius = 15,
	strokeAlpha = 0.1
})

local icon = core.construct("guiIcon", {
	parent = button,
	iconType = "faSolid",
	iconId = "lock",
	iconColour = colour.black(),
	iconMax = 14,
	size = guiCoord(0, 40, 1, 0),
	active = false
})

local text = core.construct("guiTextBox", {
	parent = button,
	size = guiCoord(1, -60, 1, 0),
	position = guiCoord(0, 40, 0, 0),
	text = "Login",
	textAlign = "middle",
	textFont = "deviap:fonts/openSansBold.ttf",
	textSize = 20,
	backgroundAlpha = 0,
	active = false
})

core.engine:on("authenticating", function(state)
	if state ~= "failed" then
		text.active = false
		text.text = "Pending"
	else
		text.active = true
		text.text = "Login"
	end
end)

button:on("mouseEnter", function()
	button.backgroundColour = colourMap.dark
	text.textColour = colour.white()
	icon.iconColour = colour.white()
end)

button:on("mouseExit", function()
	button.backgroundColour = colour.white()
	text.textColour = colour.black()
	icon.iconColour = colour.black()
end)

button:on("mouseLeftUp", function()
	if _DEVICE:sub(0, 6) == "iPhone" or _DEVICE:sub(0, 4) == "iPad" then
		core.process:openUrl("https://deviap.com/dashboard?client=2")
	else
		core.process:openUrl("https://deviap.com/dashboard?client=1")
	end
end)