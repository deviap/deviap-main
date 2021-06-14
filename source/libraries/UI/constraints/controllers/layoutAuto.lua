-- Copyright 2021 - Deviap (deviap.com)
-- Attribution: https://www.youtube.com/watch?v=CGsEJToeXmA
return function()
	--[[
		@description
			Makes a gridlayout
		@parameter
			nil
		@returns
			nil
	]]

	local public = {}
	public.container = core.construct("guiScrollView", {
		size = guiCoord(1, 0, 1, 0)
	})
	public.rows = 3
	public.columns = 3
	public.cellSize = vector2(100, 100)
	public.cellSpacing = vector2(10, 10)
	public.fitX = false
	public.fitY = true
	public.wrap = false

	public.refresh = function()
		--[[
			@description
				Refreshes the layout with updated positions.
			@parameters
				nil
			@returns
				nil
		]]

		local children = public.container.children

		if public.fitX then
			public.cellSize.x = public.container.absoluteSize.x / public.columns
		end

		if public.fitY then
			public.cellSize.y = public.container.absoluteSize.y / public.rows
		end

		local x = 0
		local y = 0

		local offset = guiCoord(0, 0, 0, 0)

		for i = 1, #children do
			local child = children[i]
			child.position = guiCoord(0, public.cellSize.x * x, 0, public.cellSize.y * y) + offset
			child.size = guiCoord(0, public.cellSize.x, 0, public.cellSize.y)
			x = x + 1

			offset.offset = offset.offset + vector3(public.cellSpacing.x, 0)
			if x >= public.columns or
							(public.wrap and (public.cellSize.x * (x + 1)) + offset.offset.x > public.container.absoluteSize.x) then
				x = 0
				y = y + 1
				offset.offset = vector2(0, offset.offset.y + public.cellSpacing.y)
			end

			child.backgroundColour = public.cellColour or child.backgroundColour
			child.backgroundAlpha = public.cellBackgroundAlpha or child.backgroundAlpha
		end
	end

	public.container:on("childAdded", public.refresh)
	public.container:on("childRemoved", public.refresh)
	public.container:on("changed", public.refresh)
	core.input:on("screenResized", public.refresh)

	return public
end
