-- Copyright 2020 - Deviap (deviap.com)
-- Author(s): utrain, Sanjay-B(Sanjay)

-- Creates a primary button instance
local newBaseButton = require("tevgit:source/libraries/UI/components/buttons/baseButton.lua")

return function(props)
	-- Defaults
	props.containerBackgroundColour = colour.hex("#333333")
	props.secondaryColour = colour(1, 1, 1)
	props.containerBackgroundAlpha = 1
	props.borderWidth = 2

	local self = newBaseButton(props)

	self.container:on("mouseEnter", function() self.state.dispatch { type = "hover" } end)
	self.container:on("mouseExit", function() self.state.dispatch { type = "unhover" } self.state.dispatch { type = "deactivate" } end)
	self.container:on("mouseLeftDown", function() self.state.dispatch { type = "activate" } end)
	self.container:on("mouseLeftUp", function() self.state.dispatch { type = "deactivate" } end)

	self.state.subscribe(function(state)
		if state.enabled then
			props.secondaryColour = colour(1, 1, 1)

			if state.active then
				props.containerBackgroundColour = colour.hex("#4f4f4f")
				props.borderAlpha = 1
				props.borderInset = 5
			elseif state.hovering then
				props.containerBackgroundColour = colour.hex("#424242")
				props.borderAlpha = 0.4
				props.borderInset = 4
			else
				props.containerBackgroundColour = colour.hex("#333333")
				props.borderAlpha = 0
				props.borderInset = 2
			end
		else -- disabled
			props.containerBackgroundColour = colour.hex("#E0E0E0")
			props.secondaryColour = colour.hex("EAEAEA")
			props.borderAlpha = 0
		end

		self.render()
	end)
	
    self.render()

	return self
end