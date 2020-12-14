---------------------------------------------------------------
-- Copyright 2020 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------

-- To load a page, simply add its folder name below:
local pageNames = {
    "sceneEdit",
    "gui"
}

local pages = {}

for _,v in pairs(pageNames) do
    table.insert(pages, require("./" .. v .. "/main.lua"))
end

return pages