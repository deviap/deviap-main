-- Copyright 2020 - Deviap (deviap.com)
-- Author(s): utrain
-- Creates a stateful instance
local function insertInGap(array, value)
    --[[
		@description
			Takes a given array and inserts the value at the closest nil gap.
		
		@parameters
			table, array
			any, value

		@return
			integer, location
	]]

    local function helper(oldKey)
        local newKey = next(array, oldKey)
        oldKey = oldKey or 0

        if newKey == nil then
            array[oldKey + 1] = value
            return oldKey + 1
        end
        if type(newKey) ~= "number" then
            error(
                "Got a mixed table or dictionary as argument #1 (expected array).")
        end
        if newKey - 1 ~= oldKey then
            array[newKey - 1] = value
            return newKey - 1
        end

        return helper(newKey)
    end

    return helper()
end

return function(reducer, startingState)
    --[[
		@description
			Makes a new state. Rip-off of redux. Sue me.
		@parameters
			function, reducer
				Must be a pure function that doesn't mutate the old state.
			any, startingState
		@return
			table, interface
	]]

    local state = startingState or reducer(nil, {})
    local subscribers = {}
    local interface = {}

    interface.dispatch = function(action)
        --[[
			@description
				Dispatch an action to update the state
			@parameters
				table, action
					{ type = "actionName", arg1 = 1, ...}
			@returns
				nil
		]]

        local newState = reducer(state, action)

        for _, callback in next, subscribers do
            coroutine.wrap(callback)(newState, state, action)
        end

        state = newState
    end

    interface.getState = function()
        --[[
			@description
				getState
			@parameter
				nil
			@returns
				any, state
		]]

        return state
    end

    interface.subscribe = function(callback)
        --[[
			@description
				Bind a function to be invoked whenever a dispatch occurs.
			@parameter
				function, callback
			@returns
				function, unsubscribe
		]]

        local location = insertInGap(subscribers, callback)

        return function() subscribers[location] = nil end
    end

    interface.getReducer = function()
        --[[
			@description
				Returns the current reducer. Use case: extending a state.
			@parameter
				nil
			@returns
				function, reducer
		]]
        return reducer
    end

    interface.replaceReducer = function(newReducer)
        --[[
			@description
				Replaces the current reducer with a new reducer.
			@parameter
				function, newReducer
			@returns
				nil
		]]
        reducer = newReducer
    end

    return interface
end
