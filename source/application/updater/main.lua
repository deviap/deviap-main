-- Copyright 2020 - Deviap (deviap.com)
local colourMap =
    require("devgit:source/application/utilities/colourScheme.lua")

local container = core.construct("guiFrame", {
    parent = core.interface,
    size = guiCoord(1, 0, 1, 100),
    position = guiCoord(0, 0, 0, -50),
    backgroundColour = colour.black()
})

local pattern = core.construct("guiImage", {
    parent = container,
    size = guiCoord(1, 0, 1, 0),
    backgroundAlpha = 0,
    image = "devgit:assets/images/tile.png",
    patternScaleValues = false,
    imageBottomRight = vector2(120, 120)
})

local tween;
tween = core.tween:begin(pattern, 5, {imageTopLeft = vector2(-120, 120)},
                         "linear", function()
    tween:reset()
    tween:resume()
end)

local logoBg, logoShadow, logoText = require(
                                         "devgit:source/application/utilities/logo.lua")(
                                         {
        parent = container,
        size = guiCoord(0, 400, 0, 160),
        position = guiCoord(0.5, -200, 0.5, -80),
        backgroundColour = colour.rgb(255, 255, 255),
        backgroundAlpha = 0.98
    })

-- Move to effects module (or something similar)
local colours = {
    colourMap.purple, colourMap.lightBlue, colourMap.blue, colourMap.green,
    colourMap.terraCotta
}

local currentColourIndex = 1

spawn(function()
    while true do
        core.tween:begin(container, 4,
                         {backgroundColour = colours[currentColourIndex]})
        core.tween:begin(logoText, 4, {textColour = colours[currentColourIndex]})
        currentColourIndex = currentColourIndex + 1
        if currentColourIndex > #colours then currentColourIndex = 1 end
        sleep(4)
    end
end)

--
sleep(3)
core.tween:begin(logoShadow, 1, {position = guiCoord(0.5, -200, 0.4, -90)})
core.tween:begin(logoBg, 1, {position = guiCoord(0.5, -190, 0.4, -100)})
sleep(1)

-- If devgit is overridden
if core.dev.localDevGitEnabled then

    core.construct("guiTextBox", {
        parent = container,
        size = guiCoord(0, 370, 0, 100),
        position = guiCoord(0.5, -185, 0.58, -30),
        backgroundAlpha = 0,
        text = "We've detected that your client has been overrided with the following PATH: ",
        textColour = colour.rgb(1, 1, 1),
        textAlign = "middle",
        textSize = 18,
        textFont = "deviap:assets/fonts/openSansBold.ttf",
        textMultiline = true,
        textWrap = true
    })

    local pathUi = core.construct("guiTextBox", {
        parent = container,
        size = guiCoord(0, 300, 0, 30),
        position = guiCoord(0.5, -150, 0.64, 10),
        backgroundColour = colour.rgb(246, 248, 250),
        backgroundAlpha = 1,
        text = core.dev.localDevGitPath,
        textColour = colour.rgb(1, 1, 1),
        textAlign = "middle",
        textSize = 15,
        textFont = "deviap:assets/fonts/sourceCodeProBold.ttf",
        strokeRadius = 3
    })

    pathUi.size = guiCoord(0, pathUi.textDimensions.x + 30, 0, 30)
    pathUi.position = guiCoord(0.5, -pathUi.size.offset.x / 2, 0.64, 10)
end

-- If barebones application
if not core.dev.localDevGitEnabled then

    local infoLabel = core.construct("guiTextBox", {
        parent = container,
        size = guiCoord(0, 370, 0, 100),
        position = guiCoord(0.5, -185, 0.58, -40),
        backgroundAlpha = 0,
        text = "Please give us a moment while we update your CLIENT: ",
        textColour = colour.rgb(1, 1, 1),
        textAlign = "middle",
        textSize = 18,
        textFont = "deviap:assets/fonts/openSansBold.ttf",
        textMultiline = true,
        textWrap = true
    })

    local progressBarContainer = core.construct("guiFrame", {
        parent = Container,
        size = guiCoord(0, 300, 0, 30),
        position = guiCoord(0.5, -150, 0.64, 10),
        backgroundColour = colour.rgb(246, 248, 250),
        backgroundAlpha = 1,
        strokeRadius = 3
    })

    core.input:on("keyDown", function(key)
        if key == "KEY_RETURN" then
            -- Remove Updater / Splash Screen
            container:destroy()
        end
    end)

    core.engine:on("updateMessage",
                   function(message) infoLabel.text = message end)

    core.engine:on("updateProgress", function(str)
        core.tween:begin(progressBarFrame, 0.2,
                         {size = guiCoord(i / 100, 0, 1, 0)})
    end)
end

core.construct("guiTextBox", {
    parent = container,
    size = guiCoord(0, 370, 0, 100),
    position = guiCoord(0.5, -185, 0.7, -30),
    backgroundAlpha = 0,
    text = "Please press 'return' or 'enter' to continue.",
    textColour = colour.rgb(1, 1, 1),
    textAlign = "middle",
    textSize = 16,
    textMultiline = true,
    textWrap = true
})

core.input:on("keyDown", function(key)
    if key == "KEY_RETURN" then
        -- Remove Updater / Splash Screen
        container:destroy()

        -- Check if the user is authenticated

        -- If user is authenticated
        -- Push to Dashboard

        -- If user is not authenticated
        -- Push to Login 
    end
end)
