
-- Textbox colour/border radius/shadow demo

print("io", io)
print("gui", require('ping'), core)
local colours = {
    colour(1, 0, 0),
    colour(1, 1, 0),
    colour(0, 1, 0),
    colour(0, 1, 1),
    colour(0, 0, 1),
    colour(1, 0, 1),
    colour(1, 1, 1),
    colour(0, 0, 0)
}

local size = 1/#colours
local lastColour = colour(0,0,0)
for i = 1, #colours do
    core.construct("guiTextBox", {
        parent = core.interface,
        size = guiCoord(size, 0, 0, 50),
        position = guiCoord(size * (i - 1), 0, 0, 0),
        backgroundColour = colours[i],
        text = "#" .. colours[i]:hex(),
        textShadowSize = 2,
        textColour = colour(1, 1, 1)
    })

    local c = colours[i] * colour(0.9, 0.9, 0.9)
    core.construct("guiGradientFrame", {
        parent = core.interface,
        size = guiCoord(size, 2, 0, 20),
        position = guiCoord(size * (i - 1), -1, 0, 60),
        backgroundColour = lastColour,
        backgroundColourB = c,
        start = guiCoord(0.4, 0, 0, 0),
        finish = guiCoord(0.6, 0, size * (i - 1), 0)
    })

    lastColour = c
end

-- Textbox Align Demo

local reverseAlign = {}
for k,v in pairs(enums.align) do
    reverseAlign[tonumber(v)] = k
end

local txtGuis = {}

local size = 1/3
local i = 0
local y = 90
for a = 0, 8 do
    i = i + 1
    local gui = core.construct("guiTextBox", {
        parent = core.interface,
        size = guiCoord(size, -1, 0, 28),
        position = guiCoord(size * (i - 1), 0, 0, y),
        backgroundColour = colour(1, 1, 1),
        text = "enums.align." .. reverseAlign[a],
        textSize = 14,
        textAlign = a,
        strokeRadius = 5
    })
    table.insert(txtGuis, gui)
    if i > 2 then
        i = 0
        y = y + 29
    end
end

for i = 1, #colours do
    core.construct("guiImage", {
        position = guiCoord(0, (i-1) * 75, 0, y),
        size = guiCoord(0, 75, 0, 50),
        parent = core.interface,
        backgroundAlpha = 0,
        image = "tevurl:img/tTiled.png",
        imageBottomRight = vector2(3, 2),
        imageColour = colours[i]
    })
end

local size = 1/#colours
y = y + 60
local previous = 0
for i = 1, #colours do 
    local new = math.random(1, 50)
    local a = core.construct("guiLine", {
        pointA = guiCoord(size*(i-1), 0, 0, y + previous),
        pointB = guiCoord(size*(i), 0, 0, y + new),
        parent = core.interface,
        lineWidth = 5,
        lineAlpha = 0.5,
        lineColour = colours[i],
        lineCap = enums.lineCap.round
    })
    previous = new
end

for i = 1, #colours do 
    local new = math.random(1, 50)
    local a = core.construct("guiLineBezier", {
        pointA = guiCoord(0, 0, 0, y + (i * 10)),
        controlA = guiCoord(0, 50, 0, y+100),
        pointB = guiCoord(1, 0, 0, y - 30 + (i * 10)),
        controlB = guiCoord(1, -200, 0, y-100),
        parent = core.interface,
        lineWidth = 2,
        lineColour = colours[i],
        lineCap = enums.lineCap.round
    })
    previous = new
end

y = y + 60

-- create an arrow using lines:
local arrow = core.construct("guiLine", {
    pointA = guiCoord(0, 100, 0, y ),
    pointB = guiCoord(0, 100, 0, y + 50),
    parent = core.interface,
    lineWidth = 2,
    -- rotation = 0.4
})

core.construct("guiLine", {
    parent = arrow,
    pointA = guiCoord(0, 0, 0, 0 ),
    pointB = guiCoord(0, 10, 0, -10),
    lineWidth = 2
})

core.construct("guiLine", {
    parent = arrow,
    pointA = guiCoord(0, 0, 0, 0 ),
    pointB = guiCoord(0, -10, 0, -10),
    lineWidth = 2
})

local scrollView = core.construct("guiScrollView", {
	parent = core.interface,
	size = guiCoord(0, 300, 0, 200),
	position = guiCoord(1, -310, 0, 10),
	scrollbarAlpha = 0.8,
	scrollbarColour = colour(0.75, 0, 0),
	scrollbarRadius = 0,
	scrollbarWidth = 5,
    active = true,
    canvasSize = guiCoord(1, 0, 2, 0)
})

core.construct("guiFrame", {
    parent = scrollView,
    size = guiCoord(0, 50, 0, 50),
    position = guiCoord(0, 200, 0, 150),
    backgroundColour = colour(1, 0, 0)
})