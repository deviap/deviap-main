---------------------------------------------------------------
-- Copyright 2021 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------
-- Creates the Settings page.
local autoCollectionGrid = require("devgit:source/libraries/UI/constraints/controllers/collectionLayoutAuto.lua")

return {
    construct = function(parent)
		local heading = core.construct("guiTextBox", {
			parent = parent,
			text = "  ".."Settings",
			position = guiCoord(0, 0, 0, 0),
            size = guiCoord(1, 0, 0, 35),
            backgroundColour = colour.hex("212121"),
			textSize = 25,
            textFont = "deviap:fonts/openSansExtraBold.ttf",
            textAlign = "middleLeft",
            textColour = colour.hex("FFFFFF"),
            strokeWidth = 2,
            strokeColour = colour.hex("F5F5F5"),
		})

		local subheading1 = core.construct("guiTextBox", {
			parent = parent,
			text = "   ".."Manage Deviap's settings.",
			position = guiCoord(0, 0, 0, 40),
			size = guiCoord(1, 0, 0, 78),
			textSize = 18,
            textAlpha = 0.9,
            textColour = colour.hex("FFFFFF"),
            textFont = "deviap:fonts/openSansRegular.ttf",
			backgroundAlpha = 0
        })

        -- Enable this when in use.
		--[[local gridController = autoCollectionGrid()
        gridController.container.parent = parent
        gridController.container.position = guiCoord(0, 11, 0, 80)
        gridController.container.size = guiCoord(0, 260, 0, 703)
        gridController.container.backgroundColour = colour.rgb(255, 0, 0)
        gridController.container.backgroundAlpha = 0
        ]]--

		-- Settings elements go here.
	end
}

