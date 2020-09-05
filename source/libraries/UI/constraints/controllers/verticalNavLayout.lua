local newTabResolver = require("tevgit:source/libraries/UI/constraints/controllers/verticalNavLayout.lua")

local function createNavBar()
	local resolver = newTabResolver()
	local public = {}

	public.offset = 5
	public.container = core.construct("guiFrame")

	public.refresh = function()
		--[[
			@description
				Refreshes the container.
		]]

		local i = 0
		local width = public.container.absoluteSize.y / count(objects)
		for _, object in next, objects do
			object.parent = public.container
			object.size = guiCoord(1, 0, 0, width - public.offset)
			object.position = guiCoord(0, 0, 0, width * i)
			i = i + 1
		end
	end

	public.destroy = function(destroyChildren)
		--[[
			@description
				Destroys the layout and what it stands for.

			@parameter
				boolean, destroyChildren
					If true, will destroy the children. Otherwise, it will de-parent the children
					and return them back to you.
			
			@return
				table, [children]
		]]

		local children = public.container.children
		
		if destroyChildren then
			object:destroyChildren()
			object:destroy()
		else
			for _, object in next, children do
				object.parent = nil
			end
			object:destroy()
			
			return children
		end
	end
	
	return public
end

return function()
	local public = {}

	local resolver = newTabResolver()
	resolver.registerAnchorTab("y", "start", 0)
	resolver.registerRelativeTab("y", "end", "start", public.min, public.max)
	resolver.registerRelativeTab("y", "neverEnding", 0, math.huge)

	public.container = core.construct("guiFrame")
	public.secondaryObject = nil
	public.min = 0
	public.max = 50

	public.navBar = createNavBar()

	public.refresh = function()
		--[[
			@description
				Refreshes the layout.
		--]]

		public.navBar.refresh()
		if public.secondaryObject then
			local resolved = resolver.resolveForAxis("y", public.container.absoluteSize.y)
			public.navBar.container.size = guiCoord(1, 0, 0, resolved["end"])
			public.navBar.container.position = guiCoord(0, 0, 0, resolved["end"])
			public.container.size = guiCoord(1, 0, 0, resolved["neverEnding"])
		end
	end

	public.destroy = function(destroyChildren)
		--[[
			@description
				Destroys the layout and what it stands for.

			@parameter
				boolean, destroyChildren
					If true, will destroy the children. Otherwise, it will de-parent the children
					and return them back to you.
			
			@return
				table, [children]
		--]]

		local children = public.container.children
		
		if destroyChildren then
			object:destroyChildren()
			object:destroy()
		else
			for _, object in next, children do
				object.parent = nil
			end
			object:destroy()
			
			return children
		end
	end
	

	return public
end