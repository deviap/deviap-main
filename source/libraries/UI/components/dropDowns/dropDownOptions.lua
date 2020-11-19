-- Copyright 2020 - Deviap (deviap.com)

local newDropdown = require("devgit:source/libraries/UI/components/dropDowns/dropDown.lua")
local newButton = require("devgit:source/libraries/UI/components/buttons/secondaryButton.lua")
local newState = require("devgit:source/libraries/state/main.lua")

local count = function(x)
	--[[
		@description
			Counts total entries in a table
		@parameter
			table, x
		@returns
			integer, c
	]]
	local c = 0 for _,_ in next, x do c = c + 1 end return c
end

local function reducer(state, action)
	--[[
		@description
			Given a state and action, reduce to new state.
		@parameter
			any, state
			table, action
		@returns
			any, newState
	]]

	if action.type == "clear" then
		return nil
	elseif action.type == "selectButton" then
		return action.newButton
	end
	
	return state
end

return function(props)
	--[[
		@description
			Makes a new dropdown menu with options to select.
		@parameters
			table, props
		@returns
			table, interface
	]]

	props.text = props.text or "Choose an option..."
	props.secondaryColour = colour(0.3, 0.3, 0.3)
	props.containerBackgroundColour =  colour(1, 1, 1)
	props.borderAlpha = 1
	props.borderInset = 1
	props.borderWidth = 1
	props.helperText = props.helperText or ""
	props.size = props.size or guiCoord(0, 288, 0, 40)

	local self = newDropdown(props)

	local helper = core.construct("guiTextBox", {
		parent = self.container,
		size = guiCoord(1, 0, 0, 24),
		backgroundAlpha = 1,
		textColour = props.secondaryColour,
		text = props.helperText,
	})

	self._buttons = {}
	self.addButton = function(tag)
		--[[
			@description
				Add a new button.
			@parameters
				string, tag
			@returns
				table, buttonInterface
		]]
		local button = newButton({
			parent = self.menu,
			text = tag,
		})

		button.state.subscribe(function(state)
			if state.active then
				self.state.dispatch({ type = "selectButton", newButton = tag })
			end
		end)

		self._buttons[tag] = button

		return button
	end

	self.removeButton = function(tag)
		--[[
			@description
				Remove a button.
			@parameters
				string, tag
			@returns
				nil
		]]
		self._buttons[tag].destroy()
		self._buttons[tag] = nil
	end

	self.getButton = function(tag)
		--[[
			@description
				Get a button
			@parameters
				string, tag
			@returns
				table, buttonInterface
		]]
		return self._buttons[tag]
	end

	local oldRender = self.render
	self.render = function()
		helper.textColour = props.secondaryColour
		helper.text = props.helperText

		if props.helperText ~= "" then
			helper.visible = true
			helper.size = guiCoord(1, 0, 0, 24)
			helper.position = guiCoord(0, 0, 0, -24)
			self.container.size = props.size
			self.container.position = props.position + guiCoord(0, 0, 0, 24)
		else
			helper.visible = false
			helper.size = guiCoord(1, 0, 0, 24)
			helper.position = guiCoord(0, 0, 0, -24)
			self.container.size = props.size
			self.container.position = props.position + guiCoord(0, 0, 0, 24)
		end
	
		local heightOfButton = self.menu.absoluteSize.y / count(self._buttons)

		local i = 0
		for _, button in next, self._buttons do
			button.container.size = guiCoord(1, 0, 0, heightOfButton)
			button.container.position = guiCoord(0, 0, 0, heightOfButton * i)
			i = i + 1
		end

		oldRender()
	end

	local oldReducer = self.state.getReducer()
	self.state.replaceReducer(function(state, action)
		local r1 = oldReducer(state, action)
		r1.selectedButton = reducer(state.selectedButton, action)

		return r1
	end)

	self.state.subscribe(function(state)
		self.menu.visible = false
		props.text = state.selectedButton or "Choose an option..."
		props.iconId = "expand_more"
		props.borderAlpha = 1
		props.borderInset = 1
		props.borderWidth = 1

		if state.enabled then
			props.secondaryColour = colour(0.3, 0.3, 0.3)

			if state.active then
				self.menu.visible = true
				props.containerBackgroundColour = colour(0.9, 0.9, 0.9)
				props.iconId = "expand_less"
			elseif state.hovering then
				self.menu.visible = false
				props.containerBackgroundColour =  colour(0.95, 0.95, 0.95)
			else
				props.containerBackgroundColour =  colour(1, 1, 1)
				self.menu.visible = false
			end
		else -- disabled
			self.menu.visible = false
			props.text = "Disabled"
			props.containerBackgroundColour = colour.hex("#E0E0E0")
			props.secondaryColour = colour.hex("FFFFFF")
		end

		self.render()
	end)

	self.render()
	return self
end
