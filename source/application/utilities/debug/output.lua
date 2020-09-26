-- Copyright 2020 - Deviap (deviap.com)
-- Author(s): Sanjay-B(Sanjay), utrain
-- Output for internal debug purposes.
local maxEntries = 19
local debounce, contents = false, {}
local Container = core.construct(
                  				"guiFrame", {
					parent = core.interface,
					name = "outputWindow", -- So, we can reference this later.
					size = guiCoord(
									0, math.max(core.interface.absoluteSize.x / 3, 150), 0,
									math.max(core.interface.absoluteSize.y / 3, 200)),
					position = guiCoord(0, 250, 0, 50),
					backgroundColour = colour(1, 1, 1),
					backgroundAlpha = 0.9,
					strokeWidth = 2,
					strokeColour = colour(0.75, 0.75, 0.75),
					strokeAlpha = 1,
					strokeRadius = 2,
					visible = false,
					zIndex = 200
				})

local topBar = core.construct(
               				"guiFrame", {
					parent = Container,
					size = guiCoord(1, 0, 0, 20),
					backgroundColour = colour(0.75, 0.75, 0.75)
				})

local headerText = core.construct(
                   				"guiTextBox", {
					parent = Container,
					size = guiCoord(1, 0, 1, 0),
					position = guiCoord(0, 0, 0, 0),
					backgroundAlpha = 0,
					text = " Console",
					textFont = "deviap:fonts/openSansBold.ttf",
					textMultiline = true,
					textWrap = true
				})

local scrollContents = core.construct(
                       				"guiScrollView", {
					parent = Container,
					size = guiCoord(1, 0, 1, -20),
					position = guiCoord(0, 0, 0, 20),
					backgroundColour = colour.rgb(255, 255, 255),
					backgroundAlpha = 1,
					scrollbarAlpha = 0.8,
					scrollbarColour = colour(0.75, 0.75, 0.75),
					scrollbarRadius = 0,
					scrollbarWidth = 5,
					active = true
				})

-- Console Move Logic
local down = headerText:on(
             				"mouseLeftDown", function(initialPosition)

					if debounce then return end
					debounce = true

					local offset = initialPosition - Container.absolutePosition

					move = core.input:on(
       									"mouseMoved", function()
										Container.position = guiCoord(
                     														0, core.input.mousePosition.x - offset.x, 0,
                     														core.input.mousePosition.y - offset.y)
									end)

					release = core.input:on(
          									"mouseLeftUp", function()
										core.disconnect(move)
										core.disconnect(release)
										core.disconnect(down)
										debounce = false
									end)
				end)

-- Contents Population Logic
-- RED: colour.rgb(229, 115, 115)
-- GREY: colour.rgb(102, 102, 102)
core.debug:on(
				"print", function(message)
					contents[#contents + 1] = {
						["message"] = os.date("%H:%M:%S", os.time()) .. ": " .. message,
						["colour"] = (string.match(message, "ERROR:") and colour.rgb(229, 115, 115) or
										colour.rgb(102, 102, 102))
					}
				end)

core.debug:on(
				"warn", function(message)
					contents[#contents + 1] = {
						["message"] = os.date("%H:%M:%S", os.time()) .. ": " .. message,
						["colour"] = colour.rgb(255, 183, 77)
					}
				end)

-- error(message) doesn't invoke this so, it's disabled until it's fixed.
--[[
core.debug:on("error", function(message)
    contents[#contents+1] = {
        ["message"] = os.date("%H:%M:%S", os.time())..": "..message,
        ["colour"] = colour.rgb(229, 115, 115)
    }
end)
]] --

-- Update Console Contents
spawn(
				function()
					while sleep(0.3) do
						scrollContents:destroyChildren()
						scrollContents.canvasSize = guiCoord(1, 0, 0, 0)
						for index, data in pairs(contents) do
							local textLabel = core.construct(
                  											"guiTextBox", {
												parent = scrollContents,
												size = guiCoord(1, 0, 1, 0),
												position = guiCoord(0, 0, 0, scrollContents.canvasSize.offset.y),
												backgroundColour = colour.rgb(255, 255, 255),
												text = data["message"],
												textColour = data["colour"],
												-- textFont = "deviap:fonts/firaCodeBold.otf",
												textSize = 14,
												textWrap = true,
												visible = true
											})
							textLabel.size = guiCoord(1, 0, 0, textLabel.textDimensions.y + 2)
							scrollContents.canvasSize = scrollContents.canvasSize +
                            											guiCoord(0, 0, 0, textLabel.absoluteSize.y)
						end
					end
				end)
