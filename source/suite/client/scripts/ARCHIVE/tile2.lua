local baseComponent = require("devgit:source/libraries/UI/components/baseComponent.lua")

return function(props)
	props.left = nil
	props.right = nil
	props.orientation = "v"
	props.splitAt = 0.5

	local self = baseComponent(props)

	-- local divider = core.construct("guiFrame", { parent = self.container })
	local oldRender = self.render
	self.render = function()
		if props.left and props.right then
			local left = props.left
			left.parent = self.container
			left.size = guiCoord(
				props.orientation == "v" and 1 or props.splitAt,
				props.orientation == "v" and 0 or -5,
				props.orientation == "v" and props.splitAt or 1,
				props.orientation == "v" and 0 or -5
			)
			left.position = guiCoord(0, 0, 0, 0)

			local right = props.right
			right.parent = self.container
			right.size = guiCoord(
				props.orientation == "v" and 1 or 1 - props.splitAt,
				props.orientation == "v" and 0 or -5,
				props.orientation == "v" and props.splitAt or 1,
				props.orientation == "v" and 0 or -5
			)
			right.position = guiCoord(
				props.orientation == "v" and props.splitAt or 0,
				props.orientation == "v" and 0 or 5,
				props.orientation == "h" and props.splitAt or 0,
				props.orientation == "h" and 0 or 5
			)
		end

		local oneWindow = props.left or props.right
		if oneWindow then
			oneWindow.parent = self.container
			oneWindow.size = guiCoord(1, 0, 1, 0)
			oneWindow.position = guiCoord(0, 0, 0, 0)
		end
		oldRender()
	end

	self.render()

	return self
end