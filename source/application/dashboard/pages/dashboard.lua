-- Copyright 2020 - Deviap (deviap.com)

local checkbox = require("devgit:source/libraries/UI/components/checkbox.lua")

return {
	name 		= "Dashboard",
	iconId 		= "home",
	iconType	= "material",
	construct 	= function(parent)

		local heading = core.construct("guiTextBox", {
			parent = parent,
			text = "Dashboard",
			size = guiCoord(1, 0, 0, 38),
			textSize = 38,
			textFont = "deviap:fonts/openSansExtraBold.ttf",

		})

		local _checkbox = checkbox {
			parent = parent,
			position = guiCoord(0.5, -0, 0.5, -0),
			text = "Checkbox item"
		}
	end
}