---------------------------------------------------------------
-- Copyright 2020 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------
--[[
    Internal, accessed by history system

    Used to store a list of saved snapshots
]]

local snapshots = {}

snapshots.storage = {}
snapshots.currentId = 0

function snapshots.add(snapshot)
    snapshots.currentId = snapshots.currentId + 1
    snapshots.storage[snapshots.currentId] = snapshot
end

return snapshots