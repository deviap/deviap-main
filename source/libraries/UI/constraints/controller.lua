local newTabulars = require("tevgit:source/libraries/UI/constraints/tabResolver.lua")

local controllers =
{
    verticalLayoutAuto = require("tevgit:source/libraries/UI/constraints/controllers/verticalLayoutAuto.lua");
	horizontialLayoutAuto = require("tevgit:source/libraries/UI/constraints/controllers/horizontialLayoutAuto.lua");
	verticalLayout = require("tevgit:source/libraries/UI/constraints/controllers/verticalLayoutAuto.lua");
	horizontialLayout = require("tevgit:source/libraries/UI/constraints/controllers/horizontialLayoutAuto.lua");
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