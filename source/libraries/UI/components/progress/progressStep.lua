-- Copyright 2020 - Deviap (deviap.com)
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
	state = state or {enabled = true, mode = "complete"}
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
	props.text = props.text or ""
	props.label = props.label or ""

	local self = newBaseComponent(props)
	self.container.size = guiCoord(0, 120, 0, 38)
	self.container.backgroundAlpha = 0

	local box = core.construct("guiIcon", {
		name = "box",
		parent = self.container,
		active = true,
		iconId = "radio_button_unchecked",
		iconColour = colour.black()
	})

	local textBox = core.construct("guiTextBox", {name = "textBox", parent = self.container, active = false})

	local label = core.construct("guiTextBox", {name = "label", parent = self.container, active = false})

	self.state = newState(reducer)
	self.render = function()
		--[[
			@description
				Renders the component
			@parameter
				nil
			@returns
				nil
        ]]

		box.name = "box"
		box.size = guiCoord(0, 14, 0, 14)
		box.position = guiCoord(0, 2, 0, 2)

		textBox.size = guiCoord(1, -21, 0, 18)
		textBox.position = guiCoord(0, 21, 0, 0)
		textBox.backgroundAlpha = 1
		textBox.text = props.text
		textBox.textSize = 18

		label.size = guiCoord(1, -21, 1, -16)
		label.position = guiCoord(0, 21, 0, 16)
		label.backgroundAlpha = 0
		label.text = props.label
		label.textSize = 16
		label.textAlpha = 0.7
	end

	self.state.subscribe(function(state)
		box.iconColour = colour(0, 0, 0)
		if state.mode == "complete" then
			textBox.textColour = colour.hex('0f62fe')
			box.iconColour = colour.hex('0f62fe')
			box.iconId = "check_circle_outline"
		elseif state.mode == "current" then
			textBox.textColour = colour.hex('0f62fe')
			box.iconColour = colour.hex('0f62fe')
			box.iconId = "lens"
		elseif state.mode == "invalid" then
			box.iconId = "error_outline"
			box.iconColour = colour.hex("#bf1d1d")
		else
			box.iconId = "radio_button_unchecked"
		end

		if not state.enabled then
			textBox.textColour = colour.hex("#c6c6c6")
			label.textColour = colour.hex("#c6c6c6")
			box.iconColour = colour.hex("#c6c6c6")
		end

		self.render()
	end)

	self.render()

	return self
end
