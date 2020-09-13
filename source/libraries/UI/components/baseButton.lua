-- Copyright 2020 - Deviap (deviap.com)
-- Author(s): Sanjay-B(Sanjay), utrain

-- Creates a button instance

--[[
	core.tween:begin(self.child, 0.1, {
		size = guiCoord(1, -10, 1, -10),
		position = guiCoord(0, 5, 0, 5),
		strokeAlpha = 1,
	}, "outCirc")
]]

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
	state = state or { enabled = true, mode = "idle" }
	local newState = { enabled = state.enabled, mode = state.mode }

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
	props.textSize = props.textSize or 16
	props.text = props.text or ""
	props.iconId = props.iconId or ""
	
	local self = newBaseComponent(props)

	-- Determine fixed sizing based on props.
	if props.text ~= "" then self.container.size = guiCoord(0, 178, 0, 48)
	else self.container.size = guiCoord(0, 48, 0, 48) end

	local label = core.construct("guiTextBox", {
		active = false,
		parent = self.container,
	})
	local icon = core.construct("guiIcon", {
		active = false,
		parent = self.container
	})
	
	self.state = newState(reducer)

	local oldRender = self.render
	self.render = function()
		--[[
			@description
				Renders the component
			@parameter
				nil
			@returns
				nil
		]]

		label.backgroundAlpha = 0
		label.text = props.text
		label.position = guiCoord(0, props.textSize, 0, 0)
		label.textSize = props.textSize
		label.size = guiCoord(0, label.textDimensions.x, 1, 0)
		label.textAlign = "middle"
		label.textColour = props.secondaryColour

		icon.backgroundAlpha = 0
		icon.position = guiCoord(1, -props.textSize * 2, 0, 0)
		icon.size = guiCoord(0, props.textSize, 1, 0)
		icon.iconId = "plus"
		icon.iconColour = props.secondaryColour

		oldRender()
	end

	return self
end