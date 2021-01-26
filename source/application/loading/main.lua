-- Copyright 2021 - Deviap (deviap.com)
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
	backgroundColour = colour.hex("#FFFFFF")
})

core.construct("guiTextBox", {
	parent = container,
	text = "Loading Dashboard",
	position = guiCoord(0, 11, 0, 4),
	size = guiCoord(1, 0, 0, 78),
	textSize = 38,
	textFont = "deviap:fonts/openSansExtraBold.ttf",
	backgroundAlpha = 0
})

core.construct("guiTextBox", {
	parent = container,
	text = "This will just be a moment",
	position = guiCoord(0, 11, 0, 40),
	size = guiCoord(1, 0, 0, 78),
	textSize = 18,
	textFont = "deviap:fonts/sourceCodeProBold.ttf",
	textAlpha = 0.5,
	backgroundAlpha = 0
})

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

local bar = core.construct("guiFrame", {
	parent = barContainer,
	size = guiCoord(0, 500, 1, 0),
	position = guiCoord(0, -500, 0, 0),
	backgroundColour = colour.hex("#FF7043"),
	backgroundAlpha = 1
})

local tween;
tween = core.tween:create(bar, 2, {
	position = guiCoord(1, 200, 0, 0),
	backgroundAlpha = 0
}, "outQuad", function()
    tween:reset()
    tween:resume()
end)
tween:resume()

--[[
spawn(function()
    while true do
        card {
            parent = layout.container,
            text = "mango",
            size = guiCoord(0, 45, 0, 20)
        }
    
        
        core.tween:begin(bar, 5, {position = guiCoord(1, 400, 0, 0), backgroundAlpha = 0.2}, "inOutQuad")

        sleep(2)
    end
end)
]]

return container