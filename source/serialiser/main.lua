---------------------------------------------------------------
-- Copyright 2020 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------

local serialise = require("devgit:source/serialiser/internal/serialise.lua")
local deserialise = require("devgit:source/serialiser/internal/deserialise.lua")

return {
    toJSON = serialise,
    fromJSON = deserialise,
    fromFile = function(file)
        return deserialise(core.io:read(file))
    end
}