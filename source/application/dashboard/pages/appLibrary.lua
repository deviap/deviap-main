-- Copyright 2020 - Deviap (deviap.com)

local appCard = require("devgit:source/libraries/UI/components/cards/app.lua")

local newlayout = require("devgit:source/libraries/UI/constraints/controllers/gridLayout.lua")

return {
	name 		= "Apps",
	iconId 		= "apps",
	iconType	= "material",
	construct 	= function(parent)

		local heading = core.construct("guiTextBox", {
			parent = parent,
			text = "App Library",
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

		core.http:get("https://deviap.com/api/v1/apps", {["Authorization"] = "Bearer " .. core.engine:getUserToken()}, function(status, body)
			print(status, body)
			local payload = core.json:decode(body)
			for _,app in pairs(payload.results) do
				print("https://cdn.deviap.com/" .. (app.icon or ""))
				appCard {
					parent = layout.container,
					name = app.name,
					image = "https://cdn.deviap.com/" .. (app.icon or "")
				}.container:on("mouseLeftUp", function()
					if not app.activeRelease then
						print("app not released")
					else
						print(app.activeRelease.isNetworked)
						if not app.activeRelease.isNetworked then
							core.apps:loadRemote(app.id)
						else
							core.networking:initiate(app.id)
						end
					end
				end)
			end
		end)

	end
}