-- Copyright 2020 - Deviap (deviap.com)
-- Author(s): Sanjay-B(Sanjay)

-- Home (default) page-view

local Button = require("devgit:source/libraries/UI/components/button.lua")

return function(parent)

    -- Example Button Constructor
    local infoButton = Button {
        parent = parent,
        position = guiCoord(0.5, -60, 0.5, -20),
        size = guiCoord(0, 178, 0, 48),
    }

    -- Set the initial state to 'active'
    infoButton.render("active")

    -- Bind render to state subscriber
    infoButton.states.subscribe(infoButton.render)

    -- When state is 'focused' invoke action
    infoButton.states.subscribe(function(newState)
        if newState == "focused" then
            print("Hello world!")
        end
    end)
end