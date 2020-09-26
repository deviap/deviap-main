-- Copyright 2020 - Deviap (deviap.com)
-- Author(s): Sanjay-B(Sanjay)
-- Creates a checkbox instance
local newBaseComponent = require(
                             "devgit:source/libraries/UI/components/baseComponent.lua")
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
    props.text = props.text or ""

    local self = newBaseComponent(props)
    self.container.size = guiCoord(0, 120, 0, 18)
    self.container.backgroundAlpha = 0

    local box = core.construct("guiFrame", {
        name = "box",
        parent = self.container,
        active = true
    })

    local boxIcon = core.construct("guiIcon", {
        name = "boxIcon",
        parent = box,
        visible = false
    })

    local textBox = core.construct("guiTextBox", {
        name = "textBox",
        parent = self.container,
        active = false
    })

    box:on("mouseEnter", function()
        self.state.dispatch {type = "setMode", mode = "hover"}
    end)
    box:on("mouseExit",
           function() self.state.dispatch {type = "setMode", mode = "idle"} end)
    box:on("mouseLeftDown", function()
        self.state.dispatch {type = "setMode", mode = "active"}
    end)
    boxIcon:on("mouseLeftDown", function()
        self.state.dispatch {type = "setMode", mode = "active"}
    end)
    boxIcon:on("mouseEnter", function()
        self.state.dispatch {type = "setMode", mode = "hover"}
    end)
    boxIcon:on("mouseExit", function()
        self.state.dispatch {type = "setMode", mode = "idle"}
    end)

    self.state = newState(reducer)
    self.selected = false

    self.render = function()
        --[[
			@description
				Renders the component
			@parameter
				nil
			@returns
				nil
        ]]

        box.name = "box"
        box.size = guiCoord(0, 16, 0, 16)
        box.position = guiCoord(0, 2, 0, 1)
        box.strokeWidth = 1
        box.strokeAlpha = 1

        boxIcon.size = guiCoord(1, 0, 1, 0)
        boxIcon.position = guiCoord(0, 0, 0, 0)
        boxIcon.iconId = "check"
        boxIcon.iconMax = 10
        boxIcon.iconColour = colour.hex("#FFFFFF")
        boxIcon.backgroundColour = colour.hex("#212121")
        boxIcon.backgroundAlpha = 1

        textBox.size = guiCoord(1, -25, 1, 0)
        textBox.position = guiCoord(0, 25, 0, 0)
        textBox.backgroundAlpha = 1
        textBox.text = props.text
    end

    self.state.subscribe(function(state)
        if state.enabled then
            if state.mode == "hover" then
                box.strokeColour = colour.hex("#0f62fe")
            elseif state.mode == "active" then
                boxIcon.visible = not self.selected
                self.selected = not self.selected
            elseif state.mode == "idle" then
                box.strokeColour = colour.hex("#212121")
            end
        else -- disabled
            box.strokeAlpha = 0.1
            textBox.textColour = colour.hex("#E0E0E0")
            boxIcon.backgroundColour = colour.hex("#E0E0E0")
        end

        self.render()
    end)

    self.render()

    return self
end
