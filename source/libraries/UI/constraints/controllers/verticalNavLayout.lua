local newTabResolver = require("tevgit:source/libraries/UI/constraints/tabResolver.lua")

local count = function(x)
	local c = 0
	for _,_ in next, x do
		c = c + 1
	end
	return c
end


local function createNavBar()
	--local resolver = newTabResolver()
	local public = {}

	public.offset = 5
	public.container = core.construct("guiFrame")

	public.refresh = function()
		--[[
			@description
				Refreshes the container.
			@parameter
				nil
			@returns
				nil
		]]

		local i = 0
		local objects = public.container.children
		local width = public.container.absoluteSize.x / count(objects)
		for _, object in next, objects do
			object.parent = public.container
			object.size = guiCoord(0, width - public.offset, 0, 1)
			object.position = guiCoord(0, width * i, 0, 0)
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
	resolver.registerAnchorTab("x", "start", 0)
	resolver.registerRelativeTab("x", "end", "start", 0, 50)
	resolver.registerRelativeTab("x", "neverEnding", "end", 0, math.huge)

	public.container = core.construct("guiFrame")
	public.secondaryObject = nil

	public.navBar = createNavBar()
	public.navBar.container.parent = public.container

	public.refresh = function()
		--[[
			@description
				Refreshes the layout.
		--]]

		
		if public.secondaryObject then
			public.secondaryObject.parent = public.container
			local resolved = resolver.resolveForAxis("x", public.container.absoluteSize.x)

			public.navBar.container.size = guiCoord(0, resolved["end"], 1, 0)
			public.navBar.container.position = guiCoord(0, 0, 0, 0)

			public.secondaryObject.position = guiCoord(0, resolved["end"], 0, 0)
			public.secondaryObject.size = guiCoord(0, resolved["neverEnding"] - resolved["end"], 1, 0)
		end

		public.navBar.refresh()
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