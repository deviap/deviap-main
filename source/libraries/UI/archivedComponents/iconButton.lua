-- Copyright 2020 - Deviap (deviap.com)
-- Author(s): Sanjay-B(Sanjay)

-- Creates an icon button instance

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
		iconId = state.iconId or "plus"
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
	elseif action.type == "setIconId" then
		newState.iconId = action.iconId
	end

	return newState
end

return function(props)
	--[[
		@description
			Icon Button with states
		@parameter
			table, props
		@returns
			table, component
	]]

	local self = createBaseComponent(props)
	
	self.container = core.construct("guiFrame", self.props)

    self.child = core.construct("guiIcon", {
        parent = self.container,
        size = guiCoord(1, 0, 1, 0),
        iconMax = 24,
        clip = false
    })
	
	self.states = newState(reducer, { enabled = true })
	
	self.child:on("mouseEnter", function() self.states.dispatch({ type = "hover" }) end)
    self.child:on("mouseExit", function() self.states.dispatch({ type = "unhover" }) self.states.dispatch({ type = "deactivate" }) end)
    self.child:on("mouseLeftUp", function() self.states.dispatch({ type = "deactivate" }) end)
	self.child:on("mouseLeftDown", function() self.states.dispatch({ type = "activate" }) end)

	self.render = function(state)
		self.child.iconId = state.iconId

		if state.enabled then
			self.container.backgroundColour = colour.hex("#03A9F4")
			self.child.backgroundColour = colour.hex("#03A9F4")
			self.child.iconColour = colour.hex("#FFFFFF")
			self.child.strokeColour = colour.hex("#FFFFFF")
		else
			self.container.backgroundColour = colour.hex("#E0E0E0")
			self.child.backgroundColour = colour.hex("#E0E0E0")
			self.child.iconColour = colour.hex("#8D8D8D")
			self.child.strokeColour = colour.hex("#EAEAEA")
		end

		if state.active then
			core.tween:begin(self.child, 0.1, {
				size = guiCoord(1, -10, 1, -10),
				position = guiCoord(0, 5, 0, 5),
				strokeAlpha = 1,
			}, "outCirc")
		else
			if state.hovering then
				core.tween:begin(self.child, 0.1, {
					size = guiCoord(1, -8, 1, -8),
					position = guiCoord(0, 4, 0, 4),
					strokeAlpha = 0.5,
				}, "outCirc")
			else
				core.tween:begin(self.child, 0.1, {
					size = guiCoord(1, 0, 1, 0),
					position = guiCoord(0, 0, 0, 0),
					strokeAlpha = 0,
				}, "outCirc")
			end
		end
	end

	self.states.subscribe(self.render)
	self.states.dispatch({ type = "enabled" })
    return self
end