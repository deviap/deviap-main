-- Inspiration: https://www.youtube.com/watch?v=CGsEJToeXmA

return function()
	local public = {}
	public.container = core.construct("guiFrame")
	public.cellSize = vector2(0, 0)
	public.cellSpacing = vector2(0, 0)
	public.padding = vector2(0, 0)
	public.fitX = true
	public.fitY = true
	
	public.update = function()

	end

	return public
end