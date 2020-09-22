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

		core.http:get("https://deviap.com/api/v1/users/me", {["Authorization"] = "Bearer " .. core.engine:getUserToken()}, function(status, body)
			local user = core.json:decode(body)
			local _checkbox = checkbox {
				parent = parent,
				position = guiCoord(0.5, -0, 0.5, -0),
				text = user.profileImage
			}
		end)
	end
}