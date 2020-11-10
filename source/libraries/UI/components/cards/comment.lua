-- Copyright 2020 - Deviap (deviap.com)
-- Author(s): Sanjay-B(Sanjay)
-- Creates an comment component.
local newBaseComponent = require("devgit:source/libraries/UI/components/baseComponent.lua")

return function(props)
	--[[
		@description
			Creates a base component
		@parameter
			table, props
		@returns
			table, component
	]]

	props.containerBackgroundColour = colour.hex("#E5E5E5")
	props.secondaryColour = colour.hex("#000000")
	props.author = props.author or ""
	props.content = props.content or ""
	props.avatar = props.avatar or ""
	props.postedAt = props.postedAt or ""

	local self = newBaseComponent(props)

	local avatarThumbnail = core.construct("guiImage", {
		parent = self.container,
		active = false,
		backgroundAlpha = 0.5,
		backgroundColour = colour(1, 0, 0),
		size = guiCoord(0, 48, 0, 48),
		position = guiCoord(0, 6, 1, -73)
	})

	local authorLabel = core.construct("guiTextBox", {
		parent = self.container,
		active = false,
		backgroundAlpha = 0,
		textColour = colour.hex("#212121"),
		size = guiCoord(1, -12, 0, 20),
		position = guiCoord(0, 70, 1, -77),
		textFont = "deviap:fonts/openSansBold.ttf",
		textSize = 20,
	})

	local contentLabel = core.construct("guiTextBox", {
		parent = self.container,
		active = false,
		backgroundAlpha = 0,
		textColour = colour.hex("#212121"),
		size = guiCoord(1, -12, 0, 20),
		position = guiCoord(0, 70, 1, -50),
		textFont = "deviap:fonts/openSansRegular.ttf",
		textSize = 18,
	})

	local postedAtLabel = core.construct("guiTextBox", {
		parent = self.container,
		active = false,
		backgroundAlpha = 0,
		textColour = colour.hex("#212121"),
		size = guiCoord(1, -12, 0, 20),
		position = guiCoord(0, 212, 1, -73),
		textFont = "deviap:fonts/openSansLight.ttf",
		textSize = 10,
		textAlpha = 0.5
	})

	self.render = function()
		--[[
			@description
				Renders the component
			@parameter
				nil
			@returns
				nil
		]]
		
		authorLabel.text = props.author
		contentLabel.text = props.content
		postedAtLabel.text = props.postedAt
		avatarThumbnail.image = props.avatar
	end

	self.render()

	return self
end
