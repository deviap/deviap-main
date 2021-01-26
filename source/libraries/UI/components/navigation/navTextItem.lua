---------------------------------------------------------------
-- Copyright 2021 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------
-- Author(s): Sanjay-B(Sanjay)
-- Creates a navTextItem instance
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

    local item = core.construct("guiTextBox", {
        parent = self.container,
        name = "textBox",
        position = guiCoord(0, 0, 0, 0),
        size = guiCoord(1, 0, 1, 0),
        textColour = colour.hex("#FFFFFF"),
        textAlign = "middle",
        textSize = 15,
        backgroundAlpha = 0
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

        item.text = props.text
        --item.textColour = props.textColour
    end

    self.state.subscribe(function(state)
		if state.enabled then
			if state.mode == "hover" then
				item.textColour = colour.hex("#0f62fe")
            elseif state.mode == "idle" then
                item.textColour = props.textColour
            elseif state.mode == "selected" and props.redirect then
				props.redirect()
			end
		else -- disabled
			item.textColour = colour.hex("#E0E0E0")
		end

		self.render()
    end)
    
	self.render()

	return self
end