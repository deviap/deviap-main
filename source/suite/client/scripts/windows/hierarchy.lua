---------------------------------------------------------------
-- Copyright 2020 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------
local newButton = function(props)
	local container = core.construct("guiFrame", {
		parent = props.parent;
		size = props.size;
		position = props.position;
		backgroundColour = props.backgroundColour;
		backgroundAlpha = props.backgroundAlpha;
	})

	if props.hasDescendants then
		local dropDown = core.construct("guiIcon", {
			parent = container;
			iconId = props.expanded and "expand_less" or "expand_more";
			size = guiCoord(0, props.fontSize, 0, props.fontSize);
			position = guiCoord(0, 2, 0.5, -props.fontSize/2);
			backgroundAlpha = 0;
		})
	end

	local icon = core.construct("guiIcon", {
		parent = container;
		iconId = props.iconId;
		size = guiCoord(0, props.fontSize, 0, props.fontSize);
		position = guiCoord(0, props.fontSize + 4, 0.5, -props.fontSize/2);
		backgroundAlpha = 0;
	})
	local textBox = core.construct("guiTextBox", {
		parent = container;
		text = props.text;
		size = guiCoord(1, -props.fontSize*2 - 8, 1 , 0);
		position = guiCoord(0, props.fontSize*2 + 8, 0, 0);
		textAlign = "middleLeft";
		backgroundAlpha = 0;
		textColour = colour.white()
	})

	return {
		destroy;
		render;
		props;

		onDown1;
		onDown2;
		onUp1;
		onUp2;
		onMove;
		onEnter;
		onExit;
	}
end

local getNumOfEntries 
getNumOfEntries = function(start)
	local c = 0
	if start then
		for k,v in next, start do
			c = c + 1 + getNumOfEntries(v.children)
		end
	end
	return c
end

local construct
construct = function(props)
	local container = core.construct("guiFrame", {
		parent = props.parent, 
		size = props.size, 
		position = props.position,
		backgroundColour = colour(0.1,0.1,0.1);
	})
	
	local offset = 0
	for k,v in next, props.hierarchy do
		local descendants = getNumOfEntries(v.children)
		local button = newButton {
			parent = container,
			size = guiCoord(1, 0, 0, props.buttonHeight),
			position = guiCoord(0, 0, 0, props.buttonHeight*offset),
			text = v.text,
			iconId = v.icon,
			fontSize = props.buttonHeight - 10,
			backgroundColour = colour(0.1,0.1,0.1);
			backgroundAlpha = 1;
			hasDescendants = descendants > 0
		}
		offset = offset + 1

		if descendants > 0 then
			construct({
				parent = container, 
				hierarchy = v.children, 
				buttonHeight = props.buttonHeight,
				position = guiCoord(0, 10, 0, props.buttonHeight*offset),
				size = guiCoord(1, -10, 0, props.buttonHeight*descendants)
			})
			offset = offset + descendants
		end
	end

	return {
		getTreeFromId; -- table function(id)
		render;
		props;
		__ids;
		
		-- Events
		onButtonDown1; -- function disconnect function(callback(id, tree))
		onButtonUp1;
	}
end

return construct