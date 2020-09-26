------------------------------------
------------------------------------
-- LEGACY FILE - REQUIRES REWRITE --
------------------------------------
------------------------------------
-- This script is ran when the user is running a local app/sandbox
local share = core.construct("guiTextBox", {
    parent = core.engine.coreInterface,
    size = guiCoord(0, 60, 0, 16),
    position = guiCoord(0.5, -65, 1, -16),
    strokeRadius = 2,
    text = "Share",
    textAlign = "middle",
    textSize = 12
})

local reload = core.construct("guiTextBox", {
    parent = core.engine.coreInterface,
    size = guiCoord(0, 60, 0, 16),
    position = guiCoord(0.5, 5, 1, -16),
    strokeRadius = 2,
    text = "Reload",
    textAlign = "middle",
    textSize = 12
})

local test = core.construct("guiTextBox", {
    parent = core.engine.coreInterface,
    size = guiCoord(0, 90, 0, 16),
    position = guiCoord(1.0, -140, 1, -16),
    strokeRadius = 2,
    text = "Remote Test",
    textAlign = "middle",
    textSize = 12
})

reload:on("mouseLeftUp", function() core.apps:reload() end)

share:on("mouseLeftUp", function()
    share.visible = false
    reload.visible = false

    local backdrop = core.construct("guiFrame", {
        parent = core.engine.coreInterface,
        size = guiCoord(1, 0, 1, 0),
        position = guiCoord(0, 0, 0, 0),
        backgroundColour = colour(.25, .25, .25),
        backgroundAlpha = 0.6,
        zIndex = 1000
    })

    local spinner = core.construct("guiIcon", {
        parent = backdrop,
        size = guiCoord(0, 40, 0, 40),
        position = guiCoord(0.5, -20, 0.5, -20),
        iconMax = 40,
        iconColour = colour(1, 1, 1),
        iconType = "faSolid",
        iconId = "spinner",
        iconAlpha = 0.9
    })

    spawn(function()
        while sleep() and spinner.alive do
            spinner.rotation = spinner.rotation + math.rad(1)
        end
    end)

    core.apps:upload()
    local success, result = core.apps:waitFor("upload")
    spinner:destroy()

    local container = core.construct("guiTextBox", {
        parent = backdrop,
        size = guiCoord(0, 460, 0, 120),
        position = guiCoord(0.5, -230, 0.5, -60),
        backgroundColour = colour(1, 1, 1),
        dropShadowAlpha = 0.3
    })

    local label = core.construct("guiTextBox", {
        parent = container,
        size = guiCoord(1.0, -20, 1.0, -20),
        position = guiCoord(0, 10, 0, 10),
        backgroundAlpha = 0.0,
        textSize = 16,
        textWrap = true,
        textAlign = "topLeft"
        -- textFont = "tevurl:fonts/firaCodeRegular.otf"
    })

    local title = core.construct("guiTextBox", {
        parent = backdrop,
        size = guiCoord(0, 460, 0, 20),
        position = guiCoord(0.5, -230, 0.5, -80),
        backgroundColour = colour(0.9, 0.9, 0.9),
        textSize = 18,
        dropShadowAlpha = 0.3,
        textAlign = "middle",
        zIndex = 2
    })

    if success then
        title.backgroundColour = colour.rgb(70, 179, 88)
        title.textColour = colour.white()
        title.text = "Uploaded"
        label.text =
            "Your build has been submitted\n\nApp Id: " .. result.appId ..
                "\nBuild ID: " .. result.id .. "\nBuild Version: " ..
                result.version
    else
        title.backgroundColour = colour.rgb(179, 70, 70)
        title.textColour = colour.white()
        title.text = "Something went wrong"
        label.text = result
    end

    core.input:waitFor("mouseLeftUp")
    core.apps:reload()
end)

test:on("mouseLeftUp", function()
    test.visible = false
    reload.visible = false

    local backdrop = core.construct("guiFrame", {
        parent = core.engine.coreInterface,
        size = guiCoord(1, 0, 1, 0),
        position = guiCoord(0, 0, 0, 0),
        backgroundColour = colour(.25, .25, .25),
        backgroundAlpha = 0.6,
        zIndex = 1000
    })

    local spinner = core.construct("guiIcon", {
        parent = backdrop,
        size = guiCoord(0, 40, 0, 40),
        position = guiCoord(0.5, -20, 0.5, -20),
        iconMax = 40,
        iconColour = colour(1, 1, 1),
        iconType = "faSolid",
        iconId = "spinner",
        iconAlpha = 0.9
    })

    spawn(function()
        while sleep() and spinner.alive do
            spinner.rotation = spinner.rotation + math.rad(1)
        end
    end)

    core.apps:test()
    local success, result = core.apps:waitFor("upload")
    spinner:destroy()

    local container = core.construct("guiTextBox", {
        parent = backdrop,
        size = guiCoord(0, 460, 0, 120),
        position = guiCoord(0.5, -230, 0.5, -60),
        backgroundColour = colour(1, 1, 1),
        dropShadowAlpha = 0.3
    })

    local label = core.construct("guiTextBox", {
        parent = container,
        size = guiCoord(1.0, -20, 1.0, -20),
        position = guiCoord(0, 10, 0, 10),
        backgroundAlpha = 0.0,
        textSize = 16,
        textWrap = true,
        textAlign = "topLeft"
        -- textFont = "tevurl:fonts/firaCodeRegular.otf"
    })

    local title = core.construct("guiTextBox", {
        parent = backdrop,
        size = guiCoord(0, 460, 0, 20),
        position = guiCoord(0.5, -230, 0.5, -80),
        backgroundColour = colour(0.9, 0.9, 0.9),
        textSize = 18,
        dropShadowAlpha = 0.3,
        textAlign = "middle",
        zIndex = 2
    })

    if success then
        core.apps:reload()
    else
        title.backgroundColour = colour.rgb(179, 70, 70)
        title.textColour = colour.white()
        title.text = "Something went wrong"
        label.text = result
    end
end)
