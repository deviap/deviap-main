local textButton = require("devgit:source/libraries/UI/components/textButton.lua")

return function(parent)
	-- Example Button Constructor
	local infoButton = textButton {
		parent = parent,
		position = guiCoord(0.5, -60, 0.5, -20),
		size = guiCoord(0, 178, 0, 48)
	}

	-- When the button is pressed, say hello!
	infoButton.states.subscribe(
					function(newState) if newState.active then print("Hello world!") end end)
end
