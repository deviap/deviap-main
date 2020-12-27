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
	local selected = {}

	props.hierarchy = {}
	props.name = "__SCENE_EXPLORER_DO_NOT_ENTER"
	local hierarchy = newHierarchy(props)

	props.onButtonDown1 = function(node, button, updateHandler)
		if core.input:isKeyDown(enums.keys.KEY_LSHIFT) then
			if selected[node] then
				selected[node] = nil
				node.backgroundColour = nil
			else
				selected[node] = true
				node.backgroundColour = colour(0.8, 0.8, 0.8)
			end
		else
			for k,v in next, selected do
				k.backgroundColour = nil
				selected[k] = nil
			end

			selected[node] = true
			node.backgroundColour = colour(0.8, 0.8, 0.8)

			if node.children and #node.children > 0 then
				node.isExpanded = not node.isExpanded
			end
			hierarchy.render()

		end

		updateHandler()
	end

	local helper
	helper = function(child)
	
		local node = {}
		node.text = child.name
		node.iconId = "stop"
		node.signature = child
		node.children = {}

		if child.name == "__SCENE_EXPLORER_DO_NOT_ENTER" then
			return node
		end

		if child.name == "outputWindow" then
			return node
		end
	
		if #child.children > 0 then
			for k,v in next, child.children do
				node.children[k] = helper(v)
			end
		end

		child:on("childAdded", function(newChild)
			local children = child.children
			if not children[#children] then return end -- Meant object was deleted.
			if hierarchy.getButtonFromSignature(children[#children]) then return end --Was already registered.
			sleep(100)
			print(child.parent.name)
			print(child.parent.parent.name)
			print(child.parent.parent.parent.name)
			print(child.parent.parent.parent.parent.name)
			node.children[#node.children+1] = helper(children[#children]) --OK ERRORS HERE
			hierarchy.render() -- NOT FULL PICTURE
		end)

		-- child:on("childRemoved", function(newChild)
		-- 	local newChildHierarchy = hierarchy.getButtonFromSignature(newChild)
		-- 	for k,v in next, node.children do
		-- 		if v == newChildHierarchy then
		-- 			table.remove(node.children, k)
		-- 			hierarchy.render()
		-- 			break
		-- 		end
		-- 	end
		-- end)
		
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