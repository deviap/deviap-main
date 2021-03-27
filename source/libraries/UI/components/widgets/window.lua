-- Copyright 2021 - Deviap (deviap.com)
-- Window component

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
			name = "icon",
			position = guiCoord(1, -17, 0, 0),
			size = guiCoord(0, 16, 0, 16),
			iconColour = colour.white(),
			backgroundColour = colour.hex("ef5350"),
			backgroundAlpha = 1,
			iconId = "close",
			iconMax = 9,
			iconAlpha = 0.5,
		})	
	}

	props.icons[1]:on("mouseLeftDown", function()
		self.container.visible = false
    end)
    props.icons[1]:on("mouseEnter", function()
        props.icons[1].iconAlpha = 1
	end)
    props.icons[1]:on("mouseExit", function()
        props.icons[1].iconAlpha = 0.5
	end)

	self.topBar:on("mouseLeftDown", function()
		local offset = core.input.mousePosition - self.topBar.absolutePosition
		local move = core.input:on("mouseMoved", function()
			local newPosition = core.input.mousePosition
			self.props.position = guiCoord(0, newPosition.x - offset.x, 0, newPosition.y - offset.y)
			self.render()
		end)

		core.input:on("mouseLeftUp", function() 
			core.disconnect(move)	
		end)
	end)
	
	do
		local minimumSpace = vector2(40, props.topBarHeight + 4)
		local draggableSpace = props.draggableSpace or 8
	
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
				local left = props.position.offset
				local right = props.size.offset + left
	
				if direction.x == 1 then
					props.size = guiCoord(0, math.max(mousePosition.x - left.x, minimumSpace.x), 0, props.size.offset.y)
				elseif direction.x == -1 then
					props.position = guiCoord(0, mousePosition.x, 0, props.position.offset.y)
					props.size = guiCoord(0, math.max(right.x - mousePosition.x, minimumSpace.x), 0, props.size.offset.y)
				end
	
				if direction.y == 1 then
					props.size = guiCoord(0, props.size.offset.x, 0, math.max(mousePosition.y - left.y, minimumSpace.y))
				elseif direction.y == -1 then
					props.position = guiCoord(0, props.position.offset.x, 0, mousePosition.y)
					props.size = guiCoord(0, props.size.offset.x, 0, math.max(right.y - mousePosition.y, minimumSpace.y))
				end
	
				self.render()
			end)
		end)
	end

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

		if props.content then
			props.content.parent = self.container
			props.content.size = guiCoord(1, -4, 1, -(props.topBarHeight + 2))
			props.content.position = guiCoord(0, 2, 0, props.topBarHeight)
		end
	end

	self.props = props

	self.render()
	return self
end