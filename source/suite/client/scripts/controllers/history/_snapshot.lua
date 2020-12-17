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
    -- Sleeping for a negative value essentially waits for other tasks scheduled for this frame to finish
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

local function _getObjectTrack(self, object, id)
    if not self.tracking[id] then
        self.tracking[id] = {object = object, changes = {}}
    end

    return self.tracking[id]
end

local function _bindObject(self, object)
    local objectId = object.id
        
    -- Track changes
    local eventHook = object:on("changed", function(property, oldvalue, newvalue)
        local track = self:_getObjectTrack(object, objectId)
        if not track.changes[property] then
            track.changes[property] = {
                old = oldvalue,
                new = newvalue
            }
        else
            track.changes[property].new = newvalue
        end
    end)
    table.insert(self.eventHooks, eventHook)

    -- Track destruction
    local eventHook = object:on("destroying", function()
        self:_getObjectTrack(object, objectId)._DESTROYED = true
    end)
    table.insert(self.eventHooks, eventHook)
end

local function add(self, object)
    local track = self:_getObjectTrack(object, object.id)
    track._CREATED = true

    local info = core.reflection:getClassReflection(object.className)
    for k, v in pairs(info.properties) do
		local value = object[k]
		if v.hasSetter then
			track.changes[k] = {
                old = nil,
                new = value
            }
		end
	end
end

return function()
    return {
        startTime = os.time(),
        tracking = {},
        eventHooks = {},

        -- to finish/save a snapshot:
        commit = commit,

        -- to mark an object as created:
        add = add,

        -- internal:
        kill = kill,
        _getObjectTrack = _getObjectTrack,
        _bindObject = _bindObject
    }
end