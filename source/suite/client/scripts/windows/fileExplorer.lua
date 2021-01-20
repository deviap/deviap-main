---------------------------------------------------------------
-- Copyright 2020 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------
local newState = require("devgit:source/libraries/state/main.lua")

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

local folderColour = colour.hex("ebc860")

local parseFileToHierarchy = function()
	local fileHierarchy = {}
	local tags = {}

	for _, directory in next, core.io:list() do
		local rootChildren = fileHierarchy
		local currDirectory = ""
		for subDirectory, isFolder in ("/"..directory):gmatch("/([^/]+)(/?)") do
			currDirectory = currDirectory.."/"..subDirectory
			local extension = subDirectory:match("%.(.+)$")

			if extension == nil or extensionWhitelist[extension] then
				extension = extension or (not isFolder and "")

				local node = tags[subDirectory]
				if node == nil then
					node = {
						text = subDirectory;
						iconId = extension and "insert_drive_file" or "folder";
						signature = currDirectory;
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

local reducer = function(oldState, action)
	oldState = oldState or {}

	if action.type == "select" then
		oldState[action.target] = true
	elseif action.type == "unselect" then
		oldState[action.target] = nil
	elseif action.type == "clear" then
		oldState = {}
	end

	return oldState
end

local fileHierarchy = parseFileToHierarchy()

return { 
	construct = function(props)
		local selectedState = newState(reducer, {})

		local hierarchyMenu
		hierarchyMenu = require("./hierarchy.lua"){
			parent = props.parent,
			size = props.size,
			position = props.position,
		
			defaultBackgroundColour = colour.hex("FFFFFF"),
			defaultTextColour = colour(0, 0, 0),
			defaultIconColour = colour(0, 0, 0),
			backgroundColour = colour.hex("FFFFFF"),
			scrollbarColour = colour(0.5, 0.5, 0.5),
		
			buttonHeight = props.buttonHeight,
			insetBy = props.insetBy,
		
			onButtonDown1 = function(child)
				if not core.input:isKeyDown(enums.keys.KEY_LSHIFT) or not props.multipleSelections then
					for k,v in next, selectedState.getState() do
						local node = hierarchyMenu.getButtonFromSignature(k)
						node.backgroundColour = nil
					end
					selectedState.dispatch({ type = "clear" })
				end

				selectedState.dispatch({ type = "select", target = child.signature })
				child.backgroundColour = colour.hex("EAEAEA")

				if child.isExpanded then
					child.isExpanded = false
				else
					child.isExpanded = true
				end
				
				if child._extension == false then
					child.iconId = child.isExpanded and "folder_open" or "folder"
				end

				hierarchyMenu.render()
			end,

			onButtonEnter = function(child, button)
				if selectedState.getState()[child.signature] then return end
				child.backgroundColour = colour.hex("F0F0F0")
				button.propsThenRender {
					backgroundColour = child.backgroundColour
				}
			end,
		
			onButtonExit = function(child, button)
				if selectedState.getState()[child.signature] then return end
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

		return {
			container = hierarchyMenu.container,
			props = props,
			subscribeToSelected = selectedState.subscribe,
			getSelected = function()
				local clone, state = {}, selectedState.getState()
				for k,v in next, state do clone[k] = v end return clone
			end,
			render = function()
				local hProps = hierarchyMenu.props
				hProps.parent = props.parent
				hProps.size = props.size
				hProps.position = props.position
				hProps.buttonHeight = props.buttonHeight
				hProps.insetBy = props.insetBy
				hierarchyMenu.render()
			end,
			destroy = hierarchyMenu.destroy
		}
	end
}