local newState = require("devgit:source/libraries/state/main.lua")
local reducer = function(oldState, action)
	local newState = oldState or {}
	if action.type == "copy" then
		return { clipboard = action.paste, selected = oldState.selected }
	elseif action.type == "select" then
		return { selected = action.select, clipboard = oldState.clipboard }
	end
	return newState
end

--[[
	type clipboard = string
	type seletced = object

]]
local selector = {}
selector.state = newState(reducer)
selector.isSelected = function(testAgainst)
	return selector.state.getState().selected == testAgainst
end
selector.getClipboard = function()
	return selector.state.getState().clipboard
end
selector.select = function(select)
	selector.state.dispatch({ type = "select", select = select })
end
selector.copy = function(copy)
	selector.state.dispatch({ type = "copy", copy = copy })
end
selector.onSelected = function(callback)
	return selector.state.subscribe(function(newState, _, action)
		if action.type == "select" then
			callback(newState.selected)
		end
	end)
end
selector.onCopied = function(callback)
	return selector.state.subscribe(function(newState, _, action)
		if action.type == "copy" then
			callback(newState.clipboard)
		end
	end)
end
return selector
