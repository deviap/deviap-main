-- Copyright 2020 - Deviap (deviap.com)
-- Author(s): Sanjay-B(Sanjay), utrain

-- Home (default) page-view

<<<<<<< HEAD
local button = require("devgit:source/libraries/UI/components/dropDowns/dropDown.lua")
=======
local checkbox = require("devgit:source/libraries/UI/components/checkbox.lua")
>>>>>>> 8e04eb37b95fae08efba93a5a3ee26b01548a9be

return function(parent)
	local _checkbox = checkbox {
		parent = parent,
		position = guiCoord(0.5, -0, 0.5, -0),
		text = "Checkbox item",
	}.render()
end