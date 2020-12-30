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
			parent = parent,
			size = guiCoord(0, 400, 0, 400),
			position = guiCoord(0, 50, 0, 0),
		
			defaultBackgroundColour = colour(0.0, 0.0, 0.0),
			defaultTextColour = colour(0.9, 0.9, 0.9),
			defaultIconColour = colour(1, 1, 1),
			backgroundColour = colour(0, 0, 0),
			scrollbarColour = colour(1,1,1),
		
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

			hierarchy = fileHierarchy
		}
	end
}