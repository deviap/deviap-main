-- Copyright 2020 - Deviap (deviap.com)
-- Author(s): Sanjay-B(Sanjay), utrain

-- Creates a button instance

local Component = require("devgit:source/libraries/UI/component.lua")
local State = require("devgit:source/libraries/UI/component-builtins/state.lua")

local function reducer(state, action)
    state = state or "active"
    return action.type or state
end

return function(props)
    local self = Component(props)
    self.container = core.construct("guiFrame", self.props)
    self.child = core.construct("guiTextBox", {
        parent = self.container,
        position = guiCoord(0.5, -60, 0.5, -20),
        size = guiCoord(1, 0, 1, 0),
        text = "    ".."Primary button",
        textAlign = enums.align.middleLeft
    })
    self.visibility = self.container.visible
    self.states = State(reducer, "active")
    self.child:on("mouseEnter", function() self.states.dispatch({ type = "hovered" }) end)
    self.child:on("mouseExit", function() self.states.dispatch({ type = "active" }) end)
    self.child:on("mouseLeftDown", function(newPosition) self.states.dispatch({ type = "focused" }) end)
    self.child:on("mouseLeftUp", function(newPosition) self.states.dispatch({ type = "enabled" }) end)
    self.render = function(state)
        if state == "active" then
            self.container.backgroundColour = colour.hex("#03A9F4")
            self.child.backgroundColour = colour.hex("#03A9F4")
            self.child.textColour = colour.hex("#FFFFFF")
            self.child.position = guiCoord(0, 0, 0, 0)
            self.child.size = guiCoord(1, 0, 1, 0)
            self.child.strokeWidth = 0
            self.child.strokeAlpha = 0
        elseif state == "enabled" then
            self.container.backgroundColour = colour.hex("#03A9F4")
            self.child.backgroundColour = colour.hex("#03A9F4")
            self.child.textColour = colour.hex("#FFFFFF")
            self.child.position = guiCoord(0, 0, 0, 0)
            self.child.size = guiCoord(1, 0, 1, 0)
            self.child.strokeWidth = 0
            self.child.strokeAlpha = 0
        elseif state == "hover" then
            self.container.backgroundColour = colour.hex("#03A9F4")
            self.child.backgroundColour = colour.hex("#03A9F4")
            self.child.textColour = colour.hex("#FFFFFF")
            self.child.position = guiCoord(0, 0, 0, 0)
            self.child.size = guiCoord(1, 0, 1, 0)
            self.child.strokeWidth = 0
            self.child.strokeAlpha = 0
        elseif state == "focused" then
            self.container.backgroundColour = colour.hex("#03A9F4")
            self.child.backgroundColour = colour.hex("#03A9F4")
            self.child.textColour = colour.hex("#FFFFFF")
            self.child.size = guiCoord(1, -10, 1, -10)
            self.child.position = guiCoord(0, 5, 0, 5)
            self.child.strokeColour = colour.hex("#FFFFFF")
            self.child.strokeWidth = 2
            self.child.strokeAlpha = 1
        elseif state == "disabled" then
            self.container.backgroundColour = colour.hex("#E0E0E0")
            self.child.backgroundColour = colour.hex("#E0E0E0")
            self.child.textColour = colour.hex("#8D8D8D")
            self.child.position = guiCoord(0, 0, 0, 0)
            self.child.size = guiCoord(1, 0, 1, 0)
            self.child.strokeWidth = 0
            self.child.strokeAlpha = 0
        end
    end
    return self
end