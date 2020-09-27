-- Copyright 2020 - Deviap (deviap.com)
-- Author(s): Sanjay-B(Sanjay), utrain

-- Home (default) page-view

local dropDown = require("devgit:source/libraries/UI/components/dropDowns/dropDownOptions.lua")

return function(parent)
	local drop = dropDown({
		parent = parent,
		position = guiCoord(0,200,0,200),
	})

	drop.state.subscribe(function(state, _, action)
		if action.type == "selectButton" then
			print(action.newButton)
		end
	end)

	drop.addButton("ok")
	drop.addButton("yes")
	drop.addButton("two")
end