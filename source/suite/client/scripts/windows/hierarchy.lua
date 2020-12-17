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
	--[[
		parent
		size
		position
		backgroundColour
		buttonHeight
		indentBy
		children

		onButtonDown1(button, signature)
		onButtonDown2
		onButtonUp1
		onButtonUp2
		onButtonEnter
		onButtonLeave
	]]

	--[[
		hierarchy = 
		{
			text
			textColour
			font
			icon or image
			isExpanded
			backgroundColour
			backgroundAlpha
			signature
			children
		}
	]]
	--[[
		render
		getSubComponentFromSignature
		destroy
		props
	]]

	local container = core.construct("guiFrame", {
		parent = props.parent, 
		size = props.size, 
		position = props.position,
		backgroundColour = props.backgroundColour;
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
			backgroundColour = v.backgroundColour or props.backgroundColour;
			textColour = v.textColour or props.textColour;
			backgroundAlpha = v.backgroundAlpha;
			hasDescendants = descendants > 0
		}
		offset = offset + 1

		if descendants > 0 then
			construct({
				parent = container, 
				hierarchy = v.children, 
				buttonHeight = props.buttonHeight,
				backgroundColour = props.backgroundColour,
				textColour = props.textColour,
				position = guiCoord(0, 10, 0, props.buttonHeight*offset),
				size = guiCoord(1, -10, 0, props.buttonHeight*descendants)
			})
			offset = offset + descendants
		end
	end

	return {
		render = function()

		end,
		destroy = function()

		end,
		getSubComponentFromSignature = function(signature)

		end,
		props = props
	}
end

return construct