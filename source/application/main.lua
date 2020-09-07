-- Copyright 2020 - Deviap (deviap.com)
-- Author(s): Sanjay-B(Sanjay)

-- This is the actual start file. (../core/dashboard/main.lua) is still enforced so, we're forced to use it. 

-- Essential Debug Utilities
require("tevgit:source/application/utilities/debug/output.lua")
require("tevgit:source/application/utilities/debug/keybinds.lua")

-- List of stuff that updates
--require("tevgit:source/application/updater/main.lua")

local class = require("tevgit:source/libraries/UI/constraints/main.lua").newController
local i = 1
local a = class("gridLayout")
a.container.parent = core.interface
a.container.size = guiCoord(1, 0, 1, 0)
local box = core.construct("guiFrame")
box.backgroundColour = colour.random()
box.parent = a.container
local box = core.construct("guiFrame")
box.backgroundColour = colour.random()
box.parent = a.container
local box = core.construct("guiFrame")
box.backgroundColour = colour.random()
box.parent = a.container
local box = core.construct("guiFrame")
box.backgroundColour = colour.random()
box.parent = a.container
local box = core.construct("guiFrame")
box.backgroundColour = colour.random()
box.parent = a.container
core.input:on("screenResized", a.refresh)