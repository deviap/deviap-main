---------------------------------------------------------------
-- Copyright 2021 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/sample-apps/blob/master/LICENSE --
---------------------------------------------------------------
--
local filePrompt = require("scripts/filePrompt.lua")
local serialiser = require("devgit:source/serialiser/main.lua")
core.scene.simulate = true
local file = filePrompt.open()
if file ~= "new" then
	-- user selected resource
	serialiser.fromFile(file)
else
	-- new scene
	local light = core.construct("light", {
		type = "directional",
		diffuseColour = colour(1, 1, 1),
		specularColour = colour(1, 1, 1),
		rotation = quaternion.euler(math.rad(-45),0,math.rad(45)),
		power = 3
	})
end

core.graphics.lowerAmbient = colour(0.3, 0.3, 0.3)
core.graphics.upperAmbient = colour(0.6, 0.6, 0.6)
core.graphics.ambientDirection = vector3(0, 1, 0)

require("scripts/inserter.lua")
require("devgit:source/application/utilities/camera.lua")