-- Copyright 2020 - Deviap (deviap.com)
-- Author(s): Sanjay-B(Sanjay), utrain

-- Home (default) page-view

local checkbox = require("devgit:source/libraries/UI/components/checkbox.lua")

return function(parent)
	local _checkbox = checkbox {
		parent = parent,
		position = guiCoord(0.5, -0, 0.5, -0),
		text = "Checkbox item"
	}.render()
end