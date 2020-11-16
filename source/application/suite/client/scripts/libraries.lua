-- Copyright 2020 - Deviap (deviap.com)
-- Library loader.

local dir = "libraries"

local libs =
{
	test = "./test.lua",
	window = "./window.lua",
	windowManager = "./windowManager.lua",
	state = "devgit:source/libraries/state/main.lua",
	uiLibrary = "devgit:source/libraries/UI/main.lua",
	homeBar = "./homeBar.lua",
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
	print(name)
	return require(libs[name]:gsub("^%.", dir))
end