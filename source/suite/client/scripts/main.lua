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
core.graphics.upperAmbient = colour.rgb(111, 111, 111)
core.graphics.lowerAmbient = colour.rgb(0, 0, 0)

core.graphics.sky = ""

local base = core.construct("block", {
	position = vector3(0, -10, 0),
	scale = vector3(30, 1, 30),
	colour = colour.hex("#ffffff")
})

local test123 = core.construct("block", {
	position = vector3(0, -9, 0),
	scale = vector3(1, 1, 1),
	colour = colour.hex("#0fffff")
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

horizontalNav.addNavTextItem({
	defaultPage = false,
	relativeLocation = "top",
	size = guiCoord(0, 65, 0, 10),
	textColour = colour.hex("#FFFFFF"),
	text = "EXPLORER",
	redirect = nil
})

--  core.io:list()


require("./windows/hierarchy.lua"){
	parent = core.construct("guiFrame", {
		parent = core.interface,
		zIndex = 10,
		size = guiCoord(1, 0, 1, 0)
	});
	size = guiCoord(0, 400, 0, 800);
	position = guiCoord(0, 50, 0, 0);
	hierarchy = {
		{
			text = "Friend List",
			icon = "list",
			children = {
				{
					text = "Jay",
					icon = "person",
					children = {
						{
							text = "Jaysan would like to know what is due.",
							icon = "label",
						},
						{
							text = "Jaysan needs an alternator?.",
							icon = "label",
						},
						{
							text = "Jaysan and Sanjay are the same person!?.",
							icon = "label",
						},
					}
				},
				{
					text = "Sanjay",
					icon = "person",
					children = {
						{
							text = "Needs a update ASAP",
							icon = "label",
						},
						{
							text = "Explain that refactoring is good!",
							icon = "label"
						},
						{
							text = "Sanjay hook up with Ryan?",
							icon = "label"
						},
						{
							text = "Sanjay needs to get more sleep.",
							icon = "label",
							children = {
								{
									text = "Literally impossible, stop trying already."
								}
							}
						},
					}
				},
				{
					text = "Ryan",
					icon = "person"
				},
				{
					text = "Neztore",
					icon = "person"
				},
			}
		},
	},
	buttonHeight = 25
}




-- PLACEHOLDER
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
