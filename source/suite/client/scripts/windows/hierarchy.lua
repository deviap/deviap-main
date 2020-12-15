---------------------------------------------------------------
-- Copyright 2020 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------
local getDepth 
getDepth = function(start)
	local c = 1
	if start.children then
		for k,v in next, start.children do
			c = c + getDepth(v)
		end
	end

	return c
end

local construct
construct = function(parent, hierarchy, buttonHeight)
	local container = core.construct("guiFrame", {
		parent = parent, 
		strokeAlpha = 1,
		strokeWidth = 10,
		strokeColour = colour(0.5, 0.5, 0.5), 
		size = guiCoord(0, 200, 0, 500), 
		position = guiCoord(0, 100, 0, 0)
	})
	
	local offset = 0
	for k,v in next, hierarchy do
		core.construct("guiTextBox", {
			parent = container,
			size = guiCoord(1, 0, 0, buttonHeight),
			position = guiCoord(0, 0, 0, buttonHeight*offset),
			text = v.text
		})

		if v.children then
			offset = offset + getDepth(v.children)
			construct(container, v.children, buttonHeight)
		end
		offset = offset + 1
	end

	-- TODO: make props into a table
	-- make a simple interface
	return 1
end

return construct