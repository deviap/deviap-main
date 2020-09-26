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
	state = state or {enabled = true, active = false, valid = true, error = ""}

	local newState = {
		enabled = state.enabled,
		active = state.active,
		valid = state.valid,
		error = state.error
	}

	if action.type == "enable" then
		newState.enabled = true
	elseif action.type == "disable" then
		newState.enabled = false
	elseif action.type == "activate" then
		newState.active = true
	elseif action.type == "deactivate" then
		newState.active = false
	elseif action.type == "invalidate" then
		newState.valid = false
		newState.error = action.error or ""
	elseif action.type == "validate" then
		newState.valid = true
		newState.error = nil
	elseif action.type == "reset" then
		newState.enabled = true
		newState.active = false
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
	props.placeholder = props.placeholder or ""
	props.label = props.label or ""
	props.helper = props.helper or ""
	props.text = props.text or ""

	local self = newBaseComponent(props)
	self.container.backgroundAlpha = 0
	self.container.size = guiCoord(0, 178, 0, 48)

	local label = core.construct(
              					"guiTextBox", {
						name = "label",
						parent = self.container,
						active = false,
						backgroundAlpha = 0,
						textColour = colour.hex("525252"),
						size = guiCoord(1, 0, 0, 14),
						position = guiCoord(0, 0, 0, -18),
						text = "label",
						textSize = 14
					})

	local helper = core.construct(
               					"guiTextBox", {
						name = "helper",
						parent = self.container,
						active = false,
						backgroundAlpha = 0,
						textColour = colour.hex("525252"),
						size = guiCoord(1, 0, 0, 14),
						position = guiCoord(0, 0, 1, 2),
						text = "helper",
						textSize = 14
					})

	local inputContainer = core.construct(
                       					"guiFrame", {
						name = "inputContainer",
						parent = self.container,
						active = false,
						backgroundColour = colour.hex("f4f4f4"),
						size = guiCoord(1, 0, 1, 0),
						position = guiCoord(0, 0, 0, 0)
					})

	local input = core.construct(
              					"guiTextBox", {
						name = "input",
						parent = inputContainer,
						backgroundAlpha = 0,
						textColour = colour.hex("161616"),
						size = guiCoord(1, -30, 1, -10),
						position = guiCoord(0, 15, 0, 5),
						textEditable = true,
						textAlign = "middleLeft",
						text = props.text == "" and props.placeholder or props.text
					})

	self.input = input

	local borderBottom = core.construct(
                     					"guiLine", {
						active = false,
						parent = self.container,
						lineColour = colour.hex("8d8d8d"),
						pointA = guiCoord(0, 0, 1, -1),
						pointB = guiCoord(1, 0, 1, -1)
					})

	local activeBorder = core.construct(
                     					"guiFrame", {
						active = false,
						parent = self.container,
						strokeColour = colour.hex("0f62fe"),
						strokeAlpha = 1,
						strokeWidth = 2,
						backgroundAlpha = 0,
						size = guiCoord(1, -4, 1, -4),
						position = guiCoord(0, 2, 0, 2),
						visible = false
					})

	local icon = core.construct(
             					"guiIcon", {
						active = false,
						parent = inputContainer,
						name = "icon",
						iconId = "error",
						position = guiCoord(1, -40, 0, 0),
						size = guiCoord(0, 40, 1, 0),
						iconMax = 16,
						iconColour = colour.hex('da1e28'),
						backgroundAlpha = 1,
						backgroundColour = inputContainer.backgroundColour,
						visible = false
					})

	local isPlaceholder = props.text == ""

	-- Focus the textbox if the user clicks the surrounding area (inc label, helper text)
	self.container:on("mouseLeftUp", function() input:setFocus() end)

	input:on(
					"focused", function()
						if isPlaceholder then
							isPlaceholder = false
							input.text = ""
						end

						self.state.dispatch {type = "activate"}
					end)

	input:on(
					"unfocused", function()
						if input.text == "" then isPlaceholder = true end

						self.state.dispatch {type = "deactivate"}
					end)

	self.state = newState(reducer)

	self.state.subscribe(
					function(state)
						borderBottom.visible = true
						self.render()

						if not state.valid then
							activeBorder.strokeColour = colour.hex("da1e28")
							helper.textColour = colour.hex("da1e28")
							helper.text = state.error
							activeBorder.visible = true
							borderBottom.visible = false
							icon.visible = true
						else
							icon.visible = false
							helper.textColour = colour.hex("525252")
						end

						if state.active then
							activeBorder.strokeColour = colour.hex("0f62fe")
							activeBorder.visible = true
							borderBottom.visible = false
						elseif state.valid then
							activeBorder.visible = false
							borderBottom.visible = true
						end

						if state.enabled then
							label.textAlpha = 1.0
							helper.textAlpha = 1.0
						else
							activeBorder.visible = false
							borderBottom.visible = false
							label.textAlpha = 0.5
							helper.textAlpha = 0.5
						end
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

		if props.size then self.container.size = props.size end

		label.text = props.label
		helper.text = props.helper

		if isPlaceholder then
			input.text = props.placeholder
			input.textAlpha = 0.75
		else
			input.textAlpha = 1.0
		end

		input.textSize = props.textSize
	end

	self.render()

	return self
end
