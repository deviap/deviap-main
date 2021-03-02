---------------------------------------------------------------
-- Copyright 2021 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------
-- Creates a card component.
local newBaseComponent = require("devgit:source/libraries/UI/components/baseComponent.lua")
local newState = require("devgit:source/libraries/state/main.lua")
local defaultState = {}

local MAX_PRINTOUTS = 100
local OUTPUT_TYPES = {
	PRINT = 1,
	WARN = 2,
	ERROR = 3,
	PAST = 4,
}

local deepClone
deepClone = function(target)
	local newTbl = {}
	for key, value in next, target do
		if type(value) == "table" then newTbl[key] = deepClone(value)
		else newTbl[key] = value end
	end
	return newTbl
end

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

	local newState = deepClone(state or defaultState)

	if action.type == "append" then
		if #newState > MAX_PRINTOUTS - 1 then
			table.remove(newState, 1)
		end

		newState[#newState + 1] = {
			outputType = action.outputType,
			content = action.content,
			timeStamp = os.date("%H:%M:%S", os.time())
		}
	elseif action.type == "clear" then
		newState = {}
	end

	return newState
end

local getDebugHistory = function()
	local preformatted = core.debug:getOutputHistory()
	local formatted = {}

	for _, value in next, core.debug:getOutputHistory() do
		formatted[#formatted + 1] = {
			outputType = OUTPUT_TYPES.PAST,
			content = value.message,
			timeStamp = os.date("%H:%M:%S", value.time)
		}

		-- HACK: Try to color some of the errors correctly.
		-- messageType is missing that would inform us the type of output
		-- it actually is.
		if value.message:match("ERROR") then
			formatted[#formatted].outputType = OUTPUT_TYPES.ERROR
		elseif value.message:match("Trace %(thread%)") then
			formatted[#formatted].outputType = OUTPUT_TYPES.ERROR
		end
	end

	return formatted
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

    local self = newBaseComponent(props)
	local autoScrolling = true

    self.container.backgroundColour = colour.hex("FFFFFF")
    self.container.strokeRadius = 8

    self.state = newState(reducer, getDebugHistory())
	self.renderedPrintout = {}

    local heading = core.construct("guiTextBox", {
        parent = self.container,
        position = guiCoord(0, 10, 0, 5),
        size = guiCoord(0, 50, 0, 20),
        backgroundColour = colour.hex("FF0000"),
        backgroundAlpha = 0,
        textSize = 18,
        textFont = "deviap:fonts/openSansBold.ttf",
        textAlign = "middleLeft",
        textColour = colour.hex("212121"),
    })

	local follow = core.construct("guiTextBox", {
        parent = self.container,
        position = guiCoord(0, 225 - 80, 0, 5),
        size = guiCoord(0, 80, 0, 14),
		backgroundColour = colour.rgb(152, 152, 152),
		strokeRadius = 7,
        backgroundAlpha = 0,
        textSize = 14,
        textAlign = "middle",
		strokeAlpha = 1,
		strokeColour = colour.rgb(152, 152, 152),
        textColour = colour.rgb(152, 152, 152),
		text = "Auto-scroll: on"
    })

	follow:on("mouseEnter", function()
		follow.strokeAlpha = 0
		follow.backgroundAlpha = 1
		follow.textColour = colour.white()
	end)

	follow:on("mouseExit", function()
		follow.strokeAlpha = 1
		follow.backgroundAlpha = 0
		follow.textColour = colour.rgb(152, 152, 152)
	end)

	follow:on("mouseLeftDown", function()
		autoScrolling = not autoScrolling

		if autoScrolling then
			follow.text = "Auto-scroll: on"
		else
			follow.text = "Auto-scroll: off"
		end
	end)

	local clear = core.construct("guiIcon", {
        parent = self.container,
        position = guiCoord(0, 230, 0, 5),
        size = guiCoord(0, 14, 0, 14),
        backgroundColour = colour.rgb(152, 152, 152),
		backgroundAlpha = 0,
		strokeRadius = 7,
		iconColour = colour.rgb(152, 152, 152),
		iconId = "delete",
		strokeAlpha = 1,
		strokeColour = colour.rgb(152, 152, 152),
        iconMax = 10,
    })

	clear:on("mouseEnter", function()
		clear.strokeAlpha = 0
		clear.backgroundAlpha = 1
		clear.iconColour = colour.white()
	end)

	clear:on("mouseExit", function()
		clear.strokeAlpha = 1
		clear.backgroundAlpha = 0
		clear.iconColour = colour.rgb(152, 152, 152)
	end)

	clear:on("mouseLeftDown", function()
		core.debug:clearOutputHistory()
		self.state.dispatch({
			type = "clear"
		})
	end)

    local scrollContents = core.construct("guiScrollView", {
        parent = self.container,
        size = guiCoord(0, 240, 0, 262),
        position = guiCoord(0, 10, 0, 27),
        backgroundColour = colour.rgb(255, 0, 0),
        backgroundAlpha = 0,
        scrollbarAlpha = 0.8,
        scrollbarColour = colour(0.50, 0.50, 0.50),
        scrollbarRadius = 0,
        scrollbarWidth = 5,
		zIndex = -1,
    })

	for i = 1, MAX_PRINTOUTS do
		self.renderedPrintout[i] = core.construct("guiTextBox", {
		    parent = scrollContents,
		    size = guiCoord(1, 0, 0, 20),
			visible = false,
			backgroundColour = i % 2 == 0 
				and colour(0.9, 0.9, 0.9) 
				or colour(0.95, 0.95, 0.95),
			textWrap = true,
		    textSize = 14,
		})
	end

    core.debug:on("print", function(content)
        self.state.dispatch({
			type = "append",
			outputType = OUTPUT_TYPES.PRINT,
			content = content,
		})
   end)

    core.debug:on("warn", function(content)
        self.state.dispatch({
			type = "append",
			outputType = OUTPUT_TYPES.WARN,
			content = content,
		})
    end)

	core.debug:on("error", function(content)
        self.state.dispatch({
			type = "append",
			outputType = OUTPUT_TYPES.ERROR,
			content = content,
		})
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

		local height = 0
		local history = self.state:getState()
		for key, obj in next, self.renderedPrintout do
			local value = history[key]

			if value then
				obj.text = value.timeStamp .. " : " .. value.content
				obj.size = guiCoord(0, scrollContents.absoluteSize.x, 0, obj.textDimensions.y)
				obj.position = guiCoord(0, 0, 0, height)
				obj.visible = true

				if value.outputType == OUTPUT_TYPES.PRINT then
					obj.textColour = colour.rgb(102, 102, 102)
				elseif value.outputType == OUTPUT_TYPES.WARN then
					obj.textColour = colour.rgb(255, 179, 0) -- Add more contrast
				elseif value.outputType == OUTPUT_TYPES.ERROR then
					obj.textColour = colour.rgb(229, 115, 115)
				elseif value.outputType == OUTPUT_TYPES.PAST then
					obj.textColour = colour.rgb(102, 102, 102)
				end
				
				height = height + obj.textDimensions.y
			else
				obj.text = ""
				obj.visible = false
			end
		end

		scrollContents.canvasSize = guiCoord(0, scrollContents.absoluteSize.x, 0, height)
		if autoScrolling then
			scrollContents.canvasOffset = vector2(0, math.max(0, height - scrollContents.absoluteSize.y))
		end
        heading.text = props.title
	end
	
	
	self.state.subscribe(self.render)

	-- Hack: Sleep then render since fonts aren't immediately loaded in.
	spawn(function()
		sleep(3)
		self.render()
	end)

	
	return self
end