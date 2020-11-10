-- Copyright 2020 - Deviap (deviap.com)
local dir = "devgit:source/libraries/UI"

local components = {
	baseComponent = require("./baseComponent.lua")
	
	baseButton = require("./components/buttons/baseButton.lua"),
	primaryButton = require("./components/buttons/primaryButton.lua"),
	dangerButton = require("./components/buttons/dangerButton.lua"),
	secondaryButton = require("./components/buttons/secondaryButton.lua"),
	tertiaryButton = require("./components/buttons/tertiaryButton.lua"),
	baseComponent = require("./components/baseComponent.lua"),

	appCard = require("./cards/app.lua"),

	dropDown = require("./dropDowns/dropDown.lua"),
	dropDownOptions = require("./dropDowns/dropDownOptions.lua"),

	textInput = require("./inputs/textInput.lua")
	numberInput = require("./inputs/numberInput.lua"),

	inlineNotification = require("./notifications/inlineNotification.lua"),
	multilineNotification = require("./notifications/multilineNotification.lua"),

	tab = require("./tabs/tab.lua"),
	tabs = require("./tabs/tabs.lua"),

	checkbox = require("./checkbox.lua"),
	loading = require("./loading.lua"),
	modal = require("./modal.lua"),
	toggle = require("./toggle.lua"),
	tooltip = require("./tooltip.lua"),
}

return function(name, props)
	--[[
		@description
			Create a new component with the given props.
		@parameter
			string, name
			table, props
		@returns
			table, component
	]]
	return components[name:gsub("^%.", dir)](props)
end
