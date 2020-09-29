-- Copyright 2020 - Deviap (deviap.com)
-- This is a test file really, it will have minimal documentation because it will change.

local libs = require("scripts/libraries.lua")
local newWindow = libs("window")
local newState = libs("state")

local function reducer(state, action)
	-- Takes a state and action and reduces a new state.

	state = state or {dragging = false, collapsed = false}
	local newState = {dragging = state.dragging, collapsed = state.collapsed}

	if action.type == "startDrag" then
		newState.dragging = true
	elseif action.type == "endDrag" then
		newState.dragging = false
	elseif action.type == "collapse" then
		newState.collapsed = true
	elseif action.type == "uncollapse" then
		newState.collapsed = false
	end

	return newState
end

local self = {}

self.addWindow = function(props)
	local self = newWindow(props)

	self.state = newState(reducer)

	do -- Drag to move window.
		self.topBar:on("mouseLeftDown", function() self.state.dispatch({ type = "startDrag" }) end)
		core.input:on("mouseLeftUp", function() self.state.dispatch({ type = "endDrag" }) end)

		local move
		self.state.subscribe(function(newState, oldState)
			if newState.dragging then
				local offset = core.input.mousePosition - self.topBar.absolutePosition
				move = core.input:on("mouseMoved", function()
					local newPosition = core.input.mousePosition
					self.props.position = guiCoord(0, newPosition.x - offset.x, 0, newPosition.y - offset.y)
					self.render()
				end)
			else
				if oldState.dragging then
					core.disconnect(move)
				end
			end
		end)
	end

	do -- Minimize
		local savedSize = self.props.size

		self.minimize:on("mouseLeftUp", function()
			if self.state.getState().collapsed then
				self.state.dispatch({ type = "uncollapse" })
			else
				self.state.dispatch({ type = "collapse" })
			end
		end)

		self.state.subscribe(function(state, oldState)
			if state.collapsed and not oldState.collapsed then
				self.props.subContainer.visible = false
				savedSize = self.props.size
				self.props.size = guiCoord(self.props.size.scale.x, self.props.size.offset.x, 0, self.props.topBarHeight) -- VERY DONT DO THIS
			elseif not state.collapsed and oldState.collapsed then
				self.props.subContainer.visible = true
				self.props.size = savedSize
			end

			self.render()
		end)
	end

	do -- Drag to resize window.
		local draggableSpace = 8

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

		core.input:on("mouseLeftDown", function()
			local direction = getDirection(
				core.input.mousePosition, 
				self.container.absolutePosition, 
				self.container.absoluteSize + self.container.absolutePosition
			)

			local onUp
			local onMove

			onUp = core.input:on("mouseLeftUp", function()
				core.disconnect(onMove)
				core.disconnect(onUp)
			end)

			onMove = core.input:on("mouseMoved", function()
				local mousePosition = core.input.mousePosition
				local left = self.props.position.offset
				local right = self.props.size.offset + left

				if direction.x == 1 then
					self.props.size = guiCoord(0, math.max(mousePosition.x - left.x, 44), 0, self.props.size.offset.y)
				elseif direction.x == -1 then
					self.props.position = guiCoord(0, mousePosition.x, 0, self.props.position.offset.y)
					self.props.size = guiCoord(0, math.max(right.x - mousePosition.x, 44), 0, self.props.size.offset.y)
				end
				if direction.y == 1 then
					self.props.size = guiCoord(0, self.props.size.offset.x, 0, math.max(mousePosition.y - left.y, self.props.topBarHeight + 2))
				elseif direction.y == -1 then
					self.props.position = guiCoord(0, self.props.position.offset.x, 0, mousePosition.y)
					self.props.size = guiCoord(0, self.props.size.offset.x, 0, math.max(right.y - mousePosition.y, self.props.topBarHeight + 2))
				end

				self.render()
			end)
		end)
	end

	self.close:on("mouseLeftUp", function()
		self.container:destroy()
	end)

	return self
end

return self