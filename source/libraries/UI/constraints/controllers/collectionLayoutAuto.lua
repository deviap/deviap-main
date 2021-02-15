return function(params)
	local public = {}
	public.container = core.construct("guiScrollView", params)
	public.yGap = 10
	
	public.refresh = function()
		local yOffset = 0
		local widest = 0
		for k,v in next, public.container.children do
			v.position = guiCoord(0, 0, 0, yOffset)
			if v.absoluteSize.x > widest then
				widest = v.absoluteSize.x
			end
			yOffset = yOffset + v.absoluteSize.y + public.yGap
		end
		public.container.canvasSize = guiCoord(
			0,
			widest,
			0,
			yOffset
		)
	end

	public.container:on("childAdded", public.refresh)
	public.container:on("childRemoved", public.refresh)
	core.input:on("screenResized", public.refresh)
	return public
end