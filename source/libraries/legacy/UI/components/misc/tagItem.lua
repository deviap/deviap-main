-- Copyright 2021 - Deviap (deviap.com)
-- Author(s): Sanjay-B(Sanjay)
-- Creates a tagItem instance
local newBaseComponent = require("devgit:source/libraries/UI/components/baseComponent.lua")
local newState = require("devgit:source/libraries/state/main.lua")
local tooltip = require("devgit:source/libraries/UI/components/tooltip.lua")

local function reducer(state, action)
	--[[
		@description
			Reducers action to a new state
		@parameter
			any, state
			table, action
		@returns
			any, state
	]]
	state = state or {enabled = true, mode = "idle"}
	local newState = {enabled = state.enabled, mode = state.mode}

	if action.type == "enable" then
		newState.enabled = true
	elseif action.type == "disable" then
		newState.enabled = false
	elseif action.type == "setMode" then
		newState.mode = action.mode
	end

	return newState
end

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
    self.container.size = guiCoord(0, 64, 0, 32)
	self.container.position = props.position
	self.container.backgroundAlpha = 0
	
	local primaryColour = props.primaryColour or colour.hex("#212121")
	local secondaryColour = props.secondaryColour or colour.hex("#FFFFFF")

    local tag = core.construct("guiTextBox", {
        parent = self.container,
        position = guiCoord(0, 0, 0, 0),
		size = guiCoord(1, 0, 1, 0),
		backgroundColour = props.secondaryColour,
		strokeAlpha = 1,
		strokeColour = props.primaryColour,
		strokeRadius = 2,
		strokeWidth = 2,
		textAlign = "middle",
		textFont = "deviap:fonts/openSansBold.ttf",
		textSize = 15,
        text = props.text
    })

    tag:on("mouseEnter", function()
		self.state.dispatch {type = "setMode", mode = "hover"}
	end)
	tag:on("mouseExit", function()
		self.state.dispatch {type = "setMode", mode = "idle"}
	end)

    self.state = newState(reducer)
    self.redirect = props.redirect or function() end
    
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

    self.state.subscribe(function(state)
		if state.enabled then
			if state.mode == "hover" then
				tag.textColour = secondaryColour
				tag.strokeColour = secondaryColour
				tag.backgroundColour = primaryColour
			elseif state.mode == "idle" then
				tag.textColour = primaryColour
				tag.strokeColour = primaryColour
				tag.backgroundColour = secondaryColour
			end
		else -- disabled
			--tag.iconColour = colour.hex("#E0E0E0")
		end

		self.render()
    end)
    
	self.render()

	return self
end


