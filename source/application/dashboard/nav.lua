local controller = {}
local colours = require("devgit:source/application/utilities/colourScheme.lua")
local breakpointer = require("devgit:source/libraries/UI-breakpointer/main.lua")

controller.sidebar = core.construct("guiFrame", {
    parent = core.interface,
    backgroundColour = colours.dark,
    strokeColour = colours.orange,
    strokeWidth = 2,
    strokeAlpha = 1,
    clip = true,
    zIndex = 10
})

breakpointer:bind(controller.sidebar, "xs", {
    size = guiCoord(1, 0, 0, 50),
    position = guiCoord(0, 0, 1, -50),
})

breakpointer:bind(controller.sidebar, "sm", {
    size = guiCoord(0, 50, 1, 0),
    position = guiCoord(0, 0, 0, 0),
})

controller.activeBall = core.construct("guiFrame", {
    parent = controller.sidebar,
    size = guiCoord(0, 8, 0, 8),
    position = guiCoord(1, -4, 0, 30 - 4),
    backgroundColour = colours.orange,
    strokeRadius = 4
})

breakpointer:bind(controller.activeBall, "xs", {
    visible = false
})

breakpointer:bind(controller.activeBall, "sm", {
    visible = true
})

controller.container = core.construct("guiFrame", {
    parent = core.interface,
    size = guiCoord(1, -50, 1, 0),
    position = guiCoord(0, 50, 0, 0),
    backgroundAlpha = 0,
    clip = true
})

local currentY = 10
local btns = {}
local pages = {}

controller.register = function(module)
    local pageDetail = require(module)

    local btn = core.construct("guiIcon", {
        parent = controller.sidebar,
        size = guiCoord(0, 40, 0, 40),
        iconId = pageDetail.iconId,
        iconType = pageDetail.iconType,
        iconMax = 24,
        clip = false
    })

    breakpointer:bind(btn, "xs", {
        position = guiCoord(0, currentY, 0, 5)
    })

    breakpointer:bind(btn, "sm", {
        position = guiCoord(0, 5, 0, currentY)
    })

    table.insert(btns, btn)

    currentY = currentY +50
    local label = core.construct("guiTextBox", {
        parent = btn,
        active = false,
        size = guiCoord(1, 20, 0, 20),
        position = guiCoord(0, -10, 0, 30),
        textSize = 14,
        text = pageDetail.name,
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

    local page = core.construct("guiFrame", {
        parent = controller.container,
        size = guiCoord(1, -40, 1, -20),
        position = guiCoord(0, 20, 0, 20),
        backgroundAlpha = 0,
        visible = false
    })

    if #btns == 1 then
        page.visible = true
    end

    table.insert(pages, page)

    btn:on("mouseLeftDown", function()
        for _,v in pairs(pages) do
            v.visible = false
        end
        core.tween:begin(controller.activeBall, 0.3, {
            position = guiCoord(1, -4, 0, btn.position.offset.y + 20 - 4)
        }, "inOutQuad")
        page.visible = true
    end)

    local gui = pageDetail.construct(page)
end

return controller