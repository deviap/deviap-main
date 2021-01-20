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

local componentMap = {
	["loading"] = {client = true, server = false},
	["playerList"] = {client = true, server = false},
	["disconnection"] = {client = true, server = false},
	["character"] = {client = true, server = true},
	["chat"] = {client = true, server = true},
}

local finished = false
spawn(function()
    -- After sleeping if the function below hasn't been invoked,
    -- The developer hasn't properly set up game kit

    sleep()
    local didWarn = not finished
    while not finished do
        warn("GameKit has NOT been set up properly. Please make sure you invoke the returned function immediately.\n\nCorrect use is: \nrequire(\"devgit:source/gameKit/main.lua\") {}\n")
        sleep(3.5)
    end

    if didWarn then
        warn("GameKit is now set up properly... This is odd, did you yield before invoking the returned function?")
    end
end)

return function(requestedComponents)
    -- Set this internal local to true to stop us from spitting out a warning
    finished = true

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
