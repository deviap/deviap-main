-- Copyright 2020 - Deviap (deviap.com)

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
	
    props.containerBackgroundColour = colour.hex('ffffff')
    props.secondaryColour = colour.hex('000000')
    props.borderAlpha = 0.1
    props.name = props.name or "Unnamed App"
    props.image = props.image or ""

    local self = newBaseComponent(props)
   
	local label = core.construct("guiTextBox", {
        name                = "label",
        parent              = self.container,
        active              = false,
        backgroundAlpha     = 0,
        textColour          = colour.hex("000"),
        size                = guiCoord(1, -12, 0, 18),
        position            = guiCoord(0, 6, 1, -24),
        text                = "label",
        textFont            = "deviap:fonts/openSansBold.ttf",
        textSize            = 18
    })

	local image = core.construct("guiImage", {
        name                = "image",
        parent              = self.container,
        active              = false,
        backgroundAlpha     = 0,
        size                = guiCoord(1, 0, 1, -30),
        position            = guiCoord(0, 0, 0, 0)
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
        
        label.text = props.name
        image.image = props.image

        oldRender()
	end

	self.render()
	
	return self
end