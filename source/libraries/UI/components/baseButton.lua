-- Copyright 2020 - Deviap (deviap.com)
-- Author(s): Sanjay-B(Sanjay), utrain

-- Creates a button instance

--[[
	core.tween:begin(self.child, 0.1, {
		size = guiCoord(1, -10, 1, -10),
		position = guiCoord(0, 5, 0, 5),
		strokeAlpha = 1,
	}, "outCirc")
]]

local newBaseComponent = require("devgit:source/libraries/UI/components/baseComponent.lua")

return function(props)
	props.fontSize = props.fontSize or 16

	local self = newBaseComponent(props)
	local label = core.construct("guiTextBox")
	local icon = core.construct("guiIcon")

	self.render = function()
		label.backgroundAlpha = 1
		label.text = props.text
		label.position = guiCoord(0, props.fontSize, 0, 0)
		label.size = guiCoord(0, label.textDimnesion.x, 1, 0)
		label.fontSize = props.fontSize
		label.textColour = props.secondaryColour

		icon.backgroundAlpha = 1
		icon.position = guiCoord(0, label.textDimnesion.x + props.fontSize * 2, 0, 0)
		icon.size = guiCoord(props.fontSize, 0,  0, 1)
		icon.iconId = props.iconId
		icon.iconColour = props.secondaryColour

		self.render()
	end

	self.state.subscribe(function(state)
		if state == "enable" then
			--CHANGE PROPS
		elseif state == "disable" then
		elseif state == "hover" then
		elseif state == "active" then
		elseif state == "disable" then
		end

		self.render()
	end)
	return self
end