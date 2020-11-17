-- Copyright 2020 - Deviap (deviap.com)
-- Author(s): Sanjay-B(Sanjay)
-- Creates the Develop page.
local card = require("devgit:source/libraries/UI/components/cards/editApp.lua")
local gridLayout = require("devgit:source/libraries/UI/constraints/controllers/gridLayout.lua")
local primaryButton = require("devgit:source/libraries/UI/components/buttons/primaryButton.lua")
local secondaryButton = require("devgit:source/libraries/UI/components/buttons/secondaryButton.lua")


return {
    default = false,
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
			text = "Develop",
			position = guiCoord(0, 11, 0, 4),
			size = guiCoord(1, 0, 0, 78),
			textSize = 38,
			textFont = "deviap:fonts/openSansExtraBold.ttf",
			backgroundAlpha = 0
        })

        local subheading1 = core.construct("guiTextBox", {
			parent = scrollContainer,
			text = "Options",
			position = guiCoord(0, 11, 0, 50),
			size = guiCoord(1, 0, 0, 78),
			textSize = 20,
			textAlpha = 0.8,
			textFont = "deviap:fonts/openSansSemiBold.ttf",
			backgroundAlpha = 0
		})

        primaryButton {
            parent = scrollContainer,
            position = guiCoord(0, 11, 0, 80),
			text = "OPEN UNPACKED APP",
			textAlign = "middle",
            strokeRadius = 5
        }.state.subscribe(function(state)
            if state.active then
                core.apps:promptAppDirectory()
            end
        end)

        secondaryButton {
            parent = scrollContainer,
            position = guiCoord(0, 11, 0, 135),
			text = "OPEN SUITE",
			textAlign = "middle",
            strokeRadius = 5
        }.state.subscribe(function(state)
            if state.active then
                -- Reroute to suite barebones
            end
        end)

        local subheading2 = core.construct("guiTextBox", {
			parent = scrollContainer,
			text = "Apps",
			position = guiCoord(0, 11, 0, 200),
			size = guiCoord(1, 0, 0, 78),
			textSize = 20,
			textAlpha = 0.8,
			textFont = "deviap:fonts/openSansSemiBold.ttf",
			backgroundAlpha = 0
        })

        local layout = gridLayout()
		layout.container.parent = scrollContainer
		layout.container.position = guiCoord(0, 10, 0, 230)
		layout.container.size = guiCoord(1, -20, 1, -240)
		layout.container.canvasSize = guiCoord(0, 0, 0, 0)
		layout.container.backgroundColour = colour.hex("#FF0000")
		layout.container.backgroundAlpha = 0
		layout.container.scrollbarAlpha = 0
		layout.rows = 1
		layout.columns = 8
		layout.cellSize = vector2(100, 100)
		layout.cellSpacing = vector2(10, 10)
		layout.fitX = false
		layout.fitY = false
        layout.wrap = true

		core.http:get("https://deviap.com/api/v1/users/"..(core.networking.localClient.id).."/apps", {["Authorization"] = "Bearer " .. core.engine:getUserToken()}, function(status, body)
			local response = core.json:decode(body)
            for index, entry in pairs(response) do
                card {
                    parent = layout.container,
                    title = (string.len(entry["name"]) > 15 and string.sub(entry["name"], 1, 12).."...") or entry["name"],
                    name = entry["username"],
                    thumbnail = "https://cdn.deviap.com/"..(entry["icon"] or "")
                }.container:on("mouseLeftUp", function()
                    -- Route to suite to open the app specifically
                end)
            end
		end)
	end
}
