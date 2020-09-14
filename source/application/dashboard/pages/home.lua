-- Copyright 2020 - Deviap (deviap.com)
-- Author(s): Sanjay-B(Sanjay), utrain

-- Home (default) page-view

local button = require("devgit:source/libraries/UI/components/buttons/primaryButton.lua")

return function(parent)

	local _button = button {
		parent = parent,
		position = guiCoord(0.5, -0, 0.5, -0),
		iconId = "plus",
		text = "Primary button"
	}.render()
end