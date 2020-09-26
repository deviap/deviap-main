-- Copyright 2020 - Deviap (deviap.com)
-- Author(s): utrain, Sanjay-B(Sanjay)
-- Creates a primary button instance
local newTextInput = require(
                         "devgit:source/libraries/UI/components/textInput.lua")

return function(props)
    props.step = props.step or 10
    props.max = props.max or 100
    props.min = props.min or 0
    props.value = props.value or 50
    props.text = tostring(props.value)

    local self = newTextInput(props)

    local inputContainer = self.container:child("inputContainer")
    local icon = inputContainer:child("icon")

    icon.position = guiCoord(1, -50, 0, 0)
    icon.size = guiCoord(0, 20, 1, 0)

    local increaseContainer = core.construct("guiFrame", {
        name = "increase",
        parent = inputContainer,
        position = guiCoord(1, -30, 0, 0),
        size = guiCoord(0, 30, 0.5, 0),
        backgroundAlpha = 0,
        clip = true
    })

    local increaseBtn = core.construct("guiIcon", {
        name = "btn",
        active = false,
        parent = increaseContainer,
        iconId = "arrow_drop_up",
        position = guiCoord(0, 0, 1, -14),
        size = guiCoord(0.9, 0, 0, 16),
        iconMax = 16,
        iconColour = colour.hex("161616")
    })

    local decreaseContainer = increaseContainer:clone{
        name = "decrease",
        parent = inputContainer,
        position = guiCoord(1, -30, 0.5, 0)
    }

    local decreaseBtn = decreaseContainer:child("btn")
    decreaseBtn.iconId = "arrow_drop_down"
    decreaseBtn.position = guiCoord(0, 0, 0, -2)

    decreaseContainer:on("mouseLeftUp", function()
        props.value = math.max(props.min, props.value - props.step)
        self.input.text = tostring(props.value)
        self.validate()
    end)

    increaseContainer:on("mouseLeftUp", function()
        props.value = math.min(props.max, props.value + props.step)
        self.input.text = tostring(props.value)
        self.validate()
    end)

    self.input:on("keyUp", function() self.validate() end)

    self.validate = function()
        if tonumber(self.input.text) == nil then
            self.state.dispatch {
                type = "invalidate",
                error = "Number is not valid"
            }
        else
            props.value = tonumber(self.input.text)

            if props.value < props.min then
                self.state.dispatch {
                    type = "invalidate",
                    error = "Must not be less than " .. props.min
                }
            elseif props.value > props.max then
                self.state.dispatch {
                    type = "invalidate",
                    error = "Must not be greater than " .. props.max
                }
            else
                self.state.dispatch {type = "validate"}
            end
        end
    end

    local oldRender = self.render
    self.render = function() oldRender() end

    return self
end
