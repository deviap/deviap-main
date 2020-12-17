---------------------------------------------------------------
-- Copyright 2020 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------
--[[
    Internal, accessed by _snapshotter.lua
    Defines and creates snapshots
]]

local snapshots = require("./_snapshots.lua")

local function commit(self, message)
    -- We need to wait for all the events to fire.
    -- Sleeping for a negative value essentially waits for other tasks to finish
    sleep(-1)

    if self.eventHooks then
        -- so we dont add the same snapshot twice
        self.message = message
        snapshots.add(self)
    else
        warn("THIS SNAPSHOT WAS ALREADY COMITTED!!!")
    end

    self:kill()
end

local function kill(self)
    if self.eventHooks then
        for _,eventHook in pairs(self.eventHooks) do
            core.disconnect(eventHook)
        end
    else
        warn("This snapshot was already killed!")
    end
    
    self.eventHooks = nil
end

return function()
    return {
        startTime = os.time(),
        tracking = {},
        eventHooks = {},

        commit = commit,
        kill = kill
    }
end