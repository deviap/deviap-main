-- Copyright 2020 - Deviap (deviap.com)
-- Author(s): Sanjay-B(Sanjay)
-- Text Icon Button Example
local button = require("devgit:source/libraries/UI/components/primaryButton.lua")

return function(parent)

	-- Text & icon are both defined in the constructor therefore, it'll be a text button w/ an icon.
	local _button = button{
		parent = parent,
		position = guiCoord(0.5, -0, 0.5, -0),
		text = "Primary button",
		iconId = "plus"
	}.render()
end
