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

        -- create a new objectc

        snapshot:commit("Some useful or not so useful description about this snapshot")
]]

local history = {}
local snapshotter = require("./history/_snapshotter.lua")
local snapshots = require("./history/_snapshots.lua")

history.createSnapshot = snapshotter.createSnapshot

history.undo = function()
    local snapshot = snapshots.current()
    print("Undo", snapshot.message)

    for id, track in pairs(snapshot.tracking) do
        for k, values in pairs(track.changes) do
            track.object[k] = values.old
        end
    end

    snapshots.back()
end

history.redo = function()
    local snapshot = snapshots.current()
    print("Redo", snapshot.message)

    for id, track in pairs(snapshot.tracking) do
        for k, values in pairs(track.changes) do
            track.object[k] = values.new
        end
    end

    snapshots.forward()
end

return history
