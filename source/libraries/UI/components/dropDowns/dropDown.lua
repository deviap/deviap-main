local newButton = require("devgit:source/libraries/UI/components/buttons/baseButton.lua")

return function(props)
	--[[
		@description
			Makes a new dropdown menu with options to select.
		@parameters
			table, props
		@returns
			table, interface
	]]

	props.menuHeight = props.menuHeight or 100
	local self = newButton(props)

	-- TODO: Layer a main frame that changes size and another frame that is child to be the actual menu.
	self.menu = core.construct("guiFrame", {
		visible = false,
		parent = self.container,
		size = guiCoord(1, 0, 0, props.menuHeight),
		position = guiCoord(0, 0, 1, 0),
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

	return self
end