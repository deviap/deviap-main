---------------------------------------------------------------
-- Copyright 2020 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/sample-apps/blob/master/LICENSE --
---------------------------------------------------------------
--
local objects = {
	["cube"] = function()
		return core.construct("block", {})
	end
}

local function insert(object)
    object.position = core.scene.camera.position + core.scene.camera.rotation * vector3(0, 0, -10)
    local hits = core.scene:raycast(core.scene.camera.position, object.position)
    for _,v in pairs(hits) do
        if v.obj ~= object then
            object.position = v.position
            return
        end
    end
end

local container = core.construct("guiFrame", {
	parent = core.interface,
	size = guiCoord(0, 40, 0, 220),
	position = guiCoord(1, -50, 0, 10),
	backgroundColour = colour(1, 1, 1),
	strokeRadius = 4,
	strokeAlpha = 0.3
})

local y = 5
for name, f in pairs(objects) do
	local btn = core.construct("guiTextBox", {
		parent = container,
		size = guiCoord(0, 30, 0, 30),
		position = guiCoord(0, 5, 0, y),
		text = name,
		textFont = "deviap:fonts/openSansBold.ttf",
		textSize = 14,
		textAlign = "middle",
		backgroundColour = colour(0.9, 0.9, 0.9),
		strokeRadius = 4
	})

	btn:on("mouseLeftUp", function()
		print("insert")
		insert(f())
	end)

	y = y + 35
end

container.size = guiCoord(0, 40, 0, y)
