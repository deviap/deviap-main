-- Copyright 2020 - Deviap (deviap.com)

-- Essential Debug Utilities
require("devgit:source/application/utilities/debug/output.lua")
require("devgit:source/application/utilities/debug/keybinds.lua")

local colourMap = require("devgit:source/application/utilities/colourScheme.lua")

local container = core.construct("guiFrame", {
    parent = core.interface,
    size = guiCoord(1, 0, 1, 100),
    position = guiCoord(0, 0, 0, -50),
    backgroundColour = colourMap.orange
})

local pattern = core.construct("guiImage", {
    parent = container,
    size = guiCoord(1, 0, 1, 0),
    backgroundAlpha = 0,
    image = "devgit:assets/images/tile.png",
    patternScaleValues = false,
    imageBottomRight = vector2(120, 120),
    imageColour = colour.black()
})

local tween;
tween = core.tween:begin(pattern, 10, {
    imageTopLeft = vector2(-120, 120)
}, "linear", function()
    tween:reset()
    tween:resume()
end)

local sideContainer = core.construct("guiFrame", {
    parent = core.interface,
    size = guiCoord(0.5, 0, 1, -200),
    position = guiCoord(0.5, 0, 0, 100),
    backgroundAlpha = 0
})

local logoBg, logoShadow, logoText = require("devgit:source/application/utilities/logo.lua")({
    parent = sideContainer,
    size = guiCoord(0, 100, 0, 40),
    position = guiCoord(0.5, -50, 0.5, -80),
    backgroundColour = colour.black(),
    backgroundAlpha = 0.98
}, colour.white())

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
    if _DEVICE:sub(0, 6) == "iPhone" or _DEVICE:sub(0, 4) == "iPad" then        core.openUrl("https://deviap.com/dashboard?client=2")
    else
        core.openUrl("https://deviap.com/dashboard?client=1")
    end
end)
