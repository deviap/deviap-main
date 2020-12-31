---------------------------------------------------------------
-- Copyright 2020 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------

local extensionWhitelist = {
	["lua"] = true,
	["json"] = true,
	--["DS_Store"] = true,
}

local extensionColours = {
	["json"] = colour.hex("6c97ab"),
	["lua"] = colour.hex("6fb7d9"),
	["DS_Store"] = colour.hex("636161"),
	[""] = colour.hex("636161"), -- Binary
}

local folderColour =colour.hex("ebc860")

local parseFileToHierarchy = function()
	local fileHierarchy = {}
	local tags = {}

	for _, directory in next, core.io:list() do
		directory = "/"..directory -- Pattern-Matching

		local rootChildren = fileHierarchy
		for subDirectory, isFolder in directory:gmatch("/([^/]+)(/?)") do
			local extension = subDirectory:match("%.(.+)$")

			if extension == nil or extensionWhitelist[extension] then
				extension = extension or (not isFolder and "")

				local node = tags[subDirectory]
				if node == nil then
					node = {
						text = subDirectory;
						iconId = extension and "insert_drive_file" or "folder";
						iconColour = extensionColours[extension] 
							or folderColour;
						_extension = extension;
						children = {}
					}
					tags[subDirectory] = node
					rootChildren[#rootChildren + 1] = node
				end

				rootChildren = node.children
			end
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