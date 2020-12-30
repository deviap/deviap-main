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

		scrollbarAlpha = number
		scrollbarColour = colour
		scrollbarRadius = number
		scrollbarWidth = number

		defaultBackgroundColour = colour,
		defaultBackgroundAlpha = number,
		defaultTextColour = colour,
		defaultTextAlpha = number,
		defaultIconColour = colour,
		defaultIconType = string,

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
		table getButtonFromSignature(any: id)
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

return function(props)
	local container = core.construct("guiScrollView", { parent = props.parent })
	local rendered = {}
	local __id = {}

	local self = {
		props = props,
		destroy = function()
		end,
		render = function()
			local parent = props.parent
			local size = props.size or guiCoord(0, 0, 0, 0)
			local position = props.position or guiCoord(0, 0, 0, 0)
			local backgroundColour = props.backgroundColour or colour(1, 1, 1)
			local name = props.name or "object"
			local scrollbarAlpha = props.scrollbarAlpha or 1
			local scrollbarColour = props.scrollbarColour or colour(0, 0, 0)
			local scrollbarRadius = props.scrollbarRadius or 0
			local scrollbarWidth = props.scrollbarWidth or 2

			local buttonHeight = props.buttonHeight or 25
			local insetBy = props.insetBy or 25

			local defaultBackgroundColour = props.defaultBackgroundColour or backgroundColour
			local defaultBackgroundAlpha = props.defaultBackgroundAlpha or 1
			local defaultTextColour = props.defaultTextColour or colour(0, 0, 0)
			local defaultTextAlpha = props.defaultTextAlpha or 1
			local defaultIconType = props.defaultIconType or "material"
			local defaultIconColour = props.defaultIconColour or colour(0, 0, 0)

			local onButtonDown1 = props.onButtonDown1
			local onButtonDown2 = props.onButtonDown2
			local onButtonUp1 = props.onButtonUp1
			local onButtonUp2 = props.onButtonUp2
			local onButtonDown2 = props.onButtonDown2
			local onButtonEnter = props.onButtonEnter
			local onButtonExit = props.onButtonExit

			container.parent = parent
			container.name = name
			container.size = size
			container.position = position
			container.backgroundColour = backgroundColour
			container.scrollbarAlpha = scrollbarAlpha
			container.scrollbarColour = scrollbarColour
			container.scrollbarRadius = scrollbarRadius

			local offset = 0
			local visited = {}

			local renderChild 
			renderChild = function(child, inset)
				visited[child] = true
				
				local button = rendered[child]
				if button == nil then
					button = newButton { parent = container }
					rendered[child] = button
				end

				button.propsThenRender {
					position = guiCoord(0, insetBy * inset, 0, buttonHeight * offset),
					size = guiCoord(1, -insetBy * inset - scrollbarWidth, 0, buttonHeight),
					backgroundColour = child.backgroundColour or defaultBackgroundColour,
					backgroundAlpha = child.backgroundAlpha or defaultBackgroundAlpha,
					
					text = child.text or "",
					textSize = buttonHeight - 10,
					textColour = child.textColour or defaultTextColour,
					textAlpha = child.textAlpha or defaultTextAlpha,
					
					iconId = child.iconId,
					iconType = child.iconType or defaultIconType,
					iconColour = child.iconColour or defaultIconColour,
					
					hasDescendants = child.hasDescendants or (child.children and #child.children > 0),
					isExpanded = child.isExpanded,
		
					onDown1 = onButtonDown1 and function()
						onButtonDown1(child, button)
					end,
					onDown2 = onButtonDown2 and function()
						onButtonDown2(child, button)
					end,
					onUp1 = onButtonUp1 and function()
						onButtonUp2(child, button)
					end,
					onUp2 = onButtonUp2 and function()
						onButtonDown2(child, button)
					end,
					onEnter = onButtonEnter and function()
						onButtonEnter(child, button)
					end,
					onExit = onButtonExit and function()
						onButtonExit(child, button)
					end,
				}

				offset = offset + 1

				
				if child.children and child.isExpanded then
					for _, _child in next, child.children do
						renderChild(_child, inset + 1)
					end
				end

				if child.signature then
					local possibleChild = __id[child.signature] 
					if possibleChild and possibleChild ~= child then
						error(("HIERARCHY: Two children have matching signature (%s)")
							:format(child.signature))
					end
					__id[child.signature] = child
				end
			end

			for _, child in next, props.hierarchy do
				renderChild(child, 0)
			end

			for child, button in next, rendered do
				if not visited[child] then
					button.destroy()
					rendered[child] = nil
					if child.signature then
						__id[child.signature] = nil
					end
				end
			end
			print(offset)
			container.canvasSize = guiCoord(1, 0, 0, offset * buttonHeight)
		end,
		getButtonFromSignature = function(signature)
			return __id[signature]
		end
	}

	self.render()
	return self
end
