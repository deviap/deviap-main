---------------------------------------------------------------
-- Copyright 2021 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------
-- Splashscreen Entry Point
local button = require(
               				"devgit:source/libraries/UI/components/buttons/baseButton.lua")

local container = core.construct("guiFrame", {
	parent = core.engine.coreInterface,
	position = guiCoord(0, 0, 0, 0),
	size = guiCoord(1, 0, 1, 0),
	backgroundColour = colour.rgb(255, 138, 101)
})

local brandLogo = core.construct("guiImage", {
	parent = container,
	position = guiCoord(0.5, -32, 0, -64),
	size = guiCoord(0, 64, 0, 64),
	image = "devgit:assets/images/logo.png",
	backgroundAlpha = 0
})

local versionInfo = core.construct("guiTextBox", {
	parent = brandLogo,
	text = _TEV_VERSION,
	position = guiCoord(1, 20, 1, -24),
	size = guiCoord(0, 100, 0, 14),
	backgroundAlpha = 0,
	textAlpha = 0,
	textSize = 14,
	textFont = "deviap:fonts/openSansSemiBold.ttf",
	textAlign = "middleLeft",
	textColour = colour.hex("FFFFFF")
})

-- Abitrary background shapes and animations
-- Works fine without this!
spawn(function()
	local abstractShape1 = core.construct("guiImage", {
		parent = container,
		position = guiCoord(0, -1024 / 3, 0, -1024 / 2), -- guiCoord(0, 340, 0, 200),
		size = guiCoord(0, 1024, 0, 1024),
		image = "devgit:assets/images/abstractShape1.png",
		backgroundAlpha = 0,
		imageAlpha = 0.15,
		zIndex = -2
	})

	local abstractShape1Blur = core.construct("guiImage", {
		parent = container,
		position = guiCoord(0, 1024 / 3, 0, -1024 / 2.5), -- guiCoord(0, 340, 0, 200),
		size = guiCoord(0, 1024 / 1.5, 0, 1024 / 1.5),
		image = "devgit:assets/images/abstractShape1Blur.png",
		backgroundAlpha = 0,
		imageAlpha = 0.15,
		rotation = math.rad(90),
		zIndex = -2
	})

	while sleep(.1) do
		abstractShape1.rotation = abstractShape1.rotation + math.rad(0.01)
		abstractShape1Blur.rotation = abstractShape1Blur.rotation - math.rad(0.01)
	end
end)

local buttons = {
	{
		text = "Docs",
		icon = "apps",
		clicked = function()

		end
	},
	{
		text = "LICENSE",
		icon = "apps",
		clicked = function()

		end
	}
}

for i, v in pairs(buttons) do
	local btn = core.construct("guiIcon", {
		parent = container,
		position = guiCoord(0.5, ((-#buttons*110)/2) + ((i-1) * 110), 0.5, -50),
		size = guiCoord(0, 100, 0, 100),
		iconMax = 24,
		iconId = v.icon,
		iconColour = colour.rgb(0, 0, 0),
		backgroundAlpha = 1,
		strokeRadius = 2
	})

    local txt = core.construct("guiTextBox", {
        parent = btn,
        backgroundAlpha = 0,
        text = v.text,
        position = guiCoord(0, 0, 0.5, 20),
        size = guiCoord(1, 0, 0, 20),
        textAlign = "topMiddle",
        textSize = 14,
        active = false
    })
end

core.tween:begin(brandLogo, 1, {
	position = guiCoord(0.5, -32, 0.5, -132),
	size = guiCoord(0, 64, 0, 64)
}, "outQuad")
core.tween:begin(versionInfo, 1.5,
                 {textAlpha = 0.5, position = guiCoord(1, 0, 1, -24)}, "outQuad")
