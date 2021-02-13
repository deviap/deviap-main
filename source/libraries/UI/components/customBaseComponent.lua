---------------------------------------------------------------
-- Copyright 2021 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------
-- Create a base component instance
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
	props.position = props.position or guiCoord(0, 0, 0, 0)
	props.size = props.size or guiCoord(0, 0, 0, 0)

	local self = {}
	self.container = core.construct("guiGradientFrame", {
		parent = props.parent,
		position = props.position,
        size = props.size,
        backgroundColourB = props.backgroundColourB
	})

	local border = core.construct("guiFrame", {
		parent = self.container,
		active = false,
		backgroundAlpha = 0,
		size = guiCoord(1, -props.borderInset * 2, 1, -props.borderInset * 2),
		position = guiCoord(0, props.borderInset, 0, props.borderInset),
		strokeColour = props.secondaryColour,
		strokeAlpha = props.borderAlpha,
		strokeWidth = props.borderWidth
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

		-- Make into tweens later.
		self.container.backgroundColour = props.containerBackgroundColour
		self.container.backgroundAlpha = props.containerBackgroundAlpha

		border.position = guiCoord(0, props.borderInset, 0, props.borderInset)
		border.size = guiCoord(1, -props.borderInset * 2, 1, -props.borderInset * 2)
		border.strokeColour = props.secondaryColour
		border.strokeAlpha = props.borderAlpha
		border.strokeWidth = props.borderWidth
	end

	self.destroy = function()
		self.container:destroy()
	end

	self.props = props

	return self
end
