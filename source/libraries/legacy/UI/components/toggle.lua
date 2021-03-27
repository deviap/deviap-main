-- Copyright 2021 - Deviap (deviap.com)
-- Author(s): Sanjay-B(Sanjay), utrain
-- Creates a button instance
--[[
	core.tween:begin(self.child, 0.1, {
		size = guiCoord(1, -10, 1, -10),
		position = guiCoord(0, 5, 0, 5),
		strokeAlpha = 1,
	}, "outCirc")
]] local newBaseComponent = require("devgit:source/libraries/UI/components/baseComponent.lua")
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
	state = state or {on = false}

	local newState = {on = state.on}

	if action.type == "check" then
		newState.on = true
	elseif action.type == "uncheck" then
		newState.on = false
	elseif action.type == "toggle" then
		newState.on = not newState.on
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
	props.label = props.label or ""
	props.onStatus = props.onStatus or "On"
	props.offStatus = props.offStatus or "Off"
	props.onColour = props.onColour or colour.hex("24a148")
	props.offColour = props.offColour or colour.hex("8d8d8d")
	props.backdropStrokeRadius = props.backdropStrokeRadius or 12
	props.dotStrokeRadius = props.dotStrokeRadius or 9
	props.statusEnabled = props.statusEnabled or false

	-- 5, 2

	local self = newBaseComponent(props)
	self.container.backgroundAlpha = 0
	self.container.size = guiCoord(0, 178, 0, 48)
	self.on = props.on or false

	local label = core.construct("guiTextBox", {
		name = "label",
		parent = self.container,
		active = false,
		backgroundAlpha = 0,
		textColour = colour.hex("525252"),
		size = guiCoord(1, 0, 0, 14),
		position = guiCoord(0, 0, 0, 0),
		textSize = 14
	})

	local backdrop = core.construct("guiFrame", {
		name = "backdrop",
		parent = self.container,
		active = false,
		backgroundColour = colour.hex("8d8d8d"),
		size = guiCoord(0, 48, 0, 24),
		position = guiCoord(0, 0, 0, 18),
		strokeRadius = props.backdropStrokeRadius
	})

	local dot = core.construct("guiFrame", {
		name = "backdrop",
		parent = backdrop,
		active = false,
		backgroundColour = colour.hex("ffffff"),
		size = guiCoord(0, 18, 0, 18),
		position = self.on and guiCoord(1, -21, 0, 3) or guiCoord(0, 3, 0, 3),
		strokeRadius = props.dotStrokeRadius
	})

	local status = core.construct("guiTextBox", {
		name = "status",
		parent = self.container,
		active = false,
		backgroundAlpha = 0,
		textColour = colour.hex("525252"),
		size = guiCoord(1, -58, 0, 24),
		position = guiCoord(0, 58, 0, 18),
		text = "Off",
		textAlign = "middleLeft",
		textSize = 18,
		visible = props.statusEnabled
	})

	self.state = newState(reducer)

	self.container:on("mouseLeftUp", function()
		self.state.dispatch {type = "toggle"}
	end)

	self.state.subscribe(function(state)
		self.on = state.on

		core.tween:begin(dot, 0.1, {
			position = self.on and guiCoord(1, -21, 0, 3) or guiCoord(0, 3, 0, 3)
		}, "inOutQuad")

		self.render()
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

		label.text = props.label
		status.text = self.on and props.onStatus or props.offStatus
		backdrop.backgroundColour = self.on and props.onColour or props.offColour
	end

	self.render()

	return self
end
