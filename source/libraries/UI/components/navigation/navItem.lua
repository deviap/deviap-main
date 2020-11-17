-- Copyright 2020 - Deviap (deviap.com)
-- Author(s): Sanjay-B(Sanjay)
-- Creates a navItem instance
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
    self.container.size = props.size
    self.container.position = props.position
    self.container.backgroundAlpha = 0

	self.tooltip = nil

    local item = core.construct("guiIcon", {
        parent = self.container,
        name = "icon",
        position = guiCoord(0, 0, 0, 0),
        size = guiCoord(1, 0, 1, 0),
        iconColour = props.iconColour
	})

    if props.tooltip then
        local tempPosition = guiCoord(0, 0, 0, 0)
        if props.navOrientation == "vertical" then
            tempPosition = guiCoord(0.5, (self.container.size.offset.x / 2) + 20, 0.5, (self.container.size.offset.y / 2) - 30)
        elseif props.navOrientation == "horizontal" then 
			tempPosition = guiCoord(0.5, (self.container.size.offset.x / 2) - 43, 0.5, (self.container.size.offset.y / 2) - 82)
        end

        self.tooltip = tooltip {
            parent = self.container,
            position = tempPosition,
            text = props.tooltip
        }
		self.tooltip.state.dispatch {type = "disable"}
		
        item:on("mouseEnter", function()
            self.tooltip.state.dispatch {type = "enable"}
        end)
        item:on("mouseExit", function()
            self.tooltip.state.dispatch {type = "disable"}
        end)
	end

    item:on("mouseEnter", function()
		self.state.dispatch {type = "setMode", mode = "hover"}
	end)
	item:on("mouseExit", function()
		self.state.dispatch {type = "setMode", mode = "idle"}
	end)
	item:on("mouseLeftDown", function()
		self.state.dispatch {type = "setMode", mode = "selected"}
	end)

    self.state = newState(reducer)
	self.redirect = props.redirect
    
	self.render = function()
		--[[
			@description
				Renders the component
			@parameter
				nil
			@returns
				nil
        ]]

        item.iconMax = props.iconMax
        item.iconId = props.iconId
    end

    self.state.subscribe(function(state)
		if state.enabled then
			if state.mode == "hover" then
				item.iconColour = colour.hex("#0f62fe")
            elseif state.mode == "idle" then
                item.iconColour = props.iconColour
            elseif state.mode == "selected" and props.redirect then
				props.redirect()
				print("RAN: ", props.redirect)
			end
		else -- disabled
			item.iconColour = colour.hex("#E0E0E0")
		end

		self.render()
    end)
    
	self.render()

	return self
end