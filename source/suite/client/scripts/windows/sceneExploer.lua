---------------------------------------------------------------
-- Copyright 2020 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------
local newHierarchy = require("./hierarchy.lua")

return function(props)
	return {
		render = function()
		end;
		destroy = function()
			
		end;
		props = props;
	}
end