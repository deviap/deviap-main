---------------------------------------------------------------
-- Copyright 2020 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------
return {
    name = "Scene Edit",
    description = "Desc",
	iconId = "view_quilt",
    tools = {
        require("./translate.lua"),
        require("./rotate.lua")
    }
}