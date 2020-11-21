---------------------------------------------------------------
-- Copyright 2020 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------
--[[
    Usage:
    
    -- Load all of the gameKit components
    require("devgit:source/gameKit/main.lua") {}
    
    -- Load only the gameKit components you choose
    require("devgit:source/gameKit/main.lua") {
        "loading",
        "chat",
        "playerList"
    }
]] --

local prefixPath = "devgit:source/gameKit/"
local componentMap = {
	["loading"] = {client = true, server = false},
	["playerList"] = {client = true, server = false},
	["disconnection"] = {client = true, server = false},
}

return function(requestedComponents)
	-- Validate input
	if type(requestedComponents) ~= "table" then
		requestedComponents = {}
	end

	if #requestedComponents == 0 then
		for component, _ in pairs(componentMap) do
			table.insert(requestedComponents, component)
		end
	end

	for _, requestedComponent in pairs(requestedComponents) do
		if componentMap[requestedComponent] == nil then
			return error("Requested component (" .. tostring(requestedComponent) .. ") is not valid", 2)
		end
	end

	-- Load requested components
    for _, v in pairs(requestedComponents) do
        if _SERVER and componentMap[v].server then
            require("devgit:source/gameKit/server/" .. v .. ".lua")
        elseif not _SERVER and componentMap[v].client then
            require("devgit:source/gameKit/client/" .. v .. ".lua")
        end
	end
end
