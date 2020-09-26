-- Copyright 2020 - Deviap (deviap.com)

local count = function(x)
	local c = 0
	for _,_ in next, x do
		c = c + 1
	end
	return c
end

return function()
	--[[
		@description
			Creates a new horizontialLayoutAuto that automatically fits itself.
			So, that means there is no minimum or maximum really.

		@returns
			table, interface
	]]

	local public = {}
	local objects = {}

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
		local width = public.container.absoluteSize.y / count(objects)
		for _, object in next, objects do
			object.parent = public.container
			object.size = guiCoord(1, 0, 0, width)
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

	public.addObject = function(tag, object)
		--[[
			@description
				Add object
			@parameter
				string, tag
					Tag.
				guiObject, object
					Object.
			@return
				nil
		]]

		objects[tag] = object
	end

	public.selectObject = function(tag)
		--[[
			@description
				select object

			@parameter
				string, tag
					Tag.
			@return
				guiObject, object
		]]

		return objects[tag]
	end

	public.removeObject = function(tag)
		--[[
			@description
				remove object

			@parameter
				string, tag
					Tag.
			@return
				guiObject, object
		]]

		local object = objects[tag]
		objects[tag] = nil
		return object
	end

	return public
end