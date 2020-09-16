-- Copyright 2020 - Deviap (deviap.com)
-- Author(s): Sanjay-B(Sanjay), utrain

-- Home (default) page-view

local button = require("devgit:source/libraries/UI/components/dropDowns/dropDown.lua")

return function(parent)
	print("error")
	local _button = button {
		parent = parent,
		position = guiCoord(0.5, -0, 0.5, -0),
		text = "Checkbox item",
	}.render()
end