-- Copyright 2020 - Deviap (deviap.com)
-- Author(s): Sanjay-B(Sanjay)

-- This is the actual start file. (../core/dashboard/main.lua) is still enforced so, we're forced to use it. 

-- Essential Debug Utilities
require("tevgit:source/application/utilities/debug/output.lua")
require("tevgit:source/application/utilities/debug/keybinds.lua")

-- List of stuff that updates
--require("tevgit:source/application/updater/main.lua")

local class = require("tevgit:source/libraries/UI/constraints/main.lua").newController

local a = class("horizontialLayout")
a.container.parent = core.interface
a.container.size = guiCoord(1, 0, 1, 0)
a.max = 100

local obj1 = core.construct("guiFrame")
obj1.backgroundColour = colour.random()

a.objects[#a.objects+1] = obj1

local obj1 = core.construct("guiFrame")
obj1.backgroundColour = colour.random()

a.objects[#a.objects+1] = obj1

local obj1 = core.construct("guiFrame")
obj1.backgroundColour = colour.random()

a.objects[#a.objects+1] = obj1

local obj1 = core.construct("guiFrame")
obj1.backgroundColour = colour.random()

a.objects[#a.objects+1] = obj1

core.input:on("screenResized", a.refresh)