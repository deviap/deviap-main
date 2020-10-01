local libs = require("scripts/libraries.lua")
local windowManager = libs("windowManager")
local tabs = libs("components").tabs
local state = libs("state")
local theme = libs("theme")

local reducer = function(state, action)
	--[[
		selectedTab

	]]
end

local self = {}

self.state = state(reducer)

self.addSecton = function(container)

end

return self