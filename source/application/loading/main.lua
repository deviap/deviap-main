-- Copyright 2020 - Deviap (deviap.com)
-- Author(s): Sanjay-B(Sanjay)
-- Loading screen.
local colourMap = require("devgit:source/application/utilities/colourScheme.lua")
local card = require("devgit:source/libraries/UI/components/cards/text.lua")
local gridLayout = require("devgit:source/libraries/UI/constraints/controllers/gridLayout.lua")

local container = core.construct("guiFrame", {
	parent = core.interface,
    size = guiCoord(1, 0, 1, 0),
    backgroundColour = colour.hex("#E0E0E0"),
    zIndex = 10
})

core.construct("guiFrame", {
	parent = container,
    size = guiCoord(1, 0, 0, 790),
    backgroundColour = colour.hex("#FFFFFF"),
})

core.construct("guiTextBox", {
    parent = container,
    text = "LOADING COMPONENTS",
    position = guiCoord(0, 11, 0, 4),
    size = guiCoord(1, 0, 0, 78),
    textSize = 38,
    textFont = "deviap:fonts/openSansExtraBold.ttf",
    backgroundAlpha = 0
})

core.construct("guiTextBox", {
    parent = container,
    text = "mango@Mangos-MangoBookPro mango-main %",
    position = guiCoord(0, 11, 0, 40),
    size = guiCoord(1, 0, 0, 78),
    textSize = 18,
    textFont = "deviap:fonts/sourceCodeProBold.ttf",
    textAlpha = 0.5,
    backgroundAlpha = 0
})

--[[
    Going to rant because, its 3am and this is extremely stupid. 
    Whoever thought it was a great idea to add: 
    
    :setColour(index, colour)

    ..was smart but, this is specifically is stupid. This is basically
    the equivalent of me changing the textcolour. Bruh. This is overrated 
    tbh. 

    Change it to something more sane & practical like: 

    :setColour(startIndex, endIndex, colour)

    Until then, this is a pointless gui element.
]]--

core.construct("guiRichTextBox", {
    parent = container,
    text = "for x in 100000 do @echo mango done",
    position = guiCoord(0, 340, 0, 41),
    size = guiCoord(1, 0, 0, 78),
    textSize = 16,
    textFont = "deviap:fonts/sourceCodeProBold.ttf",
    textAlpha = 0.3,
    backgroundAlpha = 0
}):setColour(1, colour.hex("#66BB6A"))

local layout = gridLayout()
layout.container.parent = container
layout.container.position = guiCoord(0, 11, 0, 70)
layout.container.size = guiCoord(1, -20, 1, -100)
layout.container.canvasSize = guiCoord(1, 0, 1, 0)
layout.container.backgroundAlpha = 0
layout.container.scrollbarAlpha = 1
layout.container.scrollbarWidth = 5
layout.container.scrollbarRadius = 1
layout.rows = 8
layout.columns = 20
layout.cellSize = vector2(35, 10)
layout.cellSpacing = vector2(12, 10)
layout.fitX = false
layout.fitY = false
layout.wrap = true

local barContainer = core.construct("guiFrame", {
    parent = container,
    size = guiCoord(1, 0, 0, 20),
    position = guiCoord(0, 0, 1, -20),
    backgroundColour = colour.hex("#E0E0E0"),
    strokeWidth = 5,
    strokeColour = colour.hex("#FFFFFF"),
    strokeAlpha = 1
})

spawn(function()
    while sleep(2) do
        card {
            parent = layout.container,
            text = "mango",
            size = guiCoord(0, 45, 0, 20)
        }
    
        local bar = core.construct("guiFrame", {
            parent = barContainer,
            size = guiCoord(0, 500, 1, 0),
            position = guiCoord(-1, 0, 0, 0),
            backgroundColour = colour.hex("#FF7043"),
            backgroundAlpha = 1
        })
        core.tween:begin(bar, 5, {position = guiCoord(1, 400, 0, 0), backgroundAlpha = 0.2}, "inOutQuad")
    end
end)

return container