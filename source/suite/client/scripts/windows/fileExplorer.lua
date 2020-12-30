---------------------------------------------------------------
-- Copyright 2020 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------

local parseFileToHierarchy = function()
	local fileHierarchy = {}
	local tags = {}

	for _, directory in next, core.io:list() do
		directory = "/"..directory -- Pattern-Matching

		local rootChildren = fileHierarchy
		for subDirectory in directory:gmatch("/([^/]+)") do
			local node = tags[subDirectory]
			if node == nil then
				node = {
					text = subDirectory;
					iconId = subDirectory:match("%.") 
						and "insert_drive_file" 
						or "folder";
					children = {}
				}
				tags[subDirectory] = node
				rootChildren[#rootChildren + 1] = node
			end

			rootChildren = node.children
		end
	end

	return fileHierarchy
end

local fileHierarchy = parseFileToHierarchy()

return { 
	construct = function(parent)
		local hierarchyMenu
		hierarchyMenu = require("./hierarchy.lua"){
			parent = core.interface,
			size = guiCoord(1, 0, 1, 0),
			position = guiCoord(0, 0, 0, 0),
		
			defaultBackgroundColour = colour.hex("FFFFFF"),
			defaultTextColour = colour(0, 0, 0),
			defaultIconColour = colour(0, 0, 0),
			backgroundColour = colour.hex("FFFFFF"),
			scrollbarColour = colour(0.5, 0.5, 0.5),
		
			buttonHeight = 25,
			insetBy = 10,
		
			onButtonDown1 = function(child)
				if child.isExpanded then
					child.isExpanded = false
				else
					child.isExpanded = true
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

			hierarchy = fileHierarchy
		}

		-- This is extremely hacky. We need widgets that can support components.
		hierarchyMenu.container:on("changed", function(propName)
			hierarchyMenu.props[propName] = hierarchyMenu.container[propName]
		end)

		return hierarchyMenu.container
	end
}