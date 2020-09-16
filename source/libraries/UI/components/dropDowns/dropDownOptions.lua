local newDropdown = require("devgit:source/libraries/UI/components/dropDown.lua")
local newState = require("devgit:source/libraries/state/main.lua")

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
	end
	self.removeButton = function(tag)
		self._buttons[tag].destroy()
		self._buttons[tag] = nil
	end
	self.getButton = function(tag)
		-- Case you want to bind to hover to preview option?
	end

	self.state = newState(reducer)

	local oldRender = self.render
	self.render = function()
		local heightOfButton = self.menu.absoluteSize.y / #self._buttons

		local i = 0
		for _, button in next, self._buttons do
			button.size = guiCoord(1, 0, 0, heightOfButton)
			button.position = guiCoord(0, 0, 0, heightOfButton * i)
		end

		oldRender()
	end

	return self
end