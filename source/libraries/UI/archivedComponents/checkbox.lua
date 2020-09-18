-- Copyright 2020 - Deviap (deviap.com)
-- Author(s): Sanjay-B(Sanjay)

-- Creates a checkbox instance

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
		text = state.text or "Checkbox item"
	}

	-- Might want to change to a lookup table.
	if action.type == "enabled" then
		newState.enabled = true
	elseif action.type == "hover" then
        newState.hovering = true
    elseif action.type == "unhover" then
		newState.hovering = false
	elseif action.type == "activate" then
		newState.active = true
	elseif action.type == "focusActivate" then
		newState.enabled = true
	elseif action.type == "disabled" then
		newState.enabled = false
	elseif action.type == "skeleton" then
		newState.enabled = false
	elseif action.type == "setText" then
		newState.text = action.text
	end

	return newState
end

return function(props)
	--[[
		@description
			Checkbox with states
		@parameter
			table, props
		@returns
			table, component
	]]

	local self = createBaseComponent(props)
	
    self.container = core.construct("guiFrame", self.props)
    
    self.selected = false

    core.construct("guiFrame", {
        name = "box",
        parent = self.container,
        size = guiCoord(0, 16, 0, 16),
        position = guiCoord(0, 2, 0, 1),
        strokeColour = colour.hex("#212121"),
        strokeWidth = 1,
        strokeAlpha = 1
    })

    core.construct("guiIcon", {
        name = "boxIcon",
        parent = self.container:child("box"),
        size = guiCoord(1, 0, 1, 0),
        position = guiCoord(0, 0, 0, 0),
        iconId = "check",
        iconMax = 10,
        iconColour = colour.hex("#FFFFFF"),
        backgroundColour = colour.hex("#212121"),
        backgroundAlpha = 1,
        visible = false
    })

    core.construct("guiTextBox", {
        name = "textBox",
        parent = self.container,
        size = guiCoord(1, -25, 1, 0),
        position = guiCoord(0, 25, 0, 0),
        backgroundAlpha = 1,
        text = self.text
    })
    
	
	self.states = newState(reducer, { enabled = true })
	
	self.container:child("box"):on("mouseEnter", function() self.states.dispatch({ type = "hover" }) end)
    self.container:child("box"):on("mouseExit", function() self.states.dispatch({ type = "unhover" }) self.states.dispatch({ type = "deactivate" }) end)
    self.container:child("box"):on("mouseLeftUp", function() self.states.dispatch({ type = "deactivate" }) end)
    self.container:child("box"):on("mouseLeftDown", function() self.states.dispatch({ type = "activate" }) end)

	self.render = function(state)
        self.container:child("textBox").text = state.text

        if state.enabled then
			self.container:child("box").strokeAlpha = 1
            self.container:child("textBox").textColour = colour.hex("#212121")
            self.container:child("box"):child("boxIcon").backgroundColour = colour.hex("#212121")
		else
            self.container:child("box").strokeAlpha = 0.1
            self.container:child("textBox").textColour = colour.hex("#E0E0E0")
            self.container:child("box"):child("boxIcon").backgroundColour = colour.hex("#E0E0E0")
		end
        
        if state.active then
            self.container:child("box"):child("boxIcon").visible = true
            core.tween:begin(self.container:child("box"), 0.1, {
                strokeColour = colour.hex("#212121")
            }, "outCirc")
            self.selected = not self.selected
        else
            if state.hovering then
				core.tween:begin(self.container:child("box"), 0.1, {
                    strokeColour = colour.hex("#03A9F4")
                }, "outCirc")
            else
				core.tween:begin(self.container:child("box"), 0.1, {
                    strokeColour = colour.hex("#212121")
                }, "outCirc")
			end
		end
	end

	self.states.subscribe(self.render)
	self.states.dispatch({ type = "enabled" })
    return self
end