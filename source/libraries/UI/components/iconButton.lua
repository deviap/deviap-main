-- Copyright 2020 - Deviap (deviap.com)
-- Author(s): Sanjay-B(Sanjay)

-- Creates an icon button instance

local createBaseComponent = require("devgit:source/libraries/UI/components/baseComponent.lua")
local State = require("devgit:source/libraries/state/main.lua")

local function reducer(state, action)
	--[[
		@description
			Reduces action to a new state.
		@parameter
			any, state
			table, action
		@returns
			any, newState
	]]

    state = state or "active"
    return action.type or state
end

local buttonStates =
{
	active = function(self)
		self.container.backgroundColour = colour.hex("#03A9F4")
		self.child.backgroundColour = colour.hex("#03A9F4")
		self.child.iconColour = colour.hex("#FFFFFF")
		self.child.position = guiCoord(0, 0, 0, 0)
		self.child.size = guiCoord(1, 0, 1, 0)
		self.child.strokeAlpha = 0
	end,
	enabled = function(self)
		self.container.backgroundColour = colour.hex("#03A9F4")
		self.child.backgroundColour = colour.hex("#03A9F4")
		self.child.iconColour = colour.hex("#FFFFFF")
		self.child.position = guiCoord(0, 0, 0, 0)
		self.child.size = guiCoord(1, 0, 1, 0)
		self.child.strokeAlpha = 0
	end,
	hovered = function(self)
		self.container.backgroundColour = colour.hex("#03A9F4")
		self.child.backgroundColour = colour.hex("#03A9F4")
		self.child.iconColour = colour.hex("#FFFFFF")
		self.child.strokeColour = colour.hex("#FFFFFF")
		self.child.size = guiCoord(1, -10, 1, -10)
		self.child.position = guiCoord(0, 5, 0, 5)
		self.child.strokeWidth = 2
		self.child.strokeAlpha = 0.5
	end,
	focused = function(self)
		self.container.backgroundColour = colour.hex("#03A9F4")
		self.child.backgroundColour = colour.hex("#03A9F4")
		self.child.iconColour = colour.hex("#FFFFFF")
		self.child.size = guiCoord(1, -10, 1, -10)
		self.child.position = guiCoord(0, 5, 0, 5)
		self.child.strokeColour = colour.hex("#FFFFFF")
		self.child.strokeWidth = 2
		self.child.strokeAlpha = 1
	end,
	disabled = function(self)
		self.container.backgroundColour = colour.hex("#E0E0E0")
		self.child.backgroundColour = colour.hex("#E0E0E0")
		self.child.iconColour = colour.hex("#8D8D8D")
		self.child.position = guiCoord(0, 0, 0, 0)
		self.child.size = guiCoord(1, 0, 1, 0)
		self.child.strokeAlpha = 0
	end
}

return function(props)
	--[[
		@description
			Button with states
		@parameter
			table, props
		@returns
			table, component
	]]

	local self = createBaseComponent(props)
	
    self.container = core.construct("guiFrame", self.props)

    self.icon = "plus"

    self.child = core.construct("guiIcon", {
        parent = self.container,
        size = guiCoord(1, 0, 1, 0),
        iconId = self.icon,
        iconMax = 24,
        clip = false
    })

    self.setIcon = function(icon)
        self.icon = icon
        self.child.iconId = icon 
    end

	self.states = State(reducer, "active")
    self.render = function(state)
		buttonStates[state](self)
	end
	
    self.child:on("mouseEnter", function() self.states.dispatch({ type = "hovered" }) end)
    self.child:on("mouseExit", function() self.states.dispatch({ type = "active" }) end)
    self.child:on("mouseLeftDown", function() self.states.dispatch({ type = "focused" }) end)
	self.child:on("mouseLeftUp", function() self.states.dispatch({ type = "enabled" }) end)
	
    return self
end