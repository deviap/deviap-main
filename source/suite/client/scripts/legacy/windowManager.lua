-- Copyright 2021 - Deviap (deviap.com)
-- Contains uilities, soon to become a tiling manager. 

local libs = require("scripts/libraries.lua")
local newWindow = libs("window")

local self = {}

self.applyDraggable = function(window, dragBy)
	return dragBy:on("mouseLeftDown", function()
		local offset = core.input.mousePosition - dragBy.absolutePosition
		local move = core.input:on("mouseMoved", function()
			local newPosition = core.input.mousePosition
			window.props.position = guiCoord(0, newPosition.x - offset.x, 0, newPosition.y - offset.y)
			window.render()
		end)

		core.input:on("mouseLeftUp", function() 
			core.disconnect(move)	
		end)
	end)
end

self.applyResizable = function(window, minimumSpace, draggableSpace)
	minimumSpace = vector2(40, window.props.topBarHeight + 4)
	draggableSpace = draggableSpace or 8

	local getDirectionForAxis = function(pos, left, right)
		if pos > right and pos < right + draggableSpace then return 1 end
		if pos < left and pos > left - draggableSpace then return -1 end
		return 0
	end

	local getDirection = function(pos, left, right)
		return vector2(
			getDirectionForAxis(pos.x, left.x, right.x), 
			getDirectionForAxis(pos.y, left.y, right.y)
		)
	end

	return core.input:on("mouseLeftDown", function()
		local direction = getDirection(
			core.input.mousePosition, 
			window.container.absolutePosition, 
			window.container.absoluteSize + window.container.absolutePosition
		)

		local onUp
		local onMove

		onUp = core.input:on("mouseLeftUp", function()
			core.disconnect(onMove)
			core.disconnect(onUp)
		end)

		onMove = core.input:on("mouseMoved", function()
			local mousePosition = core.input.mousePosition
			local left = window.props.position.offset
			local right = window.props.size.offset + left

			if direction.x == 1 then
				window.props.size = guiCoord(0, math.max(mousePosition.x - left.x, minimumSpace.x), 0, window.props.size.offset.y)
			elseif direction.x == -1 then
				window.props.position = guiCoord(0, mousePosition.x, 0, window.props.position.offset.y)
				window.props.size = guiCoord(0, math.max(right.x - mousePosition.x, minimumSpace.x), 0, window.props.size.offset.y)
			end

			if direction.y == 1 then
				window.props.size = guiCoord(0, window.props.size.offset.x, 0, math.max(mousePosition.y - left.y, minimumSpace.y))
			elseif direction.y == -1 then
				window.props.position = guiCoord(0, window.props.position.offset.x, 0, mousePosition.y)
				window.props.size = guiCoord(0, window.props.size.offset.x, 0, math.max(right.y - mousePosition.y, minimumSpace.y))
			end

			window.render()
		end)
	end)
end

self.applyMinimization = function(window)
	local savedSize = window.props.size
	local isCollapsed = false

	return function()
		if not isCollapsed then
			isCollapsed = false
			window.props.subContainer.visible = false
			savedSize = window.props.size
			window.props.size = guiCoord(window.props.size.scale.x, window.props.size.offset.x, 0, window.props.topBarHeight)
		else
			window.props.subContainer.visible = true
			window.props.size = savedSize
			isCollapsed = true
		end

		window.render()
	end
end

self.addWindow = function(props)
	local window = newWindow(props)
	
	self.applyDraggable(window, window.topBar)
	self.applyResizable(window)
	window.props.icons[2]:on("mouseLeftDown", self.applyMinimization(window))
	window.props.icons[1]:on("mouseLeftUp", function()
		self.container:destroy()
	end)

	return self
end

self.newWindow = newWindow

return self