---------------------------------------------------------------
-- Copyright 2020 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------
--[[
    local history = require("client/scripts/controllers/history.lua")


    TO ADD A SNAPSHOT
        local block = ...
        local snapshot = history.createSnapshot(block)
        block.colour = colour.random()
        snapshot:commit("Some useful or not so useful description about this snapshot")
]]

local history = {}
local snapshotter = require("./history/_snapshotter.lua")

history.createSnapshot = snapshotter.createSnapshot

return history
