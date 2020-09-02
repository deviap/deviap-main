-- Copyright 2020 - Deviap (deviap.com)
-- Author(s): Sanjay-B(Sanjay)

-- Updater & Splash Screen file: Updates Deviap Application w/ style
-- Note: Ignores updating process when tevgit is active / enabled

--[[
    Terra Cotta: e57373 // 229, 115, 115
    Blue: 3e92cc // 62, 146, 204
    Green: 67ce67 // 103, 206, 103
    Dark Grey: 666666 // 102, 102, 102
    Light Blue: 679bce // 103, 155, 206
    Purple: 6767ce // 103, 103, 206
    Orange: ff8a65 // 255, 138, 101
    Yellow: ffb74d // 255, 183, 77
]]--

local Container = core.construct("guiFrame", {
    parent = core.interface,
    size = guiCoord(1, 0, 1, 100),
    position = guiCoord(0, 0, 0, -50),
    backgroundColour = colour.rgb(1, 1, 1)
})

local centerBackContainer = core.construct("guiFrame", {
    parent = Container,
    size = guiCoord(0, 400, 0, 200),
    position = guiCoord(0.5, -200, 0.5, -100),
    backgroundColour = colour.rgb(255, 255, 255),
    backgroundAlpha = 0.7
})

local centerContainer = core.construct("guiFrame", {
    parent = Container,
    size = guiCoord(0, 400, 0, 200),
    position = guiCoord(0.5, -190, 0.5, -110),
    backgroundColour = colour.rgb(255, 255, 255),
    backgroundAlpha = 0.98
})

local Header = core.construct("guiTextBox", {
    parent = centerContainer,
    size = guiCoord(0, 400, 0, 200), 
    position = guiCoord(0.5, -200, 0.5, -100),
    backgroundAlpha = 0,
    text = "deviap",
    textColour = colour.rgb(1, 1, 1),
    textAlign = "middle",
    textSize = 140,
    textFont = "tevgit:fonts/monofonto.ttf"
})

-- Move to effects module (or something similar)
local Colors = {
    [1] = colour.rgb(102, 102, 102), 
    [2] = colour.rgb(103, 155, 206), 
    [3] = colour.rgb(103, 155, 206), 
    [4] = colour.rgb(62, 146, 204), 
    [5] = colour.rgb(103, 206, 103),
    [6] = colour.rgb(229, 115, 115), 
    [7] = colour.rgb(1, 1, 1)
}

local Count = 1

spawn(function() 
    while sleep(4) do
        core.tween:begin(Container, 4, { backgroundColour = Colors[Count] })
        core.tween:begin(Header, 4, { textColour = Colors[Count] })
        Count = Count + 1
        if Count == 7 then Count = 1 end
    end
end)

--
sleep(5)
core.tween:begin(centerBackContainer, 1, { position = guiCoord(0.5, -200, 0.4, -100) })
core.tween:begin(centerContainer, 1, { position = guiCoord(0.5, -190, 0.4, -110) })
sleep(1)


-- If Tevgit is overridden
if core.dev.localTevGit then

    core.construct("guiTextBox", {
        parent = Container,
        size = guiCoord(0, 370, 0, 100),
        position = guiCoord(0.5, -185, 0.58, -30),
        backgroundAlpha = 0,
        text = "We've detected that your client has been overrided with the following PATH: ",
        textColour = colour.rgb(1, 1, 1),
        textAlign = "middle",
        textSize = 18,
        textFont = "tevurl:fonts/openSansBold.ttf",
        textMultiline = true,
        textWrap = true
    })

    core.construct("guiTextBox", {
        parent = Container,
        size = guiCoord(0, 300, 0, 30),
        position = guiCoord(0.5, -150, 0.64, 10),
        backgroundColour = colour.rgb(246, 248, 250),
        backgroundAlpha = 1,
        text = "/Users/username/Desktop/deviap-main",
        textColour = colour.rgb(1, 1, 1),
        textAlign = "middle",
        textSize = 15,
        textFont = "tevurl:fonts/firaCodeBold.otf",
        strokeRadius = 3
    })
end

-- If barebones application
if not core.dev.localTevGit then
    
    local infoLabel = core.construct("guiTextBox", {
        parent = Container,
        size = guiCoord(0, 370, 0, 100),
        position = guiCoord(0.5, -185, 0.58, -40),
        backgroundAlpha = 0,
        text = "Please give us a moment while we update your CLIENT: ",
        textColour = colour.rgb(1, 1, 1),
        textAlign = "middle",
        textSize = 18,
        textFont = "tevurl:fonts/openSansBold.ttf",
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

    local progressBarFrame = core.construct("guiGradientFrame", {
        parent = progressBarContainer,
        size = guiCoord(0, 0, 1, 0),
        position = guiCoord(0, 0, 0, 0),
        backgroundColour = colour.rgb(129, 231, 129),
        backgroundColourB = colour.rgb(103, 206, 103),
        backgroundAlpha = 1,
        strokeRadius = 3
    })

    core.networking:on("_update", function(message)
        infoLabel.text = message
    end)

    core.networking:on("_downloadProgress", function(str)
        core.tween:begin(progressBarFrame, 0.2, { size = guiCoord(i/100, 0, 1, 0) })
    end)
end

core.construct("guiTextBox", {
    parent = Container,
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