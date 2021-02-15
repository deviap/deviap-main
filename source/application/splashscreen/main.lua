---------------------------------------------------------------
-- Copyright 2021 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------
-- Splashscreen Entry Point
local button = require("devgit:source/libraries/UI/components/buttons/baseButton.lua")

local devGitEnabled = core.dev.localDevGitEnabled

local container = core.construct("guiFrame", {
    parent = core.engine.coreInterface,
    position = guiCoord(0, 0, 0, 0),
    size = guiCoord(1, 0, 1, 0),
    backgroundColour = colour.hex("212121")
})

local brandLogo = core.construct("guiImage", {
    parent = container,
    position = guiCoord(0.5, -50, 0.5, -200), --guiCoord(0, 340, 0, 200),
    size = guiCoord(0, 128, 0, 128),
    image = "devgit:assets/images/logo.png",
    backgroundAlpha = 0
})

local brandHeading = core.construct("guiTextBox", {
    parent = container,
    text = "Deviap",
    position = guiCoord(0.5, -80, 0.5, 100),
    size = guiCoord(0, 200, 0, 100),
    backgroundAlpha = 0,
    textSize = 55,
    textFont = "deviap:fonts/openSansSemiBold.ttf",
    textAlign = "middle",
    textColour = colour.hex("FFFFFF"),
    strokeWidth = 2,
    strokeColour = colour.hex("F5F5F5"),
})

local editAppButton = button {
    parent = container,
    position = guiCoord(1, 250, 0.5, -40),
    size = guiCoord(0, 180, 0, 50),
    containerBackgroundColour = colour.rgb(255, 138, 101),
    text = "Edit Application",
    textAlign = "middle",
    textSize = 24,
    strokeRadius = 10,
}

editAppButton.container:on("mouseLeftUp", function()
    -- Do something here, idk.
end)

-- Only enabled if devgit is overriden.
local overrideButton = button {
    parent = container,
    position = guiCoord(1, 250, 0.5, 20),
    size = guiCoord(0, 180, 0, 50),
    containerBackgroundColour = colour.rgb(229, 115, 115),
    text = "Override",
    textAlign = "middle",
    textSize = 24,
    strokeRadius = 10
}

overrideButton.container:on("mouseLeftUp", function()
    -- Remove Splashscreen
    container:destroy()

    -- Load in overlay because, no reason not to.
    require("devgit:source/application/overlay/main.lua")
end)

core.tween:begin(brandHeading, 1, {textAlpha = 0, position = guiCoord(0.5, -80, 0.5, 150)}, "outQuad")
core.tween:begin(brandLogo, 1, {position = guiCoord(0.5, -60, 0.5, -200), size = guiCoord(0, 140, 0, 140)}, "outQuad")
core.tween:begin(editAppButton.container, 0.8, {position = guiCoord(0.5, -70, 0.5, -40)}, "inQuad")

-- Logic to enabled/put into view when devgit is enabled.
if devGitEnabled then
    core.tween:begin(overrideButton.container, 0.8, {position = guiCoord(0.5, -70, 0.5, 20)}, "inQuad")
end