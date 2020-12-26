---------------------------------------------------------------
-- Copyright 2020 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------
-- Creates Window component.
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
    self.container.size = props.size
    self.container.position = props.position
    self.container.backgroundAlpha = 0
    self.container.zIndex = 10

    local debounce = false

    props.heading = props.heading or ""
    props.strokeRadius = props.strokeRadius or 1
    props.content = props.content or nil


    local container = core.construct("guiFrame", {
        parent = self.container,
        position = guiCoord(0, 0, 0, 0),
        size = guiCoord(1, 0, 1, 0),
        backgroundColour = colour.rgb(255, 0, 0),
        backgroundAlpha = 0,
        strokeColour = colour.hex("E8E8E8"),
        strokeWidth = 5,
        strokeAlpha = 1,
        strokeRadius = props.strokeRadius
    })
    
    local topbar = core.construct("guiFrame", {
        parent = container,
        position = guiCoord(0, 0, 0, 0),
        size = guiCoord(1, 0, 0, 20),
        backgroundColour = colour.hex("E8E8E8")
    })

    local heading = core.construct("guiTextBox", {
        parent = topbar,
        text = props.heading,
        position = guiCoord(0, 0, 0, 0),
        size = guiCoord(0, 0, 0, 0),
        textSize = 16,
        textFont = "deviap:fonts/openSansExtraBold.ttf",
        textAlpha = 0.5,
        backgroundAlpha = 0
    })

    local exitButton = core.construct("guiIcon", {
        parent = topbar,
        name = "icon",
        position = guiCoord(1, -17, 0, 0),
        size = guiCoord(0, 16, 0, 16),
        iconColour = colour.hex("ef5350"),
        iconId = "disabled_by_default",
        iconMax = 14,
        iconAlpha = 0.5,
        strokeColour = colour.hex("ef5350"),
        strokeWidth = 1,
        strokeAlpha = 0.5,
        strokeRadius = props.strokeRadius
	})

    -- Convert to scrollFrame. 
    local contentContainer = core.construct("guiFrame", {
        parent = container,
        position = guiCoord(0, 0, 0, 20),
        size = guiCoord(1, 0, 1, -20),
    })

    -- Mounting Content.
    if props.content then
        props.content.parent = contentContainer
        props.content.size = guiCoord(1, 0, 1, 0)
    end

    -- Movement.
    topbar:on("mouseLeftDown", function(initialPosition)
        if debounce then
            return
        end
        debounce = true
    
        local offset = initialPosition - self.container.absolutePosition
    
        move = core.input:on("mouseMoved", function()
            self.container.position = guiCoord(0, core.input.mousePosition.x - offset.x, 0, core.input.mousePosition.y - offset.y)
        end)
    
        release = core.input:on("mouseLeftUp", function()
            core.disconnect(move)
            core.disconnect(release)
            core.disconnect(down)
            debounce = false
        end)
    end)

    -- Exit.
    exitButton:on("mouseLeftDown", function()
		self.container.visible = false
    end)
    exitButton:on("mouseEnter", function()
        exitButton.iconAlpha = 1
        exitButton.strokeAlpha = 1
	end)
    exitButton:on("mouseExit", function()
        exitButton.iconAlpha = 0.5
        exitButton.strokeAlpha = 0.5
	end)
    
    
	self.render = function()
		--[[
			@description
				Renders the component
			@parameter
				nil
			@returns
				nil
        ]]

    end
    
	self.render()

	return self
end