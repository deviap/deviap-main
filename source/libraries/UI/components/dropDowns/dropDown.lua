local newButton = require("devgit:source/libraries/UI/components/buttons/baseButton.lua")

return function(props)
	local self = newButton(props)

	-- TODO: Layer a main frame that changes size and another frame that is child to be the actual menu.
	self.menu = core.construct("guiFrame", {
		visible = false,
		parent = self.container,
		size = guiCoord(0, 100, 0, 100),
		position = guiCoord(0, 0, 1, 0),
		backgroundColour = colour.random() -- debug
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
				props.borderInset = 5
			elseif state.hovering then
				self.menu.visible = false
				props.containerBackgroundColour = colour.hex("#14b1f7")
				props.borderInset = 4
			else
				props.containerBackgroundColour = colour.hex("#03A9F4")
				self.menu.visible = false
				props.borderAlpha = 0
				props.borderInset = 2
			end
		else -- disabled
			self.menu.visible = false
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

		menuContainer
			elementA
			elementB
]]