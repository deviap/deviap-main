-- Copyright 2021 - Deviap (deviap.com)

local components = {
	baseComponent = require("./baseComponent.lua"),
	
	baseButton = require("./components/buttons/baseButton.lua"),
	primaryButton = require("./components/buttons/primaryButton.lua"),
	dangerButton = require("./components/buttons/dangerButton.lua"),
	secondaryButton = require("./components/buttons/secondaryButton.lua"),
	tertiaryButton = require("./components/buttons/tertiaryButton.lua"),

	appCard = require("devgit:source/libraries/UI/components/cards/app.lua"),

	dropDown = require("devgit:source/libraries/UI/components/dropDowns/dropDown.lua"),
	dropDownOptions = require("devgit:source/libraries/UI/components/dropDowns/dropDownOptions.lua"),

	textInput = require("./inputs/textInput.lua"),
	numberInput = require("./inputs/numberInput.lua"),

	inlineNotification = require("devgit:source/libraries/UI/components/notifications/inlineNotification.lua"),
	multilineNotification = require("devgit:source/libraries/UI/components/notifications/multilineNotification.lua"),

	tab = require("devgit:source/libraries/UI/components/tabs/tab.lua"),
	tabs = require("devgit:source/libraries/UI/components/tabs/tabs.lua"),

	checkbox = require("devgit:source/libraries/UI/components/checkbox.lua"),
	loading = require("devgit:source/libraries/UI/components/loading.lua"),
	modal = require("devgit:source/libraries/UI/components/modal.lua"),
	toggle = require("devgit:source/libraries/UI/components/toggle.lua"),
	tooltip = require("devgit:source/libraries/UI/components/tooltip.lua"),
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
	return components[name](props)
end
