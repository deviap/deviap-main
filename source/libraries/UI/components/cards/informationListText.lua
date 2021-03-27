---------------------------------------------------------------
-- Copyright 2021 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------
-- Creates a card component.
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
    
    props.title = props.title or "Title"
    props.subheadings = props.subheadings or {}

    local self = newBaseComponent(props)
    self.container.backgroundColour = colour.hex("FFFFFF")
    self.container.strokeRadius = 8

    self.state = newState(reducer)

    local heading = core.construct("guiTextBox", {
        parent = self.container,
        position = guiCoord(0, 10, 0, 5),
        size = guiCoord(0, 250, 0, 20),
        backgroundColour = colour.hex("FF0000"),
        backgroundAlpha = 0,
        textSize = 18,
        textFont = "deviap:fonts/openSansBold.ttf",
        textAlign = "middleLeft",
        textColour = colour.hex("212121"),
    })

    for index, subheading in pairs(props.subheadings) do
        local _subheading = core.construct("guiTextBox", {
            parent = self.container,
            position = guiCoord(0, 10, 0, 10+(index*15)),
            size = guiCoord(0, 250, 0, 20),
            backgroundColour = colour.hex("FF0000"),
            backgroundAlpha = 0,
            textSize = 16,
            textFont = "deviap:fonts/openSansRegular.ttf",
            textAlign = "middleLeft",
            textColour = colour.hex("212121"),
        })
        _subheading.text = subheading
    end

	self.container:on("mouseEnter", function()
		self.state.dispatch {type = "setMode", mode = "hover"}
	end)
	self.container:on("mouseExit", function()
		self.state.dispatch {type = "setMode", mode = "idle"}
	end)

	self.render = function()
		--[[
			@description
				Renders the component
			@parameter
				nil
			@returns
				nil
        ]]
        heading.text = props.title
	end
	
	self.state.subscribe(function(state)
		if state.enabled then
			if state.mode == "hover" then
				
			elseif state.mode == "idle" then
				
			end
		else -- disabled
		end

		self.render()
	end)

	self.render()

	return self
end