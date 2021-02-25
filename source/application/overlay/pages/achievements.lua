---------------------------------------------------------------
-- Copyright 2021 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------
-- Creates the Achievement page.
local autoCollectionGrid = require("devgit:source/libraries/UI/constraints/controllers/collectionLayoutAuto.lua")
local achievementCard = require("devgit:source/libraries/UI/components/cards/achievement.lua")

return {
    construct = function(parent)
		local heading = core.construct("guiTextBox", {
			parent = parent,
			text = "  ".."Achievements",
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
			text = "   ".."Shows current game's achievement.",
			position = guiCoord(0, 0, 0, 40),
			size = guiCoord(1, 0, 0, 78),
			textSize = 18,
            textAlpha = 0.9,
            textColour = colour.hex("FFFFFF"),
            textFont = "deviap:fonts/openSansRegular.ttf",
			backgroundAlpha = 0
        })

		local gridController = autoCollectionGrid()
        gridController.container.parent = parent
        gridController.container.position = guiCoord(0, 11, 0, 80)
        gridController.container.size = guiCoord(0, 260, 1, -85)
        gridController.container.backgroundColour = colour.rgb(255, 0, 0)
        gridController.container.backgroundAlpha = 0

		-- Achievement Card (not unlocked)
		achievementCard {
            parent = gridController.container,
            position = guiCoord(0, 11, 0, 80),
            size = guiCoord(0, 260, 0, 103),
            title = "Legendary Boss Set",
			content = "Beat 5 bosses on Easy to complete.",
            image = "devgit:assets/images/abstract1.png",
			icon = "check_circle",
        }

		-- Achievement Card (unlocked)
		achievementCard {
            parent = gridController.container,
            position = guiCoord(0, 11, 0, 80),
            size = guiCoord(0, 260, 0, 103),
            title = "Legendary Boss Set",
			content = "Beat 5 bosses on Easy to complete.",
            image = "devgit:assets/images/abstract1.png",
			icon = "check_circle",
			unlocked = true
        }
	end
}

