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
    props.content = props.content or "Content"
	props.titleColour = props.titleColour or colour.hex("212121")
    props.contentColour = props.contentColour or colour.hex("212121")

    local self = newBaseComponent(props)
    self.container.backgroundColour = colour.hex("FFFFFF")
    self.container.strokeRadius = 8

    self.state = newState(reducer)

    local heading = core.construct("guiTextBox", {
        parent = self.container,
        position = guiCoord(0, 10, 0, 5),
        size = guiCoord(0, 240, 0, 20),
        backgroundColour = colour.hex("FF0000"),
        backgroundAlpha = 0,
        textSize = 18,
        textFont = "deviap:fonts/openSansBold.ttf",
        textAlign = "middleLeft",
        textColour = props.titleColour,
    })

    local content = core.construct("guiTextBox", {
        parent = self.container,
        position = guiCoord(0, 10, 0, 27),
        size = guiCoord(0, 240, 0, 60),
        backgroundColour = colour.hex("FF0000"),
        backgroundAlpha = 0,
        textSize = 16,
        textFont = "deviap:fonts/openSansRegular.ttf",
        textAlign = "topLeft",
        textWrap = true,
        textColour = props.contentColour,
    })
    
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
        content.text = props.content
	end
	
	self.state.subscribe(function(state)
		if state.enabled then
			if state.mode == "hover" then
				-- n/a
			elseif state.mode == "idle" then
				-- n/a
			end
		else -- disabled
		end

		self.render()
	end)

	self.render()

	return self
end