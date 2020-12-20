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
	local binded = {}
	for eventName, callback in next, events do
		binded[eventName] = object:on(eventName, callback)
	end

	return function()
		for _, index in next, binded do
			core.disconnect(index)
		end
	end
end

return function(props)
	local container = core.construct("guiFrame", { parent = props.parent })
	local disconnectEvents = bindAll(container, {
		mouseLeftDown = props.onDown1,
		mouseRightDown = props.onDown2,
		mouseLeftUp = props.onUp1,
		mouseRightUp = props.onUp2,
		mouseEnter = props.onEnter,
		mouseExit = props.onExit,
	})

	local dropDown = core.construct("guiIcon", { parent = container })
	local icon = core.construct("guiIcon", { parent = container })
	local textBox = core.construct("guiTextBox", { parent = container })

	local self
	self = {
		destroy = function()
			container:destroy()
		end,
		render = function()
			local parent = props.parent
			local size = props.size or guiCoord(0, 0, 0, 0)
			local position = props.position or guiCoord(0, 0, 0, 0)
			local backgroundColour = props.backgroundColour or colour(1, 1, 1)
			local backgroundAlpha = props.backgroundAlpha or 1
			
			local isExpanded = props.isExpanded -- Default false
			local hasDescendants = props.hasDescendants -- Default false
			local dropDownColour = props.dropDownColour or colour(1, 1, 1)

			local iconId = props.iconId or ""
			local iconColour = props.iconColour or colour(1, 1, 1)
			local iconType = props.iconType or "material"

			local text = props.text or ""
			local textSize = props.textSize or 16
			local textColour = props.textColour or colour(0, 0, 0)
			local textAlpha = props.textAlpha or  1
		
			container.parent = parent
			container.size = size
			container.position = position
			container.backgroundColour = backgroundColour
			container.backgroundAlpha = backgroundAlpha

			disconnectEvents()
			disconnectEvents = bindAll(container, {
				mouseLeftDown = props.onDown1,
				mouseRightDown = props.onDown2,
				mouseLeftUp = props.onUp1,
				mouseRightUp = props.onUp2,
				mouseEnter = props.onEnter,
				mouseExit = props.onExit,
			})

			if hasDescendants then
				if dropDown then
					dropDown.parent = container
					dropDown.iconId = isExpanded and "expand_less" or "expand_more"
					dropDown.iconColour = dropDownColour or colour(1, 1, 1)
					dropDown.size = guiCoord(0, textSize, 0, textSize)
					dropDown.position = guiCoord(0, 2, 0.5, -textSize / 2)
					dropDown.backgroundAlpha = 0
					dropDown.active = false
				else
					dropDown = core.construct("guiIcon", {
						parent = container,
						iconId = isExpanded and "expand_less" or "chevron_right",
						iconColour = dropDownColour or colour(1, 1, 1),
						size = guiCoord(0, textSize, 0, textSize),
						position = guiCoord(0, 2, 0.5, -textSize / 2),
						backgroundAlpha = 0,
						active = false,
					})
				end
			else
				if dropDown then					
					dropDown:destroy()
					dropDown = nil
				end
			end

			icon.iconId = iconId
			icon.iconColour = iconColour
			icon.iconType = iconType
			icon.size = guiCoord(0, textSize, 0, textSize)
			icon.position = guiCoord(0, textSize + 4, 0.5, -textSize / 2)
			icon.backgroundAlpha = 0
			icon.active = false

			textBox.parent = container
			textBox.text = text
			textBox.size = guiCoord(1, -textSize * 2 - 8, 1 , 0)
			textBox.position = guiCoord(0, textSize * 2 + 8, 0, 0)
			textBox.textAlign = "middleLeft"
			textBox.textAlpha = textAlpha
			textBox.backgroundAlpha = 0
			textBox.textColour = textColour
			textBox.active = false
		end,
		propsThenRender = function(changes)
			for k,v in next, changes do
				props[k] = v
			end
			self.render()
		end,
		props = props,
	}

	self.render()
	return self
end