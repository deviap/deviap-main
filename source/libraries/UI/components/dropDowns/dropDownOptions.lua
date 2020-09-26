local newDropdown = require("devgit:source/libraries/UI/components/dropDowns/dropDown.lua")
local newButton = require("devgit:source/libraries/UI/components/buttons/secondaryButton.lua")
local newState = require("devgit:source/libraries/state/main.lua")

local count = function(x)
	local c = 0 for _,_ in next, x do c = c + 1 end return c
end

local function reducer(state, action)
	if action.type == "clear" then
		return nil
	elseif action.type == "selectButton" then
		return action.newButton
	end
	
	return nil
end

return function(props)
	local self = newDropdown(props)

	self._buttons = {}
	self.addButton = function(tag)
		local button = newButton({
			parent = self.menu,
			text = tag,
		})

		self._buttons[tag] = button

		return button
	end

	self.removeButton = function(tag)
		self._buttons[tag].destroy()
		self._buttons[tag] = nil
	end

	self.getButton = function(tag)
		return self._buttons[tag]
	end

	local oldRender = self.render
	self.render = function()
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
		r1.selectedButton = reducer(state, action)

		return r1
	end)

	self.render()
	return self
end