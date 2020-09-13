return function(props)
	--[[
		@description
			Creates a base component
		@parameter
			table, props
		@returns
			table, component
	]]

	props.containerBackgroundColour = props.containerBackgroundColour or colour.hex("#03A9F4")
	props.containerBackgroundAlpha = props.containerBackgroundAlpha or 1
	props.secondaryColour = props.secondaryColour or colour(1, 1, 1)
	props.borderWidth = props.borderWidth or 1
	props.borderAlpha = props.borderAlpha or 0
	props.borderInset = props.borderInset or 2

	local self = {}
	self.container = core.construct("guiFrame", {
		parent = props.parent,
		backgroundColour = props.containerBackgroundColour,
		backgroundAlpha = props.containerBackgroundAlpha
	})

	local border = core.construct("guiFrame", {
		parent = self.container,
		active = false,
		backgroundAlpha = 0,
		size = guiCoord(1, -props.borderInset * 2, 1, -props.borderInset * 2),
		position = guiCoord(0, props.borderInset, 0, props.borderInset),
		strokeColour = props.secondaryColour,
		strokeAlpha = props.borderAlpha,
		strokeWidth = props.borderWidth,
	})

	self.render = function()
		--[[
			@description
				Renders the component
			@parameter
				nil
			@returns
				nil
		]]

		-- Make into tweens later. I want to first kill myself.
		self.container.backgroundColour = props.containerBackgroundColour
		self.container.backgroundAlpha = props.containerBackgroundAlpha

		border.position = guiCoord(0, props.borderInset, 0, props.borderInset)
		border.size = guiCoord(1, -props.borderInset * 2, 1, -props.borderInset * 2)
		border.strokeColour = props.secondaryColour
		border.strokeAlpha = props.borderAlpha
		border.strokeWidth = props.borderWidth
	end

	self.props = props

	return self
end