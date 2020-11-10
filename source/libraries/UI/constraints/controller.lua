-- Copyright 2020 - Deviap (deviap.com)
local controllers = {
	verticalLayoutAuto = require("devgit:source/libraries/UI/constraints/controllers/verticalLayoutAuto.lua"),
	horizontialLayoutAuto = require("devgit:source/libraries/UI/constraints/controllers/horizontialLayoutAuto.lua"),
	gridLayout = require("devgit:source/libraries/UI/constraints/controllers/gridLayout.lua"),
	verticalNavLayout = require("devgit:source/libraries/UI/constraints/controllers/verticalNavLayout.lua")
}

return function(controllerName, ...)
	--[[
		@description
			Create a new controller.
		@parameters
			string, controllerName
				Name of controller
			any, ...
		@returns
			table, interface
	]]

	return controllers[controllerName](...)
end
