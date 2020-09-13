-- Copyright 2020 - Deviap (deviap.com)
-- Author(s): Sanjay-B(Sanjay)

-- Home (default) page-view

local button = require("devgit:source/libraries/UI/components/baseButton.lua")
--[[props =
{
	parent
	containerBackgroundColour
	containerBackgroundAlpha
	secondaryColour
	borderWidth
	borderAlpha
	borderInset
}
]]
return function(parent)

	local b = button {
		parent = parent,
		borderInset = 5,
		containerBackgroundColour = colour.random(),
		containerBackgroundAlpha = 1,
		secondaryColour = colour.random(),
		borderWidth = 2,
		borderAlpha = 1,
	}

	b.size = guiCoord(0, 200, 0, 200)
	b.position = guiCoord(0.0, -0, 0.0, -0)
	--[[
    -- Example Button Constructor
    local infoButton = checkBox {
        parent = parent,
        position = guiCoord(0.5, -60, 0.5, -20),
        size = guiCoord(0, 178, 0, 48)
    }

    -- When the button is pressed, say hello!
    --[[infoButton.states.subscribe(function(newState)
        if newState.active then
            print("Hello world!")
        end
    end)]]--
end