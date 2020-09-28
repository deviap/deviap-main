print("Dashboard Entry")
core.workshop:promptOpen()

--[[
local main = core.construct("guiFrame", {
	parent = core.interface,
	size = guiCoord(1, 0, 1, 0)
})

local nav = require("devgit:source/application/dashboard/nav.lua")
nav.register("devgit:source/application/dashboard/pages/dashboard.lua")
nav.register("devgit:source/application/dashboard/pages/appLibrary.lua")
nav.register("devgit:source/application/dashboard/pages/developDashboard.lua")
-- nav.register("devgit:source/application/dashboard/pages/components.lua")]]
