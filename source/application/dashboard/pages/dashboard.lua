-- Copyright 2020 - Deviap (deviap.com)
-- Author(s): Sanjay-B(Sanjay)
-- Creates the Dashboard page.
local card = require("devgit:source/libraries/UI/components/cards/app.lua")
local comment = require("devgit:source/libraries/UI/components/cards/comment.lua")
local gridLayout = require("devgit:source/libraries/UI/constraints/controllers/gridLayout.lua")
local textInput = require("devgit:source/libraries/UI/components/inputs/textInput.lua")
local inlineNotification = require("devgit:source/libraries/UI/components/notifications/inlineNotification.lua")
local multilineNotification = require("devgit:source/libraries/UI/components/notifications/multilineNotification.lua")

return {
	default = true,
	construct = function(parent)

		local scrollContainer = core.construct("guiScrollView", {
			parent = parent,
			position = guiCoord(0, 0, 0, 0),
			size = guiCoord(1, 0, 1, 0),
			scrollbarColour = colour.hex("#212121"),
			scrollbarRadius = 0,
			scrollbarWidth = 2,
			scrollbarAlpha = 0
		})

		local heading = core.construct("guiTextBox", {
			parent = scrollContainer,
			text = "Dashboard",
			position = guiCoord(0, 11, 0, 4),
			size = guiCoord(1, 0, 0, 78),
			textSize = 38,
			textFont = "deviap:fonts/openSansExtraBold.ttf",
			backgroundAlpha = 0
		})

		local subheading1 = core.construct("guiTextBox", {
			parent = scrollContainer,
			text = "Favorites",
			position = guiCoord(0, 11, 0, 50),
			size = guiCoord(1, 0, 0, 78),
			textSize = 20,
			textAlpha = 0.8,
			textFont = "deviap:fonts/openSansSemiBold.ttf",
			backgroundAlpha = 0
		})

		local layout = gridLayout()
		layout.container.parent = scrollContainer
		layout.container.position = guiCoord(0, 10, 0, 75)
		layout.container.size = guiCoord(1, -20, 1, -204)
		layout.container.canvasSize = guiCoord(0, 0, 0, 0)
		layout.container.backgroundColour = colour.hex("#FF0000")
		layout.container.backgroundAlpha = 0
		layout.container.scrollbarAlpha = 0
		layout.rows = 1
		layout.columns = 8
		layout.cellSize = vector2(90, 120)
		layout.cellSpacing = vector2(10, 10)
		layout.fitX = false
		layout.fitY = false
		layout.wrap = true

		core.http:get("https://deviap.com/api/v1/users/"..(core.networking.localClient.id).."/favourites", {["Authorization"] = "Bearer " .. core.engine:getUserToken()}, function(status, body)
			local response = core.json:decode(body)
			for index, app in pairs(response) do
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
						core.interface:destroyChildren()
						core.apps:loadRemote(app.id)
						multilineNotification {
							parent = core.interface,
							position = guiCoord(1, -306, 1, -58),
							iconEnabled = false,
							text = "Selected app ("..((string.len(app.name) > 15 and string.sub(app.name, 1, 10).."...") or app.name)..") has been launched."
						}
					elseif app.activeRelease.isNetworked then
						core.interface:destroyChildren()
						core.networking:initiate(app.id)
						multilineNotification {
							parent = core.interface,
							position = guiCoord(1, -306, 1, -58),
							iconEnabled = false,
							text = "Selected networked app ("..((string.len(app.name) > 15 and string.sub(app.name, 1, 10).."...") or app.name)..") has been launched."
						}
					end
				end)
			end
		end)

		local subheading2 = core.construct("guiTextBox", {
			parent = scrollContainer,
			text = "Feed",
			position = guiCoord(0, 11, 0, 200),
			size = guiCoord(1, 0, 0, 78),
			textSize = 20,
			textAlpha = 0.8,
			textFont = "deviap:fonts/openSansSemiBold.ttf",
			backgroundAlpha = 0
		})

		local layout2 = gridLayout()
		layout2.container.parent = scrollContainer
		layout2.container.position = guiCoord(0, 5, 0, 250)
		layout2.container.size = guiCoord(1, -20, 1, -255)
		layout2.container.canvasSize = guiCoord(1, 0, 2, 0)
		layout2.container.backgroundColour = colour.hex("#FF0000")
		layout2.container.backgroundAlpha = 0
		layout2.container.scrollbarAlpha = 0
		layout2.rows = 20
		layout2.columns = 1
		layout2.cellSize = vector2(300, 80)
		layout2.cellSpacing = vector2(0, -20)
		layout2.cellColour = colour(1, 1, 1)
		layout2.cellBackgroundAlpha = 0
		layout2.fitX = false
		layout2.fitY = false
		layout2.wrap = true

		local status, body = core.http:get("https://deviap.com/api/v1/comments?page=1", {["Authorization"] = "Bearer " .. core.engine:getUserToken()})

		-- Send Notification Error (we probably want to streamline this better)
		if status ~= 200 then
			inlineNotification {
				parent = core.interface,
				position = guiCoord(1, -306, 1, -58),
				iconEnabled = false,
				type = "warning",
				text = "Failed to load feed. Code: "..status
			}
			return
		end

		local maxPages = core.json:decode(body)["maxPage"]

		for page=1, maxPages, 1 do
			core.http:get("https://deviap.com/api/v1/comments?page="..page, {["Authorization"] = "Bearer " .. core.engine:getUserToken()}, function(status, body)
				local response = core.json:decode(body)
				for index, entry in pairs(response["results"]) do
					comment {
						parent = layout2.container,
						author = entry["postedBy"]["username"],
						content = entry["message"],
						postedAt =  entry["postedAt"],
						avatar =  (entry["postedBy"]["profileImage"] and "https://cdn.deviap.com/"..entry["postedBy"]["profileImage"]) or ""
					}
				end
			end)
		end

		local feedInput = textInput {
			parent = scrollContainer,
			position = guiCoord(0, 11, 0, 222),
			size = guiCoord(0, 300, 0, 23),
			placeholder = "Enter Comment",
			textSize = 15
		}
		
		feedInput.input:on("keyDown", function(key)
			if key == "KEY_RETURN" then
				print("TEXT: ", feedInput.input.text)
				-- Send text to POST comment
			end
		end)
	end
}
