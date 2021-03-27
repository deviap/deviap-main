---------------------------------------------------------------
-- Copyright 2021 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------
--[[
    Usage:
    local serialiser = require("devgit:source/serialiser/main.lua")

    -- Save a scene to a JSON string
    local sceneAsJSON = serialiser.toJSON(core.scene)

    -- Save a scene to a file
    local sceneAsJSON = core.io:write("client/assets/starterScene.json", serialiser.toJSON(core.scene))

    -- Load a scene from a JSON string
    serialiser.fromJSON(sceneAsJSON)
    
    -- Load a scene from a file
    serialiser.fromFile("client/assets/starterScene.json")
]] --

local serialise = require("devgit:source/serialiser/internal/serialise.lua")
local deserialise = require("devgit:source/serialiser/internal/deserialise.lua")

return {
    toJSON = serialise,
    fromJSON = deserialise,
    fromFile = function(file)
        return deserialise(core.io:read(file))
    end
    
    -- Note the lack of a 'toFile' method,
    -- This is deliberate, as we do NOT want to give any app IO write access
    -- Even to their own app files
}