---------------------------------------------------------------
-- Copyright 2020 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------
-- Author(s): Sanjay-B(Sanjay)
-- Creates the new instance based on name provided.

return {
	default = false,
    construct = function(name, props)
        -- Initialize basic instance provided.
        core.construct(name, props)
	end
}
