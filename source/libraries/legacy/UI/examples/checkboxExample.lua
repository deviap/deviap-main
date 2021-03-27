-- Copyright 2021 - Deviap (deviap.com)
-- Author(s): Sanjay-B(Sanjay), utrain
-- Checkbox Example
local checkbox = require("devgit:source/libraries/UI/components/checkbox.lua")

return function(parent)

	-- Creates a checkbox w/ the text provided. If no text is provided, text will be empty.
	local _checkbox = checkbox{
		parent = parent,
		position = guiCoord(0.5, -0, 0.5, -0),
		text = "Checkbox item"
	}
end
