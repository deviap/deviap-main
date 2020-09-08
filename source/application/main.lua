-- Copyright 2020 - Deviap (deviap.com)
-- Author(s): Sanjay-B(Sanjay)

-- This is the actual start file. (../core/dashboard/main.lua) is still enforced so, we're forced to use it. 

-- Essential Debug Utilities
require("tevgit:source/application/utilities/debug/output.lua")
require("tevgit:source/application/utilities/debug/keybinds.lua")

-- List of stuff that updates
require("tevgit:source/application/updater/main.lua")
local UI = require("tevgit:source/libraries/UI/main.lua")
local Enum = UI.Enum

Enum:newEnum("This/Is/Testing", "AnEnum")

local resolved = Enum:resolveValue("AnEnum")

print(resolved)
