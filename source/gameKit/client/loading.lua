---------------------------------------------------------------
-- Copyright 2020 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------
if core.networking.isConnected then
	-- No need, we're already connected!
	return
end

-- 400 Padding? Why? Because some screens such as iphones have a margin
local interfaceBackdrop = core.construct("guiFrame", {
	parent = core.interface,
	name = "_LoadingInterface",
	size = guiCoord(1, 400, 1, 400),
	position = guiCoord(0, -200, 0, -200),
	backgroundColour = colour.rgb(0, 0, 0),
	zIndex = 1000,
	backgroundAlpha = 0.85
})

local spinner = core.construct("guiImage", {
	parent = interfaceBackdrop,
	size = guiCoord(0, 22, 0, 22),
	position = guiCoord(0.5, -11, 0.5, -11),
	image = "deviap:img/spinner.png",
	backgroundAlpha = 0,
	imageColour = colour.rgb(255, 255, 255)
})

local statusText = core.construct("guiTextBox", {
	parent = interfaceBackdrop,
	size = guiCoord(1, 0, 0, 18),
	position = guiCoord(0, 0, 0.5, 15),
	backgroundAlpha = 0,
	textColour = colour.rgb(255, 255, 255),
	text = "Waiting for connection...",
	textAlign = "middle"
})

local tween;
tween = core.tween:create(spinner, 1.5, {rotation = math.rad(360)}, "linear", function()
	tween:reset()
	tween:resume()
end)

tween:resume()

core.networking:on("_connected", function()
	statusText.text = "You're in"

	sleep(1)

	core.tween:begin(spinner, 1, {imageAlpha = 0}, "inOutQuad")

	core.tween:begin(statusText, 1, {textAlpha = 0}, "inOutQuad")

	core.tween:begin(interfaceBackdrop, 1.5, {backgroundAlpha = 0}, "inOutQuad")

	sleep(1.5)

	interfaceBackdrop:destroy()
end)
