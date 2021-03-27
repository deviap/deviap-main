---------------------------------------------------------------
-- Copyright 2021 Deviap (https://deviap.com/)               --
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
snapshots.latestId = 0

function snapshots.add(snapshot)
    snapshots.invalidateFuture()
    snapshots.currentId = snapshots.currentId + 1
    snapshots.latestId = snapshots.currentId
    snapshots.storage[snapshots.currentId] = snapshot
end

function snapshots.current()
    return snapshots.storage[snapshots.currentId]
end

function snapshots.hasBack() 
    return snapshots.storage[snapshots.currentId - 1] ~= nil
end

function snapshots.back()
    if not snapshots.storage[snapshots.currentId - 1] then
        warn("There's no past to go to")
        return false
    end
    snapshots.currentId = snapshots.currentId - 1
    return true
end

function snapshots.forward()
    if snapshots.latestId > snapshots.currentId then
        snapshots.currentId = snapshots.currentId + 1
        return true
    else
        warn("There is no future...")
        return false
    end
end

function snapshots.invalidateFuture()
    if snapshots.currentId + 1 < snapshots.latestId then
        for i = snapshots.currentId + 1, snapshots.latestId do
            print("kill future", i)
            snapshots.storage[i] = nil
        end
    end
end

return snapshots