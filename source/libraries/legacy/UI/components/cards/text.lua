-- Copyright 2020 - Deviap (deviap.com)
-- Author(s): Sanjay-B(Sanjay)
-- Creates an text component.
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
    local self = newBaseComponent(props)
    self.container.backgroundAlpha = 0

	local contentLabel = core.construct("guiTextBox", {
		parent = self.container,
        active = false,
        backgroundAlpha = 0,
		textColour = colour.hex("#FF7043"),
		size = props.size,
		position = guiCoord(0, 0, 0, 0),
        textFont = "deviap:fonts/openSansBold.ttf",
        textAlign = "topMiddle",
		textSize = 18,
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
        
        contentLabel.text = props.text
	end

	self.render()

	return self
end
