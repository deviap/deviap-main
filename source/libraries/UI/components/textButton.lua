-- Copyright 2020 - Deviap (deviap.com)
-- Author(s): Sanjay-B(Sanjay), utrain

-- Creates a button instance

local createBaseComponent = require("devgit:source/libraries/UI/components/baseComponent.lua")
local newState = require("devgit:source/libraries/state/main.lua")

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
	state = state or {}

	local newState = 
	{
		active = state.active, 
		hovering = state.hovering, 
		enabled = state.enabled,
		text = state.text or "    Primary Button"
	}

	-- Might want to change to a lookup table.
	if action.type == "activate" then
		newState.active = true
	elseif action.type == "deactivate" then
		newState.active = false
	elseif action.type == "enable" then
		newState.enabled = true
	elseif action.type == "disable" then
		newState.enabled = false
	elseif action.type == "hover" then
		newState.hovering = true
	elseif action.type == "unhover" then
		newState.hovering = false
	elseif action.type == "setText" then
		newState.text = "    "..action.text
	end

	return newState
end

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

    self.child = core.construct("guiTextBox", {
        parent = self.container,
        size = guiCoord(1, 0, 1, 0),
		textAlign = enums.align.middleLeft,
		strokeWidth = 2,
	})
	
	self.states = newState(reducer)
	
	-- Bind mouse controls to button states
	self.child:on("mouseEnter", function() self.states.dispatch({ type = "hover" }) end)
    self.child:on("mouseExit", function() self.states.dispatch({ type = "unhover" }) self.states.dispatch({ type = "deactivate" }) end)
    self.child:on("mouseLeftUp", function() self.states.dispatch({ type = "deactivate" }) end)
	self.child:on("mouseLeftDown", function() self.states.dispatch({ type = "activate" }) end)

	self.render = function(state)
		self.child.text = state.text

		if state.enabled then
			self.container.backgroundColour = colour.hex("#03A9F4")
			self.child.backgroundColour = colour.hex("#03A9F4")
			self.child.textColour = colour.hex("#FFFFFF")
			self.child.strokeColour = colour.hex("#FFFFFF")
		else
			self.container.backgroundColour = colour.hex("#E0E0E0")
			self.child.backgroundColour = colour.hex("#E0E0E0")
			self.child.textColour = colour.hex("#8D8D8D")
			self.child.strokeColour = colour.hex("#EAEAEA")
		end

		if state.active then
			core.tween:begin(self.child, 0.5, {
				size = guiCoord(1, -10, 1, -10),
				position = guiCoord(0, 5, 0, 5),
				strokeAlpha = 1,
			}, "outCirc")
		else
			if state.hovering then
				core.tween:begin(self.child, 0.5, {
					size = guiCoord(1, -8, 1, -8),
					position = guiCoord(0, 4, 0, 4),
					strokeAlpha = 0.5,
				}, "outCirc")
			else
				core.tween:begin(self.child, 0.5, {
					size = guiCoord(1, 0, 1, 0),
					position = guiCoord(0, 0, 0, 0),
					strokeAlpha = 0,
				}, "outCirc")
			end
		end
	end

    return self
end