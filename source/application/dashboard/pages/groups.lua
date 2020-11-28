-- Copyright 2020 - Deviap (deviap.com)
-- Author(s): Sanjay-B(Sanjay)
-- Creates the Groups page.
local groupCard = require("devgit:source/libraries/UI/components/cards/group.lua")
local gridLayout = require("devgit:source/libraries/UI/constraints/controllers/gridLayout.lua")

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
			text = "Groups",
			position = guiCoord(0, 11, 0, 4),
			size = guiCoord(1, 0, 0, 78),
			textSize = 38,
			textFont = "deviap:fonts/openSansExtraBold.ttf",
			backgroundAlpha = 0
        })

        local subheading1 = core.construct("guiTextBox", {
			parent = scrollContainer,
			text = "Memberships",
			position = guiCoord(0, 11, 0, 50),
			size = guiCoord(1, 0, 0, 78),
			textSize = 20,
			textAlpha = 0.8,
			textFont = "deviap:fonts/openSansSemiBold.ttf",
			backgroundAlpha = 0
		})

        local layout = gridLayout()
		layout.container.parent = scrollContainer
		layout.container.position = guiCoord(0, 10, 0, 80)
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

        print(core.networking.localClient.id)

        core.http:get("https://deviap.com/api/v1/users/"..(core.networking.localClient.id).."/organisations", {["Authorization"] = "Bearer " .. core.engine:getUserToken()}, function(status, body)
			local response = core.json:decode(body)
            for index, entry in pairs(response) do
                groupCard {
                    parent = layout.container,
                    title = (string.len(entry["name"]) > 15 and string.sub(entry["name"], 1, 12).."...") or entry["name"],
                    --name = entry["username"],
                    --thumbnail = "https://cdn.deviap.com/"..(entry["icon"] or "")
                }.container:on("mouseLeftUp", function()
                    -- ROUTE TO GROUP SUB-MENU
                end)
            end
		end)
	end
}
