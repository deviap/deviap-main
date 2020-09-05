-- This is the main interface loaded into coreinterface

-- status bar for mobiles:
core.construct("guiFrame", {
    name = "statusBar",
    parent = core.coreInterface,
    size = guiCoord(1, 0, 0, 50),
    position = guiCoord(0, 0, 0, -50),
    backgroundColour = colour.black(),
    backgroundAlpha = 0.75
})

if core.dev.localDevGitEnabled then
    core.construct("guiTextBox", {
        parent = core.coreInterface,
        size = guiCoord(0,40, 0, 8),
        position = guiCoord(0, 2, 1, -10),
        zIndex = 1000,
        textSize = 8,
        text = "Local devgit",
        textAlign = "middleRight",
        textAlpha = 0.8,
        backgroundAlpha = 0.5,
        textAlign = "middle",
        strokeRadius = 4
    })
end

local debug = false
core.input:on("keyUp", function(key)
    if key == "KEY_F1" and not core.dev.localDevGitEnabled and core.input:isKeyDown("KEY_LSHIFT") then
        core.dev:promptDevGit()
    elseif key == "KEY_F2" and core.input:isKeyDown("KEY_LSHIFT") then
        print("Reload")
        core.dev:reloadAllShaders()
    elseif key == "KEY_F12" and core.input:isKeyDown("KEY_LSHIFT") then
        print("Debug")
        debug = not debug
        core.graphics:setDebug(debug)
    end
end)

local settingsButton = core.construct("guiFrame", {
    parent = core.coreInterface,
    size = guiCoord(0, 66, 0, 66),
    position = guiCoord(1, -33, 1, -33),
    strokeRadius = 33,
    dropShadowAlpha = 0.15,
    strokeAlpha = 0.05,
    backgroundAlpha = 1,
    visible = core.networking.localClient ~= nil,
    zIndex = 1000
})

local keyboardSupport = false
if _TEV_VERSION_MINOR >= 27 then
    keyboardSupport = not core.input.hasScreenKeyboard
end

if keyboardSupport then
    settingsButton.visible = false

    local reminder = core.construct("guiTextBox", {
        parent = core.coreInterface,
        size = guiCoord(0, 145, 0, 14),
        position = guiCoord(1, -160, 1, -14),
        zIndex = 1000,
        textSize = 12,
        text = "<ESC> : main menu at anytime",
        textAlpha = 0,
        textAlign = "middle",
        textFont = "tevurl:fonts/openSansBold.ttf",
        textWrap = true,
        backgroundColour = colour.rgb(45, 45, 45),
        textColour = colour.rgb(255, 255, 255),
        backgroundAlpha = 0
    })

    spawn(function() 
        core.tween:begin(reminder, 0.5, {
            position = guiCoord(1, -145, 1, -14),
            textAlpha = 1.0,
            backgroundAlpha = 1.0,
            strokeAlpha = 0.1,
            dropShadowAlpha = 0.1
        }, "inOutQuad")
        sleep(1.5)
        core.tween:begin(reminder, 0.5, {
            position = guiCoord(1, 2, 1, -14)
        }, "inOutQuad")
        sleep(0.5)
        reminder:destroy()
    end)
end

core.construct("guiIcon", {
    parent = settingsButton,
    size = guiCoord(0, 30, 0, 30),
    position = guiCoord(0, 5, 0, 5),
    iconId = "wrench",
    iconType = "faSolid",
    iconColour = colour(0, 0, 0),
    iconMax = 10,
    iconAlpha = 0.75,
    active = false
})

local container = core.construct("guiFrame", {
    parent = core.coreInterface,
    size = guiCoord(1, 200, 1, 200),
    position = guiCoord(0, -100, 0, -100),
    backgroundAlpha = 0.85,
    backgroundColour = colour.rgb(0, 0, 0),
    visible = false
})

local inner = core.construct("guiFrame", {
    parent = container,
    size = guiCoord(0, 100, 0, 50),
    position = guiCoord(0.5, -50, 0.5, -25),
    strokeRadius = 25,
    strokeAlpha = 0.3,
})

local console = require("devgit:core/teverseUI/console.lua")
local lastClick = 0
local function onClick()
    if os.clock() - lastClick < 0.4 then
        -- double click
        lastClick = 0
        console.visible = not console.visible
    else
        lastClick = os.clock()
        if container.visible then
            container.visible = false
            if not keyboardSupport then
                settingsButton.visible = true
            end
        else
            settingsButton.visible = false
            container.visible = true
            container.backgroundAlpha = 0
            container.position = guiCoord(0, -100, 0, -80)
            core.tween:begin(container, 0.25, {
                position = guiCoord(0, -100, 0, -100),
                backgroundAlpha = 0.9
            }, "inOutQuad")
        end
    end
end

settingsButton:on("mouseLeftUp", onClick)
core.input:on("keyUp", function(key)
    if key == "KEY_ESCAPE" then
        onClick()
    end
end)

local closeButton = core.construct("guiIcon", {
    parent = inner,
    size = guiCoord(0, 30, 0, 30),
    position = guiCoord(0, 10, 0, 10),
    iconId = "arrow-left",
    iconType = "faSolid",
    iconColour = colour(0, 0, 0),
    iconMax = 12,
    iconAlpha = 0.75,
    strokeRadius = 15,
    dropShadowAlpha = 0.15,
    strokeAlpha = 0.05,
    backgroundAlpha = 1
})

closeButton:on("mouseEnter", function()
    closeButton.backgroundColour = colour.rgb(45, 45, 45)
    closeButton.iconColour = colour.rgb(255, 255, 255)
end)

closeButton:on("mouseExit", function()
    closeButton.backgroundColour = colour.rgb(255, 255, 2555)
    closeButton.iconColour = colour.rgb(0, 0, 0)
end)

closeButton:on("mouseLeftUp", function()
    container.visible = false
    if not keyboardSupport then
        settingsButton.visible = true
    end
end)

local homeButton = core.construct("guiIcon", {
    parent = inner,
    size = guiCoord(0, 30, 0, 30),
    position = guiCoord(0, 60, 0, 10),
    iconId = "home",
    iconType = "faSolid",
    iconColour = colour(0, 0, 0),
    iconMax = 12,
    iconAlpha = 0.75,
    strokeRadius = 15,
    dropShadowAlpha = 0.15,
    strokeAlpha = 0.05,
    backgroundAlpha = 1
})

homeButton:on("mouseEnter", function()
    homeButton.backgroundColour = colour.rgb(45, 45, 45)
    homeButton.iconColour = colour.rgb(255, 255, 255)
end)

homeButton:on("mouseExit", function()
    homeButton.backgroundColour = colour.rgb(255, 255, 2555)
    homeButton.iconColour = colour.rgb(0, 0, 0)
end)

homeButton:on("mouseLeftUp", function()
    core.apps:loadDashboard()
end)