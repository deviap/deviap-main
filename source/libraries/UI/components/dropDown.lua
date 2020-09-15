local newButton = require("devgit:source/libraries/UI/components/buttons/baseButton.lua")

return function(props)
	local self = newButton(props)

	-- Make a frame be the container and have a seperate menu frame
	-- Reason: cool transition effect for opening, makes it gradually appear without changing size.
	self.menu = core.construct("guiFrame", {
		visible = false,
		backgroundColour = colour.random(),
		parent = self.container,
		position = guiCoord(0, 0, 1, 0),
		active = false,
		zIndex = 100
	})

	self.container:on("mouseEnter", function() self.state.dispatch { type = "hover" } end)
	self.container:on("mouseExit", function() self.state.dispatch { type = "unhover" } end)
	self.container:on("mouseLeftDown", function() 
		if self.state.getState().active then
			self.state.dispatch { type = "deactivate" }
		else
			self.state.dispatch { type = "activate" } 
		end
	end)

	self.state.subscribe(function(state)
		self.menu.visible = false

		if state.enabled then
			props.secondaryColour = colour(1, 1, 1)

			if state.active then
				self.menu.visible = true
				props.containerBackgroundColour = colour.hex("#12a4e6")
				props.borderAlpha = 1
				props.borderInset = 5
			elseif state.hovering then
				props.containerBackgroundColour = colour.hex("#14b1f7")
				props.borderAlpha = 0.4
				props.borderInset = 4
			else
				props.containerBackgroundColour = colour.hex("#03A9F4")
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


	return self
end

--[[
	container
		border
		
		buttonText
		buttonIcon

		menuContainer (0, 0, 1, 0)
			elementA
			elementB
]]