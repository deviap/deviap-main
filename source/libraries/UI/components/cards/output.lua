---------------------------------------------------------------
-- Copyright 2021 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------
-- Creates a card component.
local newBaseComponent = require("devgit:source/libraries/UI/components/baseComponent.lua")
local newState = require("devgit:source/libraries/state/main.lua")

local function reducer(state, action)
	--[[
		@description
			Reducers action to a new state
		@parameter
			any, state
			table, action
		@returns
			any, state
	]]
	state = state or {enabled = true, mode = "idle"}
	local newState = {enabled = state.enabled, mode = state.mode}

	if action.type == "enable" then
		newState.enabled = true
	elseif action.type == "disable" then
		newState.enabled = false
	elseif action.type == "setMode" then
		newState.mode = action.mode
	end

	return newState
end

return function(props)
	--[[
		@description
			Creates a base component
		@parameter
			table, props
		@returns
			table, component
    ]]
    
    -- COLOURS DEFAULT
    -- RED: colour.rgb(229, 115, 115)
    -- GREY: colour.rgb(102, 102, 102)

    props.title = props.title or "Title"

    local maxEntries = 19
    local debounce = false
    local contents = {}

    local self = newBaseComponent(props)
    self.container.backgroundColour = colour.hex("FFFFFF")
    self.container.strokeRadius = 8

    self.state = newState(reducer)

    local heading = core.construct("guiTextBox", {
        parent = self.container,
        position = guiCoord(0, 10, 0, 5),
        size = guiCoord(0, 240, 0, 20),
        backgroundColour = colour.hex("FF0000"),
        backgroundAlpha = 0,
        textSize = 18,
        textFont = "deviap:fonts/openSansBold.ttf",
        textAlign = "middleLeft",
        textColour = colour.hex("212121"),
    })

    local scrollContents = core.construct("guiScrollView", {
        parent = self.container,
        size = guiCoord(0, 240, 0, 262),
        position = guiCoord(0, 10, 0, 27),
        backgroundColour = colour.rgb(255, 0, 0),
        backgroundAlpha = 0,
        scrollbarAlpha = 0.8,
        scrollbarColour = colour(0.75, 0.75, 0.75),
        scrollbarRadius = 0,
        scrollbarWidth = 5,
    })

    core.debug:on("print", function(message)
        contents[#contents + 1] = {
            ["message"] = os.date("%H:%M:%S", os.time()) .. ": " .. message,
            ["colour"] = (string.match(message, "ERROR:") and colour.rgb(229, 115, 115) or colour.rgb(102, 102, 102))
        }
    end)

    core.debug:on("warn", function(message)
        contents[#contents + 1] = {
            ["message"] = os.date("%H:%M:%S", os.time()) .. ": " .. message,
            ["colour"] = colour.rgb(255, 183, 77)
        }
    end)

    -- Update Console Contents
    spawn(function()
        while sleep(0.3) do
            scrollContents:destroyChildren()
            scrollContents.canvasSize = guiCoord(1, 0, 0, 0)
            for index, data in pairs(contents) do
                local textLabel = core.construct("guiTextBox", {
                    parent = scrollContents,
                    size = guiCoord(1, 0, 1, 0),
                    position = guiCoord(0, 0, 0, scrollContents.canvasSize.offset.y),
                    backgroundColour = colour.rgb(255, 255, 255),
                    text = data["message"],
                    textColour = data["colour"],
                    textSize = 14,
                    textWrap = true,
                    visible = true
                })
                textLabel.size = guiCoord(1, 0, 0, textLabel.textDimensions.y + 2)
                scrollContents.canvasSize = scrollContents.canvasSize + guiCoord(0, 0, 0, textLabel.absoluteSize.y)
            end
        end
    end)
    
	self.container:on("mouseEnter", function()
		self.state.dispatch {type = "setMode", mode = "hover"}
	end)
	self.container:on("mouseExit", function()
		self.state.dispatch {type = "setMode", mode = "idle"}
	end)

	self.render = function()
		--[[
			@description
				Renders the component
			@parameter
				nil
			@returns
				nil
        ]]
        heading.text = props.title
	end
	
	self.state.subscribe(function(state)
		if state.enabled then
			if state.mode == "hover" then
				
			elseif state.mode == "idle" then
				
			end
		else -- disabled
		end

		self.render()
	end)

	self.render()

	return self
end