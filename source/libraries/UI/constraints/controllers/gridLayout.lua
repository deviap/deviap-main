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
	public.container = core.construct("guiFrame")
	public.rows = 3
	public.columns = 3
	public.cellSize = vector2(100, 100)
	public.cellSpacing = vector2(10, 10)
	public.fitX = false
	public.fitY = true

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
			public.cellSize.x = public.container.absoluteSize.x / public.rows - public.cellSpacing.x
		end

		if public.fitY then
			public.cellSize.y = public.container.absoluteSize.y / public.columns - public.cellSpacing.x
		end

		local x = 0
		local y = 0

		for i = 1, #children do
			local child = children[i]
			child.position = guiCoord(0, public.cellSize.x * x, 0, public.cellSize.y * y)
			child.size = guiCoord(0, public.cellSize.x , 0, public.cellSize.y)
			x = x + 1
			
			
			if x >= public.rows then
				x = 0
				y = y + 1
			end
			
		end
	end

	return public
end