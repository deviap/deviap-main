local baseComponent = require("devgit:source/libraries/UI/components/baseComponent.lua")
local state = require("devgit:source/libraries/State/main.lua")

local reducer = function(oldState, action)
	-- Click and drag
	return { unpack(oldState) } -- lol
end

return function(props)
	props.tile1 = props.tile1 or core.construct("guiFrame")
	props.tile2 = props.tile2
	props.tile1Width = 50
	props.orientation = props.orientation or "vertical"

	local self = baseComponent(props)
	local oldRender = self.render

	self.state = state(reducer)

	self.render = function()
		props.tile1.parent = self.container
		if props.tile2 then

		else
			props.tile1.size = guiCoord(1, 0, 1, 0)
		end

		oldRender()
	end

	return self
end

--[[
	{
		l = part
		r = part
		lW or LV = 0
	}
]]