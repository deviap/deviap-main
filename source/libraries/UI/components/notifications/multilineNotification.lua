-- Copyright 2020 - Deviap (deviap.com)
-- Author(s): Sanjay-B(Sanjay)
-- Creates a multilineNotification instance
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
	state = state or {enabled = false}
	local newState = {enabled = state.enabled}

	if action.type == "enable" then
		newState.enabled = true
	elseif action.type == "disable" then
		newState.enabled = false
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
	props.type = props.type or ""
	props.iconEnabled = props.iconEnabled or false

	local self = newBaseComponent(props)
	self.container.size = guiCoord(0, 300, 0, 35)
	self.container.backgroundColour = colour.hex("#212121")
	self.container.zIndex = 6

	local colourBorder = core.construct("guiFrame", {
		parent = self.container,
		position = guiCoord(0, 0, 0, 0),
		size = guiCoord(0, 3, 1, 0),
		backgroundColour = colour.hex("#0f62fe")
	})

	local headerIcon = core.construct("guiIcon", {
		parent = self.container,
		backgroundAlpha = 0,
		position = guiCoord(0, 10, 0, 6),
		size = guiCoord(0, 18, 0, 18),
		visible = false
	})

	local headerText = core.construct("guiTextBox", {
		parent = self.container,
        backgroundAlpha = 0,
        size = guiCoord(0, 80, 0, 30),
        position = guiCoord(0, 10, 0, 0),
		text = "Info",
		textAlign = "middleLeft",
		textFont = "deviap:fonts/openSansBold.ttf",
		textSize = 12,
		textColour = colour.hex("#ffffff")
	})

	local bodyText = core.construct("guiTextBox", {
		parent = self.container,
		backgroundAlpha = 0,
		position = guiCoord(0, 10, 0, 20),
		text = props.text,
		textSize = 12,
		textWrap = true,
		textMultiline = true,
		textColour = colour.hex("#ffffff")
	})

	local removeIcon = core.construct("guiIcon", {
		parent = self.container,
		position = guiCoord(0, 280, 0, 10),
		size = guiCoord(0, 10, 0, 10),
		iconId = "clear",
		iconColour = colour.hex("#ffffff"),
		backgroundAlpha = 0
	})

	self.state = newState(reducer)

	removeIcon:on("mouseLeftDown", function()
		self.container:destroy()
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

		bodyText.size = guiCoord(0, 160, 0, bodyText.textDimensions.y / 2)
		self.container.size = self.container.size + guiCoord(0, 0, 0, bodyText.textDimensions.y - 5)

		if props.type == "success" then
			colourBorder.backgroundColour = colour.hex("#3DBA61")
			headerText.text = "Success"
			headerText.size = guiCoord(0, headerText.textDimensions.x, 0, 30)

			if props.iconEnabled then
				headerIcon.iconId = "check_circle"
				headerIcon.iconColour = colour.hex("#3DBA61")
				headerIcon.visible = true
				headerText.position = guiCoord(0, 35, 0, 0)
				bodyText.position = guiCoord(0, 35, 0, 20)
			end
		elseif props.type == "warning" then
			colourBorder.backgroundColour = colour.hex("#FDD03A")
			headerText.text = "Warning"
			headerText.size = guiCoord(0, headerText.textDimensions.x, 0, 30)

			if props.iconEnabled then
				headerIcon.iconId = "warning"
				headerIcon.iconColour = colour.hex("#FDD03A")
				headerIcon.visible = true
				headerText.position = guiCoord(0, 35, 0, 0)
				bodyText.position = guiCoord(0, 35, 0, 20)
			end
		elseif props.type == "error" then
			colourBorder.backgroundColour = colour.hex("#F44336")
			headerText.text = "Error"
			headerText.size = guiCoord(0, headerText.textDimensions.x, 0, 30)

			if props.iconEnabled then
				headerIcon.iconId = "error"
				headerIcon.iconColour = colour.hex("#F44336")
				headerIcon.visible = true
				headerText.position = guiCoord(0, 35, 0, 0)
				bodyText.position = guiCoord(0, 35, 0, 20)
			end
		end
	end

	self.render()

	return self
end
