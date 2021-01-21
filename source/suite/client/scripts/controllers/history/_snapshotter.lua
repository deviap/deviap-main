---------------------------------------------------------------
-- Copyright 2020 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------
--[[
    Internal, accessed by history.lua
]] 
local snapshotter = {}
local snapshot = require("./_snapshot.lua")

function snapshotter.createSnapshot(objs)
	local pendingSnapshot = snapshot()

    -- This is a simple way to prevent us tracking the same object twice...
    -- Keys are unique.
	local objects = {}
	if type(objs) == "table" then
        for _,v in pairs(objs) do
            objects[v] = true
        end
    else
        objects[objs] = true
    end

    -- We want to track children of the objects given to us
    for object, _ in pairs(objects) do
        if object.children then
            for _,v in pairs(object.children) do
                objects[v] = true
            end
        end
    end

    -- Bind the appropriate events for each object
    for object, _ in pairs(objects) do
		pendingSnapshot:_bindObject(object)
	end

	return pendingSnapshot
end

return snapshotter
