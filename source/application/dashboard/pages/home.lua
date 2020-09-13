-- Copyright 2020 - Deviap (deviap.com)
-- Author(s): Sanjay-B(Sanjay)

-- Home (default) page-view

local checkBox = require("devgit:source/libraries/UI/components/checkbox.lua")

return function(parent)
    -- Example Button Constructor
    local infoButton = checkBox {
        parent = parent,
        position = guiCoord(0.5, -60, 0.5, -20),
        size = guiCoord(0, 120, 0, 18)
    }

    -- When the button is pressed, say hello!
    --[[infoButton.states.subscribe(function(newState)
        if newState.active then
            print("Hello world!")
        end
    end)]]--
end