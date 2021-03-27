---------------------------------------------------------------
-- Copyright 2021 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------
-- Loading overlay/screen.
local newBaseComponent = require("devgit:source/libraries/UI/components/baseComponent.lua")

return function(props)
	--[[
		@description
			Creates a base component
		@parameter
			table, props
		@returns
			table, component
	]]
	props.containerBackgroundAlpha = 0.8
	props.containerBackgroundColour = colour(0, 0, 0)
	props.foregroundColour = colour(1, 1, 1)
	props.speed = props.speed or 3
	props.position = guiCoord(0, -150, 0, -150)
	props.text = props.text or "Loading..."

	local self = newBaseComponent(props)
	self.container.size = guiCoord(1, 300, 1, 300)

	local shadow = core.construct("guiImage", {
		parent = self.container,
		size = guiCoord(0, 24, 0, 24),
		position = guiCoord(0.5, -12, 0.5, -12),
		image = "deviap:img/spinner.png",
		backgroundAlpha = 0,
		imageColour = colour(0, 0, 0),
		imageAlpha = 0.25
	})

	local icon = shadow:clone{
		parent = shadow,
		position = guiCoord(0, 1, 0, 1),
		size = guiCoord(1, -2, 1, -2),
		imageAlpha = 1
	}

	local statusText = core.construct("guiTextBox", {
		parent = self.container,
		size = guiCoord(1, 0, 0, 18),
		position = guiCoord(0, 0, 0.5, 15),
		backgroundAlpha = 0,
		textAlign = "middle"
	})
	

	local oldRender = self.render
	self.render = function()
		--[[
			@description
				Renders the component
			@parameter
				nil
			@returns
				nil
        ]]

		oldRender()
		icon.imageColour = props.foregroundColour
		statusText.text = props.text
		statusText.textColour = props.foregroundColour
	end

	self.setText = function(text)
		props.text = text
		self.render()
	end

	spinThread = false
	self.spin = function()
		if not spinThread then
			spinThread = true
			spawn(function()
				while spinThread and sleep() do
					shadow.rotation = shadow.rotation + math.rad(props.speed)
				end
			end)
		end
	end

	self.stop = function()
		spinThread = false
	end

	self.spin()

	self.render()

	self.container.parent = core.interface
	self.container.zIndex = 5999

	return self
end
