local controller = {}
local colours = require("devgit:source/application/utilities/colourScheme.lua")

controller.sidebar = core.construct("guiFrame", {
    parent = teverse.interface,
    size = guiCoord(0, 50, 1, 0),
    backgroundColour = colours.dark,
    clip = true
})

controller.activeBall = core.construct("guiFrame", {
    parent = controller.sidebar,
    size = guiCoord(0, 8, 0, 8),
    position = guiCoord(1, -4, 0, 30 - 4),
    backgroundColour = colours.orange,
    strokeRadius = 4
})

controller.container = core.construct("guiFrame", {
    parent = teverse.interface,
    size = guiCoord(1, -50, 1, 0),
    position = guiCoord(0, 50, 0, 0),
    backgroundAlpha = 0,
    clip = true
})

local currentY = 10
local btns = {}

controller.addButton = function(text, icon, cb)
    local btn = core.construct("guiIcon", {
        parent = controller.sidebar,
        size = guiCoord(0, 40, 0, 40),
        position = guiCoord(0, 5, 0, currentY),
        iconId = icon,
        iconMax = 24,
        clip = false
    })

    table.insert(btns, btn)

    currentY = currentY +50
    local label = core.construct("guiTextBox", {
        parent = btn,
        active = false,
        size = guiCoord(1, 20, 0, 20),
        position = guiCoord(0, -10, 0, 30),
        textSize = 14,
        text = text,
        textAlign = "middle",
        backgroundAlpha = 0,
        textColour = colour.white(),
        textAlpha = 0
    })

    btn:on("mouseEnter", function()
        core.tween:begin(btn, 0.3, {
            iconMax = 16
        }, "inOutQuad")

        core.tween:begin(label, 0.2, {
            textAlpha = 0.8,
        }, "inOutQuad")
    end)

    btn:on("mouseExit", function()
        core.tween:begin(btn, 0.3, {
            iconMax = 24,
        }, "inOutQuad")

        core.tween:begin(label, 0.2, {
            textAlpha = 0
        }, "inOutQuad")
    end)

    if cb then
        local gui = cb(controller.container)
        
    end
end

return controller