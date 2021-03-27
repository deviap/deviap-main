---------------------------------------------------------------
-- Copyright 2021 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------
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

	local hoverColour = colour.hex("212121")
	local self = newBaseComponent(props)
    self.container.size = props.size
    self.container.position = props.position
	self.container.backgroundAlpha = 0
	self.container.backgroundColour = colour.hex("FFFFFF")
	self.container.strokeRadius = 5
	self.container.strokeWidth = 1

	self.tooltip = nil

    local item = core.construct("guiIcon", {
        parent = self.container,
        name = "icon",
        position = guiCoord(0, 0, 0, 0),
        size = guiCoord(1, 0, 1, 0),
		iconColour = props.iconColour,
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

        item.iconMax = props.iconMax
		item.iconId = props.iconId
		item.iconColour = props.iconColour
    end

    self.state.subscribe(function(state)
		self.render()
		if state.enabled then
			if state.mode == "hover" then
				item.iconColour = hoverColour
				self.container.backgroundAlpha = 1
            elseif state.mode == "idle" then
				item.iconColour = props.iconColour
				self.container.backgroundAlpha = 0
			elseif state.mode == "selected" and props.redirect then
				item.iconColour = hoverColour
				props.redirect()
			end
		else -- disabled
			item.iconColour = colour.hex("#E0E0E0")
		end
    end)
    
	self.render()

	return self
end