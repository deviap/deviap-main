-- Copyright 2020 - Deviap (deviap.com)

local appCard = require("devgit:source/libraries/UI/components/cards/app.lua")

local newlayout = require("devgit:source/libraries/UI/constraints/controllers/gridLayout.lua")

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

		local layout = newlayout()
		layout.container.parent = parent
		layout.container.position = guiCoord(0, 0, 0, 50)
		layout.container.size = guiCoord(1, 0, 1, 0)
		layout.rows = 15
		layout.columns = 15
		layout.cellSize = vector2(100, 100)
		layout.cellSpacing = vector2(10, 10)
		layout.fitX = false
		layout.fitY = false
		layout.wrap = true

		core.http:get("https://deviap.com/api/v1/users/" .. core.networking.localClient.id .. "/favourites", {["Authorization"] = "Bearer " .. core.engine:getUserToken()}, function(status, body)
			local apps = core.json:decode(body)
			for _,app in pairs(apps) do
				appCard {
					parent = layout.container,
					name = app.name,
					image = "https://cdn.deviap.com" .. (app.icon or "")
				}
			end
		end)
	end
}