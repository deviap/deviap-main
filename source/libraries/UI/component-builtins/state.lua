-- Copyright 2020 - Deviap (deviap.com)
-- Author(s): utrain

-- Creates a stateful instance

local function insertInGap(list, value)
    local function helper(oldKey)
        local newKey = next(list, oldKey)
        oldKey = oldKey or 0

        if newKey == nil then list[oldKey + 1] = value return oldKey + 1 end
        if type(newKey) ~= "number" then error("Got a mixed table or dictionary as argument #1 (expected array).") end
        if newKey - 1 ~= oldKey then list[newKey - 1] = value return newKey - 1 end

        return helper(newKey)
    end

    return helper()
end

return function(reducer, startingState)
    local state = startingState or reducer(nil, {})
    local subscribers = {}
    local interface = {}

    interface.dispatch = function(action)
        newState = reducer(state, action)

        for _, callback in next, subscribers do
            coroutine.wrap(callback)(newState, state, action)
        end

        state = newState
    end

    interface.getState = function()
        return state
    end

    interface.subscribe = function(callback)
        local location = insertInGap(subscribers, callback)

        return function()
            subscribers[location] = nil
        end
    end

    return interface
end