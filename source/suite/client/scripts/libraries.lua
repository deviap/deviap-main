local dir = "scripts/libraries"

local libs =
{
	test = "./test.lua",
	window = "./window.lua",
	windowManager = "./windowManager.lua",
	state = "devgit:source/libraries/state/main.lua"
}

return function(name)
	return require(libs[name]:gsub("^%.", dir))
end