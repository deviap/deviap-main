--[[
    !! !! !! !! !! !! !! !! !! !! !! !!  !! !! !! !! !! !! !! !! !! !! !!
    !! MOCKED, UNFINISHED, NOT CREATED AS PER OUR CHOSEN DESIGN SYSTEM !!
    !! !! !! !! !! !! !! !! !! !! !! !!  !! !! !! !! !! !! !! !! !! !! !!
]]

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
    props.containerBackgroundAlpha = 1
    props.containerBackgroundColour = colour(1,1,1)
    props.size = props.size or guiCoord(0, 400, 0, 300)

    local self = newBaseComponent(props)

    self.container.visible = false
    self.container.zIndex = 1000

    self.backdrop = core.construct("guiFrame", {
        parent              = core.interface,
        position            = guiCoord(0, -50, 0, -50),
        size                = guiCoord(1, 100, 1, 100),
        backgroundColour    = colour.black(),
        backgroundAlpha     = 0.5,
        visible             = false,
        zIndex              = 999
    })

    local icon = core.construct("guiIcon", {
        parent              = self.container,
        name                = "close",
        iconId              = "close",
        position            = guiCoord(1, -30, 0, 0),
        size                = guiCoord(0, 30, 0, 30),
        iconMax             = 20,
        iconColour          = colour.black(),
        iconAlpha           = 0.5,
        backgroundAlpha     = 1.0,
        backgroundColour    = props.containerBackgroundColour,
        zIndex              = 100
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
        self.container.size = props.size
        self.container.position = guiCoord(
            0.5 - (props.size.scale.x/2), 
            -props.size.offset.x/2, 
            0.5 - (props.size.scale.y/2),
            -props.size.offset.y/2)

        icon.backgroundColour = props.containerBackgroundColour
        self.container.backgroundAlpha = 1.0
    end

    self.show = function()
        self.container.visible = true
        self.backdrop.visible = true
        self.render()
    end

    self.hide = function()
        self.container.visible = false
        self.backdrop.visible = false
        self.render()
    end

    icon:on("mouseLeftUp", self.hide)

    self.render()

    return self
end
