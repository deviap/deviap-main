print("Dashboard Entry")
-- Essential Debug Utilities
require("devgit:source/application/utilities/debug/output.lua")
require("devgit:source/application/utilities/debug/keybinds.lua")

local colours = require("devgit:source/application/utilities/colourScheme.lua")

local main = core.construct("guiFrame", {
    parent = core.interface,
    size = guiCoord(1, 0, 1, 0)
})

local sidebar = require("devgit:source/application/dashboard/sidebar.lua")
sidebar.addButton("Home", "th", require("devgit:source/application/dashboard/pages/home.lua"))
sidebar.addButton("Apps", "book")
sidebar.addButton("Develop", "code")
sidebar.addButton("Tutorials", "graduation-cap")