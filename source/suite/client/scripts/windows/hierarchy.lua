---------------------------------------------------------------
-- Copyright 2020 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------
local newButton = require("devgit:source/libraries/UI/components/buttons/baseButton.lua")

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
construct = function(props)
	-- parent, hierarchy, buttonHeight)
	local container = core.construct("guiFrame", {
		parent = props.parent, 
		strokeAlpha = 1,
		strokeWidth = 1,
		strokeColour = colour(0.5, 0.5, 0.5), 
		size = props.size, 
		position = props.position
	})
	
	local offset = 0
	for k,v in next, props.hierarchy do
		local button = newButton {
			parent = container,
			size = guiCoord(1, 0, 0, props.buttonHeight),
			position = guiCoord(0, 0, 0, props.buttonHeight*offset),
			text = v.text,
			iconId = v.icon
		}

		if v.children then
			offset = offset + 1
			local childDepth = getDepth(v)
			construct({
				parent = container, 
				hierarchy = v.children, 
				buttonHeight = props.buttonHeight,
				position = guiCoord(0, 10, 0, props.buttonHeight*(offset)),
				size = guiCoord(1, -10, 0, props.buttonHeight*(childDepth))
			})
			offset = offset + childDepth
		end
		offset = offset + 1
	end

	-- make a simple interface
	return 1
end

return construct