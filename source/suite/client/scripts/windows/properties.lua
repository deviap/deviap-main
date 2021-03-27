---------------------------------------------------------------
-- Copyright 2021 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------
local textInput = require("devgit:source/libraries/legacy/UI/components/inputs/textInput.lua")
local checkbox = require("devgit:source/libraries/legacy/UI/components/checkbox.lua")

local inputsGivenType =
{
	["string"] = function(parent, orignalValue)
		local input = textInput {
			parent = parent,
			position = guiCoord(1, -130, 0, 7),
			size = guiCoord(0, 130, 0, 23),
			placeholder = orignalValue,
			textSize = 18,
			textAlpha = 0.95,
			textColour = colour.hex("707070"),
			activeBorder = 0,
			borderBottom = true,
			borderBottomColour = colour.hex("0f62fe"),
			backgroundAlpha = 0
		}
		return 135
	end;
	["boolean"] = function(parent, orignalValue)
		local _checkbox = checkbox {
			parent = parent,
			position = guiCoord(1, -20, 0, 13),
			size = guiCoord(0, 20, 0, 16)
		}

		if orignalValue then
			_checkbox.state.dispatch({type = "setMode", mode = "active"})
		end
		
		return 25
	end;
	["number"] = function(parent, orignalValue)
		local input = textInput {
			parent = parent,
			position = guiCoord(1, -20, 0, 7),
			size = guiCoord(0, 20, 0, 23),
			placeholder = tostring(orignalValue),
			textSize = 18,
			textAlpha = 0.95,
			textAlign = "middle",
			textColour = colour.hex("707070"),
			activeBorder = 0,
			borderBottom = true,
			borderBottomColour = colour.hex("0f62fe"),
			backgroundAlpha = 0
		}
		return 25
	end;
	["vector2"] = nil; -- TODO: IMPLEMENT
	["vector3"] = function(parent, orignalValue)
		for i=0, 2, 1 do
			local input = textInput {
				parent = parent,
				position = guiCoord(1, -20-((2-i)*25), 0, 7),
				size = guiCoord(0, 20, 0, 23),
				placeholder = (i == 0 and tostring(orignalValue.x)) or (i == 1 and tostring(orignalValue.y)) or (i == 2 and tostring(orignalValue.x)),
				textSize = 18,
				textAlpha = 0.95,
				textAlign = "middle",
				textColour = colour.hex("707070"),
				activeBorder = 0,
				borderBottom = true,
				borderBottomColour = colour.hex("0f62fe"),
				backgroundAlpha = 0
			}
		end

		return 75
	end;
	["colour"] = function(parent, orignalValue)
		for i=0, 2, 1 do
			local input = textInput {
				parent = parent,
				position = guiCoord(1, -20-((2-i)*25), 0, 7),
				size = guiCoord(0, 20, 0, 23),
				placeholder = (i == 0 and tostring(orignalValue.r)) or (i == 1 and tostring(orignalValue.g)) or (i == 2 and tostring(orignalValue.b)),
				textSize = 18,
				textAlpha = 0.95,
				textAlign = "middle",
				textColour = colour.hex("707070"),
				activeBorder = 0,
				borderBottom = true,
				borderBottomColour = colour.hex("0f62fe"),
				backgroundAlpha = 0
			}
		end
		return 75
	end;
	["quaternion"] = nil; -- TODO: IMPLEMENT
	["guiCoord"] = nil; -- TODO: IMPLEMENT
	["enums.align"] = nil; -- TODO: IMPLEMENT
	["enums.fogType"] = nil; -- TODO: IMPLEMENT
	["enums.iconType"] = nil; -- TODO: IMPLEMENT
	["enums.keys"] = nil; -- TODO: IMPLEMENT
	["enums.lightType"] = nil; -- TODO: IMPLEMENT
	["enums.lineCap"] = nil; -- TODO: IMPLEMENT
	["enums.membershipType"] = nil; -- TODO: IMPLEMENT
	["guiBase"] = nil; -- TODO: IMPLEMENT
	["sceneObject"] = nil; -- TODO: IMPLEMENT
	["undefined"] = function(parent, orignalValue)
		local textBox = core.construct("guiTextBox", {
			parent = parent,
			text = "Property '"..orignalValue.."' does not have an implementation. Report to Deviap as a bug!",
			textSize = 14;
			position = guiCoord(1, 0, 0, 0),
			size = guiCoord(0, 20, 0, 23),
		})
		textBox.position = textBox.position - guiCoord(0, textBox.textDimensions.x, 0, 0)
		return textBox.textDimensions.x
	end;
}

-- Aliases
inputsGivenType["bool"] = inputsGivenType["boolean"]
inputsGivenType["uint8_t"] = inputsGivenType["number"]

return {
    construct = function(object)
        local container = core.construct("guiScrollView", {
            size = guiCoord(1, 0, 1, 0),
            canvasSize = guiCoord(1, 0, 2, 0),
            backgroundColour = colour.rgb(255, 255, 255),
            backgroundAlpha = 1,
			scrollbarColour = colour.hex("#212121"),
			scrollbarRadius = 0,
			scrollbarWidth = 2,
			scrollbarAlpha = 0.3
		})

		-- Since 1 unit on scale is equal to the viewport, not canvas, a holder
		-- has to be used that will grow to the canvas size.
		local holder = core.construct("guiFrame", {
			parent = container,
			size = guiCoord(1, 0, 1, 0),
		})

        -- Generate Properties (might split into seperate method)
        local properties = core.reflection:getClassReflection(object.className)["properties"]
		local count = 0
		local longestWidth = 0

        if properties then
			for property, data in pairs(properties) do
                local subcontainer = core.construct("guiFrame", {
                    parent = holder,
                    position = guiCoord(0, 10, 0, (40*count)+0),
                    size = guiCoord(1, -20, 0, 40),
					backgroundAlpha = 1,
					backgroundColour = colour.random()
                })
        
                local label = core.construct("guiTextBox", {
                    parent = subcontainer,
                    position = guiCoord(0, 0, 0, 0),
                    size = guiCoord(0, 100, 1, 0),
                    text = property,
                    textSize = 31,
                    textAlign = "middleLeft",
                    textColour = colour.hex("212121"),
                    textAlpha = 0.49,
                    backgroundAlpha = 0
				})
				
                -- Clear inputs based on parameter type.
                local propertyType = data.type
				local neededWidth = label.textDimensions.x
				if inputsGivenType[propertyType] then
					neededWidth = neededWidth + inputsGivenType[propertyType](subcontainer, object[property])
				else
					neededWidth = neededWidth + inputsGivenType.undefined(subcontainer, propertyType)
				end

				longestWidth = longestWidth > neededWidth and longestWidth or neededWidth
                count = count + 1
            end
		end

		container.canvasSize = guiCoord(0, longestWidth + 20, 0, count*40)
		holder.size = container.canvasSize

		return container
    end
}