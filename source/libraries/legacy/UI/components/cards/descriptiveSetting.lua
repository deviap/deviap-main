-- Copyright 2020 - Deviap (deviap.com)
-- Author(s): Sanjay-B(Sanjay)
-- Creates an descriptiveSetting component.
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

	props.containerBackgroundColour = colour.hex("#E5E5E5")
	props.secondaryColour = colour.hex("#000000")
	props.header = props.header or ""
    props.description = props.description or ""
	props.child = props.child or nil

    local self = newBaseComponent(props)
    self.container.size = guiCoord(0, 510, 0, 50)
    self.container.backgroundAlpha = 0

	local headerLabel = core.construct("guiTextBox", {
		parent = self.container,
		active = false,
        backgroundAlpha = 0,
        backgroundColour = colour.rgb(255, 0, 0),
		textColour = colour.hex("#212121"),
		size = guiCoord(0, 300, 0, 20),
		position = guiCoord(0, 0, 0, 0),
		textFont = "deviap:fonts/openSansBold.ttf",
        textSize = 20,
        textAlpha = 0.8
    })
    
    local descriptionLabel = core.construct("guiTextBox", {
		parent = self.container,
		active = false,
        backgroundAlpha = 0,
        backgroundColour = colour.rgb(0, 255, 0),
		textColour = colour.hex("#212121"),
		size = guiCoord(0, 300, 0, 75),
		position = guiCoord(0, 0, 0, 25),
		textFont = "deviap:fonts/openSansRegular.ttf",
        textSize = 14,
        textAlpha = 0.5
    })
    
    if props.child then
		props.child.container.parent = self.container
    end


	self.render = function()
		--[[
			@description
				Renders the component
			@parameter
				nil
			@returns
				nil
		]]
		
		headerLabel.text = props.header
		descriptionLabel.text = props.description
	end

	self.render()

	return self
end
