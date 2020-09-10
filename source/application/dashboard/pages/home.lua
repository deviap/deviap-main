-- Copyright 2020 - Deviap (deviap.com)
-- Author(s): Sanjay-B(Sanjay)

-- Home (default) page-view

local Button = require("devgit:source/libraries/UI/components/textButton.lua")

return function(parent)
    -- Example Button Constructor
    local infoButton = Button {
        parent = parent,
        position = guiCoord(0.5, -60, 0.5, -20),
        size = guiCoord(0, 178, 0, 48),
    }

	-- Bind mouse controls to button states
	infoButton.child:on("mouseEnter", function() infoButton.states.dispatch({ type = "hover" }) end)
    infoButton.child:on("mouseExit", function() infoButton.states.dispatch({ type = "unhover" }) infoButton.states.dispatch({ type = "deactivate" }) end)
    infoButton.child:on("mouseLeftUp", function() infoButton.states.dispatch({ type = "deactivate" }) end)
	infoButton.child:on("mouseLeftDown", function() infoButton.states.dispatch({ type = "activate" }) end)

    -- Bind render to state subscriber
    infoButton.states.subscribe(infoButton.render)

	-- Enable the button
	infoButton.states.dispatch({ type = "disable" })

    -- When the button is pressed, say hello!
    infoButton.states.subscribe(function(newState)
        if newState.active then
            print("Hello world!")
        end
    end)
end