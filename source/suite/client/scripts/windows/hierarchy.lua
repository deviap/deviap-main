---------------------------------------------------------------
-- Copyright 2020 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------

--[[
	Name: Hierarchy Menu

	Description: This is a generic hierarchy menu. Use it for your menu needs!
	This is not standalone and it will require you to implement behaviors such
	as click-and-drag to move elements around. But, this also means it is quite
	generic. You also have tagging to help select only parts of the tree.

	Properties:
		parent = guiObject,
		size = guiCoord,
		position = guiCoord,
		backgroundColour = colour,
		buttonHeight = number,
		indentBy = number,
		children = { child, ... },

		onButtonDown1 = function,
		onButtonDown2 = function,
		onButtonUp1 = function,
		onButtonUp2 = function,
		onButtonEnter = function,
		onButtonLeave = function,

	Child:
		text = string,
		textColour = colour,
		font = string or enum.fonts,
		icon = string,
		isExpanded = boolean,
		backgroundColour = colour,
		backgroundAlpha = number,
		signature = any,
		children = { child, ... },

	Interface:
		function render(nil)
			Rerender this component.
		table getSubComponentFromSignature(any: id)
			This returns the table associated with the signature
		destroy
			Destroy component.
		props
			Props being used to render component.
--]]

local newButton = require("./hierarchyButton.lua")

local bindAll = function(object, events)
	for eventName, callback in next, events do
		object:on(eventName, callback)
	end
end

local getNumberOfDescendants 
getNumberOfDescendants = function(start)
	local count = 0
	if start then
		for _, child in next, start do
			count = count + 1 + getNumberOfDescendants(child.children)
		end
	end
	return count
end

local renderHierarchy
renderHierarchy = function(props, __id)
	local container = core.construct("guiFrame", {
		parent = props.parent, 
		size = props.size, 
		position = props.position,
		backgroundColour = props.backgroundColour,
	})

	local offset = 0

	local renderChild
	renderChild = function(child, inset)
		-- Don't want to have the callback to change without calling render()
		-- again.
		local onButtonDown1 = props.onButtonDown1
		local onButtonDown2 = props.onButtonDown2
		local onButtonUp1 = props.onButtonUp1
		local onButtonUp2 = props.onButtonUp2
		local onButtonEnter = props.onButtonEnter
		local onButtonExit = props.onButtonExit

		local numOfDescendants = getNumberOfDescendants(child.children)

		newButton {
			parent = container,
			position = guiCoord(0, props.insetBy * inset, 0, props.buttonHeight * offset),
			size = guiCoord(1, -props.insetBy * inset, 0, props.buttonHeight),
			backgroundColour = child.backgroundColour or props.defaultBackgroundColour,
			backgroundAlpha = child.backgroundAlpha or props.defaultBackgroundAlpha,
			
			text = child.text or "",
			textSize = props.buttonHeight - 10,
			textColour = child.textColour or props.defaultTextColour,
			textAlpha = child.textAlpha or props.defaultTextAlpha,
			
			iconId = child.iconId,
			iconType = child.iconType or props.defaultIconType,
			iconColour = child.iconColour or props.defaultIconColour,
			
			hasDescendants = numOfDescendants > 0,
			isExpanded = child.isExpanded,

			onDown1 = onButtonDown1 and function()
				onButtonDown1(child)
			end,
			onDown2 = onButtonDown2 and function()
				onButtonDown2(child)
			end,
			onUp1 = onButtonUp2 and function()
				onButtonUp2(child)
			end,
			onUp2 = onButtonDown2 and function()
				onButtonDown2(child)
			end,
			onEnter = onButtonEnter and function()
				onButtonEnter(child)
			end,
			onExit = onButtonExit and function()
				onButtonExit(child)
			end,
		}

		offset = offset + 1

		if child.children and child.isExpanded then
			for _, _child in next, child.children do
				renderChild(_child, inset + 1)
			end
		end

		if child.signature then
			if __id[child.signature] then
				error(("HIERARCHY: Two children have matching signature (%s)")
					:format(child.signature))
			end
			__id[child.signature] = child
		end
	end

	for _, child in next, props.hierarchy do
		renderChild(child, 0)
	end

	return container
end

local construct
construct = function(props)
	local __id = {}
	local container = renderHierarchy(props)
	return {
		render = function()
			container:destroy()
			container = renderHierarchy(props)
		end,
		destroy = function()
			container:destroy()
			container = nil
			__id = nil
		end,
		getSubComponentFromSignature = function(signature)
			return __id[signature]
		end,
		props = props
	}
end

return construct