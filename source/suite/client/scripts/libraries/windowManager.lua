local libs = require("scripts/libraries.lua")
local newWindow = libs("window")
--[[
	state = 
	{
		focused
		minimized
		hidden
	}
]]
local reducer = function(state, action)
	state = state or {focused = false, minimized = false, closed = false}
	local newState = { focused = state.focused, minimized = state.minimized, closed = state.closed }

	if action.type == "set" then
		newState[action.name] = action.value
	end

	return newState
end


local self = {}

self.addWindow = function(props)
	return newWindow(props)
end

return self