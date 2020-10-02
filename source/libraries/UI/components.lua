-- Copyright 2020 - Deviap (deviap.com)

local components = {
	baseComponent = require("devgit:source/libraries/UI/components/baseComponent.lua"),
	
	baseButton = require("devgit:source/libraries/UI/components/buttons/baseButton.lua"),
	primaryButton = require("devgit:source/libraries/UI/components/buttons/primaryButton.lua"),
	dangerButton = require("devgit:source/libraries/UI/components/buttons/dangerButton.lua"),
	secondaryButton = require("devgit:source/libraries/UI/components/buttons/secondaryButton.lua"),
	tertiaryButton = require("devgit:source/libraries/UI/components/buttons/tertiaryButton.lua"),
	baseComponent = require("devgit:source/libraries/UI/components/baseComponent.lua"),

	appCard = require("devgit:source/libraries/UI/components/cards/app.lua"),

	dropDown = require("devgit:source/libraries/UI/components/dropDowns/dropDown.lua"),
	dropDownOptions = require("devgit:source/libraries/UI/components/dropDowns/dropDownOptions.lua"),

	textInput = require("devgit:source/libraries/UI/components/inputs/textInput.lua"),
	numberInput = require("devgit:source/libraries/UI/components/inputs/numberInput.lua"),

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
