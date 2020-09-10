local iconButton = require("devgit:source/libraries/UI/components/iconButton.lua")

-- Example Button Constructor
local infoButton = iconButton {
    parent = , -- Set parent
    position = guiCoord(0.5, -60, 0.5, -20),
    size = guiCoord(0, 48, 0, 48)
}

-- Set the text of the textButton to 'Home'
--infoButton.setIcon()

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