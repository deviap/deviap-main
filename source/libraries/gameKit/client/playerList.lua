---------------------------------------------------------------
-- Copyright 2021 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------
local container = core.construct("guiFrame", {
	parent = core.interface,
	name = "_PlayerList",
	size = guiCoord(0, 200, 0, 100),
	position = guiCoord(1, -200, 0, 0),
	backgroundColour = colour.rgb(0, 0, 0),
	zIndex = 900,
	backgroundAlpha = 0
})

local function add(client)
	local y = 0
	for _, v in pairs(container.children) do
		v.position = guiCoord(0, 0, 0, y)
		y = y + 20
	end

	core.construct("guiTextBox", {
		parent = container,
		size = guiCoord(1, 0, 0, 18),
		position = guiCoord(0, 0, 0, y),
		textSize = 16,
		name = client.name,
		text = client.name
	})
end

for _, client in pairs(core.networking.clients) do
	add(client)
end

core.networking:on("_clientConnected", add)

local function remove(client)
    local gui = container:child(client.name)
    if gui then
        gui:destroy()
    end

	local y = 0
	for _, v in pairs(container.children) do
		v.position = guiCoord(0, 0, 0, y)
		y = y + 20
	end
end

core.networking:on("_clientDisconnected", remove)
core.networking:on("_disconnected", function()
    container:destroyChildren()
end)