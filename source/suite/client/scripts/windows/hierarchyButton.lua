---------------------------------------------------------------
-- Copyright 2020 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------
--[[
	onDown1;
	onDown2;
	onUp1;
	onUp2;
	onEnter;
	onExit;
	parent;
	position;
	backgroundColour;
	backgroundAlpha;
	hasDescendants;
	expanded;
	iconId;
	fontSize;
	size;
	textColour;
	text;
]]

--[[
	destroy
	render
	props
]]
local bindAll = function(object, events)
	for k,v in next, events do
		object:on(k, v)
	end
end

local newButton = function(props)
	local container = core.construct("guiFrame", {
		parent = props.parent;
		size = props.size;
		position = props.position;
		backgroundColour = props.backgroundColour;
		backgroundAlpha = props.backgroundAlpha;
	})

	bindAll(container, {
		mouseLeftDown = props.onDown1;
		mouseRightDown = props.onDown2;
		mouseLeftUp = props.onUp1;
		mouseRightUp = props.onUp2;
		mouseEnter = props.onEnter;
		mouseExit = props.onExit;
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
		textColour = props.textColour
	})

	return {
		destroy = function()
			container:destroy()
			container = nil
		end;
		render = function()
			container:destroy()
			container = core.construct("guiFrame", {
				parent = props.parent;
				size = props.size;
				position = props.position;
				backgroundColour = props.backgroundColour;
				backgroundAlpha = props.backgroundAlpha;
			})
		
			bindAll(container, {
				mouseLeftDown = props.onDown1;
				mouseRightDown = props.onDown2;
				mouseLeftUp = props.onUp1;
				mouseRightUp = props.onUp2;
				mouseEnter = props.onEnter;
				mouseExit = props.onExit;
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
		end;
		props = props;
	}
end

return newButton