-- Copyright 2020 - Deviap (deviap.com)
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
    state = state or {enabled = true, selected = false, hover = false}
    local newState = {
        enabled = state.enabled,
        selected = state.selected,
        hover = state.hover
    }

    if action.type == "select" then
        newState.selected = true
    elseif action.type == "deselect" then
        newState.selected = false
    elseif action.type == "enable" then
        newState.enabled = true
    elseif action.type == "disable" then
        newState.enabled = false
    elseif action.type == "hover" then
        newState.hover = true
    elseif action.type == "unhover" then
        newState.hover = false
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
    props.isContainer = props.isContainer or false
    props.bottomColour = props.bottomColour or colour.hex("e0e0e0")
    props.label = props.label or "Unnamed Tab"
    props.labelColour = props.labelColour or colour.hex("161616")
    props.labelFont = props.font or "deviap:fonts/openSansRegular.ttf"
    props.labelAlpha = props.labelAlpha or 0.9

    local self = newBaseComponent(props)
    self.container.size = guiCoord(0, 120, 0, 38)
    self.container.backgroundAlpha = 0

    local label = core.construct("guiTextBox", {
        name = "label",
        parent = self.container,
        active = false,
        size = guiCoord(1, -20, 1, -10),
        position = guiCoord(0, 10, 0, 5),
        backgroundAlpha = 0,
        textSize = 18,
        textAlign = "middleLeft"
    })

    props.containerBackgroundColour = colour.hex("ffffff")
    props.containerBackgroundAlpha = 0.5

    local borderBottom = core.construct("guiLine", {
        active = false,
        parent = self.container,
        lineWidth = 2,
        pointA = guiCoord(0, 1, 1, -1),
        pointB = guiCoord(1, -1, 1, -1)
    })

    self.borderRight = core.construct("guiLine", {
        active = false,
        parent = self.container,
        lineWidth = 1,
        pointA = guiCoord(1, 0, 0, 0),
        pointB = guiCoord(1, 0, 1, 0),
        lineColour = colour.hex("8d8d8d"),
        visible = false
    })

    self.state = newState(reducer)

    self.container:on("mouseEnter",
                      function() self.state.dispatch {type = "hover"} end)
    self.container:on("mouseExit",
                      function() self.state.dispatch {type = "unhover"} end)

    local oldRender = self.render
    self.render = function()
        --[[
			@description
				Renders the component
			@parameter
				nil
			@returns
				nil
        ]]

        label.textColour = props.labelColour
        label.textFont = props.labelFont
        label.text = props.label
        label.textAlpha = props.labelAlpha

        borderBottom.lineColour = props.bottomColour

        if props.isContainer then
            borderBottom.pointA = guiCoord(0, 0, 0, 0)
            borderBottom.pointB = guiCoord(1, 0, 0, 0)
            props.containerBackgroundColour = colour.hex("e0e0e0")
            self.borderRight.visible = true
        else
            borderBottom.pointA = guiCoord(0, 1, 1, -1)
            borderBottom.pointB = guiCoord(1, -1, 1, -1)
            props.containerBackgroundColour = colour.hex("ffffff")
            self.borderRight.visible = false
        end

        oldRender()
        label.text = props.label
    end

    self.state.subscribe(function(state)
        if state.selected then
            props.labelAlpha = 1
            props.labelFont = "deviap:fonts/openSansBold.ttf"
            props.bottomColour = colour.hex("0f62fe")
        else
            props.labelAlpha = 0.9
            props.labelFont = "deviap:fonts/openSansRegular.ttf"
            props.bottomColour = colour.hex("e0e0e0")
        end

        if state.hover then
            props.bottomColour = colour.hex("8d8d8d")
            props.containerBackgroundAlpha = 1.0
        else
            props.containerBackgroundAlpha = 0.6
        end

        if state.selected then props.containerBackgroundAlpha = 0.3 end

        if not state.enabled then
            props.labelFont = "deviap:fonts/openSansRegular.ttf"
            props.bottomColour = colour.hex("f4f4f4")
            props.labelColour = colour.hex("c6c6c6")
        end

        self.render()
    end)

    self.render()

    return self
end
