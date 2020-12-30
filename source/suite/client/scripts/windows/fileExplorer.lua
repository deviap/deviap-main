---------------------------------------------------------------
-- Copyright 2020 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------
local fileHierarchy = {}
local tags = {}

local parseFileToHierarchy = function(list)
	for _, directory in next, list do
		directory = "/"..directory -- Pattern-Matching

		local rootChildren = fileHierarchy
		for subDirectory in directory:gmatch("/([^/]+)") do
			local node = tags[subDirectory]
			if node == nil then
				node = {
					text = subDirectory;
					iconId = "folder";
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

local hierarchyMenu
hierarchyMenu = require("./hierarchy.lua"){
	parent = core.construct("guiFrame", {
		parent = core.interface,
		zIndex = 10,
		size = guiCoord(1, 0, 1, 0)
	}),
	size = guiCoord(0, 400, 0, 800),
	position = guiCoord(0, 50, 0, 0),

	defaultBackgroundColour = colour(0.0, 0.0, 0.0),
	defaultTextColour = colour(0.9, 0.9, 0.9),
	defaultIconColour = colour(1, 1, 1),
	backgroundColour = colour(0, 0, 0),

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
	hierarchy = parseFileToHierarchy(core.io:list())
}
return function()
	parseFileToHierarchy(core.io:list())
end