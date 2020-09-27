local dir = "devgit:source/suite/client/scripts/libraries"

local libs =
{
	test = "./test.lua"
}

return function(name)
	return require(libs[name]:gsub("^%.", dir))
end