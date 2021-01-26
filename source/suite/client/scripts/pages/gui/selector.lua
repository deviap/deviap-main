---------------------------------------------------------------
-- Copyright 2021 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------
return {
    name = "Selector",
    description = "Desc",
    iconId = "highlight_alt",
    
    activate = function(self)
        print("gui selector activate")
    end,

    deactivate = function(self)
        print("gui selector deactivate")
    end
}