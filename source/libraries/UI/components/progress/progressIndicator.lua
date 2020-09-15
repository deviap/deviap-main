-- Copyright 2020 - Deviap (deviap.com)

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
	state = state or { vertical = false }
	local newState = { vertical = state.vertical }

	if action.type == "setVertical" then
		newState.vertical = action == true
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

    local self = newBaseComponent(props)
    self.container.size = guiCoord(0, 512, 0, 34)
    self.container.backgroundAlpha = 0

    local progressBar = core.construct("guiFrame", {
        name = "progressBar",
        parent = self.container,
        active = true,
        backgroundColour = colour.hex('0f62fe')
    })

    props.progress = props.progress or 0
    props.steps = props.steps or {}

    self.state = newState(reducer)

    self.render = function()
        --[[
			@description
				Renders the component
			@parameter
				nil
			@returns
				nil
        ]]

        local s = 1/#props.steps
        for i,v in pairs (props.steps) do
            v.container.parent = self.container
            v.container.position = guiCoord(s*(i-1), 0, 0, 6)
            v.container.size = guiCoord(s, 0, 1, 0)
        end

        progressBar.size = guiCoord(props.progress * s, 0, 0, 2)
    end

    self.state.subscribe(function(state)
        if state.vertical then

        end

        self.render()
    end)

    self.render()

    return self
end
