---------------------------------------------------------------
-- Copyright 2021 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------
-- Creates the Performance page.
local dotGraphCard = require("devgit:source/libraries/UI/components/cards/dotGraph.lua")
--local outputCard = require("devgit:source/libraries/UI/components/cards/output.lua")
local autoCollectionGrid = require("devgit:source/libraries/UI/constraints/controllers/collectionLayoutAuto.lua")

return {
    construct = function(parent)
		local heading = core.construct("guiTextBox", {
			parent = parent,
			text = "  ".."Performance",
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
			text = "   ".."Section that measures performance.",
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
       
        --[[outputCard {
            parent = gridController.container,
            position = guiCoord(0, 11, 0, 80),
            size = guiCoord(0, 260, 0, 300),
            title = "Output"
        }
  
]]
		-- Extremely buggy rn; don't enable unless you're trying to fix it.
        -- DOT GRAPH TEST (PING)
        --[[
        dotGraphCard  {
            parent = gridController.container,
            position = guiCoord(0, 11, 0, 80),
            size = guiCoord(0, 260, 0, 100),
            title = "FPS"
        }
        ]]--
	end
}