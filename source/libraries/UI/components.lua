---------------------------------------------------------------
-- Copyright 2021 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------
-- Component quick-list.
local components = {
	-- RESET
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
