---------------------------------------------------------------
-- Copyright 2021 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------
return {
    name = "Scene Edit",
	iconId = "aspect_ratio",
    tools = {
        require("./select.lua"),
        require("./translate.lua"),
        require("./scale.lua"),
        --require("./rotate.lua")
    }
}