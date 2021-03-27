-- Copyright 2021 - Deviap (deviap.com)
-- Author(s): Sanjay-B(Sanjay)
-- Creates the Settings page.
local card = require("devgit:source/libraries/UI/components/cards/editApp.lua")
local gridLayout = require("devgit:source/libraries/UI/constraints/controllers/gridLayout.lua")
local tab = require("devgit:source/libraries/UI/components/tabs/tab.lua")
local tabs = require("devgit:source/libraries/UI/components/tabs/tabs.lua")

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
			text = "Settings",
			position = guiCoord(0, 11, 0, 4),
			size = guiCoord(1, 0, 0, 78),
			textSize = 38,
			textFont = "deviap:fonts/openSansExtraBold.ttf",
			backgroundAlpha = 0
        })

        local tabsContainer = tabs {
            parent = scrollContainer,
            position = guiCoord(0, 12, 0, 50)
        }

        tabsContainer.addTab(
            tab {
                parent = scrollContainer,
                label = "Appearance"
            },
            require("devgit:source/application/dashboard/pages/subpages/settings/appearance.lua")(scrollContainer)
        )

        tabsContainer.addTab(
            tab {
                parent = scrollContainer,
                label = "Graphics"
            },
            require("devgit:source/application/dashboard/pages/subpages/settings/graphics.lua")(scrollContainer)
        )

        tabsContainer.addTab(
            tab {
                parent = scrollContainer,
                label = "Experimental"
            },
            require("devgit:source/application/dashboard/pages/subpages/settings/experimental.lua")(scrollContainer)
        )
	end
}
