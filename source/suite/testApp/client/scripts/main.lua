local container = core.construct("guiFrame", {
	parent = core.interface,
	size = guiCoord(1, 0, 1, 0),
})

local box = core.construct("guiTextBox", {
	parent = container,
	
	position = guiCoord(0.5, -150, 0.5, -25),
	size = guiCoord(0, 300, 0, 50),
	textSize = 40,
	
	backgroundColour = colour.black(),
	textColour = colour.white(),

	text = "Hello World!",
	textAlign = "middle",
	textFont = "fs:fonts/SourceCodePro-Black.ttf",
})

local randomColours =
{
	colour.random(),
	colour.random(),
	colour.random(),
	colour.random(),
	colour.random(),
	colour.random(),
	colour.random(),
	colour.random()
}

while true do
	local waitTime = math.random(3, 5)
	core.tween:begin(container, waitTime, {backgroundColour = randomColours[math.random(1, 8)] })
	sleep(waitTime)
end