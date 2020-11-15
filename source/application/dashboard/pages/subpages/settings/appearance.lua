-- Copyright 2020 - Deviap (deviap.com)
-- Author(s): Sanjay-B(Sanjay)
-- Creates the Appearance Setting subpage.
local toggle = require("devgit:source/libraries/UI/components/toggle.lua")
local descriptiveSettingCard = require("devgit:source/libraries/UI/components/cards/descriptiveSetting.lua")

return function(parent)
    local container = core.construct("guiFrame", {
        parent = parent,
        position = guiCoord(0, 13, 0, 100),
        size = guiCoord(0, 510, 0, 625),
        backgroundColour = colour.rgb(255, 0, 0),
        backgroundAlpha = 0
    })

    -- Dark Mode Toggle
    descriptiveSettingCard {
        parent = container,
        position = guiCoord(0, 0, 0, 20),
        header = "Dark Mode",
        description = "Sets the application's theme to dark mode.",
        childOffset = guiCoord(0, 0, 0, 0),
        child = toggle {
            position = guiCoord(1, -49, 1, -58),
            onStatus = "Enabled",
            offStatus = "Disabled",
            backdropStrokeRadius = 4,
            dotStrokeRadius = 2
        }
    }

    return container    
end