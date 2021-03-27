-- Copyright 2021 - Deviap (deviap.com)
local newBaseComponent = require("devgit:source/libraries/UI/components/baseComponent.lua")

return function(props)
	--[[
		@description
			Creates a base component
		@parameter
			table, props
		@returns
			table, component
    ]]

	local self = newBaseComponent(props)
	self.container.size = guiCoord(0, 512, 0, 38)
	self.container.backgroundAlpha = 0

	local progressBar = core.construct("guiFrame", {
		name = "progressBar",
		parent = self.container,
		active = true,
		backgroundColour = colour.hex('0f62fe')
	})

	props.progress = props.progress or 0
	props.steps = props.steps or {}
	props.vertical = props.vertical or false

	self.render = function()
		--[[
			@description
				Renders the component
			@parameter
				nil
			@returns
				nil
        ]]

		if props.size then
			self.container.size = props.size
		end

		local s = 1 / #props.steps
		if props.vertical then
			for i, v in pairs(props.steps) do
				v.container.parent = self.container
				v.container.position = guiCoord(0, 6, s * (i - 1), 0)
				v.container.size = guiCoord(1, -6, s, 0)
			end

			progressBar.size = guiCoord(0, 2, props.progress * s, 0)
		else
			for i, v in pairs(props.steps) do
				v.container.parent = self.container
				v.container.position = guiCoord(s * (i - 1), 0, 0, 6)
				v.container.size = guiCoord(s, 0, 1, -6)
			end

			progressBar.size = guiCoord(props.progress * s, 0, 0, 2)
		end
	end

	self.render()

	return self
end
