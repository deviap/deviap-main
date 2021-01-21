--
-- LEGACY CODE
--
local globals = {
	ignoreCameraInput = false
}

local keyMap = {
	[tonumber(enums.keys.KEY_W)] = vector3(0, 0, -1),
	[tonumber(enums.keys.KEY_S)] = vector3(0, 0, 1),
	[tonumber(enums.keys.KEY_A)] = vector3(-1, 0, 0),
	[tonumber(enums.keys.KEY_D)] = vector3(1, 0, 0),
	[tonumber(enums.keys.KEY_Q)] = vector3(0, -1, 0),
	[tonumber(enums.keys.KEY_E)] = vector3(0, 1, 0)
}

local moveStep = 0.3
local rotateStep = 0.01

local cam = core.scene.camera
local db = false

core.input:on("keyDown", function(key, systemHandled)
	if systemHandled then return end

	local mapped = keyMap[tonumber(key)]
	if mapped then
		while sleep() and core.input:isKeyDown(key) and not globals.ignoreCameraInput do
			cam.position = cam.position + (cam.rotation * mapped * moveStep)
		end
	end
end)

core.input:on("mouseMoved", function(movement, systemHandled)
	if systemHandled then return end
	
	if core.input:isMouseButtonDown(3) and not globals.ignoreCameraInput then
		local pitch = quaternion.euler(-movement.y * rotateStep, 0, 0)
		local yaw = quaternion.euler(0, -movement.x * rotateStep, 0)

		-- Applied seperately to avoid camera flipping on the wrong axis.
		cam.rotation = yaw * cam.rotation;
		cam.rotation = cam.rotation * pitch
	end
end)
