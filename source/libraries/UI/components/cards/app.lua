-- Copyright 2021 - Deviap (deviap.com)
-- Author(s): Sanjay-B(Sanjay)
-- Creates an app component.
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
	props.title = props.title or "Untitled App"
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

	local developerLabel = core.construct("guiTextBox", {
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

	local rateContainer = core.construct("guiFrame", {
		parent = self.container,
		active = false,
		backgroundColour = colour.hex("#FFFFFF"),
		size = guiCoord(1, -41, 0, 7),
		position = guiCoord(0, 4, 1, -11),
		visible = false
	})

	local positiveBar = core.construct("guiFrame", {
		parent = rateContainer,
		active = false,
		backgroundColour = colour.hex("#4CAF50"),
		size = guiCoord(1, -10, 1, 0),
		position = guiCoord(0, 0, 0, 0),
		zIndex = 2
	})

	local negativeBar = core.construct("guiFrame", {
		parent = rateContainer,
		active = false,
		backgroundColour = colour.hex("#F44336"),
		size = guiCoord(1, 0, 1, 0),
		position = guiCoord(0, 0, 0, 0),
		zIndex = 1
	})

	local upButton = core.construct("guiIcon", {
        parent = self.container,
        position = guiCoord(1, -34, 1, -13),
        size = guiCoord(0, 11, 0, 11),
		iconColour = colour.hex("#4CAF50"),
		iconId = "thumb_up",
		visible = false
	})
	
	local downButton = core.construct("guiIcon", {
        parent = self.container,
        position = guiCoord(1, -22, 1, -13),
        size = guiCoord(0, 11, 0, 11),
		iconColour = colour.hex("#F44336"),
		iconId = "thumb_down",
		visible = false
	})
	
	local favoriteButton = core.construct("guiIcon", {
        parent = self.container,
        position = guiCoord(1, -11, 1, -13),
        size = guiCoord(0, 11, 0, 11),
		iconColour = colour.hex("#FFC107"),
		iconId = "bookmark",
		iconAlpha = 0.6,
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
		developerLabel.text = "By: "..props.name
		thumbnail.image = props.thumbnail
	end
	
	self.state.subscribe(function(state)
		if state.enabled then
			if state.mode == "hover" then
				titleLabel.visible = false
				developerLabel.visible = false
				rateContainer.visible = true
				upButton.visible = true
				downButton.visible = true
				favoriteButton.visible = true
			elseif state.mode == "idle" then
				titleLabel.visible = true
				developerLabel.visible = true
				rateContainer.visible = false
				upButton.visible = false
				downButton.visible = false
				favoriteButton.visible = false
			end
		else -- disabled
		end

		self.render()
	end)

	self.render()

	return self
end
