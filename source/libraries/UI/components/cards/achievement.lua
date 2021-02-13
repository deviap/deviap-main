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
    props.content = props.content or "Content"
    props.image = props.image or ""
    props.icon = props.icon or ""
    props.titleColour = props.titleColour or colour.hex("FFFFFF")
    props.contentColour = props.contentColour or colour.hex("FFFFFF")
    props.iconColour = props.iconColour or colour.hex("FFFFFF")
    props.unlocked = props.unlocked or false

    local self = newBaseComponent(props)
    self.container.backgroundColour = colour.hex("212121")
    self.container.strokeRadius = 8

    self.state = newState(reducer)

    local subContainer = core.construct("guiFrame", {
        parent = self.container,
        position = guiCoord(0, 0, 0, 83),
        size = guiCoord(0, 260, 0, 20),
        backgroundColour = colour.hex("212121"),
        backgroundAlpha = 0.8,
        zIndex = 2
    })

    local heading = core.construct("guiTextBox", {
        parent = subContainer,
        position = guiCoord(0, 8, 0, 17),
        size = guiCoord(1, -30, 1, -35),
        backgroundColour = colour.hex("FF0000"),
        backgroundAlpha = 0,
        textSize = 14,
        textFont = "deviap:fonts/openSansBold.ttf",
        textAlign = "middleLeft",
        textAlpha = 0.8,
        textColour = props.titleColour
    })

    local content = core.construct("guiTextBox", {
        parent = subContainer,
        position = guiCoord(0, 8, 0, 25),
        size = guiCoord(1, -5, 1, -18),
        backgroundColour = colour.hex("FF0000"),
        backgroundAlpha = 0,
        textSize = 14,
        textFont = "deviap:fonts/openSansRegular.ttf",
        textAlign = "topLeft",
        textAlpha = 0.5,
        textWrap = true,
        textColour = props.contentColour,
        visible = false
    })

    local icon = core.construct("guiIcon", {
        parent = subContainer,
        name = "icon",
        position = guiCoord(0, 243, 0, 4),
        size = guiCoord(0, 12, 0, 12),
        iconMax = 12,
		iconColour = props.iconColour,
        iconAlpha = 0.5,
        backgroundColour = colour.hex("FF0000"),
		backgroundAlpha = 0,
        zIndex = 3
	})
    

    local image = core.construct("guiImage", {
        parent = self.container,
        position = guiCoord(0, 0, 0, 0),
        size = guiCoord(0, 260, 0, 103),
        backgroundColour = colour.hex("FF0000"),
        backgroundAlpha = 0,
        strokeRadius = 8,
		imageColour = colour.hex("FFFFFF"),
        imageAlpha = 0.4
    })

	image:on("mouseEnter", function()
		self.state.dispatch {type = "setMode", mode = "hover"}
	end)
	image:on("mouseExit", function()
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
        content.text = props.content
        image.image = props.image
        icon.iconId = props.icon
        icon.visible = props.unlocked
	end
	
	self.state.subscribe(function(state)
		if state.enabled then
			if state.mode == "hover" then
                subContainer.position = guiCoord(0, 0, 0, 53)
				subContainer.size = guiCoord(0, 260, 0, 50)
                heading.position = guiCoord(0, 8, 0, 4)
                heading.size = guiCoord(1, -5, 1, -35)
                heading.textSize = 16
                content.visible = true
                icon.visible = false
			elseif state.mode == "idle" then
                subContainer.position = guiCoord(0, 0, 0, 83)
                subContainer.size = guiCoord(0, 260, 0, 20)
                heading.position = guiCoord(0, 8, 0, 17)
                heading.size = guiCoord(1, -30, 1, -35)
                heading.textSize = 14
                content.visible = false
                icon.visible = props.unlocked
			end
		else -- disabled
		end

		self.render()
	end)

	self.render()

	return self
end