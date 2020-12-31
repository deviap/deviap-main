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
	hierarchy.text = root.name
	hierarchy.iconId = "stop"
	hierarchy.siginature = root
	hierarchy.isExpanded = true
	hierarchy.children = {}

	for _, child in next, root.children do
		table.insert(hierarchy.children, {
			text = child.name,
			iconId = "stop",
			siginature = child,
			hasDescendants = #child.children > 0,
			children = {}
		})
	end

	return hierarchy
end

return {
	construct = function(props)
		local hierarchyMenu
		hierarchyMenu = require("./hierarchy.lua"){
			parent = props.parent,
			size = guiCoord(0, 200, 0, 400),
			position = guiCoord(0, 40, 0, 0),
		
			defaultBackgroundColour = colour.hex("FFFFFF"),
			defaultTextColour = colour(0, 0, 0),
			defaultIconColour = colour(0, 0, 0),
			backgroundColour = colour.hex("FFFFFF"),
			scrollbarColour = colour(0.5, 0.5, 0.5),
		
			buttonHeight = 25,
			insetBy = 10,
		
			onButtonDown1 = function(node)
				if node.isExpanded then
					node.isExpanded = false
					node.children = {}
				else
					node.isExpanded = true
					for _, child in next, node.siginature.children do
						table.insert(node.children, {
							text = child.name,
							iconId = "stop",
							siginature = child,
							hasDescendants = #child.children > 0,
							children = {}
						})
					end
				end
		
				hierarchyMenu.render()
			end,

			onButtonEnter = function(child, button)
				child.backgroundColour = colour.hex("F0F0F0")
				button.propsThenRender {
					backgroundColour = child.backgroundColour
				}
			end,
		
			onButtonExit = function(child, button)
				child.backgroundColour = nil
				button.propsThenRender {
					backgroundColour = hierarchyMenu.props.defaultBackgroundColour
				}
			end,

			hierarchy = {parseSceneToHierarchy(core.interface)}
		}
	end
}