---------------------------------------------------------------
-- Copyright 2020 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------

--[[
	Name: Hierarchy Button

	Description: Button made for the hierarchy view. You can definitely use this
	outside of the context of hierarchy but, that's not really intended ,). This
	may become a template for other components instead in the future.

	Properties:
		parent = guiObject,
		position = guiCoord,
		size = guiCoord,
		backgroundColour = colour,
		backgroundAlpha = number,
		text = string,
		textColour = colour,
		textAlpha = number,
		textSize = number,
		iconId = string,
		iconColour = colour,
		iconType = enum.iconType
		dropDownColour = colour,
		hasDescendants = boolean,
		isExpanded = boolean,

		onDown1 = function,
		onDown2 = function,
		onUp1 = function,
		onUp2 = function,
		onEnter = function,
		onExit = function,

	Interface:
		function destroy(nil)
			Destroy the container
		function render(nil)
			Rerender the component.
		table props
			Table of props that is used to rerender the component.
--]]

local bindAll = function(object, events)
	for eventName, callback in next, events do
		object:on(eventName, callback)
	end
end

local renderButton = function(props)
	local container = core.construct("guiFrame", {
		parent = props.parent,
		size = props.size,
		position = props.position,
		backgroundColour = props.backgroundColour,
		backgroundAlpha = props.backgroundAlpha,
	})

	bindAll(container, {
		mouseLeftDown = props.onDown1,
		mouseRightDown = props.onDown2,
		mouseLeftUp = props.onUp1,
		mouseRightUp = props.onUp2,
		mouseEnter = props.onEnter,
		mouseExit = props.onExit,
	})

	if props.hasDescendants then
		local dropDown = core.construct("guiIcon", {
			parent = container,
			iconId = props.isExpanded and "expand_less" or "expand_more",
			iconColour = props.dropDownColour or colour(1, 1, 1),
			size = guiCoord(0, props.textSize, 0, props.textSize),
			position = guiCoord(0, 2, 0.5, -props.textSize / 2),
			backgroundAlpha = 0,
			active = false,
		})
	end

	local icon = core.construct("guiIcon", {
		parent = container,
		iconId = props.iconId,
		iconColour = props.iconColour,
		iconType = props.iconType,
		size = guiCoord(0, props.textSize, 0, props.textSize),
		position = guiCoord(0, props.textSize + 4, 0.5, -props.textSize / 2),
		backgroundAlpha = 0,
		active = false,
	})

	local textBox = core.construct("guiTextBox", {
		parent = container,
		text = props.text,
		size = guiCoord(1, -props.textSize * 2 - 8, 1 , 0),
		position = guiCoord(0, props.textSize * 2 + 8, 0, 0),
		textAlign = "middleLeft",
		textAlpha = props.textAlpha,
		backgroundAlpha = 0,
		textColour = props.textColour,
		active = false,
	})

	return container
end

return function(props)
	local container = renderButton(props)
	return {
		destroy = function()
			container:destroy()
		end,
		render = function()
			container:destroy()
			container = renderButton(props)
		end,
		props = props,
	}
end