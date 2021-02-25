---------------------------------------------------------------
-- Copyright 2021 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------
-- Creates the Information page.
local autoCollectionGrid = require("devgit:source/libraries/UI/constraints/controllers/collectionLayoutAuto.lua")
local informationListTextCard = require("devgit:source/libraries/UI/components/cards/informationListText.lua")
local informationTextCard = require("devgit:source/libraries/UI/components/cards/informationText.lua")

return {
    construct = function(parent)
		local heading = core.construct("guiTextBox", {
			parent = parent,
			text = "  ".."Information",
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
			text = "   ".."Shows general information.",
			position = guiCoord(0, 0, 0, 40),
			size = guiCoord(1, 0, 0, 78),
			textSize = 18,
            textAlpha = 0.9,
            textColour = colour.hex("FFFFFF"),
            textFont = "deviap:fonts/openSansRegular.ttf",
			backgroundAlpha = 0
        })

        local gridController = autoCollectionGrid({
            parent = parent,
            position = guiCoord(0, 11, 0, 80),
            size = guiCoord(0, 260, 1, -85),
            backgroundColour = colour.rgb(255, 0, 0),
            backgroundAlpha = 0,
            scrollbarAlpha = 0
        })

        -- About Card
        informationTextCard {
            parent = gridController.container,
            position = guiCoord(0, 11, 0, 80),
            size = guiCoord(0, 260, 0, 103),
            title = "About",
            content = "Deviap is an open-source platform that enables developers with a simple, unified interface to create apps and learn about development."
        }

        -- Contributors Card
        informationTextCard {
            parent = gridController.container,
            position = guiCoord(0, 11, 0, 80),
            size = guiCoord(0, 260, 0, 83),
            title = "Developers",
            content = "Jason Carr (Jay)\nSanjay Bhadra (Sanjay)\nutrain (utrain)"
        }

        -- Acknowledgements Card
        informationTextCard {
            parent = gridController.container,
            position = guiCoord(0, 11, 0, 80),
            size = guiCoord(0, 260, 0, 102),
            title = "Acknowledgements",
            content = "sound/click.ogg sourced from http://soundbible.com/1705-Click2.html\nsound/tick.ogg sourced from http://soundbible.com/2044-Tick.html"
        }

        -- Disclaimer Card
        informationTextCard {
            parent = gridController.container,
            position = guiCoord(0, 11, 0, 80),
            size = guiCoord(0, 260, 0, 118),
            title = "Dislaimer",
            content = "If you're on a modified client, Deviap (parent or child companies) do not take responsiblity for the possible risk. By clicking this instance, app, etc, you acknowledge the risk."
        }

        -- Legal Card
        informationTextCard {
            parent = gridController.container,
            position = guiCoord(0, 11, 0, 80),
            size = guiCoord(0, 260, 0, 118),
            title = "Legal",
            content = "Copyright "..os.date("%Y").." - Deviap (deviap.com)\nTrademarks pending\nLicensing (MIT)\nTrademarks, logos, etc may not be used without written permission"
        }
	end
}