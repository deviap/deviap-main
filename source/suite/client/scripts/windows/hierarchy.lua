---------------------------------------------------------------
-- Copyright 2020 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------
local newButton = require("./hierarchyButton.lua")

local bindAll = function(object, events)
	for k,v in next, events do
		object:on(k, v)
	end
end


local getNumOfEntries 
getNumOfEntries = function(start)
	local c = 0
	if start then
		for k,v in next, start do
			c = c + 1 + getNumOfEntries(v.children)
		end
	end
	return c
end

local construct
construct = function(props)
	local container = core.construct("guiFrame", {
		parent = props.parent, 
		size = props.size, 
		position = props.position,
		backgroundColour = colour(0.1,0.1,0.1);
	})
	
	local offset = 0
	for k,v in next, props.hierarchy do
		local descendants = getNumOfEntries(v.children)
		local button = newButton {
			parent = container,
			size = guiCoord(1, 0, 0, props.buttonHeight),
			position = guiCoord(0, 0, 0, props.buttonHeight*offset),
			text = v.text,
			iconId = v.icon,
			fontSize = props.buttonHeight - 10,
			backgroundColour = colour(0.1,0.1,0.1);
			backgroundAlpha = 1;
			hasDescendants = descendants > 0
		}
		offset = offset + 1

		if descendants > 0 then
			construct({
				parent = container, 
				hierarchy = v.children, 
				buttonHeight = props.buttonHeight,
				position = guiCoord(0, 10, 0, props.buttonHeight*offset),
				size = guiCoord(1, -10, 0, props.buttonHeight*descendants)
			})
			offset = offset + descendants
		end
	end

	return {
		getTreeFromId; -- table function(id)
		render;
		props;
		__ids;
		
		-- Events
		onButtonDown1; -- function disconnect function(callback(id, tree))
		onButtonUp1;
	}
end

return construct