---------------------------------------------------------------
-- Copyright 2021 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------
--[[
    Responsible for generating the prompts to save and open resources
]]

local controller = {}
local serialiser = require("devgit:source/serialiser/main.lua")
local filePrompt = require("devgit:source/suite-level-editor/client/scripts/filePrompt.lua")
    
function controller.saveScene()
    local file = filePrompt.open(".json", "Save Scene")
    if file ~= "new" then
        core.io:write(file, serialiser.toJSON(core.scene))
        print("saved!")
    else
        warn("did not save")
    end
end

return controller
