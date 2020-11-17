-- Copyright 2020 - Deviap (deviap.com)
-- Author(s): Sanjay-B(Sanjay)
-- Creates the Graphics Setting subpage.
local toggle = require("devgit:source/libraries/UI/components/toggle.lua")
local descriptiveSettingCard = require("devgit:source/libraries/UI/components/cards/descriptiveSetting.lua")
local dropdownOptions = require("devgit:source/libraries/UI/components/dropDowns/dropDownOptions.lua")

return function(parent)
    local availableRenderers = core.graphics.getRenderers()

    local container = core.construct("guiFrame", {
        parent = parent,
        position = guiCoord(0, 13, 0, 100),
        size = guiCoord(0, 510, 0, 625),
        backgroundColour = colour.rgb(255, 0, 0),
        backgroundAlpha = 0
    })

    -- Debugger Toggle
    descriptiveSettingCard {
        parent = container,
        position = guiCoord(0, 0, 0, 20),
        header = "Debugger",
        description = "The debugger allows for the output to logged to the console.",
        childOffset = guiCoord(0, 0, 0, 0),
        child = toggle {
            position = guiCoord(1, -49, 1, -58),
            onStatus = "Enabled",
            offStatus = "Disabled",
            backdropStrokeRadius = 4,
            dotStrokeRadius = 2
        }
    }

    local rendererOptions = dropdownOptions {
        text = "",
        position = guiCoord(1, -280, 1, -58),
        size = guiCoord(0, 80, 0, 30),
        textSize = 12
    }

	if #availableRenderers == 0 then
		rendererOptions.state.dispatch({ type = "disable"})
	else
		for _, renderer in pairs(availableRenderers) do
			rendererOptions.addButton(renderer)
		end
	end

    -- Renderer Choose
    descriptiveSettingCard {
        parent = container,
        position = guiCoord(0, 0, 0, 70),
        header = "Renderer",
        description = "Choose a renderer that Deviap will use.",
        child = rendererOptions
    }












    return container    
end