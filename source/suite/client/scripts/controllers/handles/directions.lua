---------------------------------------------------------------
-- Copyright 2020 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------

return {
    ["front"] = {vector3(1, 0, 0), colour.hex("f44336")}, -- x +, handle colour (red)
    ["back"] = {vector3(-1, 0, 0), colour.hex("f44336")}, -- x -, handle colour (red)
    ["right"] = {vector3(0, 0, 1), colour.hex("3F51B5")}, -- z +, handle colour (green)
    ["left"] = {vector3(0, 0, -1), colour.hex("3F51B5")}, -- z -, handle colour (green)
    ["top"] = {vector3(0, 1, 0), colour.hex("4CAF50")}, -- y +, handle colour (blue)
    ["bottom"] = {vector3(0, -1, 0), colour.hex("4CAF50")} -- y -, handle colour (blue)
}