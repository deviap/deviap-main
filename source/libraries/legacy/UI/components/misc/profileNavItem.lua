-- Copyright 2020 - Deviap (deviap.com)
-- Author(s): Sanjay-B(Sanjay)
-- Creates a profile instance
local newBaseComponent = require("devgit:source/libraries/UI/components/baseComponent.lua")
local newState = require("devgit:source/libraries/state/main.lua")
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
    self.container.size = props.size
    self.container.position = props.position
	self.container.backgroundColour = colour.hex("#FFFFFF")
	self.container.strokeRadius = 16
    self.container.strokeWidth = 2
    self.container.strokeColour = colour.hex("#E0E0E0")
    self.container.strokeAlpha = 1

    local item = core.construct("guiIcon", {
        parent = self.container,
        position = guiCoord(0, 0, 0, 0),
        size = guiCoord(1, 0, 1, 0),
    })
    
    local avatar = core.construct("guiIcon", {
        parent = item,
        size = guiCoord(1, 0, 1, 0),
        iconColour = colour.hex("#212121"),
        iconMax = 24,
        iconId = "person"
    })
    
    local status = core.construct("guiFrame", {
        parent = item,
        size = guiCoord(0, 10, 0, 10),
        position = guiCoord(1, -8, 1, -8),
        backgroundColour = colour.hex("#00FF00"),
        strokeRadius = 16
    })

    avatar:on("mouseEnter", function()
		self.state.dispatch {type = "setMode", mode = "hover"}
	end)
	avatar:on("mouseExit", function()
		self.state.dispatch {type = "setMode", mode = "idle"}
	end)
	avatar:on("mouseLeftDown", function()
		self.state.dispatch {type = "setMode", mode = "selected"}
	end)

    self.state = newState(reducer)
    self.bindedAction = props.bindedAction or nil
    
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
				avatar.iconColour = colour.hex("#0f62fe")
			elseif state.mode == "idle" then
                avatar.iconColour = colour.hex("#212121")
            elseif state.mode == "selected" and self.bindedAction then
                self.bindedAction()
			end
		else -- disabled
			item.iconColour = colour.hex("#E0E0E0")
		end

		self.render()
    end)
    
	self.render()

	return self
end
