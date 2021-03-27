-- Copyright 2021 - Deviap (deviap.com)
-- Author(s): Sanjay-B(Sanjay)
-- Creates an editApp component.
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

	props.containerBackgroundColour = colour.hex("#E5E5E5")
	props.secondaryColour = colour.hex("#000000")
	props.title = props.title or "Untitled Group"
	props.name = props.name or "JohnDoe"
	props.thumbnail = props.thumbnail or ""

	local self = newBaseComponent(props)
	self.state = newState(reducer)

	local titleLabel = core.construct("guiTextBox", {
		parent = self.container,
		active = false,
		backgroundAlpha = 0,
		textColour = colour.hex("#212121"),
		size = guiCoord(1, -12, 0, 18),
		position = guiCoord(0, 6, 1, -29),
		textFont = "deviap:fonts/openSansBold.ttf",
		textSize = 14
	})

	local ownerLabel = core.construct("guiTextBox", {
		parent = self.container,
		active = false,
		backgroundAlpha = 0,
		textColour = colour.hex("#212121"),
		size = guiCoord(1, -12, 0, 18),
		position = guiCoord(0, 6, 1, -16),
		textFont = "deviap:fonts/openSansRegular.ttf",
		textSize = 11
	})

	local thumbnail = core.construct("guiImage", {
		parent = self.container,
		active = false,
		backgroundAlpha = 0.5,
		backgroundColour = colour(1, 0, 0),
		size = guiCoord(1, 0, 1, -30),
		position = guiCoord(0, 0, 0, 0)
	})

	local subContainer = core.construct("guiTextBox", {
		parent = self.container,
		active = false,
		backgroundColour = colour.hex("#E5E5E5"),
		size = guiCoord(1, 0, 0, 15),
        position = guiCoord(0, 0, 1, -15),
        text = "DETAILS",
        textFont = "deviap:fonts/openSansBold.ttf",
        textSize = 14,
        textAlign = "middle",
		visible = false
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

		titleLabel.text = props.title
		ownerLabel.text = "By: "..props.name
		thumbnail.image = props.thumbnail
	end
	
	self.state.subscribe(function(state)
		if state.enabled then
			if state.mode == "hover" then
				titleLabel.visible = false
				ownerLabel.visible = false
				thumbnail.size = guiCoord(1, 0, 1, -15)
				subContainer.visible = true
			elseif state.mode == "idle" then
				titleLabel.visible = true
				ownerLabel.visible = true
				thumbnail.size = guiCoord(1, 0, 1, -30)
				subContainer.visible = false
			end
		else -- disabled
		end

		self.render()
	end)

	self.render()

	return self
end
