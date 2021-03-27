-- Copyright 2021 - Deviap (deviap.com)
-- Author(s): Sanjay-B(Sanjay), utrain
-- Creates a baseButton instance
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
	state = state or {enabled = true, active = false, hover = false}

	local newState = {
		enabled = state.enabled,
		active = state.active,
		hovering = state.hovering
	}

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
	props.strokeRadius = props.strokeRadius or 0
	props.visible = props.visible

	-- Backwards Compatibility
	if props.visible == nil then
		props.visible = true
	end

	local self = newBaseComponent(props)
	self.container.strokeRadius = props.strokeRadius
	self.container.visible = props.visible
	
	self.tooltip = nil

	-- If tooltip is specified in props, create tooltip.
	if props.tooltip then
		self.tooltip = tooltip {
			parent = self.container,
			position = guiCoord(0.5, (self.container.size.offset.x / 2) - 53, 0.5, (self.container.size.offset.y / 2) + 5),
			text = props.tooltip
		}
		self.tooltip.state.dispatch {type = "disable"}
		self.container:on("mouseEnter", function()
			self.tooltip.state.dispatch {type = "enable"}
		end)
		self.container:on("mouseExit", function()
			self.tooltip.state.dispatch {type = "disable"}
		end)
	end

	local label = core.construct("guiTextBox", {
		active = false,
		parent = self.container
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
		label.position = guiCoord(0, ((props.iconId and props.iconId ~= "") and props.textSize or 0) + (props.borderInset * 2), 0, 0)
		label.textSize = props.textSize
		label.size = guiCoord(1, ((props.iconId and props.iconId ~= "") and -props.textSize or 0) - (props.borderInset * 4), 1, 0)
		label.textAlign = props.textAlign or "middleLeft"
		label.textColour = props.secondaryColour
		label.textFont = "deviap:fonts/openSansSemiBold.ttf"

		icon.backgroundAlpha = 0
		icon.position = guiCoord(1, -props.textSize * 2, 0, 0)
		icon.size = guiCoord(0, props.textSize, 1, 0)
		icon.iconId = props.iconId or ""
		icon.iconColour = props.secondaryColour

		if self.tooltip then
			self.tooltip.props.size = guiCoord(0.5, (self.container.size.offset.x / 2) - 53, 0.5, (self.container.size.offset.y / 2) + 5)
			self.tooltip.props.parent = self.container
			self.tooltip.render() --TODO: add text
		end

		oldRender()
	end

	self.render()

	return self
end
