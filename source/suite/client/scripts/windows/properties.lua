---------------------------------------------------------------
-- Copyright 2020 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------
local textInput = require("devgit:source/libraries/UI/components/inputs/textInput.lua")
local checkbox = require("devgit:source/libraries/UI/components/checkbox.lua")

return {
    construct = function(object)
        local container = core.construct("guiFrame", {
            backgroundColour = colour.rgb(255, 255, 255),
            zIndex = 10
        })

        local scrollContainer = core.construct("guiScrollView", {
			parent = container,
            size = guiCoord(1, 0, 1, 0),
            canvasSize = guiCoord(1, 0, 2, 0),
            backgroundColour = colour.rgb(255, 0, 0),
            backgroundAlpha = 0,
			scrollbarColour = colour.hex("#212121"),
			scrollbarRadius = 0,
			scrollbarWidth = 2,
			scrollbarAlpha = 0.3
		})


        -- Generate Properties (might split into seperate method)
        local properties = core.reflection:getClassReflection(object.className)["properties"]
		local count = 0
		local longestWidth = 0

        if properties then
			for property, data in pairs(properties) do
                local subcontainer = core.construct("guiFrame", {
                    parent = scrollContainer,
                    position = guiCoord(0, 10, 0, (40*count)+0),
                    size = guiCoord(1, -20, 0, 40),
                    backgroundAlpha = 0
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
				if propertyType == "vector3" then
                    for i=0, 2, 1 do
                        local input = textInput {
                            parent = subcontainer,
							position = guiCoord(1, -20-((2-i)*25), 0, 7),
                            size = guiCoord(0, 20, 0, 23),
                            placeholder = (i == 0 and tostring(object[property].x)) or (i == 1 and tostring(object[property].y)) or (i == 2 and tostring(object[property].x)),
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
					neededWidth = neededWidth + 75
                elseif propertyType == "colour" then
                    for i=0, 2, 1 do
                        local input = textInput {
                            parent = subcontainer,
                            position = guiCoord(1, -20-((2-i)*25), 0, 7),
                            size = guiCoord(0, 20, 0, 23),
                            placeholder = (i == 0 and tostring(object[property].r)) or (i == 1 and tostring(object[property].g)) or (i == 2 and tostring(object[property].b)),
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
					neededWidth = neededWidth + 75
                elseif propertyType == "number" or propertyType == "uint8_t" then
                    local input = textInput {
                        parent = subcontainer,
                        position = guiCoord(1, -20, 0, 7),
                        size = guiCoord(0, 20, 0, 23),
                        placeholder = tostring(object[property]),
                        textSize = 18,
                        textAlpha = 0.95,
                        textAlign = "middle",
                        textColour = colour.hex("707070"),
                        activeBorder = 0,
                        borderBottom = true,
                        borderBottomColour = colour.hex("0f62fe"),
                        backgroundAlpha = 0
					}
					neededWidth = 25 + neededWidth
                elseif propertyType == "string" then
                    local input = textInput {
                        parent = subcontainer,
                        position = guiCoord(1, -130, 0, 7),
                        size = guiCoord(0, 130, 0, 23),
                        placeholder = object[property],
                        textSize = 18,
                        textAlpha = 0.95,
                        textColour = colour.hex("707070"),
                        activeBorder = 0,
                        borderBottom = true,
                        borderBottomColour = colour.hex("0f62fe"),
                        backgroundAlpha = 0
					}
					neededWidth = neededWidth + 135
                elseif propertyType == "boolean" then
                    local _checkbox = checkbox {
                        parent = subcontainer,
                        position = guiCoord(1, -20, 0, 13),
                        size = guiCoord(0, 20, 0, 16)
                    }

                    if object[property] then
                        _checkbox.state.dispatch({type = "setMode", mode = "active"})
					end
					
					neededWidth = neededWidth + 25
				end
				longestWidth = longestWidth > neededWidth and longestWidth or neededWidth
                count = count + 1
            end
		end

        scrollContainer.canvasSize = guiCoord(0, longestWidth + 10, 0, count*40)
        
        return container
    end
}