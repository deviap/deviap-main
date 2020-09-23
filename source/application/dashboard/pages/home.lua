-- Copyright 2020 - Deviap (deviap.com)
-- Author(s): Sanjay-B(Sanjay), utrain

-- Home (default) page-view

local dropDown = require("devgit:source/libraries/UI/components/dropDowns/dropDownOptions.lua")

return function(parent)
	dropDown({
		parent = parent,
		position = guiCoord(0,200,0,200),
		text = "owo"
	}).render()
end