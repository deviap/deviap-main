return function(props)
	props = props or {}
	props.canvasOffset = vector2(0, 0)
	props.canvasSize = guiCoord(1, 0, 1, 200)
	props.scrollBarAlpha = 1
	props.scrollBarColour = colour(1,1,1)
	props.scrollBarWidth = 8
	props.scrollBarPadding = 1

	local self = {}
	self.container = core.construct("guiFrame", {parent = props.parent, size = guiCoord(0, 200, 0, 400), clip = true})
	self.canvas = core.construct("guiFrame", { parent = self.container })
	local scrollBarContainerY = core.construct("guiFrame", { parent = self.container})
	local scrollBarY = core.construct("guiFrame", { parent = scrollBarContainerY })
	-- local scrollBarContainerY = core.construct("guiFrame")
	-- local scrollBarY = core.construct("guiFrame")

	self.render = function()
		self.container.parent = props.parent
		self.canvas.size = props.canvasSize

		local containerSize = self.container.absoluteSize
		local canvasSize = self.canvas.absoluteSize

		if canvasSize.y > containerSize.y then
			
			scrollBarContainerY.visible = true
			scrollBarContainerY.size = guiCoord(0, props.scrollBarWidth, 1, 0)
			scrollBarContainerY.position = guiCoord(1, -props.scrollBarWidth, 0, 0)
			scrollBarY.size = guiCoord(0, props.scrollBarWidth - props.scrollBarPadding, 0, canvasSize.y / containerSize.y)
			scrollBarY.position = guiCoord(0, 0, props.canvasOffset.y / canvasSize.y, 0)
			self.canvas.size = props.canvasSize + guiCoord(0, -props.scrollBarWidth, 0, 0)
		end
	end

	self.render()
	return self
end