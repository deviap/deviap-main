local iconButton = require("devgit:source/libraries/UI/components/iconButton.lua")

return function(parent)
	-- Example Button Constructor
	local infoButton = iconButton {
		parent = parent,
		position = guiCoord(0.5, -60, 0.5, -20),
		size = guiCoord(0, 48, 0, 48)
	}

	-- When the button is pressed, say hello!
	infoButton.states.subscribe(
					function(newState) if newState.active then print("Hello world!") end end)
end
