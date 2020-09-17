-- Copyright 2020 - Deviap (deviap.com)
-- Author(s): Sanjay-B(Sanjay)

-- Creates a checkbox instance

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
    props.colour = props.colour or colour.hex("0f62fe")
    props.containerBackgroundAlpha = 1
    props.containerBackgroundColour = colour(1,1,1)
    props.speed = props.speed or 3

    local self = newBaseComponent(props)
    self.container.size = guiCoord(0, 50, 0, 50)

    local shadow = core.construct("guiImage", {
        parent = self.container,
        size = guiCoord(1, -12, 1, -12),
        position = guiCoord(0, 6, 0, 6),
        image = "deviap:img/spinner.png",
        backgroundAlpha = 0,
        imageColour = colour(0, 0, 0),
        imageAlpha = 0.25
    })

    local icon = shadow:clone {
        parent = shadow,
        position = guiCoord(0, 1, 0, 1),
        size = guiCoord(1, -2, 1, -2),
        imageColour = colour(1, 1, 1),
        imageAlpha = 1
    }

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
        icon.imageColour = props.colour
    end

    local spinThread = false
    self.spin = function()
        if not spinThread then
            spinThread = true
            spawn(function()
                while spinThread and sleep() do
                    shadow.rotation = shadow.rotation + math.rad(props.speed)
                end
            end)
        end
    end

    self.stop = function()
        spinThread = false
    end

    self.render()

    return self
end
