-- Copyright 2020 - Deviap (deviap.com)
-- Library loader.

local dir = "scripts/libraries"

local libs =
{
	test = "./test.lua",
	window = "./window.lua",
	windowManager = "./windowManager.lua",
	state = "devgit:source/libraries/state/main.lua"
}

return function(name)
	--[[
		@description
			Loads a library with the given alias.
		@parameter
			string, name
		@returns
			any, returnValue
	]]

	return require(libs[name]:gsub("^%.", dir))
end