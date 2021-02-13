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
    
    props.title = props.title or "Title"
    props.titleColour = props.titleColour or colour.hex("212121")

    local self = newBaseComponent(props)
    self.container.backgroundColour = colour.hex("FFFFFF")
    self.container.strokeRadius = 8

    self.state = newState(reducer)

    local heading = core.construct("guiTextBox", {
        parent = self.container,
        position = guiCoord(0, 5, 1, -25),
        size = guiCoord(0, 30, 0, 20),
        backgroundColour = colour.hex("FF0000"),
        backgroundAlpha = 0,
        textSize = 16,
        textFont = "deviap:fonts/openSansBold.ttf",
        textAlign = "middle",
        textColour = props.titleColour,
    })

    local value = core.construct("guiTextBox", {
        parent = self.container,
        position = guiCoord(0, 35, 1, -25),
        size = guiCoord(0, 30, 0, 20),
        backgroundColour = colour.hex("FF0000"),
        backgroundAlpha = 0,
        textSize = 16,
        textFont = "deviap:fonts/openSansRegular.ttf",
        textAlign = "middle",
        textColour = colour.hex("212121"),
    })

    local function point(parent, position, colour)
        local container = core.construct("guiFrame", {
            parent = parent,
            position = position,
            size = guiCoord(0, 5, 0, 5),
            backgroundAlpha = 0.8,
            strokeRadius = 100
        })
        return container
    end

    local function shiftPoints(array)
        for index, point in pairs(array) do
            local newpos = point.position-guiCoord(0,-5,0,0)
            core.tween:begin(point, 0.3, {position = newpos}, "linear", function()
                sleep(14)
                array[index] = nil -- Safe remove
                point:destroy()
            end)
        end
    end

    spawn(function()
        local ping = 0
        local points = {}

        while sleep(0.3) do
            local networkingStats = core.networking:getStats()

            -- Clamp Ping within some sort of contraint for now
            ping = math.min(math.max(networkingStats.lastPing, 0), 60) -- Shorthand clamp between min & max
            value.text = tostring(ping).." ms"

            -- Update graph
            local point = point(self.container, guiCoord(0, 0, 0, 0), colour.hex("212121"))
            points[#points+1] = point
            point.backgroundColour = (ping >= 30 and colour.hex("66BB6A")) or (ping <= 29 and ping >= 20 and colour.hex("FFCA28")) or colour.hex("ef5350")
            point.position = guiCoord(0, 8, 0, (-1*ping/2)+50)
            shiftPoints(points)
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