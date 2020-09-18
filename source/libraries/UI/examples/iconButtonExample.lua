-- Copyright 2020 - Deviap (deviap.com)
-- Author(s): Sanjay-B(Sanjay)

-- Icon Button Example

local button = require("devgit:source/libraries/UI/components/primaryButton.lua")

return function(parent)

    -- Text is not declared & therefore, the button instance dynamically changes to an icon button.
	local _button = button {
		parent = parent,
		position = guiCoord(0.5, -0, 0.5, -0),
		iconId = "plus",
	}.render()
end