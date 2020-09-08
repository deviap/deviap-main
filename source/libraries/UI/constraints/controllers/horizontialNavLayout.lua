local newTabResolver = require("tevgit:source/libraries/UI/constraints/tabResolver.lua")

local count = function(x)
	--[[
		@description
			Counts the number of fields in a given table. Why does this need-
		@parameter
			table, x
		@returns
			integer, c
	]]
	local c = 0
	for _,_ in next, x do
		c = c + 1
	end
	return c
end


local function createNavBar()
	--[[
		@description
			Make a new navbar.
		@parameter
			nil
		@returns
			nil
	]]
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
	--[[
		@description
			It makes a new horizontial layout with a nav-bar.
		@parameter
			nil
		@returns
			table, public
	]]
	local public = {}

	local resolver = newTabResolver()
	resolver.registerAnchorTab("y", "start", 0)
	resolver.registerRelativeTab("y", "end", "start", 0, 50)
	resolver.registerRelativeTab("y", "neverEnding", "end", 0, math.huge)

	public.container = core.construct("guiFrame")
	public.secondaryObject = nil

	public.navBar = createNavBar()
	public.navBar.container.parent = public.container

	public.refresh = function()
		--[[
			@description
				Refreshes the layout.
			@parameter
				nil
			@returns
				nil
		--]]

		
		if public.secondaryObject then
			public.secondaryObject.parent = public.container
			print(public.container.absoluteSize.y)
			local resolved = resolver.resolveForAxis("y", public.container.absoluteSize.y)

			public.navBar.container.size = guiCoord(1, 0, 0, resolved["end"])
			public.navBar.container.position = guiCoord(0, 0, 0, 0)

			public.secondaryObject.position = guiCoord(0, 0, 0, resolved["end"])
			public.secondaryObject.size = guiCoord(1, 0, 0, resolved["neverEnding"])
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