local newTabulars = require("tevgit:source/libraries/UI/constraints/tabResolver.lua")
local count = function(x)
	local c = 0
	for _,_ in next, x do
		c = c + 1
	end
	return c
end

local controllers =
{
    horizontialLayoutAuto = function()
        local public = {}
        public.container = core.construct("guiFrame")
        
       -- local constraints = newTabulars()

        public.refresh = function()
			local i = 0
			local width = public.container.absoluteSize.y / count(pubic.objects)

			for _, object in next, public.objects do
				object.parent = public.container
				object.size = guiCoord(1, 0, 0, width)
				object.position = guiCoord(0, 0, 0, width * i)
				i = i + 1
			end
		end

		public.destroy  = function()
			local children = public.container.children
			
			for _, object in next, children do
				object.parent = nil
			end

			object:destroy()
			return children
        end
        
        public.objects = {}
        return public
	end;
	
	horizontialLayout = function()
		local public = {}
		public.container = core.construct("guiFrame")
		local constraints = newTabulars()
		--constraints.registerAbsoluteTab("x", "0", 0)
		constraints.registerAbsoluteTab("y", "0", 0)

		public.refresh = function()
			local tabs = constraints.tabs
			local count = count(tabs.x) - 1

			if count > #objects then
				for i = count, #objects, -1 do
					constraints.removeTab("y", tostring(i))
				end
			elseif count < #objects then
				for i = count, #objects, 1 do
					constraints.registerRelativeTab("y", tostring(i), tostring(i - 1), public.min, public.max)
				end
			end

			local i = 1
			local resolved = constraints.resolveForAxis("y", public.container.absoluteSize.y)
			for _, object in next, public.objects do
				object.size = guiCoord(1, 0, 0, resolved[tostring(i - 1)] - resolved[tostring(i)])
				object.position = guiCoord(0, 0, 0, resolved[tostring(i)])
				i = i + 1
			end
		end

		public.destroy = function()
			local children = public.container.children
			
			for _, object in next, children do
				object.parent = nil
			end

			object:destroy()
			return children
        end
		
		public.objects = {}
		public.maxX = 0
		public.maxY = 0
		
		return public
	end
}

local new = function(controllerName, ...)
    return controllers[controllerName](...)
end

return new