-- Copyright 2021 - Deviap (deviap.com)
-- Stateless window component.

return function(props)
	--[[
		@description
			Creates a new window component.
		@parameters
			table, props
		@returns
			table, interface
	]]

	props = props or {}	
	props.size = props.size or guiCoord(0, 200, 0, 200)
	props.position = props.position or guiCoord(0, 0, 0, 0)

	props.primaryColour = props.primaryColour or colour(0.25, 0.25, 0.25)
	props.titleColour = props.titleColour or colour.white()

	props.topBarHeight = props.topBarHeight or 18
	props.iconWidth = props.iconWidth or props.topBarHeight - 6
	props.iconSpacing = props.iconSpacing or props.iconWidth / 4

	props.title = props.title or ""

	local self = {}

	self.container = core.construct("guiFrame", {
		parent = props.parent,
		size = props.size,
		position = props.position,
		backgroundColour = props.primaryColour,
	})

	self.topBar = core.construct("guiFrame", {
		parent = self.container,
		size = guiCoord(1, 0, 0, props.topBarHeight),
		backgroundColour = props.primaryColour
	})

	self.title = core.construct("guiTextBox", {
		parent = self.topBar,
		size = guiCoord(1, -(props.iconSpacing * 4 + props.iconSpacing * 3 + 2), 1, 0),
		position = guiCoord(0, 2, 0, 0),
		text = "hello world",
		textColour =  props.titleColour,
		textAlign = "middle",
		textSize = props.topBarHeight - 2,
		backgroundAlpha = 0,
		active = false,
	})

	props.icons = props.icons or
	{
		core.construct("guiIcon", {
			parent = self.topBar,
			iconColour = colour.white(),
			strokeRadius = props.iconWidth / 2,
			backgroundAlpha = 1,
			iconId = "close",
			backgroundColour = colour(0.5, 0.5, 0.5)
		}),
		core.construct("guiIcon", {
			parent = self.topBar,
			iconColour = colour.white(),
			strokeRadius = props.iconWidth / 2,
			backgroundAlpha = 1,
			iconId = "remove",
			backgroundColour = colour(0.5, 0.5, 0.5),
		}),
		core.construct("guiIcon", {
			parent = self.topBar,
			iconColour = colour.white(),
			strokeRadius = props.iconWidth / 2,
			backgroundAlpha = 1,
			iconId = "fullscreen",
			backgroundColour = colour(0.5, 0.5, 0.5)
		})
	}

	self.pushProps = function(newProps)
		--[[
			@description
				Updates the props with the given new props. Will only change what's given.
			@parameter
				table, newProps
			@returns
				nil
		]]

		for propName, propValue in next, newProps do
			self.props[propName] = propValue
		end
	end

	self.render = function()
		--[[
			@description
				Render the component.
			@parameter
				nil
			@returns
				nil
		]]

		self.title.size = guiCoord(1, -(props.iconSpacing * #props.icons + props.iconWidth * #props.icons + 2), 1, 0)
		self.title.text = props.title
		self.title.textColour = props.titleColour
		self.title.textSize = props.topBarHeight - 2

		for placement, icon in next, props.icons do
			icon.parent = self.topBar
			icon.size = guiCoord(0, props.iconWidth, 0, props.iconWidth)
			icon.strokeRadius = props.iconWidth / 2
			icon.position = guiCoord(
				1, 
				-(props.iconSpacing * placement + props.iconWidth * placement), 
				0,
				(props.topBarHeight - props.iconWidth) / 2
			)
		end

		self.topBar.size = guiCoord(1, 0, 0, props.topBarHeight)
		self.topBar.backgroundColour = props.primaryColour

		self.container.parent = props.parent
		self.container.size = props.size
		self.container.position = props.position
		self.container.backgroundColour = props.primaryColour

		if props.subContainer then
			props.subContainer.parent = self.container
			props.subContainer.size = guiCoord(1, -4, 1, -(props.topBarHeight + 2))
			props.subContainer.position = guiCoord(0, 2, 0, props.topBarHeight)
		end
	end

	self.props = props

	self.render()
	return self
end