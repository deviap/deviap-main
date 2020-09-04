local createTabResolver = require("tevgit:source/libraries/UI/constraints/tabResolver.lua");
	
return function()
	local public = {}
	local tabResolver = createTabResolver()
	tabResolver.registerAnchorTab("x", "0", 0)

	public.container = core.construct("guiFrame")
	public.refresh = function()

	end
	public.destroy = function()

	end
end