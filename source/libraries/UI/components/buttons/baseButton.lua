-- Copyright 2020 - Deviap (deviap.com)
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
	state = state or {enabled = true, active = false, hover = false}

	local newState = {enabled = state.enabled, active = state.active, hovering = state.hovering}

	if action.type == "enable" then
		newState.enabled = true
	elseif action.type == "disable" then
		newState.enabled = false
	elseif action.type == "activate" then
		newState.active = true
	elseif action.type == "deactivate" then
		newState.active = false
	elseif action.type == "hover" then
		newState.hovering = true
	elseif action.type == "unhover" then
		newState.hovering = false
	elseif action.type == "reset" then
		newState.enabled = true
		newState.active = false
		newState.hovering = false
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

	self.tooltip = nil

	-- Determine fixed sizing based on props.
	if props.text ~= "" then
		self.container.size = guiCoord(0, 178, 0, 48)

		-- Instance tooltip component when size fits icon button.
	else
		self.container.size = guiCoord(0, 48, 0, 48)

		-- If tooltip is specified in props, create tooltip.
		if props.tooltip then
			self.tooltip = tooltip {
				parent = self.container,
				position = guiCoord(
								0.5, (self.container.size.offset.x / 2) - 53, 0.5, (self.container.size.offset.y / 2) + 5),
				text = props.tooltip
			}
			self.tooltip.state.dispatch {type = "disable"}
			self.container:on("mouseEnter", function() self.tooltip.state.dispatch {type = "enable"} end)
			self.container:on("mouseExit", function() self.tooltip.state.dispatch {type = "disable"} end)
		end
	end

	local label = core.construct("guiTextBox", {active = false, parent = self.container})

	local icon = core.construct("guiIcon", {active = false, parent = self.container})

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
		icon.iconId = props.iconId or ""
		icon.iconColour = props.secondaryColour

		oldRender()
	end

	self.render()

	return self
end
