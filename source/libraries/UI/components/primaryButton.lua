local newBaseButton = require("tevgit:source/libraries/UI/components/baseButton.lua")

return function(props)
	-- Defaults
	props.containerBackgroundAlpha = 1
	props.borderWidth = 1

	local self = newBaseButton(props)

	self.container:on("mouseEnter", function() self.state.dispatch { type = "setMode", mode = "hover"} end)
	self.container:on("mouseExit", function() self.state.dispatch { type = "setMode", mode = "idle" } end)
	self.container:on("mouseLeftDown", function() self.state.dispatch { type = "setMode", mode = "active"} end)
	self.container:on("mouseLeftUp", function() self.state.dispatch { type = "setMode", mode = "idle" } end)

	self.state.subscribe(function(state)
		if state.enabled then
			if state.mode == "hover" then
				props.containerBackgroundColour = colour.hex("#19a4e3")
				props.containerBackgroundAlpha = 1
				props.secondaryColour = colour(1, 1, 1)
				props.borderWidth = 1
				props.borderAlpha = 0
				props.borderInset = 4
			elseif state.mode == "disable" then
				props.containerBackgroundColour = colour.hex("#03A9F4")
				props.containerBackgroundAlpha = 1
				props.secondaryColour = colour(1, 1, 1)
				props.borderWidth = 1
				props.borderAlpha = 0
				props.borderInset = 4
			elseif state.mode == "focused" then
				props.containerBackgroundColour = colour.hex("#03A9F4")
				props.containerBackgroundAlpha = 1
				props.secondaryColour = colour(1, 1, 1)
				props.borderWidth = 1
				props.borderAlpha = 1
				props.borderInset = 2
			elseif state.mode == "active" then
				props.containerBackgroundColour = colour.hex("#03A9F4")
				props.containerBackgroundAlpha = 1
				props.secondaryColour = colour(1, 1, 1)
				props.borderWidth = 1
				props.borderAlpha = 0
				props.borderInset = 2
			elseif state.mode == "idle" then
				props.containerBackgroundColour = colour.hex("#03A9F4")
				props.containerBackgroundAlpha = 1
				props.secondaryColour = colour(1, 1, 1)
				props.borderWidth = 1
				props.borderAlpha = 1
				props.borderInset = 2
			end
		else -- disabled
			props.containerBackgroundColour = colour.hex("#03A9F4")
			props.containerBackgroundAlpha = 1
			props.secondaryColour = colour(1, 1, 1)
			props.borderWidth = 1
			props.borderAlpha = 0
			props.borderInset = 4
		end

		self.render()
	end)

	return self
end