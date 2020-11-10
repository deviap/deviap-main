-- Copyright 2020 - Deviap (deviap.com)
-- Author(s): utrain
-- This file lazy-loads our modules that we have made. Enterprise grade, of course.
local globalStringSubstition = string.gsub -- Ensure faster call times by storing it locally.
local rootDirectory = "devgit:" -- Must ensure our code is enterprise-grade by ensuring modularity.
local stringReplacementForPeriod = ("%source/libraries/"):gsub("%%", rootDirectory) -- The string replacement.
local errorMessageIfModuleFailsToLoad = "You either misnamed the library or you forgot './' like a functional programmer."
local regex = "^%." -- Regex used to match the start of a relative path.

local errorIfModuleFailsToLoad = function(errorMessage)
	--[[
		@description
			This function will error with the message and ensure the the error
			surfaces 4 levels above this function.
		@parameter
			string, errorMessage
				The error message to be used.
		@returns
			nil
				This function returns nil.
	]]
	error(errorMessage, 4)
end

local requireModule = function(moduleName)
	--[[
		@description
			This function will require a module. It runs in protected call as
			to be enterprise safe. If it fails to load, it will error with the
			'errorMessageIfModuleFailsToLoad' message. Otherwise, it will return
			the value(s) returned.
		@parameters
			string, moduleName
				The name of the module that should be required.
		@returns
			any, returnVal
				The value(s) returned by the module.
	]]

	local success, returnVal = pcall(require, moduleName)
	if not success then
		errorIfModuleFailsToLoad(errorMessageIfModuleFailsToLoad)
	end
	return returnVal
end

local librariesRelativePath = {
	-- libraryName = "./..."
	UI = "./UI/main.lua",
	UI_breakpointer = "./UI-breakpointer/main.lua",
	kiwi = "./kiwi.lua/kiwi.lua",
	State = "./state/main.lua"
}

return function(libraryName)
	--[[
		@description
			The interface to require modules with an alias.
		@parameter
			string, libraryName
				Alias of the module you want to return.
		@returns
			any, any
				The value(s) returned by the module.
	]]

	return requireModule(globalStringSubstition(librariesRelativePath[libraryName], regex, stringReplacementForPeriod))
end
