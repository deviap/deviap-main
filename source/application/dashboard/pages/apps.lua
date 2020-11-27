-- Copyright 2020 - Deviap (deviap.com)
-- Author(s): Sanjay-B(Sanjay)
-- Creates the App's Libary page.
local card = require("devgit:source/libraries/UI/components/cards/app.lua")
local gridLayout = require("devgit:source/libraries/UI/constraints/controllers/gridLayout.lua")
local textInput = require("devgit:source/libraries/UI/components/inputs/textInput.lua")
local inlineNotification = require("devgit:source/libraries/UI/components/notifications/inlineNotification.lua")
local multilineNotification = require("devgit:source/libraries/UI/components/notifications/multilineNotification.lua")

return {
	construct = function(parent)

		local heading = core.construct("guiTextBox", {
			parent = parent,
			text = "Apps",
			position = guiCoord(0, 11, 0, 4),
			size = guiCoord(1, 0, 0, 78),
			textSize = 38,
			textFont = "deviap:fonts/openSansExtraBold.ttf",
			backgroundAlpha = 0
		})

		textInput {
			parent = parent,
			position = guiCoord(1, -217, 0, 14),
			size = guiCoord(0, 200, 0, 20),
			placeholder = "Search for an app",
			textSize = 15
		}

		local layout = gridLayout()
		layout.container.parent = parent
		layout.container.position = guiCoord(0, 10, 0, 50)
		layout.container.size = guiCoord(1, -20, 1, -50)
		layout.container.canvasSize = guiCoord(1, 0, 1, 0)
		layout.container.backgroundAlpha = 0
		layout.container.scrollbarAlpha = 1
		layout.container.scrollbarWidth = 5
		layout.container.scrollbarRadius = 1
		layout.rows = 8
		layout.columns = 8
		layout.cellSize = vector2(100, 130)
		layout.cellSpacing = vector2(10, 10)
		layout.fitX = false
		layout.fitY = false
		layout.wrap = true

		core.http:get("https://deviap.com/api/v1/apps/", {["Authorization"] = "Bearer " .. core.engine:getUserToken()}, function(status, body)
			local response = core.json:decode(body)
			for index, app in pairs(response["results"]) do
				card {
					parent = layout.container,
					title = (string.len(app.name) > 15 and string.sub(app.name, 1, 12).."...") or app.name,
					name = app.owner.username,
					thumbnail = "https://cdn.deviap.com/"..(app.icon or "")
				}.container:on("mouseLeftUp", function()
					if not app.activeRelease then
						inlineNotification {
							parent = core.interface,
							position = guiCoord(1, -306, 1, -48),
							type = "error",
							iconEnabled = false,
							text = "Selected app ("..((string.len(app.name) > 15 and string.sub(app.name, 1, 10).."...") or app.name)..") is private."
						}
					elseif not app.activeRelease.isNetworked then
						--core.interface:destroyChildren()
						local success, errorMsg = pcall(function() core.apps:loadRemote(app.id) end)
						print(success, errorMsg)
						--[[multilineNotification {
							parent = core.interface,
							position = guiCoord(1, -306, 1, -58),
							iconEnabled = false,
							text = "Selected app ("..((string.len(app.name) > 15 and string.sub(app.name, 1, 10).."...") or app.name)..") has been launched."
						}]]
					elseif app.activeRelease.isNetworked then
						core.interface:destroyChildren()


						core.networking:initiate(app.id)




						--[[multilineNotification {
							parent = core.interface,
							position = guiCoord(1, -306, 1, -58),
							iconEnabled = false,
							text = "Selected networked app ("..((string.len(app.name) > 15 and string.sub(app.name, 1, 10).."...") or app.name)..") has been launched."
						}]]--
					end
				end)
			end
		end)
	end
}
