---------------------------------------------------------------
-- Copyright 2020 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------
-- Suite Entry Point
require("devgit:source/application/utilities/camera.lua")

local selection = require("./controllers/selection.lua")

core.scene.simulate = true
core.scene.camera.position = vector3(10, 10, -10)
core.scene.camera.rotation = quaternion.euler(math.rad(25), 0, 0)

core.graphics.ambientDirection = vector3(0, 1, 0)
core.graphics.upperAmbient = colour.rgb(244, 244, 244)
core.graphics.lowerAmbient = colour.rgb(125, 124, 134)

core.graphics.sky = ""

local base = core.construct("block", {
	position = vector3(0, -10, 0),
	scale = vector3(30, 1, 30),
	colour = colour.hex("#ffffff")
})

local block = core.construct("block", {
	position = vector3(0, -9, 0),
	scale = vector3(2, 1, 2),
	colour = colour.hex("#ffff00")
})

core.scene.camera:lookAt(base.position)

-- MAIN INTERFACE IGNORE ABOVE
local navbar = require("devgit:source/libraries/UI/components/navigation/navbarAnimated.lua")

-- Vertical Sidebar Instance
local verticalNav = navbar {
	orientation = "vertical",
	parent = core.interface,
	size = guiCoord(0, 40, 1, 0),
	position = guiCoord(0, 0, 0, 0),
	containerBackgroundColour = colour.hex("#212121"),
	iconColour = colour.hex("#FFFFFF"),
	zIndex = 4
}

local pages = require("./pages/pages.lua")
local wrapper = require("./pages/wrapper.lua")
for i, pageDefinition in pairs(pages) do
	verticalNav.addNavItem({
		defaultPage = i == 1,
		relativeLocation = "top",
		size = guiCoord(0, 32, 0, 32),
		iconMax = 20,
		iconId = pageDefinition.iconId,
		tooltip = pageDefinition.name,
		redirect = wrapper.createRedirect(pageDefinition)
	})
end

-- Horizontal Navbar Instance
local horizontalNav = navbar {
	orientation = "horizontal",
	parent = core.interface,
	size = guiCoord(590, 0, 0, 15),
	position = guiCoord(0, 40, 1, -45),
	containerBackgroundColour = colour.hex("#212121"),
	iconColour = colour.hex("#212121"),
	zIndex = 3
}

local stats = core.networking:getStats()
for i,v in pairs(stats) do
	print(i,v)
end

--[[
horizontalNav.addNavTextItem({
	defaultPage = false,
	relativeLocation = "top",
	size = guiCoord(0, 65, 0, 10),
	textColour = colour.hex("#FFFFFF"),
	text = "EXPLORER",
	redirect = nil
})
--]]

-- Window / Widget Test

-- local window = require("devgit:source/libraries/UI/components/widgets/window.lua")
-- local properties = require("./windows/properties.lua")

-- window {
-- 	parent = core.interface,
-- 	position = guiCoord(0, 200, 0, 100),
-- 	size = guiCoord(0, 300, 0, 200),
-- 	title = "Properties",
-- 	content = properties.construct(horizontalNav.container)
-- }

-- IO List Test
-- local window = require("devgit:source/libraries/UI/components/widgets/window.lua")

-- window {
-- 	parent = core.interface,
-- 	position = guiCoord(0, 200, 0, 100),
-- 	size = guiCoord(0, 300, 0, 200),
-- 	title = "File Explorer",
-- 	content = require("./windows/fileExplorer.lua").construct({	parent = core.interface }).container
-- }

require("./windows/fileExplorerTest.lua")

-- Scene Explorer Test
-- require("./windows/sceneExplorer.lua").construct({ 
-- 	parent = core.construct("guiFrame", {
-- 		parent = core.interface,
-- 		size = guiCoord(1,0,1,0),
-- 		zIndex = 100,
-- 		backgroundColour = colour(0, 0, 0)
-- 	}),
-- 	size = guiCoord(0, 200, 0, 400),
-- 	position = guiCoord(0, 50, 0, 20),
-- })

-- Hierarchy Test
--require("./windows/hierarchyTest.lua")

-- Properties Test
--local test = require("./windows/properties.lua")
--test.construct(core.interface, base)

-- PLACEHOLDER (COMMENTED OUT)
-- UNTIL OUR NEW FILE BROWSER IS MADE
-- Get this file via devgit, for IO access
--[[
do
	local serialiser = require("devgit:source/serialiser/main.lua")
	local filePrompt = require("devgit:source/suite-level-editor/client/scripts/filePrompt.lua")
	local file = filePrompt.open(".json")
	if file ~= "new" then
		-- user selected resource
		core.scene:destroyChildren()
		serialiser.fromFile(file)
	end
end
]]--
--[[
local history = require("./controllers/history.lua")

local snapshot = history.createSnapshot(base)
base.colour = colour.random()
snapshot:commit("Commit #1")

local snapshot = history.createSnapshot(base)
base.scale = vector3(1,1,1)
snapshot:commit("Commit #2")

local snapshot = history.createSnapshot(base)
base.position = base.position + vector3(0, 1, 0)
snapshot:commit("Commit #3")

sleep(1)
history.undo()
sleep(1)
history.undo()
sleep(1)
history.undo()

sleep(2)
history.redo()
sleep(1)
history.redo()
sleep(1)
history.redo()
]]


-- for dev purposes only:
core.construct("guiTextBox", {
	parent = core.interface,
	text = "[test] Save Scene",
	textSize = 14,
	textAlign = "middle",
	size = guiCoord(0, 100, 0, 20),
	position = guiCoord(1, -110, 1, -100)
}):on("mouseLeftDown", function()
	require("./controllers/save.lua").saveScene()
end)