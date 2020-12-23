---------------------------------------------------------------
-- Copyright 2020 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------
local newHierarchy = require("./hierarchy.lua")

local parseSceneToHierarchy
parseSceneToHierarchy = function(root)
	local hierarchy = {}
	hierarchy.name = root.name
	hierarchy.icon = "stop"
	hierarchy.siginature = root

	if #root.children > 0 then
		hierarchy.children = {}

		for k,v in next, root.children do
			hierarchy.children[k] = parseSceneToHierarchy(v)
		end
	end

	return hierarchy
end

return function(props)
	props.hierarchy = {}
	local hierarchy = newHierarchy(props)

	local helper
	helper = function(child)
		local node = {}
		node.text = child.name
		node.iconId = "stop"
		node.signature = child

		if #child.children > 0 then
			node.children = {}
		
			for k,v in next, child.children do
				node.children[k] = helper(v)
			end
		end

		child:on("childAdded", function(newChild)
			node.children[#node.children+1] = helper(newChild)
			hierarchy.render()
		end)

		child:on("childRemoved", function(newChild)
			local newChildHierarchy = hierarchy.getButtonFromSignature(newChild)
			for k,v in next, node.children do
				if v == newChildHierarchy then
					table.remove(node.children, k)
					hierarchy.render()
					break
				end
			end
		end)
		
		return node
	end

	hierarchy.props.hierarchy = helper(core.interface).children
	hierarchy.render()
	return {
		render = function()
			hierarchy.render()
		end;
		destroy = function()
			hierarchy.destroy()
		end;
		props = props;
	}
end