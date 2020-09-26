-- Copyright 2020 - Deviap (deviap.com)
local components = {
	button = require("devgit:source/libraries/UI/components/button.lua"),
	baseComponent = require("devgit:source/libraries/UI/components/baseComponent.lua")
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
